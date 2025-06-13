//
// Created by Diego Heredia on 22.05.2025
//

#include "FBCElemSGINUS2d.h"

#include <elementAPI.h>
#include <Domain.h>
#include <Node.h>
#include <Channel.h>
#include <FEM_ObjectBroker.h>
#include <Renderer.h>
#include <Information.h>
#include <ElementResponse.h>
#include <ElementalLoad.h>

#include <NewtonCotesBeamIntegration.h>
#include <LobattoBeamIntegration.h>
#include <NewtonCotesBeamIntegrationUpdated.h>

#include <iostream>
//#define _USE_MATH_DEFINES
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>
//#include <complex.h>

// Initialize class wide variables
Matrix FBCElemSGINUS2d::theMatrix(6, 6);
Vector FBCElemSGINUS2d::theVector(6);
double FBCElemSGINUS2d::workArea[200];

Vector FBCElemSGINUS2d::eNonLocalSubdivide[maxNumSections];
Vector FBCElemSGINUS2d::eLocalSubdivide[maxNumSections];
Matrix FBCElemSGINUS2d::FSectionSubdivide[maxNumSections];
Vector FBCElemSGINUS2d::srSubdivide[maxNumSections];

// Method to read the command arguments
void* OPS_FBCElemSGINUS2d()
{
	// Check if sufficient arguments
	if (OPS_GetNumRemainingInputArgs() < 10) {
		opserr << "WARNING! insufficient arguments: eleTag, nodeI, nodeJ, coordTransf, beamIntegr, integrSecTag, numSec, maxNumIters, tolerance, lc\n";
		return 0;
	}

	// Get dimensions and nb DOFs
	int ndm = OPS_GetNDM();
	int ndf = OPS_GetNDF();
	if (ndm != 2 || ndf != 3) {
		opserr << "WARNING! dimension must be 2d and nb DOF must be 3\n";
		return 0;
	}

	// Inputs of type int
	int numIntData = 6;
	int intData[6];
	if (OPS_GetIntInput(&numIntData, &intData[0]) < 0) {
		opserr << "WARNING! invalid int inputs tags\n";
		return 0;
	}
	int eleTag = intData[0];
	int nodeTagI = intData[1];
	int nodeTagJ = intData[2];
	int transfTag = intData[3];
	int integrTag = intData[4];
	int maxNumIters = intData[5];

	// Get input of type double
	int numDoubleData = 2;
	double doubleData[2];
	if (OPS_GetDoubleInput(&numDoubleData, &doubleData[0]) < 0) {
		opserr << "WARNING! invalid double inputs tags\n";
		return 0;
	}
	double tolerance = doubleData[0];
	double lc = doubleData[1];

	// Check coordinate transformation
	CrdTransf* theCoordTransf = OPS_getCrdTransf(transfTag);
	if (theCoordTransf == 0) {
		opserr << "WARNING! coordinate transformation with tag " << transfTag << " not found\n";
		return 0;
	}

	// Check beam integration
	BeamIntegrationRule* theIntegrRule = OPS_getBeamIntegrationRule(integrTag);
	if (theIntegrRule == 0) {
		opserr << "WARNING! beam integration rule with tag " << integrTag << " not found\n";
		return 0;
	}
	BeamIntegration* theBeamIntegration = theIntegrRule->getBeamIntegration();
	if (theBeamIntegration == 0) {
		opserr << "WARNING! beam integration is null - failed to create\n";
		return 0;
	}

	// Check integration sections
	const ID& secTags = theIntegrRule->getSectionTags();
	int numIntegrPoints = secTags.Size();
	SectionForceDeformation** sections = new SectionForceDeformation * [secTags.Size()];
	//for (int i = 0; i < secTags.Size(); i++) {
	//	sections[i] = OPS_getSectionForceDeformation(secTags(i));
	//	if (sections[i] == 0) {
	//		opserr << "WARNING! section " << secTags(i) << "not found\n";
	//		delete[] sections;
	//		return 0;
	//	}
	//}

	// Initialize the element
	Element* theEle = new FBCElemSGINUS2d(eleTag, nodeTagI, nodeTagJ, *theCoordTransf, *theBeamIntegration,
		sections, numIntegrPoints, maxNumIters, tolerance, lc);
	delete[] sections;
	return 0;
}

// Constructor 2 (for parallel processing)
FBCElemSGINUS2d::FBCElemSGINUS2d() : Element(0, ELE_TAG_FBCElemSGINUS2d), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
maxIters(0), Tol(0), lc(0), initialFlag(0),
Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(2 * 10, 2 * 10), H_inv(2 * 10, 2 * 10),
FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0), Ac4MatrixHGI(0), Bc4MatrixHGI(0), Ac4MatrixH(0), Bc4MatrixH(0)
// complete
{
	// Set Node Pointers to 0
	theNodes[0] = 0;
	theNodes[1] = 0;

	load.Zero();
}

// Constructor 1 (for normal processing) invoked by a FEM_ObjectBroker
FBCElemSGINUS2d::FBCElemSGINUS2d(int tag, int nodeI, int nodeJ, CrdTransf& CT, BeamIntegration& BI,
	SectionForceDeformation** sec, int numSec, int maxNumIters, double tolerance, double LC)
	:Element(tag, ELE_TAG_FBCElemSGINUS2d), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
	maxIters(maxNumIters), Tol(tolerance), lc(LC), initialFlag(0),
	Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(2 * numSec, 2 * numSec), H_inv(2 * numSec, 2 * numSec),
	FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
	numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
	WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0), Ac4MatrixHGI(0), Bc4MatrixHGI(0), Ac4MatrixH(0), Bc4MatrixH(0)
	// complete
{
	// Pointers to Nodes and Their IDs
	if (connectedExternalNodes.Size() != 2) {
		opserr << "WARNING! FBCElemSGINUS2d::FBCElemSGINUS2d(): " << this->getTag() << " - failed to create an ID of size 2\n";
		exit(-1);
	}

	connectedExternalNodes(0) = nodeI;
	connectedExternalNodes(1) = nodeJ;

	theNodes[0] = 0;
	theNodes[1] = 0;

	load.Zero();

	// Get Copy of Integration Method
	beamIntegr = BI.getCopy();

	if (!beamIntegr) {
		opserr << "WARNING! FBCElemSGINUS2d::FBCElemSGINUS2d(): " << this->getTag() << " - could not create copy of beam integration object" << endln;
		exit(-1);
	}

	// get copy of the transformation object   
	crdTransf = CT.getCopy2d();
	if (crdTransf == 0) {
		opserr << "WARNING! FBCElemSGINUS2d::FBCElemSGINUS2d(): could not create copy of coordinate transformation object" << endln;
		exit(-1);
	}

	//get copy of sections
	this->setSectionPointers(numSec, sec);

	//// Check pseudo-inverse procedure
	//Matrix testMatrix(3, 3);
	///*testMatrix(0, 0) = 4;
	//testMatrix(0, 1) = 1;
	//testMatrix(0, 2) = 2;
	//testMatrix(1, 0) = 1;
	//testMatrix(1, 1) = 3;
	//testMatrix(1, 2) = 0;
	//testMatrix(2, 0) = 2;
	//testMatrix(2, 1) = 0;
	//testMatrix(2, 2) = 5;*/
	///*testMatrix(0, 0) = 2.0;
	//testMatrix(0, 1) = 4.0;
	//testMatrix(0, 2) = 6.0;
	//testMatrix(1, 0) = 4.0;
	//testMatrix(1, 1) = 8.0;
	//testMatrix(1, 2) = 12.0;
	//testMatrix(2, 0) = 6.0;
	//testMatrix(2, 1) = 12.0;
	//testMatrix(2, 2) = 18.0;*/
	//testMatrix(0, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(0, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(0, 2) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 2) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 2) = std::numeric_limits<double>::quiet_NaN();
	//opserr << "This is matrix A: " << testMatrix << endln;
	//Matrix testInverse(3, 3);
	//double testTol = 1e-4;
	//int value=testMatrix.computePseudoInverseSymmetric(testInverse, testTol);
	//opserr << "This is testInverse: " << testInverse << endln;
	//int test1 = 1;

	//// Check ill-condition procedure
	//Matrix testMatrix(3, 3);
	///*testMatrix(0, 0) = 4;
	//testMatrix(0, 1) = 1;
	//testMatrix(0, 2) = 2;
	//testMatrix(1, 0) = 1;
	//testMatrix(1, 1) = 3;
	//testMatrix(1, 2) = 0;
	//testMatrix(2, 0) = 2;
	//testMatrix(2, 1) = 0;
	//testMatrix(2, 2) = 5;*/
	///*testMatrix(0, 0) = 2.0;
	//testMatrix(0, 1) = 4.0;
	//testMatrix(0, 2) = 6.0;
	//testMatrix(1, 0) = 4.0;
	//testMatrix(1, 1) = 8.0;
	//testMatrix(1, 2) = 12.0;
	//testMatrix(2, 0) = 6.0;
	//testMatrix(2, 1) = 12.0;
	//testMatrix(2, 2) = 18.0;*/
	///*testMatrix(0, 0) = 1.0;
	//testMatrix(0, 1) = 1.0;
	//testMatrix(0, 2) = 1.0;
	//testMatrix(1, 0) = 1.0;
	//testMatrix(1, 1) = 1.0001;
	//testMatrix(1, 2) = 1.0;
	//testMatrix(2, 0) = 1.0;
	//testMatrix(2, 1) = 1.0;
	//testMatrix(2, 2) = 1.0002;*/
	//testMatrix(0, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(0, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(0, 2) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(1, 2) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 0) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 1) = std::numeric_limits<double>::quiet_NaN();
	//testMatrix(2, 2) = std::numeric_limits<double>::quiet_NaN(); 
	//opserr << "This is matrix A: " << testMatrix << endln;
	//double testTol = 1e-4;
	//int isIllCond=testMatrix.checkIllCondition(testTol);
	//opserr << "This is isIllCond: " << isIllCond << endln;
	//int test1 = 1;
}

