//
// Created by Diego Heredia on 10.09.22
//

#ifndef TestNonlocalElement3dDH_H 
#define TestNonlocalElement3dDH_H 

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

class TestNonlocalElement3dDH : public Element
{
public:
	// Constructor, parallel processing
	TestNonlocalElement3dDH();

	// Constructor, called by clients
	// Based on the current ForceBeamElement OpenSees manual
	TestNonlocalElement3dDH(int tag, int nodeI, int nodeJ,
		CrdTransf& coordTransf, BeamIntegration& beamIntegr,
		SectionForceDeformation** sec, int numSec,
		int maxNumIters, double tolerance, double lc);

	// Destructor
	~TestNonlocalElement3dDH();

public:

	// Method to get the class type
	const char* getClassType(void) const { return "NonlocalForceBasedBeamColumnElement"; };

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

	void computeMatrixH(Matrix& H);
	void computeMatrixH_inv(Matrix H, Matrix& H_inv);

	Matrix computeDENonlocalAll(Matrix deltaETot_All);
	void computeFelement_nonlocal(Matrix& Felement, Matrix H_inv, Matrix FSectionSubdivide[]);


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

	Matrix H;
	Matrix H_inv;

	Matrix* FSection;                    // array of section flexibility matrices
	Vector* eTot;                    // array of nonlocal section deformation vectors
	Vector* sr;                   // array of section resisting force vectors
	Vector* eTotCommit;              // array of committed section deformation vectors

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

	static Vector eTotSubdivide[];
	static Vector srSubdivide[];
	static Matrix FSectionSubdivide[];
	//static Vector sSubdivide[];

	bool isTorsion;

	bool sectionSofteningTrial;
	bool sectionSofteningCommit;

	//static Vector s[];  // array of section forces
	//static Matrix deStar_local;  // matrix of e_star_local for all sections of element

};



#endif // TestNonlocalElement3dDH_H 
