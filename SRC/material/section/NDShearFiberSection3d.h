//Added by Diego Heredia 07.06.2023 for test shear stress distribution

#ifndef NDShearFiberSection3d_h
#define NDShearFiberSection3d_h

#include <SectionForceDeformation.h>
#include <Vector.h>
#include <Matrix.h>

#include <vector>
#include <unordered_map>
#include <array>
#include <numeric> // for std::iota
#include <algorithm> // for std::sort

class NDMaterial;
class Fiber;
class Response;
class SectionIntegration;

using MatrixContainer = std::vector<Matrix>;

class NDShearFiberSection3d : public SectionForceDeformation
{
  public:
    NDShearFiberSection3d(); 
    NDShearFiberSection3d(int tag, MatrixContainer allCellsVertices, int numFibers, Fiber **fibers, double a = 1.0, bool compCentroid=true);
    NDShearFiberSection3d(int tag, MatrixContainer allCellsVertices, int numFibers, double a = 1.0, bool compCentroid=true);
    NDShearFiberSection3d(int tag, MatrixContainer allCellsVertices, int numFibers, NDMaterial **mats,
		     SectionIntegration &si, double a = 1.0, bool compCentroid=true);
    ~NDShearFiberSection3d();

    const char *getClassType(void) const {return "NDShearFiberSection3d";};

    int   setTrialSectionDeformation(const Vector &deforms); 
    const Vector &getSectionDeformation(void);

    const Vector &getStressResultant(void);
    const Matrix &getSectionTangent(void);
    const Matrix &getInitialTangent(void);

    int   commitState(void);
    int   revertToLastCommit(void);    
    int   revertToStart(void);
 
    SectionForceDeformation *getCopy(void);
    const ID &getType (void);
    int getOrder (void) const;
    
    int sendSelf(int cTag, Channel &theChannel);
    int recvSelf(int cTag, Channel &theChannel, 
		 FEM_ObjectBroker &theBroker);
    void Print(OPS_Stream &s, int flag = 0);
	    
    Response *setResponse(const char **argv, int argc, 
			  OPS_Stream &s);
    int getResponse(int responseID, Information &info);

    int addFiber(Fiber &theFiber);

    // AddingSensitivity:BEGIN //////////////////////////////////////////
    int setParameter(const char **argv, int argc, Parameter &param);
    int updateParameter(int parameterID, Information &info);
    int activateParameter(int parameterID);
    const Vector& getStressResultantSensitivity(int gradIndex,
						bool conditional);
    const Vector& getSectionDeformationSensitivity(int gradIndex);
    const Matrix& getInitialTangentSensitivity(int gradIndex);
    int commitSensitivity(const Vector& sectionDeformationGradient,
			  int gradIndex, int numGrads);
    // AddingSensitivity:END ///////////////////////////////////////////

    ////Get extreme fibers indices 
    //void getIndexExtremeFibers();

    //// Get increment section deformation decomposition
    //Matrix& getIncrementSectionDeformationsDecomposition();

    //// Get section deformation decomposition
    //Matrix& getSectionDeformationsDecomposition();

    //// Get total section deformations
    //Vector& getTotalSectionDeformations();

    //Get the total area of the cross section
    double getSectionArea();

    // Function to sort nodes in each element based on angles around centroid
    Matrix sort_nodes_in_element(Matrix coordinate_matrix, Matrix connectivity_matrix);


    // Determine connectivity and coordinate matrix of quadrilateral elements
    void determineQuadMesh();

    // Compute the section properties (inertia)
    void computeSectionProperties();

  protected:
    
    //  private:
    int numFibers, sizeFibers;                   // number of fibers in the section
    NDMaterial **theMaterials; // array of pointers to materials
    double   *matData;               // data for the materials [yloc and area]
    double   kData[36];               // data for ks matrix 
    double   sData[6];               // data for s vector 

    MatrixContainer allCellsVertices; //stores the matrix storing the vertices of each fiber (i.e. of each "cell") 

    double Abar,QyBar, QzBar;
    double yBar;       // Section centroid
    double zBar;       // Section centroid
    bool computeCentroid;
    //double alpha;      // Shear shape factor

    SectionIntegration *sectionIntegr;

    static ID code;

    Vector e;          // trial section deformations 
    Vector *s;         // section resisting forces  (axial force, bending moment)
    Matrix *ks;        // section stiffness

    double Iy;
    double Iz;
   
    // Variables for quadrilateral mesh
    Matrix connectivity_matrix;
    Matrix coordinate_matrix;

// AddingSensitivity:BEGIN //////////////////////////////////////////
    int parameterID;
    Vector dedh; // MHS hack
// AddingSensitivity:END ///////////////////////////////////////////
};

#endif