// Destructor
//      delete must be invoked on any objects created by the object
FBCElemSGINUS2d::~FBCElemSGINUS2d()
{
	if (sections != 0) {
		for (int i = 0; i < numSections; i++)
			if (sections[i] != 0)
				delete sections[i];
		delete[] sections;
	}

	if (sizeEleLoads != 0) {
		if (eleLoads != 0)
			delete[] eleLoads;

		if (eleLoadFactors != 0)
			delete[] eleLoadFactors;
	}

	if (FSection != 0) {
		delete[] FSection;
	}

	if (eNonlocal != 0) {
		delete[] eNonlocal;
	}

	if (sr != 0) {
		delete[] sr;
	}

	if (eNonlocalCommit != 0) {
		delete[] eNonlocalCommit;
	}

	if (eLocalCommit != 0) {
		delete[] eLocalCommit;
	}

	if (eLocal != 0) {
		delete[] eLocal;
	}

	if (srCommit != 0) {
		delete[] srCommit;
	}

	if (crdTransf != 0)
		delete crdTransf;

	if (beamIntegr != 0)
		delete beamIntegr;

	if (KelementInitial != 0)
		delete KelementInitial;
}

int
FBCElemSGINUS2d::getNumExternalNodes(void) const
{
	return 2;
}

const ID&
FBCElemSGINUS2d::getExternalNodes(void)
{
	return connectedExternalNodes;
}

Node**
FBCElemSGINUS2d::getNodePtrs()
{
	return theNodes;
}

int
FBCElemSGINUS2d::getNumDOF(void)
{
	return NEGD;
}

// Definition of setDomain()
void
FBCElemSGINUS2d::setDomain(Domain* theDomain)
{
	// check Domain is not null - invoked when object removed from a domain
	if (theDomain == 0) {
		theNodes[0] = 0;
		theNodes[1] = 0;

		opserr << "ERROR! FBCElemSGINUS2d::setDomain():  theDomain = 0 ";
		exit(0);
	}

	// Get pointers to the nodes
	int Nd1 = connectedExternalNodes(0);
	int Nd2 = connectedExternalNodes(1);

	theNodes[0] = theDomain->getNode(Nd1);
	theNodes[1] = theDomain->getNode(Nd2);

	if (theNodes[0] == 0) {
		opserr << "ERROR! FBCElemSGINUS2d::setDomain: Nd1: ";
		opserr << Nd1 << "does not exist in model\n";
		exit(0);
	}

	if (theNodes[1] == 0) {
		opserr << "ERROR! FBCElemSGINUS2d::setDomain: Nd2: ";
		opserr << Nd2 << "does not exist in model\n";
		exit(0);
	}

	// call the DomainComponent class method 
	this->DomainComponent::setDomain(theDomain);

	// ensure connected nodes have correct number of dof's
	int dofNode1 = theNodes[0]->getNumberDOF();
	int dofNode2 = theNodes[1]->getNumberDOF();

	if (dofNode1 != 3) {
		opserr << "ERROR! FBCElemSGINUS2d::setDomain() - element: " << this->getTag() << " - node " << Nd1 << " does not have 3 DOFs\n";
		exit(0);
	}

	if (dofNode2 != 3) {
		opserr << "ERROR! FBCElemSGINUS2d::setDomain() - element: " << this->getTag() << " - node " << Nd2 << " does not have 3 DOFs\n";
		exit(0);
	}

	// Initialize Coordinate Transformation
	if (crdTransf->initialize(theNodes[0], theNodes[1])) {
		opserr << "WARNING! FBCElemSGINUS2d::setDomain() - element: " << this->getTag() << " - Error initializing coordinate transformation\n";
		exit(0);
	}

	// get element length
	double L = crdTransf->getInitialLength();
	if (L == 0.0) {
		opserr << "WARNING! FBCElemSGINUS2d::setDomain(): element has zero length:" << this->getTag();
		exit(0);
	}

	if (initialFlag == 0)
	{
		this->initializeSectionHistoryVariables();

		// Initialize values of Ac and Bc for matrix H
		initCoefficientMatrixH();

		////Determination of matrix H
		//H.Zero();
		//this->computeMatrixH();

		////Determination of matrix H_inv
		//H_inv.Zero();
		//this->computeMatrixH_inv();
	}
}

//Function to commit state of the element
int
FBCElemSGINUS2d::commitState()
{
	int err = 0;

	// Element commitState()
	if ((err = this->Element::commitState()))
		opserr << "WARNING! FBCElemSGINUS2d::commitState() - element: " << this->getTag() << " - failed in committing base class\n";

	// Commit section state variables
	for (int i = 0; i < numSections; i++) {
		err += sections[i]->commitState();
		eNonlocalCommit[i] = eNonlocal[i];
		eLocalCommit[i] = eLocal[i];
		srCommit[i] = sr[i];
	}

	// Commit the element variables state
	KelementCommit = Kelement;
	qCommit = q;

	// Commit the transformation between coord. systems
	if ((err = crdTransf->commitState()) != 0)
		opserr << "WARNING! FBCElemSGINUS2d::commitState() - element: " << this->getTag() << " - failed to commit coordinate transformation object\n";

	WSofteningCommit = WSofteningTrial;

	// Complete committing the variables
	return err;
}

//Function to revert to last commit
int
FBCElemSGINUS2d::revertToLastCommit(void)
{
	int err = 0;
	// Revert section state variables to last committed state
	for (int i = 0; i < numSections; i++) {
		err += sections[i]->revertToLastCommit();
		eNonlocal[i] = eNonlocalCommit[i];
		eLocal[i] = eLocalCommit[i];

		sections[i]->setTrialSectionDeformation(eNonlocal[i]);
		//sr[i] = sections[i]->getStressResultant();
		sr[i] = srCommit[i];
		FSection[i] = sections[i]->getSectionFlexibility();
	}
	// Revert coordinate transformation object to last committed state
	if ((err = crdTransf->revertToLastCommit()))
		opserr << "WARNING! FBCElemSGINUS2d::revertToLastCommit() - element: " << this->getTag() << " - coordinate transformation object failed to revert to last committed state\n";

	// Revert the element variables state
	Kelement = KelementCommit;
	q = qCommit;

	WSofteningTrial = WSofteningCommit;

	initialFlag = 0;

	// complete reverting the variables
	return err;
}

//Function to revert to start
int
FBCElemSGINUS2d::revertToStart(void)
{
	// revert the sections state variables to start
	int err = 0;

	for (int i = 0; i < numSections; i++) {
		err += sections[i]->revertToStart();

		FSection[i].Zero();
		eNonlocal[i].Zero();
		sr[i].Zero();
		eLocal[i].Zero();
	}

	// revert the transformation to start
	if ((err = crdTransf->revertToStart()) != 0)
		opserr << "WARNING! FBCElemSGINUS2d::revertToStart() - element: " << this->getTag() << " - failed to revert to start coordinate transformation object\n";

	// revert the element state variables to start
	qCommit.Zero();
	KelementCommit.Zero();
	q.Zero();
	Kelement.Zero();

	WSofteningCommit = 0.;
	WSofteningTrial = 0.;

	initialFlag = 0;
	return err;
}

//Function to get initial element stiffness matrix in basic reference frame
const Matrix&
FBCElemSGINUS2d::getInitialStiff(void)
{
	// check for quick return
	if (KelementInitial != 0)
		return *KelementInitial;

	static Matrix f(NEBD, NEBD);   // element flexibility matrix  
	this->getInitialFlexibility(f);
	static Matrix KvInit(NEBD, NEBD);
	f.Invert(KvInit);
	KelementInitial = new Matrix(crdTransf->getInitialGlobalStiffMatrix(KvInit));
	return *KelementInitial;
}

//Function to get the tangent stiffness matrix
const Matrix&
FBCElemSGINUS2d::getTangentStiff(void)
{
	crdTransf->update();
	return crdTransf->getGlobalStiffMatrix(Kelement, q);

	// Try to fix issue with zero slope
	//double alphaElastic = 0.01; 
	//static Matrix f(NEBD, NEBD);   // element flexibility matrix  
	//this->getInitialFlexibility(f);
	//static Matrix KvInit(NEBD, NEBD);
	//f.Invert(KvInit);
	//Matrix K4Solver = alphaElastic * KvInit + (1. - alphaElastic) * Kelement;
	/*opserr << "This is K4Solver:" << K4Solver << endln;
	opserr << "This is Kelement:" << Kelement << endln;
	opserr << "This is Kelement-K4Solver:" << Kelement- K4Solver << endln;*/

	//return crdTransf->getGlobalStiffMatrix(K4Solver, q);
}

