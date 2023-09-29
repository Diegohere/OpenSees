//Added by Diego Heredia 28.09.2023 for test shear stress distribution

#ifndef NDTestShear4HSSFiberSection3d_h
#define NDTestShear4HSSFiberSection3d_h

#include <SectionForceDeformation.h>
#include <Vector.h>
#include <Matrix.h>

class NDMaterial;
class Fiber;
class Response;
class SectionIntegration;

class NDTestShear4HSSFiberSection3d : public SectionForceDeformation
{
  public:
    NDTestShear4HSSFiberSection3d(); 
    NDTestShear4HSSFiberSection3d(int tag, double D, double t, double rInt, int numFibers, Fiber **fibers, double a = 1.0, bool compCentroid=true);
    NDTestShear4HSSFiberSection3d(int tag, double D, double t, double rInt, int numFibers, double a = 1.0, bool compCentroid=true);
    NDTestShear4HSSFiberSection3d(int tag, double D, double t, double rInt, int numFibers, NDMaterial **mats,
		     SectionIntegration &si, double a = 1.0, bool compCentroid=true);
    ~NDTestShear4HSSFiberSection3d();

    const char *getClassType(void) const {return "NDTestShear4HSSFiberSection3d";};

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

    // Compute shear normalization parameters beta12 and beta13
    void computeShearBetas();

  protected:
    
    //  private:
    int numFibers, sizeFibers;                   // number of fibers in the section
    NDMaterial **theMaterials; // array of pointers to materials
    double   *matData;               // data for the materials [yloc and area]
    double   kData[36];               // data for ks matrix 
    double   sData[6];               // data for s vector 

    double D;
    double t;
    double rInt;
    double h;

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
    double beta22;
    double beta23;
    double beta33;
    double beta32;

// AddingSensitivity:BEGIN //////////////////////////////////////////
    int parameterID;
    Vector dedh; // MHS hack
// AddingSensitivity:END ///////////////////////////////////////////
};

#endif
