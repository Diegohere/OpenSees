//
// Created by Diego Heredia on 22.05.2025
//

#ifndef FBCElemSGINUS3d_H 
#define FBCElemSGINUS3d_H 

#include <Element.h>
#include <Node.h>
#include <Matrix.h>
#include <Vector.h>
#include <Channel.h>
#include <BeamIntegration.h>
#include <SectionForceDeformation.h>
#include <CrdTransf.h>


/* -------------------------------------------------------------------------- */

class Response;
class ElementalLoad;

class FBCElemSGINUS3d : public Element
{
public:
	// Constructor, parallel processing
	FBCElemSGINUS3d();

	// Constructor, called by clients
	// Based on the current ForceBeamElement OpenSees manual
	FBCElemSGINUS3d(int tag, int nodeI, int nodeJ,
		CrdTransf& coordTransf, BeamIntegration& beamIntegr,
		SectionForceDeformation** sec, int numSec,
		int maxNumIters, double tolerance, double lc);

	// Destructor
	~FBCElemSGINUS3d();

public:

	// Method to get the class type
	const char* getClassType(void) const { return "FBCElemSGINUS3d"; };

	// Method to initialize the domain; base class: DomainComponent
	void setDomain(Domain* theDomain);

	// Methods to get information on DOFs and connectivity; base class: Element
	int getNumExternalNodes(void) const;
	const ID& getExternalNodes(void);
	Node** getNodePtrs(void);
	int getNumDOF(void);

	// Methods to set the state of the element, base class: Element
	int commitState(void);
	int revertToLastCommit(void);
	int revertToStart(void);
	int update(void);

	// Methods to get stiffness matrices, base class: Element
	const Matrix& getTangentStiff(void);
	const Matrix& getInitialStiff(void);
	const Matrix& getMass(void);

	//Methods for adding element loads
	void zeroLoad(void);
	int addLoad(ElementalLoad* theLoad, double loadFactor);

	// Methods to get resisting force vector, base class: Element
	const Vector& getResistingForce(void);
	const Vector& getResistingForceIncInertia(void);

	// Methods to et information specific to element; base class: Element
	void Print(OPS_Stream& s, int flag = 0);
	Response* setResponse(const char** argv, int argc, OPS_Stream& output);
	int getResponse(int responseID, Information& eleInfo);

	// Method to display element
	int	displaySelf(Renderer& theViewer, int displayMode, float fact, const char** displayModes, int numMode);

	// Methods for parallel processing; base class: Channel
	int sendSelf(int commitTag, Channel& theChannel);
	int recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker);

protected:
	int getInitialFlexibility(Matrix& Fe);  // get initial flexibility matrix
	void setSectionPointers(int numSections, SectionForceDeformation** secPtrs); // set section pointers

private:
	void getForceInterpolatMatrix(double xi, Matrix& b, const ID& code);
	void getDistrLoadInterpolatMatrix(double xi, Matrix& bp, const ID& code);
	void initializeSectionHistoryVariables(void);

	void computeReactions(double* p0); // Reactions of basic system due to element loads

	void computeSectionForces(Vector& sp, int isec); // Section forces due to element loads

	void computeDeStar_nonlocal(Vector deStar_nonlocal_Tot[], Vector deStar_local_Tot[]);
	void computeE_local(Matrix& e_local_tot);
	void computeEu_nonlocal(Vector eu_nonlocal_Tot[], Vector eu_local_Tot[]);
	void computeFelement_nonlocal(Matrix& Felement_nonlocal);

	void initCoefficientMatrixH();
	void computeCoefficientMatrixH();


	/* ----------------------------------------------------------------------------- */
	/* Members                                                                       */
	/* ----------------------------------------------------------------------------- */
private:

	// Private attributes
	ID connectedExternalNodes;              // contains tags of end nodes
	Node* theNodes[2];                      // pointer to nodes
	SectionForceDeformation** sections;     // pointers to sections
	BeamIntegration* beamIntegr;			// pointer to integration method
	CrdTransf* crdTransf;					// pointer to coordinate transformation method

	int numSections;		// number of sections
	int    maxIters;               // maximum number of local iterations
	double Tol;	                   // tolerance for unbalanced element displacement norm for local iterations
	//double rho;                    // mass density per unit length
	double lc;                       // characteristic length lc

	int    initialFlag;            // indicates if the element has been initialized

	Matrix Kelement;                     // stiffness matrix in the basic system 
	Vector q;                     // element resisting forces in the basic system
	Matrix KelementCommit;               // committed stiffness matrix in the basic system
	Vector qCommit;               // committed element end forces in the basic system

	Matrix coeffs_H_GI;
	Matrix coeffs_H;

	Matrix* FSection;                    // array of section flexibility matrices
	Vector* eNonlocal;                    // array of nonlocal section deformation vectors
	Vector* sr;                   // array of section resisting force vectors
	Vector* srCommit;                   // array of comitted section resisting force vectors
	Vector* eNonlocalCommit;              // array of committed nonlocal section deformation vectors
	Vector* eLocalCommit;              // array of committed local section deformation vectors
	Vector* eLocal;              // array of local section deformation vectors

	enum { maxNumEleLoads = 100 };   // maximum number of element loads
	//enum { maxNumSections = 30 };  //maximum number of integration sections
	enum { maxNumSections = 60 };  //maximum number of integration sections
	enum { NDM = 3 };         // dimension of the problem (3d)
	enum { NND = 6 };         // number of nodal dof's
	enum { NEGD = 12 };        // number of element global dof's
	enum { NEBD = 6 };         // number of element dof's in the basic system

	int numEleLoads; // Number of element load objects
	int sizeEleLoads;
	ElementalLoad** eleLoads;
	double* eleLoadFactors;
	Vector load;

	Matrix* KelementInitial;            // pointer to initial element stiffness matrix

	// Static Class Wide Variables
	static Matrix theMatrix;
	static Vector theVector;
	static double workArea[];

	// following are added for subdivision of displacement increment
	int    maxSubdivisions;       // maximum number of subdivisons of dv for local iterations

	static Vector eNonLocalSubdivide[];
	static Vector eLocalSubdivide[];
	static Vector srSubdivide[];
	static Matrix FSectionSubdivide[];

	double WSofteningCommit;
	double WSofteningTrial;
	double WSofteningTol;
	//double DeltaWSectionTol = 1e-4;
	bool isSoftening;

	bool isTorsion;

	// Added fpr debug purpose
	double Bc4MatrixH = 0.;
	double Ac4MatrixH = 1.;
	Matrix H;

	//static Vector s[];  // array of section forces
	//static Matrix deStar_local;  // matrix of e_star_local for all sections of element

};



#endif // FBCElemSGINUS3d_H 