//Method to get reaction due to element loads
void
FBCElemSGINUS2d::computeReactions(double* p0)
{
	int type;
	double L = crdTransf->getInitialLength();

	for (int i = 0; i < numEleLoads; i++) {

		double loadFactor = eleLoadFactors[i];
		const Vector& data = eleLoads[i]->getData(type, loadFactor);

		if (type == LOAD_TAG_Beam2dUniformLoad) {
			double wa = data(1) * loadFactor;  // Axial
			double wy = data(0) * loadFactor;  // Transverse

			p0[0] -= wa * L;
			double V = 0.5 * wy * L;
			p0[1] -= V;
			p0[2] -= V;
		}
		else if (type == LOAD_TAG_Beam2dPartialUniformLoad) {
			double waa = data(2) * loadFactor;  // Axial
			double wab = data(3) * loadFactor;  // Axial
			double wya = data(0) * loadFactor;  // Transverse
			double wyb = data(1) * loadFactor;  // Transverse      
			double a = data(4) * L;
			double b = data(5) * L;

			p0[0] -= waa * (b - a) + 0.5 * (wab - waa) * (b - a);
			double Fy = wya * (b - a);
			double c = a + 0.5 * (b - a);
			p0[1] -= Fy * (1 - c / L);
			p0[2] -= Fy * c / L;
			Fy = 0.5 * (wyb - wya) * (b - a);
			c = a + 2.0 / 3.0 * (b - a);
			p0[1] -= Fy * (1 - c / L);
			p0[2] -= Fy * c / L;
		}
		else if (type == LOAD_TAG_Beam2dPointLoad) {
			double P = data(0) * loadFactor;
			double N = data(1) * loadFactor;
			double aOverL = data(2);

			if (aOverL < 0.0 || aOverL > 1.0)
				continue;

			double V1 = P * (1.0 - aOverL);
			double V2 = P * aOverL;

			p0[0] -= N;
			p0[1] -= V1;
			p0[2] -= V2;
		}
	}
}

//Function to get element resisting force vector global reference frame
const Vector&
FBCElemSGINUS2d::getResistingForce(void)
{
	double p0[3];
	Vector p0Vec(p0, 3);
	p0Vec.Zero();

	if (numEleLoads > 0)
		this->computeReactions(p0);

	crdTransf->update();
	return crdTransf->getGlobalResistingForce(q, p0Vec);
}

//Method to initialize section state variables
void
FBCElemSGINUS2d::initializeSectionHistoryVariables(void)
{
	for (int i = 0; i < numSections; i++) {
		int order = sections[i]->getOrder();

		FSection[i] = Matrix(order, order);
		eNonlocal[i] = Vector(order);
		sr[i] = Vector(order);
		eNonlocalCommit[i] = Vector(order);
		eLocal[i] = Vector(order);
		eLocalCommit[i] = Vector(order);
		srCommit[i] = Vector(order);
	}
}

//Method to solve for nodal forces
int
FBCElemSGINUS2d::update(void)
{
	// If have completed a recvSelf() - do a revertToLastCommit to get srSection etc. set correctly
	if (initialFlag == 2)
		this->revertToLastCommit();

	// Update the coordinate transformation
	crdTransf->update();

	//Get element displacements and displacements increments in basic reference frame
	const Vector& v = crdTransf->getBasicTrialDisp();
	static Vector dv(NEBD);
	dv = crdTransf->getBasicIncrDeltaDisp();

	//todo
	/*opserr << "This is v:" << v << endln;
	opserr << "This is dv:" << dv << endln;*/

	if (initialFlag != 0 && dv.Norm() <= DBL_EPSILON && numEleLoads == 0)
		return 0;

	static Vector vin(NEBD);
	vin = v;
	vin -= dv;

	double L = crdTransf->getInitialLength();
	double oneOverL = 1.0 / L;

	double xi[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, xi);

	//double wt[maxNumSections];
	double wt[maxNumSections];
	beamIntegr->getSectionWeights(numSections, L, wt);

	////todo
	//opserr << "This is the location of the integration points: ";
	//for (int ip = 0; ip < numSections; ip++) {
	//	opserr << xi[ip] << "    ";
	//}
	//opserr << "Finished\n ";
	//opserr << "This is the weights of the integration points: ";
	//for (int ip = 0; ip < numSections; ip++) {
	//	opserr << wt[ip] << "    ";
	//}
	//opserr << "Finished\n ";
	//return -1;

	static Vector vu(NEBD);       // element unbalanced displacements
	static Matrix Felement(NEBD, NEBD);   // element flexibility matrix

	static Matrix I(NEBD, NEBD);   // an identity matrix for matrix inverse
	int i, j;

	I.Zero();
	for (i = 0; i < NEBD; i++)
		I(i, i) = 1.0;

	int numSubdivide = 1;
	bool converged = false;
	static Vector dq(NEBD);
	static Vector dvToDo(NEBD);
	static Vector dvTrial(NEBD);
	static Vector qTrial(NEBD);
	static Matrix KelementTrial(NEBD, NEBD);

	//todo
	/*opserr << "This is matrix H: " << H << endln;
	opserr << "This is matrix H_inv: " << H_inv << endln;*/

	//Initilitation variables for nonlocal formulation
	//Initilitation variables for nonlocal formulation
	/*static Matrix deStar_local_Tot(NEBD, numSections);
	static Matrix deStar_nonlocal_Tot(NEBD, numSections);
	static Matrix eu_local_Tot(NEBD, numSections);
	static Matrix eu_nonlocal_Tot(NEBD, numSections);*/
	Vector deStar_local_Tot[maxNumSections];
	Vector deStar_nonlocal_Tot[maxNumSections];
	Vector eu_local_Tot[maxNumSections];
	Vector eu_nonlocal_Tot[maxNumSections];
	Vector s_Tot[maxNumSections];
	//static Matrix Felement_nonlocal(NEBD, NEBD);

	//Initialization of array of vector and matrices for nonlocal formulation
	for (int ii = 0; ii < numSections; ii++) {
		int order = sections[ii]->getOrder();

		s_Tot[ii] = Vector(order);
		deStar_local_Tot[ii] = Vector(order);
		deStar_nonlocal_Tot[ii] = Vector(order);
		eu_local_Tot[ii] = Vector(order);
		eu_nonlocal_Tot[ii] = Vector(order);
	}

	//Zero variables for nonlocal formulation
	/*deStar_local_Tot.Zero();
	deStar_nonlocal_Tot.Zero();
	eu_local_Tot.Zero();
	eu_nonlocal_Tot.Zero();*/

	dvToDo = dv;
	dvTrial = dvToDo;

	static double factor = 2;

	maxSubdivisions = 20;

	while (converged == false && numSubdivide <= maxSubdivisions)
	{
		// try regular newton (if l==0), or
	  // initial tangent iterations (if l==1), or

		for (int l = 0; l < 2; l++) {

			qTrial = q;
			KelementTrial = Kelement;

			for (i = 0; i < numSections; i++)
			{
				eNonLocalSubdivide[i] = eNonlocal[i];
				eLocalSubdivide[i] = eLocal[i];
				FSectionSubdivide[i] = FSection[i];
				srSubdivide[i] = sr[i];

				//Added 23.10.2023 so that goes to zero when change l
				eu_nonlocal_Tot[i].Zero();
				eu_local_Tot[i].Zero();
			}

			// calculate nodal force increments and update nodal forces dq=KelementTrial*dvTrial
			dq.addMatrixVector(0.0, KelementTrial, dvTrial, 1.0);
			qTrial += dq;

			////todo
			//opserr << "This is dvTrial" << dvTrial << endln;
			//opserr << "This is KelementTrial" << KelementTrial << endln;
			//opserr << "This is qTrial:" << qTrial<< endln;

			if (initialFlag != 2)
			{
				// set the maximum number of iteration
				int numItersMax = maxIters;

				if (l == 1) // l==1 -> Modified Newton with initial stiffness
				{
					for (i = 0; i < numSections; i++)
					{
						FSectionSubdivide[i] = sections[i]->getInitialFlexibility();
					}
					// Increase the maximum number of iterations because Modified Newton
					numItersMax = 10 * maxIters;
				}

				for (j = 0; j < numItersMax; j++)
				{
					// initialize f and vr for integration
					Felement.Zero();
					vu.Zero();

					//Compute matrices H and Hinv for nonlocal
					//computeMatrixH();
					computeCoefficientMatrixH();

					//todo store this in matri and use and the end
					//if (beamIntegr->addElasticFlexibility(L, Felement) < 0)
					{
						/*vu(0) += Felement(0, 0) * qTrial(0);
						vu(1) += Felement(1, 1) * qTrial(1) + Felement(1, 2) * qTrial(2);
						vu(2) += Felement(2, 1) * qTrial(1) + Felement(2, 2) * qTrial(2);*/
					}

					//double v0[3];
					//v0[0] = 0.0; v0[1] = 0.0; v0[2] = 0.0;

					//for (int ie = 0; ie < numEleLoads; ie++)
					//	beamIntegr->addElasticDeformations(eleLoads[ie], eleLoadFactors[ie], L, v0);

					//// Add effects of element loads
					//vu(0) += v0[0];
					//vu(1) += v0[1];
					//vu(2) += v0[2];

					for (i = 0; i < numSections; i++)
					{
						int order = sections[i]->getOrder();
						const ID& code = sections[i]->getType();

						//static Vector s_seci(NEBD);
						Vector ds(2);
						//static Vector deStar_local_seci(NEBD);
						Matrix Fb(2, 2);

						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						// calculate total section forces s = b*q + bp*currDistrLoad;
						int ii;
						for (ii = 0; ii < order; ii++)
						{
							switch (code(ii))
							{
							case SECTION_RESPONSE_P:
								s_Tot[i](ii) = qTrial(0);
								break;
							case SECTION_RESPONSE_MZ:
								s_Tot[i](ii) = xL1 * qTrial(1) + xL * qTrial(2);
								break;
							case SECTION_RESPONSE_VY:
								s_Tot[i](ii) = oneOverL * (qTrial(1) + qTrial(2));
								break;
							default:
								s_Tot[i](ii) = 0.0;
								break;
							}
						}
						// Add the effects of element loads, if present s = b*q + sp
						if (numEleLoads > 0)
							this->computeSectionForces(s_Tot[i], i);

						//// ds = s - sr[i];
						//ds = s_seci;
						//ds.addVector(1.0, srSubdivide[i], -1.0);

						// calculate increment section forces ds = b*dq;
						for (ii = 0; ii < order; ii++)
						{
							switch (code(ii))
							{
							case SECTION_RESPONSE_P:
								ds(ii) = dq(0);
								break;
							case SECTION_RESPONSE_MZ:
								ds(ii) = xL1 * dq(1) + xL * dq(2);
								break;
							case SECTION_RESPONSE_VY:
								ds(ii) = oneOverL * (dq(1) + dq(2));
								break;
							default:
								ds(ii) = 0.0;
								break;
							}
						}

						//Add s_seci to matrix containing all section forces
						//s_Tot[i] = s_seci;

						//opserr << "This is s_seci:" << s_seci << endln;

						// compute local section deformation increments e += fs * ds;   
						deStar_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);

						//opserr << "This is deStar_local_sec:" << deStar_local_seci << endln;
					}

					//Compute deStar_nonlocal[]
					this->computeDeStar_nonlocal(deStar_nonlocal_Tot, deStar_local_Tot);

					////todo
					/*opserr << "This is deStar_local_Tot:" << deStar_local_Tot << endln;
					opserr << "This is deStar_nonlocal_Tot:" << deStar_nonlocal_Tot << endln;*/
					//opserr << "This is eu_nonlocal_Tot:" << eu_nonlocal_Tot << endln;

					for (i = 0; i < numSections; i++)
					{
						// set section deformations
						if (initialFlag != 0)
						{
							eNonLocalSubdivide[i] += deStar_nonlocal_Tot[i];  //e_NL += deStar_nonlocal
							eNonLocalSubdivide[i] += eu_nonlocal_Tot[i];  //e_NL += eu_nonlocal
						}

						eLocalSubdivide[i] += deStar_local_Tot[i] + eu_local_Tot[i];
					}

					for (i = 0; i < numSections; i++)
					{
						//static Vector eu_local_interm(2);  //intermediate vector to fill eu_local_tot
						//eu_local_interm.Zero();

						//Set the section deformations for section state determination
						if (sections[i]->setTrialSectionDeformation(eLocalSubdivide[i]) < 0)
						{
							opserr << "FBCElemSGINUS2d::update() - section failed in setTrial\n";
							opserr << "This is section: " << i + 1 << endln;
							return -1;
						}

						// get section resisting forces
						srSubdivide[i] = sections[i]->getStressResultant();


						if (l == 0) // Newton-Raphson scheme
						{
							//// get section flexibility matrix
							//FSectionSubdivide[i] = sections[i]->getSectionFlexibility();
							//Compute section flexibility using decompostion and pseudoInverse
							const Matrix& Ksection = sections[i]->getSectionTangent();

							int isIllCondition = Ksection.checkIllCondition(1e-12);
							if (isIllCondition == 0) {// The matrix is not ill-conditioned 
								FSectionSubdivide[i] = sections[i]->getSectionFlexibility();
							}
							else // The matrix singular (ill-conditioned)
							{
								const Matrix& Fsection_elastic = sections[i]->getInitialFlexibility();
								const Matrix& Ksection_elastic = sections[i]->getInitialTangent();
								Matrix Ksection_intermed1 = Ksection - Ksection_elastic;
								Matrix Ksection_intermed1_inverse = Matrix(2, 2);
								Ksection_intermed1.Invert(Ksection_intermed1_inverse);
								Matrix Ksection_plastic = Ksection - Ksection * Ksection_intermed1_inverse * Ksection;
								/*opserr << "This is Ksection: " << Ksection << endln;
								opserr << "This is Ksection_intermed1: " << Ksection_intermed1 << endln;
								opserr << "This is Ksection_intermed1_inverse: " << Ksection_intermed1_inverse << endln;
								opserr << "This is Ksection_plastic: " << Ksection_plastic << endln;*/
								Matrix Fsection_plastic = Matrix(2, 2);
								if (Ksection_plastic.computePseudoInverseSymmetric(Fsection_plastic, 1e-2) < 0)
								{
									return -1; // matrix has nan (modified DH 18.03.2025)
								}
								FSectionSubdivide[i] = Fsection_elastic + Fsection_plastic;
								/*opserr << "This is Fsection_elastic: " << Fsection_elastic << endln;
								opserr << "This is Fsection_plastic: " << Fsection_plastic << endln;
								opserr << "This is Fsection: " << FSectionSubdivide[i] << endln;*/

								// Increase the maximum number of iterations because Modified Newton
								numItersMax = 10 * maxIters;
							}
						}

						// calculate section residual deformations de = FSection * (s - sr);
						static Vector s_seci(2); // initialize vector s_secii
						static Vector ds(2);

						ds = s_Tot[i];  //take the corresponding section force from matrix with all section forces
						ds.addVector(1.0, srSubdivide[i], -1.0);  // ds = s - sr[i];

						//compute eu_local for section i
						eu_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);

					}

					//Compute eu_non_local_tot
					this->computeEu_nonlocal(eu_nonlocal_Tot, eu_local_Tot);

					//Compute Felement_nonlocal
					this->computeFelement_nonlocal(Felement);
					//Felement = Felement_nonlocal;

					for (i = 0; i < numSections; i++)
					{
						int order = sections[i]->getOrder();
						const ID& code = sections[i]->getType();

						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						double dei;
						double tmp;

						for (int ii = 0; ii < order; ii++)
						{
							dei = eu_nonlocal_Tot[i](ii) * wtL;
							switch (code(ii))
							{
							case SECTION_RESPONSE_P:
								vu(0) += dei;
								break;
							case SECTION_RESPONSE_MZ:
								vu(1) += xL1 * dei;
								vu(2) += xL * dei;
								break;
							case SECTION_RESPONSE_VY:
								tmp = oneOverL * dei;
								vu(1) += tmp;
								vu(2) += tmp;
								break;
							default:
								break;
							}
						}
					}
					//vu.Zero();
					////vu = v - integrale_BeuNL;
					//vu = integrale_BeuNL; //using definition below

					// calculate element stiffness matrix invert3by3Matrix(F, Kelement);	  
					if (Felement.Solve(I, KelementTrial) < 0) {
						opserr << "FBCElemSGINUS2d::update() -- could not invert flexibility\n";
						/*opserr << "This is Felement: " <<Felement<<endln;
						opserr << "This is KelementTrial: " << KelementTrial << endln;*/
					}

					// Check if section experiences softening
					double WDot_isec;
					double WDot_cumulativeSoft = 0.;
					double WDot_cumulativeElasticUnload = 0.;
					double elasticUnload = 0.;
					//double WDot_isec_cumulativeElastic = 0.;
					//double WDot_totElastic = 0.;
					for (i = 0; i < numSections; i++)
					{
						WDot_isec = 0.;
						for (int iComp = 0; iComp < 2; iComp++)
						{
							WDot_isec += 0.5 * (srSubdivide[i](iComp) - srCommit[i](iComp)) * (eLocalSubdivide[i](iComp) - eLocalCommit[i](iComp));
						}
						//opserr << "This is WDot:" << WDot << endln;
						//if (WDot_isec < 0. && abs(WDot_isec)>1)
						if (WDot_isec < 0.)
						{
							WDot_cumulativeSoft += WDot_isec;
						}
						else if (eLocalSubdivide[i].Norm() - eLocalCommit[i].Norm() < 0.)
							//else if (eLocalSubdivide[i].Norm() - eLocalCommit[i].Norm() < 0. && abs(eLocalSubdivide[i].Norm() - eLocalCommit[i].Norm()) > 1.* eLocalCommit[i].Norm())
						{
							elasticUnload += 1;
							WDot_cumulativeElasticUnload += WDot_isec;
						}
					}
					if (elasticUnload == numSections)
					{
						WSofteningTrial = std::max(std::min(WSofteningCommit + WDot_cumulativeElasticUnload, 0.), WSofteningTol);
					}
					else
					{
						WSofteningTrial = std::max(std::min(WSofteningCommit + WDot_cumulativeSoft, 0.), WSofteningTol);
					}

					//todo 
					//opserr << "This is the element flexibility matrix:" << Felement << endln;
					//opserr << "This is the element stiffness matrix:" << KelementTrial << endln;
					//return -1;

					//// dv = vin + dvTrial  - vu
					//dv = vin;
					//dv += dvTrial;
					//dv -= vu;

					//opserr << "This is dv prior change:" << dv << endln;

					//// dv = -vin - dvTrial  + vu
					//dv.addVector(0.0, vin, -1.0);
					//dv -= dvTrial;
					//dv += vu;

					// dv = -vin - dvTrial  + vu +v
					dv.addVector(0.0, vu, -1.0);
					/*dv -= dvTrial;
					dv += vu;
					dv += v;*/

					//opserr << "This is vu:" << vu << endln;
					//opserr << "This is vin:" << vin << endln;
					//opserr << "This is dvTrial:" << dvTrial << endln;
					//opserr << "This is dv:" << dv << endln;

					// dq = Kelement * dv;
					dq.addMatrixVector(0.0, KelementTrial, dv, 1.0);

					qTrial += dq;

					// check for convergence of this interval
					if (dv.Norm() < Tol)
						//if (dv.Norm()/(dvTrial.Norm()+ DBL_EPSILON) < Tol)
					{
						// set the target displacement
						dvToDo -= dvTrial;
						vin += dvTrial;

						// check if we have got to where we wanted
						if (dvToDo.Norm() <= DBL_EPSILON)
						{
							converged = true;
						}
						else
						{
							// we convreged but we have more to do
							// reset variables for start of next subdivision
							dvTrial = dvToDo;
							numSubdivide = 1;
						}

						// set Kelement, e and q values
						Kelement = KelementTrial;
						q = qTrial;

						for (int k = 0; k < numSections; k++)
						{
							eNonlocal[k] = eNonLocalSubdivide[k];
							eLocal[k] = eLocalSubdivide[k];
							FSection[k] = FSectionSubdivide[k];
							sr[k] = srSubdivide[k];
						}

						// break out of j & l loops
						j = numItersMax + 1;
						l = 3;
					}
					else //if(dv.Norm() < tolerance)
					{
						// if we have failed to converge for all of our newton schemes - reduce step size by the factor specified

						if ((j == (numItersMax - 1)) && (l == 1))
						{
							dvTrial /= factor;
							numSubdivide++;
						}
					}
				}// for (j=0; j<numIters; j++)
			}// if (initialFlag != 2)
		} // for (int l=0; l<2; l++)
	}// while (converged == false)


	// if fail to converge we return an error flag & print an error message
	if (converged == false)
	{
		opserr << "WARNING - FBCElemSGINUS2d::update - failed to get compatible ";
		opserr << "element forces & deformations for element: ";
		opserr << this->getTag() << "(Norm dv: << " << dv.Norm() << ")\n";
		opserr << this->getTag() << "( dv: << " << dv << ")\n";
		return -1;
	}

	initialFlag = 1;

	return 0;
}

// Method to get force interpolation matrix b
void FBCElemSGINUS2d::getForceInterpolatMatrix(double xi, Matrix& b, const ID& code)
{
	b.Zero();

	double L = crdTransf->getInitialLength();
	for (int i = 0; i < code.Size(); i++)
	{
		switch (code(i))
		{
		case SECTION_RESPONSE_MZ:		// Moment, Mz, interpolation
			b(i, 1) = xi - 1.0;
			b(i, 2) = xi;
			break;
		case SECTION_RESPONSE_P:		// Axial, P, interpolation
			b(i, 0) = 1.0;
			break;
		case SECTION_RESPONSE_VY:		// Shear, Vy, interpolation
			b(i, 1) = b(i, 2) = 1.0 / L;
			break;
		default:
			break;
		}
	}
}

// Method to get force interpolation matrix bp due to distributed loads
void FBCElemSGINUS2d::getDistrLoadInterpolatMatrix(double xi, Matrix& bp, const ID& code)
{
	bp.Zero();

	double L = crdTransf->getInitialLength();
	for (int i = 0; i < code.Size(); i++)
	{
		switch (code(i))
		{
		case SECTION_RESPONSE_MZ:		// Moment, Mz, interpolation
			bp(i, 1) = xi * (xi - 1) * L * L / 2;
			break;
		case SECTION_RESPONSE_P:		// Axial, P, interpolation
			bp(i, 0) = (1 - xi) * L;
			break;
		case SECTION_RESPONSE_VY:		// Shear, Vy, interpolation
			bp(i, 1) = (xi - 0.5) * L;
			break;
		default:
			break;
		}
	}
}

//Method to compute section forces
void
FBCElemSGINUS2d::computeSectionForces(Vector& sp, int isec)
{
	int type;

	double L = crdTransf->getInitialLength();

	double xi[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, xi);
	double x = xi[isec] * L;

	int order = sections[isec]->getOrder();
	const ID& code = sections[isec]->getType();

	for (int i = 0; i < numEleLoads; i++)
	{
		double loadFactor = eleLoadFactors[i];
		const Vector& data = eleLoads[i]->getData(type, loadFactor);

		if (type == LOAD_TAG_Beam2dUniformLoad)
		{
			double wa = data(1) * loadFactor;  // Axial
			double wy = data(0) * loadFactor;  // Transverse

			for (int ii = 0; ii < order; ii++)
			{
				switch (code(ii))
				{
				case SECTION_RESPONSE_P:
					sp(ii) += wa * (L - x);
					break;
				case SECTION_RESPONSE_MZ:
					sp(ii) += wy * 0.5 * x * (x - L);
					break;
				case SECTION_RESPONSE_VY:
					sp(ii) += wy * (x - 0.5 * L);
					break;
				default:
					break;
				}
			}
		}
		else if (type == LOAD_TAG_Beam2dPartialUniformLoad)
		{
			double waa = data(2) * loadFactor;  // Axial
			double wab = data(3) * loadFactor;  // Axial
			double wya = data(0) * loadFactor;  // Transverse
			double wyb = data(1) * loadFactor;  // Transverse
			double a = data(4) * L;
			double b = data(5) * L;

			double Fa = waa * (b - a) + 0.5 * (wab - waa) * (b - a); // resultant axial load
			double Fy = wya * (b - a); // resultant transverse load
			double c = a + 0.5 * (b - a);
			double VI = Fy * (1 - c / L);
			double VJ = Fy * c / L;
			Fy = 0.5 * (wyb - wya) * (b - a); // resultant transverse load
			c = a + 2.0 / 3.0 * (b - a);
			VI += Fy * (1 - c / L);
			VJ += Fy * c / L;

			for (int ii = 0; ii < order; ii++)
			{
				if (x <= a)
				{
					switch (code(ii))
					{
					case SECTION_RESPONSE_P:
						sp(ii) += Fa;
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) -= VI * x;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) -= VI;
						break;
					default:
						break;
					}
				}
				else if (x >= b)
				{
					switch (code(ii))
					{
					case SECTION_RESPONSE_MZ:
						sp(ii) += VJ * (x - L);
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += VJ;
						break;
					default:
						break;
					}
				}
				else
				{
					double wx = wya + (wyb - wya) / (b - a) * (x - a);
					switch (code(ii))
					{
					case SECTION_RESPONSE_P:
						sp(ii) += Fa - waa * (x - a) - 0.5 * (wab - waa) / (b - a) * (x - a) * (x - a);
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) += -VI * x + wya * (x - a) * 0.5 * (x - a) + 0.5 * (wx - wya) * (x - a) * (x - a) / 3.0;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += -VI + wya * (x - a) + 0.5 * (wx - wya) * (x - a);
						break;
					default:
						break;
					}
				}
			}
		}
		else if (type == LOAD_TAG_Beam2dPointLoad)
		{
			double P = data(0) * loadFactor;
			double N = data(1) * loadFactor;
			double aOverL = data(2);

			if (aOverL < 0.0 || aOverL > 1.0)
				continue;

			double a = aOverL * L;

			double V1 = P * (1.0 - aOverL);
			double V2 = P * aOverL;

			for (int ii = 0; ii < order; ii++)
			{
				if (x <= a)
				{
					switch (code(ii))
					{
					case SECTION_RESPONSE_P:
						sp(ii) += N;
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) -= x * V1;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) -= V1;
						break;
					default:
						break;
					}
				}
				else
				{
					switch (code(ii))
					{
					case SECTION_RESPONSE_MZ:
						sp(ii) -= (L - x) * V2;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += V2;
						break;
					default:
						break;
					}
				}
			}
		}
		else
		{
			opserr << "FBCElemSGINUS2d::addLoad -- load type unknown for element with tag: " <<
				this->getTag() << endln;
		}
	}
}

//Method to get the mass matrix
const Matrix&
FBCElemSGINUS2d::getMass(void)
{
	theMatrix.Zero();

	double L = crdTransf->getInitialLength();
	//if (rho != 0.0)
		//theMatrix(0, 0) = theMatrix(1, 1) = theMatrix(3, 3) = theMatrix(4, 4) = 0.5 * L * rho;

	return theMatrix; // For now returns matrix 0. need to add rho to .h file 
}

//Method for zero element loads
void
FBCElemSGINUS2d::zeroLoad(void)
{
	load.Zero();

	numEleLoads = 0;

	return;
}

// Method to add element loads
int
FBCElemSGINUS2d::addLoad(ElementalLoad* theLoad, double loadFactor)
{
	if (numEleLoads == sizeEleLoads)
	{

		// create larger arrays, copy old, delete old & set as new

		ElementalLoad** theNextEleLoads = new ElementalLoad * [sizeEleLoads + 1];
		double* theNextEleLoadFactors = new double[sizeEleLoads + 1];
		for (int i = 0; i < numEleLoads; i++)
		{
			theNextEleLoads[i] = eleLoads[i];
			theNextEleLoadFactors[i] = eleLoadFactors[i];
		}
		delete[] eleLoads;
		delete[] eleLoadFactors;
		eleLoads = theNextEleLoads;
		eleLoadFactors = theNextEleLoadFactors;

		// increment array size
		sizeEleLoads += 1;
	}

	eleLoadFactors[numEleLoads] = loadFactor;
	eleLoads[numEleLoads] = theLoad;
	numEleLoads++;

	return 0;
}

//Method to include inertia forces to element resisting forces
const Vector&
FBCElemSGINUS2d::getResistingForceIncInertia()
{
	// Compute the current resisting force
	theVector = this->getResistingForce();

	// add the damping forces if rayleigh damping
	if (betaK != 0.0 || betaK0 != 0.0 || betaKc != 0.0)
		theVector += this->getRayleighDampingForces();

	return theVector;
}

//Method for sending itself for parallel processing
int
FBCElemSGINUS2d::sendSelf(int commitTag, Channel& theChannel)
{
	// No parallel processing for now
	opserr << "WARNING! FBCElemSGINUS2d::sendSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for receiving itself for parallel processing
int
FBCElemSGINUS2d::recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker)
{
	// No parallel processing for now
	opserr << "WARNING! FBCElemSGINUS2d::recvSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for computing initial element flexibility matrix
int
FBCElemSGINUS2d::getInitialFlexibility(Matrix& Fe)
{
	Fe.Zero();

	double L = crdTransf->getInitialLength();
	double oneOverL = 1.0 / L;

	// Flexibility from elastic interior
	beamIntegr->addElasticFlexibility(L, Fe);

	double xi[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, xi);

	double wt[maxNumSections];
	beamIntegr->getSectionWeights(numSections, L, wt);

	for (int i = 0; i < numSections; i++)
	{
		int order = sections[i]->getOrder();
		const ID& code = sections[i]->getType();

		Matrix Fb(workArea, order, 3);

		double xL = xi[i];
		double xL1 = xL - 1.0;
		double wtL = wt[i] * L;

		const Matrix& FSec = sections[i]->getInitialFlexibility();
		Fb.Zero();
		double tmp;
		int ii, jj;
		for (ii = 0; ii < order; ii++)
		{
			switch (code(ii))
			{
			case SECTION_RESPONSE_P:
				for (jj = 0; jj < order; jj++)
					Fb(jj, 0) += FSec(jj, ii) * wtL;
				break;
			case SECTION_RESPONSE_MZ:
				for (jj = 0; jj < order; jj++)
				{
					tmp = FSec(jj, ii) * wtL;
					Fb(jj, 1) += xL1 * tmp;
					Fb(jj, 2) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VY:
				for (jj = 0; jj < order; jj++)
				{
					tmp = oneOverL * FSec(jj, ii) * wtL;
					Fb(jj, 1) += tmp;
					Fb(jj, 2) += tmp;
				}
				break;
			default:
				break;
			}
		}
		for (ii = 0; ii < order; ii++)
		{
			switch (code(ii))
			{
			case SECTION_RESPONSE_P:
				for (jj = 0; jj < 3; jj++)
					Fe(0, jj) += Fb(ii, jj);
				break;
			case SECTION_RESPONSE_MZ:
				for (jj = 0; jj < 3; jj++)
				{
					tmp = Fb(ii, jj);
					Fe(1, jj) += xL1 * tmp;
					Fe(2, jj) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VY:
				for (jj = 0; jj < 3; jj++)
				{
					tmp = oneOverL * Fb(ii, jj);
					Fe(1, jj) += tmp;
					Fe(2, jj) += tmp;
				}
				break;
			default:
				break;
			}
		}
	}
	return 0;
}

//Method for printing 
void
FBCElemSGINUS2d::Print(OPS_Stream& s, int flag)
{
	s << "Element Tag: " << this->getTag() << endln;
	s << "Type: FBCElemSGINUS2d" << endln;
	s << "Connected Node Tags: iNode " << connectedExternalNodes(0)
		<< ", jNode " << connectedExternalNodes(1) << endln;
	s << "Section Tag: " << sections[0]->getTag() << endln;
	s << "Number of Sections: " << numSections << endln;
}

//Method to draw and view the element
int
FBCElemSGINUS2d::displaySelf(Renderer& theViewer, int displayMode, float fact, const char** displayModes, int numModes)
{
	static Vector v1(3);
	static Vector v2(3);

	theNodes[0]->getDisplayCrds(v1, fact, displayMode);
	theNodes[1]->getDisplayCrds(v2, fact, displayMode);

	return theViewer.drawLine(v1, v2, 1.0, 1.0, this->getTag());
}

//Method to define response parameters
Response*
FBCElemSGINUS2d::setResponse(const char** argv, int argc, OPS_Stream& output)
{
	// Define and initialize theResponse
	Response* theResponse = 0;

	output.tag("ElementOutput");
	output.attr("eleType", this->getClassType());
	output.attr("eleTag", this->getTag());
	output.attr("node1", connectedExternalNodes[0]);
	output.attr("node2", connectedExternalNodes[1]);

	// Global forces
	if (strcmp(argv[0], "force") == 0 || strcmp(argv[0], "forces") == 0 ||
		strcmp(argv[0], "globalForce") == 0 || strcmp(argv[0], "globalForces") == 0)
	{
		output.tag("ResponseType", "Px_1");
		output.tag("ResponseType", "Py_1");
		output.tag("ResponseType", "Mz_1");
		output.tag("ResponseType", "Px_2");
		output.tag("ResponseType", "Py_2");
		output.tag("ResponseType", "Mz_2");

		theResponse = new ElementResponse(this, 1, theVector);
	}

	// Local forces
	else if (strcmp(argv[0], "localForce") == 0 || strcmp(argv[0], "localForces") == 0)
	{
		output.tag("ResponseType", "N_ 1");
		output.tag("ResponseType", "My_1");
		output.tag("ResponseType", "Vy_1");
		output.tag("ResponseType", "N_2");
		output.tag("ResponseType", "Mz_2");
		output.tag("ResponseType", "Vy_2");

		theResponse = new ElementResponse(this, 2, theVector);
	}

	// Basic forces
	else if (strcmp(argv[0], "basicForce") == 0 || strcmp(argv[0], "basicForces") == 0)
	{
		output.tag("ResponseType", "N_J");
		output.tag("ResponseType", "Mz_I");
		output.tag("ResponseType", "Mz_J");

		theResponse = new ElementResponse(this, 3, Vector(3));
	}

	//Nonlocal section deformations
	else if (strcmp(argv[0], "NonlocalSectionDeformations") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 4, Matrix(2, numSections));
	}

	//Local section deformations
	else if (strcmp(argv[0], "LocalSectionDeformations") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 5, Matrix(2, numSections));
	}

	//Local section curvatures
	else if (strcmp(argv[0], "LocalSectionCurvature") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 6, Vector(numSections));
	}

	//Nonlocal section curvatures
	else if (strcmp(argv[0], "NonlocalSectionCurvature") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 7, Vector(numSections));
	}

	// Moment distribution along length
	else if (strcmp(argv[0], "momentDistribution") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 8, Vector(numSections));
	}

	// Element basic deformations
	else if (strcmp(argv[0], "basicDeformation") == 0)
	{
		output.tag("ResponseType", "eps");
		output.tag("ResponseType", "theta_1");
		output.tag("ResponseType", "theta_2");

		theResponse = new ElementResponse(this, 9, Vector(3));
	}

	//Section response
	else if (strstr(argv[0], "section") != 0)
	{
		if (argc > 1) {

			int sectionNum = atoi(argv[1]);

			if (sectionNum > 0 && sectionNum <= numSections && argc > 2) {

				double xi[maxNumSections];
				double L = crdTransf->getInitialLength();
				beamIntegr->getSectionLocations(numSections, L, xi);

				output.tag("GaussPointOutput");
				output.attr("number", sectionNum);
				output.attr("eta", xi[sectionNum - 1] * L);

				if (strcmp(argv[2], "dsdh") != 0) {
					theResponse = sections[sectionNum - 1]->setResponse(&argv[2], argc - 2, output);
				}
				else {
					int order = sections[sectionNum - 1]->getOrder();
					theResponse = new ElementResponse(this, 76, Vector(order));
					Information& info = theResponse->getInformation();
					info.theInt = sectionNum;
				}

				output.endTag();

			}
		}
	}

	return theResponse;
}

//Method to get the response parameters
int
FBCElemSGINUS2d::getResponse(int responseID, Information& eleInfo)
{
	switch (responseID)
	{
	case 1: // Global forces
		return eleInfo.setVector(this->getResistingForce());

	case 2: // Local forces
		double p0[3]; p0[0] = 0.0; p0[1] = 0.0; p0[2] = 0.0;
		if (numEleLoads > 0)
			this->computeReactions(p0);
		theVector(3) = q(0);
		theVector(0) = -q(0) + p0[0];
		theVector(2) = q(1);
		theVector(5) = q(2);
		double V;
		V = (q(1) + q(2)) / crdTransf->getInitialLength();
		theVector(1) = V + p0[1];
		theVector(4) = -V + p0[2];
		return eleInfo.setVector(theVector);

	case 3: // Basic forces
		return eleInfo.setVector(q);

	case 4: //nonlocal section deformations
	{
		Matrix eNonlocalOutput(2, numSections);
		eNonlocalOutput.Zero();
		Vector eNonlocalOutput_int(2);  //intermediate vector to fill
		for (int i = 0; i < numSections; i++)
		{
			eNonlocalOutput_int = eNonlocalCommit[i];
			eNonlocalOutput(0, i) = eNonlocalOutput_int(0);
			eNonlocalOutput(1, i) = eNonlocalOutput_int(1);
		}
		//todo
		/*opserr << "This is eNonlocalOutput"<< eNonlocalOutput << endln;*/
		return eleInfo.setMatrix(eNonlocalOutput);
	}

	case 5: //local section deformations
	{
		Matrix eLocalOutput(2, numSections);
		this->computeE_local(eLocalOutput);
		//todo
		/*opserr << "This is eLocalOutput" << eLocalOutput << endln;*/
		return eleInfo.setMatrix(eLocalOutput);
	}

	case 6: //local section curvatures
	{
		Vector localCurvatureOutput(numSections);
		for (int i = 0; i < numSections; i++)
		{
			localCurvatureOutput(i) = eLocal[i](1);
		}
		//todo
		//opserr << "This is localCurvatureOutput" << localCurvatureOutput << endln;
		return eleInfo.setVector(localCurvatureOutput);
	}

	case 7: //nonlocal section curvatures
	{
		Vector nonlocalCurvatureOutput(numSections);
		for (int i = 0; i < numSections; i++)
		{
			nonlocalCurvatureOutput(i) = eNonlocal[i](1);
		}
		//todo
		//opserr << "This is nonlocalCurvatureOutput" << nonlocalCurvatureOutput << endln;
		return eleInfo.setVector(nonlocalCurvatureOutput);
	}

	case 8: //moment distribution
	{
		Vector momentDistributionOutput(numSections);
		for (int i = 0; i < numSections; i++)
		{
			momentDistributionOutput(i) = sr[i](1);
		}
		//todo
		//opserr << "This is localCurvatureOutput" << localCurvatureOutput << endln;
		return eleInfo.setVector(momentDistributionOutput);
	}

	case 9: //element basic deformations
	{
		Vector vp(3);
		vp = crdTransf->getBasicTrialDisp();
		return eleInfo.setVector(vp);
	}


	default:
		return -1;
	}
}

//Method the set section pointers
void
FBCElemSGINUS2d::setSectionPointers(int numSec, SectionForceDeformation** secPtrs)
{
	if (numSec > maxNumSections) {
		opserr << "GradientError: ForceBeamColumn2d::setSectionPointers -- max number of sections exceeded";
	}

	numSections = numSec;

	if (secPtrs == 0) {
		opserr << "Error: FBCElemSGINUS2d::setSectionPointers -- invalid section pointer";
	}

	sections = new SectionForceDeformation * [numSections];
	if (sections == 0) {
		opserr << "Error: FBCElemSGINUS2d::setSectionPointers -- could not allocate section pointers";
	}

	for (int i = 0; i < numSections; i++) {

		if (secPtrs[i] == 0) {
			opserr << "Error: FBCElemSGINUS2d::setSectionPointers -- null section pointer " << i << endln;
		}

		sections[i] = secPtrs[i]->getCopy();

		if (sections[i] == 0) {
			opserr << "Error: FBCElemSGINUS2d::setSectionPointers -- could not create copy of section " << i << endln;
		}
	}

	// allocate section flexibility matrices and section deformation vectors
	FSection = new Matrix[numSections];
	if (FSection == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate fs array";
	}

	eNonlocal = new Vector[numSections];
	if (eNonlocal == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vs array";
	}

	sr = new Vector[numSections];
	if (sr == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate Ssr array";
	}

	eNonlocalCommit = new Vector[numSections];
	if (eNonlocalCommit == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vscommit array";
	}

	eLocal = new Vector[numSections];
	if (eLocal == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vs array";
	}

	srCommit = new Vector[numSections];
	if (srCommit == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate Ssr array";
	}

	eLocalCommit = new Vector[numSections];
	if (eLocalCommit == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vscommit array";
	}

}

// Method to compute theroy values Ac and Bc for matrix H
void
FBCElemSGINUS2d::initCoefficientMatrixH()
{
	double L = crdTransf->getInitialLength();
	double secX[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, secX);

	double dx = L * (secX[1] - secX[0]);	// spaces between first and second integration points

	Ac4MatrixHGI = 1 + pow((lc / dx), 2);
	Bc4MatrixHGI = 0.5 * (1. - Ac4MatrixHGI);

	double ASection = sections[0]->getSectionArea();
	//WSofteningTol = -1. * numSections * ASection * 0.5 * 378. * 1e-6;
	WSofteningTol = -1. * ASection * 0.5 * 378. * 1e-6;
	//WSofteningTol = -1e-6;

	//opserr << "This is Ac4MatrixHGI:" << Ac4MatrixHGI << endln;
	//opserr << "This is Bc4MatrixHGI:" << Bc4MatrixHGI << endln;
	//opserr << "This is WSofteningTol:" << WSofteningTol << endln;
}

// Method to compute updated values Ac using exponential smoothing function and Bc for matrix H
void
FBCElemSGINUS2d::computeCoefficientMatrixH()
{
	//Ac4MatrixH = Ac4MatrixHGI;

	double xStar = 1. - WSofteningTrial / WSofteningTol;
	double fXStar = 0.;
	double f1MinusXStar = 0.;
	if (xStar > 0.)
	{
		fXStar = exp(-1. / xStar);
	}
	if (1. - xStar > 0.)
	{
		f1MinusXStar = exp(-1. / (1. - xStar));
	}
	double gXStar = fXStar / (fXStar + f1MinusXStar);

	Ac4MatrixH = gXStar * 1 + (1 - gXStar) * Ac4MatrixHGI;

	Bc4MatrixH = 0.5 * (1. - Ac4MatrixH);

	//opserr << "This is Ac4MatrixH:" << Ac4MatrixH << endln;
	//opserr << "This is Bc4MatrixH:" << Bc4MatrixH << endln;
}

//Method to compute matrix H 
void
FBCElemSGINUS2d::computeMatrixH()
{
	H.Zero(); // initialize matrix H

	int order = sections[0]->getOrder();   // use first section to get the order

	computeCoefficientMatrixH();

	// 2nd Order PDE, Dirichlet BCs
	for (int i = 0; i < order; i++) {
		H(i, i) = 1.0;
		H(order * numSections - i - 1, order * numSections - i - 1) = 1.0;
	}

	for (int j = 1; j < numSections - 1; j++) {
		for (int i = 0; i < order; i++) {
			H(j * order + i, (j - 1) * order + i) = Bc4MatrixH;
			H(j * order + i, j * order + i) = Ac4MatrixH;
			H(j * order + i, (j + 1) * order + i) = Bc4MatrixH;
		}
	}

	//computeMatrixH_inv();
	//opserr << "This is matrix H:" << H << endln;
}

//Method to compute H_inv - NOT USED
void
FBCElemSGINUS2d::computeMatrixH_inv()
{
	H_inv.Zero();
	if (H.Invert(H_inv) < 0)
		opserr << "FBCElemSGINUS2d::update() -- could not invert matrix H\n";
}

//Method to compute deStar_nonlocal[]
void
FBCElemSGINUS2d::computeDeStar_nonlocal(Vector deStar_nonlocal_Tot[], Vector deStar_local_Tot[])
{
	//deStar_nonlocal.Zero();

	//Vector deStarLocal_MatrixFormALLSections = Vector(NEBD * numSections);
	//Vector deStarNonLocal_MatrixFormALLSections = Vector(NEBD * numSections);


	// Fill the vector with all the local section deformations
	/*for (int i = 0; i < numSections; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			deStarLocal_MatrixFormALLSections(i * NEBD + j) = deStar_local_Tot[i](j);
		}
	}*/

	// Compute the vector with all the nonlocal section deformations
	//deStarNonLocal_MatrixFormALLSections = H_inv * deStarLocal_MatrixFormALLSections;

	//Fill the matrix eu_nonlocal
	/*for (int i = 0; i < numSections; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			deStar_nonlocal_Tot[i](j) = deStarNonLocal_MatrixFormALLSections(i * NEBD + j);
		}
	}*/

	if (abs(WSofteningTrial) == 0.)
	{
		for (int i = 0; i < numSections; i++)
		{
			deStar_nonlocal_Tot[i] = deStar_local_Tot[i];
		}
	}
	else
	{
		Vector alpha4LU(numSections);
		Vector beta4LU(numSections);
		alpha4LU(0) = 1;
		beta4LU(0) = 0;
		beta4LU(1) = Bc4MatrixH;
		alpha4LU(1) = Ac4MatrixH;
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		int i;
		int j;

		for (j = 2; j < numSections - 1; j++)
		{
			beta4LU(j) = Bc4MatrixH / alpha4LU(j - 1);
			alpha4LU(j) = Ac4MatrixH - beta4LU(j) * Bc4MatrixH;
		}

		// Boundary conditions
		deStar_nonlocal_Tot[0] = deStar_local_Tot[0];
		deStar_nonlocal_Tot[numSections - 1] = deStar_local_Tot[numSections - 1];

		Vector y4LU(numSections);
		for (i = 0; i < 2; i++)
		{
			y4LU(0) = deStar_local_Tot[0](i);
			for (j = 1; j < numSections; j++)
			{
				y4LU(j) = deStar_local_Tot[j](i) - beta4LU(j) * y4LU(j - 1);
			}

			for (j = numSections - 2; j > 0; j--)
			{
				deStar_nonlocal_Tot[j](i) = (y4LU(j) - Bc4MatrixH * deStar_nonlocal_Tot[j + 1](i)) / alpha4LU(j);
			}
		}
		/*opserr << "This is deStar_local_Tot in function:" << deStar_local_Tot[2] << endln;
		opserr << "This is deStar_nonlocal_Tot in funtion:" << deStar_nonlocal_Tot[2] << endln;*/
	}

	//todo
	/*opserr << "This is deStar_local_Tot in function:" << deStar_local << endln;
	opserr << "This is deStar_nonlocal_Tot in funtion:" << deStar_nonlocal << endln;*/
}

//Method to compute e_local[] - NOT USED
void
FBCElemSGINUS2d::computeE_local(Matrix& e_local_tot)
{
	e_local_tot.Zero();
	Vector eNonLocal_SectionI_temp = Vector(NEBD);
	Vector eNonLocal_MatrixFormALLSections = Vector(NEBD * numSections);
	Vector eLocal_MatrixFormALLSections = Vector(NEBD * numSections);

	// Fill the vector with all the nonlocal section deformations
	for (int i = 0; i < numSections; i++)
	{
		eNonLocal_SectionI_temp = eNonLocalSubdivide[i];
		//opserr << "This is eNonLocal_SectionI_temp:" << eNonLocal_SectionI_temp << endln;

		for (int j = 0; j < NEBD; j++)
		{
			eNonLocal_MatrixFormALLSections(i * NEBD + j) = eNonLocal_SectionI_temp(j);
			//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln;
		}
	}

	//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln; 

	// Compute the vector with all the local section deformations
	eLocal_MatrixFormALLSections = H * eNonLocal_MatrixFormALLSections;

	//opserr << "This is eLocal_MatrixFormALLSections:" << eLocal_MatrixFormALLSections << endln; 

	//Fill the matrix e_local_tot
	for (int i = 0; i < numSections; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			e_local_tot(j, i) = eLocal_MatrixFormALLSections(i * NEBD + j);
		}
	}

	/*opserr << "This is e_local_tot:" << e_local_tot << endln;
	double test = 0.;*/
}

//Method to compute eu_nonlocal_Tot
void
FBCElemSGINUS2d::computeEu_nonlocal(Vector eu_nonlocal_Tot[], Vector eu_local_Tot[])
{
	//eu_nonlocal.Zero();

	//Vector euLocal_MatrixFormALLSections = Vector(NEBD * numSections);
	//Vector euNonLocal_MatrixFormALLSections = Vector(NEBD * numSections);


	//// Fill the vector with all the local section deformations
	//for (int i = 0; i < numSections; i++)
	//{
	//	for (int j = 0; j < NEBD; j++)
	//	{
	//		euLocal_MatrixFormALLSections(i * NEBD + j) = eu_local_Tot[i](j);
	//	}
	//}

	//// Compute the vector with all the nonlocal section deformations
	//euNonLocal_MatrixFormALLSections = H_inv * euLocal_MatrixFormALLSections;

	////Fill the matrix eu_nonlocal
	//for (int i = 0; i < numSections; i++)
	//{
	//	for (int j = 0; j < NEBD; j++)
	//	{
	//		eu_nonlocal_Tot[i](j) = euNonLocal_MatrixFormALLSections(i * NEBD + j);
	//	}
	//}


	if (abs(WSofteningTrial) == 0.)
	{
		for (int i = 0; i < numSections; i++)
		{
			eu_nonlocal_Tot[i] = eu_local_Tot[i];
		}
	}
	else
	{
		Vector alpha4LU(numSections);
		Vector beta4LU(numSections);
		alpha4LU(0) = 1;
		beta4LU(0) = 0;
		beta4LU(1) = Bc4MatrixH;
		alpha4LU(1) = Ac4MatrixH;
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		int i;
		int j;

		for (j = 2; j < numSections - 1; j++)
		{
			beta4LU(j) = Bc4MatrixH / alpha4LU(j - 1);
			alpha4LU(j) = Ac4MatrixH - beta4LU(j) * Bc4MatrixH;
		}

		// Boundary conditions
		eu_nonlocal_Tot[0] = eu_local_Tot[0];
		eu_nonlocal_Tot[numSections - 1] = eu_local_Tot[numSections - 1];

		Vector y4LU(numSections);
		for (i = 0; i < 2; i++)
		{
			y4LU(0) = eu_local_Tot[0](i);
			for (j = 1; j < numSections; j++)
			{
				y4LU(j) = eu_local_Tot[j](i) - beta4LU(j) * y4LU(j - 1);
			}

			for (j = numSections - 2; j > 0; j--)
			{
				eu_nonlocal_Tot[j](i) = (y4LU(j) - Bc4MatrixH * eu_nonlocal_Tot[j + 1](i)) / alpha4LU(j);
			}
		}

		/*opserr << "This is deStar_local_Tot in function:" << eu_local_Tot[2] << endln;
		opserr << "This is deStar_nonlocal_Tot in funtion:" << eu_nonlocal_Tot[2] << endln;*/

	}
}

//Method to compute nonlocal element flexibility matrix
void
FBCElemSGINUS2d::computeFelement_nonlocal(Matrix& Felement_nonlocal)
{
	Felement_nonlocal.Zero();
	Matrix b(2, 3);
	Matrix B_Q(2 * numSections, 3);
	Matrix B_q(3, 2 * numSections);
	Matrix Fsection_Tot(2 * numSections, 2 * numSections);
	/*B_Q.Zero();
	B_q.Zero();
	Fsection_Tot.Zero();*/

	//get info on integration quadrature rule
	double L = crdTransf->getInitialLength();
	double xi[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, xi);
	double wt[maxNumSections];
	beamIntegr->getSectionWeights(numSections, L, wt);

	/*for (int i = 0; i < numSections; i++) {
		opserr << "This xi:" << xi[i] << endln;
	}
	double sumWt = 0.;
	for (int i = 0; i < numSections; i++) {
		opserr << "This wt:" << wt[i] << endln;
		sumWt = sumWt + wt[i];
	}
	opserr << "This sum(wt):" << sumWt << endln;*/

	int i;
	int j;
	int k;

	for (i = 0; i < numSections; i++)
	{
		//compute matrix b
		b.Zero();
		const ID& code = sections[i]->getType();
		this->getForceInterpolatMatrix(xi[i], b, code);

		//compute matrices B_Q and B_q
		double wtL = wt[i] * L;

		B_Q(2 * i, 0) = b(0, 0);
		B_Q(2 * i, 1) = b(0, 1);
		B_Q(2 * i, 2) = b(0, 2);
		B_Q(2 * i + 1, 0) = b(1, 0);
		B_Q(2 * i + 1, 1) = b(1, 1);
		B_Q(2 * i + 1, 2) = b(1, 2);

		B_q(0, 2 * i) = b(0, 0) * wtL;
		B_q(0, 2 * i + 1) = b(0, 1) * wtL;
		B_q(1, 2 * i) = b(1, 0) * wtL;
		B_q(1, 2 * i + 1) = b(1, 1) * wtL;
		B_q(2, 2 * i) = b(0, 2) * wtL;
		B_q(2, 2 * i + 1) = b(1, 2) * wtL;

		//assemble matrix Fsection_Tot
		//Matrix Fsection_interm(NEBD, NEBD); //intermediate matrix to fill Fsection_Tot
		//Fsection_interm = FSectionSubdivide[i];

		//opserr << "This matrix Fsection_interm:" << Fsection_interm << endln;

		Fsection_Tot(2 * i, 2 * i) = FSectionSubdivide[i](0, 0);
		Fsection_Tot(2 * i, 2 * i + 1) = FSectionSubdivide[i](0, 1);
		Fsection_Tot(2 * i + 1, 2 * i) = FSectionSubdivide[i](1, 0);
		Fsection_Tot(2 * i + 1, 2 * i + 1) = FSectionSubdivide[i](1, 1);
	}

	Matrix Hinv_multFsection_Tot(2 * numSections, 2 * numSections);

	if (abs(WSofteningTrial) == 0.)
	{
		Hinv_multFsection_Tot = Fsection_Tot;
	}
	else
	{
		Vector alpha4LU(numSections);
		Vector beta4LU(numSections);
		alpha4LU(0) = 1;
		beta4LU(0) = 0;
		beta4LU(1) = Bc4MatrixH;
		alpha4LU(1) = Ac4MatrixH;
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		for (j = 2; j < numSections - 1; j++)
		{
			beta4LU(j) = Bc4MatrixH / alpha4LU(j - 1);
			alpha4LU(j) = Ac4MatrixH - beta4LU(j) * Bc4MatrixH;
		}

		// Boundary conditions
		for (i = 0; i < 2; i++)
		{
			for (j = 0; j < 2; j++)
			{
				Hinv_multFsection_Tot(i, j) = Fsection_Tot(i, j);
				Hinv_multFsection_Tot(2 * numSections - 1 - i, 2 * numSections - 1 - j) = Fsection_Tot(2 * numSections - 1 - i, 2 * numSections - 1 - j);
			}
		}

		// Thomas algorithm
		Vector y4LU(2 * numSections);
		for (i = 0; i < 2 * numSections; i++)
		{
			for (k = 0; k < 2; k++)
			{
				y4LU(k) = Fsection_Tot(k, i);
			}
			for (j = 2; j < 2 * numSections; j++)
			{
				y4LU(j) = Fsection_Tot(j, i) - beta4LU(j / 2) * y4LU(j - 2);
			}
			for (j = 2 * numSections - 2 - 1; j > 2 - 1; j--)
			{
				Hinv_multFsection_Tot(j, i) = (y4LU(j) - Bc4MatrixH * Hinv_multFsection_Tot(j + 2, i)) / alpha4LU(j / 2);
			}
		}

	}

	Felement_nonlocal = B_q * Hinv_multFsection_Tot * B_Q;

	//compute the matrix multiplication F_element_nonLocal=B_q*inv(H)*Fsection_Tot*B_Q;
	//computeMatrixH();
	//computeMatrixH_inv();
	//Matrix Felement_nonlocal_target = B_q * H_inv * Fsection_Tot * B_Q;
	//Felement_nonlocal = B_q * H_inv * Fsection_Tot * B_Q;

	/*opserr << "This matrix FHinv_multFsection_Target:" << H_inv * Fsection_Tot << endln;
	opserr << "This Hinv_multFsection_Tot:" << Hinv_multFsection_Tot << endln;*/
	//opserr << "This matrix Felement_nonlocal_target:" << Felement_nonlocal_target << endln;
	//opserr << "This matrix Felement_nonlocal:" << Felement_nonlocal << endln;

	//opserr << "This matrix B_q:" << B_q << endln;
	//opserr << "This matrix H:" << H << endln;
	//opserr << "This matrix H_inv:" << H_inv << endln;
	//opserr << "This matrix H_inv*Fsection_Tot:" << H_inv * Fsection_Tot << endln;
	//opserr << "This matrix Fsection_Tot:" << Fsection_Tot << endln;
	//opserr << "This matrix B_Q:" << B_Q << endln;
	//opserr << "This matrix Felement_nonlocal:" << Felement_nonlocal << endln;
	//double test = 0.;
}