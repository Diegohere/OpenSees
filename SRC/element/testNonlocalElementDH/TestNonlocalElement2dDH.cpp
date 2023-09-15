//
// Created by Diego Heredia on 31.07.2023
//

#include "TestNonlocalElement2dDH.h"

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
Matrix TestNonlocalElement2dDH::theMatrix(6, 6);
Vector TestNonlocalElement2dDH::theVector(6);
double TestNonlocalElement2dDH::workArea[200];

Vector TestNonlocalElement2dDH::eNonLocalSubdivide[maxNumSections];
Vector TestNonlocalElement2dDH::eLocalSubdivide[maxNumSections];
Matrix TestNonlocalElement2dDH::FSectionSubdivide[maxNumSections];
Vector TestNonlocalElement2dDH::srSubdivide[maxNumSections];

// Method to read the command arguments
void* OPS_TestNonlocalElement2dDH()
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
	Element* theEle = new TestNonlocalElement2dDH(eleTag, nodeTagI, nodeTagJ, *theCoordTransf, *theBeamIntegration,
		sections, numIntegrPoints, maxNumIters, tolerance,lc);
	delete[] sections;
	return 0;
}

// Constructor 2 (for parallel processing)
TestNonlocalElement2dDH::TestNonlocalElement2dDH() : Element(0, ELE_TAG_TestNonlocalElement2dDH), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
maxIters(0), Tol(0), lc(0), initialFlag(0),
Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(2 * 10, 2 * 10), H_inv(2 * 10, 2 * 10),
FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0), Ac4MatrixHTheory(0), Bc4MatrixHTheory(0), Ac4MatrixH(0), Bc4MatrixH(0)
// complete
{
	// Set Node Pointers to 0
	theNodes[0] = 0;
	theNodes[1] = 0;

	load.Zero();
}

// Constructor 1 (for normal processing) invoked by a FEM_ObjectBroker
TestNonlocalElement2dDH::TestNonlocalElement2dDH(int tag, int nodeI, int nodeJ, CrdTransf& CT, BeamIntegration& BI,
	SectionForceDeformation** sec, int numSec, int maxNumIters, double tolerance, double LC)
	:Element(tag, ELE_TAG_TestNonlocalElement2dDH), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
	maxIters(maxNumIters), Tol(tolerance), lc(LC), initialFlag(0),
	Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(2 * numSec, 2 * numSec), H_inv(2 * numSec, 2 * numSec),
	FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
	numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
	WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0), Ac4MatrixHTheory(0), Bc4MatrixHTheory(0), Ac4MatrixH(0), Bc4MatrixH(0)
	// complete
{
	// Pointers to Nodes and Their IDs
	if (connectedExternalNodes.Size() != 2) {
		opserr << "WARNING! TestNonlocalElement2dDH::TestNonlocalElement2dDH(): " << this->getTag() << " - failed to create an ID of size 2\n";
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
		opserr << "WARNING! TestNonlocalElement2dDH::TestNonlocalElement2dDH(): " << this->getTag() << " - could not create copy of beam integration object" << endln;
		exit(-1);
	}

	// get copy of the transformation object   
	crdTransf = CT.getCopy2d();
	if (crdTransf == 0) {
		opserr << "WARNING! TestNonlocalElement2dDH::TestNonlocalElement2dDH(): could not create copy of coordinate transformation object" << endln;
		exit(-1);
	}

	//get copy of sections
	this->setSectionPointers(numSec, sec);
}

// Destructor
//      delete must be invoked on any objects created by the object
TestNonlocalElement2dDH::~TestNonlocalElement2dDH()
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
TestNonlocalElement2dDH::getNumExternalNodes(void) const
{
	return 2;
}

const ID&
TestNonlocalElement2dDH::getExternalNodes(void)
{
	return connectedExternalNodes;
}

Node**
TestNonlocalElement2dDH::getNodePtrs()
{
	return theNodes;
}

int
TestNonlocalElement2dDH::getNumDOF(void)
{
	return NEGD;
}

// Definition of setDomain()
void
TestNonlocalElement2dDH::setDomain(Domain* theDomain)
{
	// check Domain is not null - invoked when object removed from a domain
	if (theDomain == 0) {
		theNodes[0] = 0;
		theNodes[1] = 0;

		opserr << "ERROR! TestNonlocalElement2dDH::setDomain():  theDomain = 0 ";
		exit(0);
	}

	// Get pointers to the nodes
	int Nd1 = connectedExternalNodes(0);
	int Nd2 = connectedExternalNodes(1);

	theNodes[0] = theDomain->getNode(Nd1);
	theNodes[1] = theDomain->getNode(Nd2);

	if (theNodes[0] == 0) {
		opserr << "ERROR! TestNonlocalElement2dDH::setDomain: Nd1: ";
		opserr << Nd1 << "does not exist in model\n";
		exit(0);
	}

	if (theNodes[1] == 0) {
		opserr << "ERROR! TestNonlocalElement2dDH::setDomain: Nd2: ";
		opserr << Nd2 << "does not exist in model\n";
		exit(0);
	}

	// call the DomainComponent class method 
	this->DomainComponent::setDomain(theDomain);

	// ensure connected nodes have correct number of dof's
	int dofNode1 = theNodes[0]->getNumberDOF();
	int dofNode2 = theNodes[1]->getNumberDOF();

	if (dofNode1 != 3) {
		opserr << "ERROR! TestNonlocalElement2dDH::setDomain() - element: " << this->getTag() << " - node " << Nd1 << " does not have 3 DOFs\n";
		exit(0);
	}

	if (dofNode2 != 3) {
		opserr << "ERROR! TestNonlocalElement2dDH::setDomain() - element: " << this->getTag() << " - node " << Nd2 << " does not have 3 DOFs\n";
		exit(0);
	}

	// Initialize Coordinate Transformation
	if (crdTransf->initialize(theNodes[0], theNodes[1])) {
		opserr << "WARNING! TestNonlocalElement2dDH::setDomain() - element: " << this->getTag() << " - Error initializing coordinate transformation\n";
		exit(0);
	}

	// get element length
	double L = crdTransf->getInitialLength();
	if (L == 0.0) {
		opserr << "WARNING! TestNonlocalElement2dDH::setDomain(): element has zero length:" << this->getTag();
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
TestNonlocalElement2dDH::commitState()
{
	int err = 0;

	// Element commitState()
	if ((err = this->Element::commitState()))
		opserr << "WARNING! TestNonlocalElement2dDH::commitState() - element: " << this->getTag() << " - failed in committing base class\n";

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
		opserr << "WARNING! TestNonlocalElement2dDH::commitState() - element: " << this->getTag() << " - failed to commit coordinate transformation object\n";

	WSofteningCommit = WSofteningTrial;

	// Complete committing the variables
	return err;
}

//Function to revert to last commit
int
TestNonlocalElement2dDH::revertToLastCommit(void)
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
		opserr << "WARNING! TestNonlocalElement2dDH::revertToLastCommit() - element: " << this->getTag() << " - coordinate transformation object failed to revert to last committed state\n";

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
TestNonlocalElement2dDH::revertToStart(void)
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
		opserr << "WARNING! TestNonlocalElement2dDH::revertToStart() - element: " << this->getTag() << " - failed to revert to start coordinate transformation object\n";

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
TestNonlocalElement2dDH::getInitialStiff(void)
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
TestNonlocalElement2dDH::getTangentStiff(void)
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
TestNonlocalElement2dDH::computeReactions(double* p0)
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
TestNonlocalElement2dDH::getResistingForce(void)
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
TestNonlocalElement2dDH::initializeSectionHistoryVariables(void)
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
TestNonlocalElement2dDH::update(void)
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

	double *xi;
	xi=new double[numSections];
	beamIntegr->getSectionLocations(numSections, L, xi);

	//double wt[maxNumSections];
	double* wt;
	wt = new double[numSections];
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
	Vector* deStar_local_Tot;
	Vector* deStar_nonlocal_Tot;
	Vector* eu_local_Tot;
	Vector* eu_nonlocal_Tot;
	deStar_local_Tot = new Vector[numSections];
	deStar_nonlocal_Tot = new Vector[numSections];
	eu_local_Tot = new Vector[numSections];
	eu_nonlocal_Tot = new Vector[numSections];
	Vector* s_Tot;
	s_Tot = new Vector[numSections];
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

	static double factor = 10;

	maxSubdivisions = 4;

	while (converged == false && numSubdivide <= maxSubdivisions)
	{
		// try regular newton (if l==0), or
		// initial tangent on first iteration then regular newton (if l==1), or 
		// initial tangent iterations (if l==2)
		for (int l = 0; l < 3; l++)
		{
			qTrial = q;
			KelementTrial = Kelement;

			for (i = 0; i < numSections; i++)
			{
				eNonLocalSubdivide[i] = eNonlocal[i];
				eLocalSubdivide[i] = eLocal[i];
				FSectionSubdivide[i] = FSection[i];
				srSubdivide[i] = sr[i];
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
				int numIters = maxIters;
				if (l == 1)
					numIters = 10 * maxIters; // allow 10 times more iterations for initial tangent

				for (j = 0; j < numIters; j++)
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

						/*s_seci.setData(workArea, order);
						ds.setData(&workArea[order], order);
						deStar_local_seci.setData(&workArea[2 * order], order);
						Fb.setData(&workArea[3 * order], order, 3);*/

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

						////todo
						//opserr << "This is s_seci:" << s_seci << endln;

						// compute local section deformation increments
						if (l == 0)
						{
							//  regular newton e += fs * ds;     
							deStar_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);
						}
						else if (l == 2)
						{
							//  newton with initial tangent if first iteration e += FSection0 * ds;     
							//  otherwise regular newton e += FSection * ds;    
							if (j == 0)
							{
								const Matrix& FSection0 = sections[i]->getInitialFlexibility();

								deStar_local_Tot[i].addMatrixVector(0.0, FSection0, ds, 1.0);
							}
							else
							{
								deStar_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);
							}
						}
						else
						{
							//  newton with initial tangent e += FSection0 * ds;    
							const Matrix& FSection0 = sections[i]->getInitialFlexibility();
							deStar_local_Tot[i].addMatrixVector(0.0, FSection0, ds, 1.0);
						}

						////todo
						//opserr << "This is deStar_local_sec:" << deStar_local_seci << endln;

						//Add each delta e_star_local to matrix containing all sections
						/*deStar_local_Tot(0, i) = deStar_local_seci(0);
						deStar_local_Tot(1, i) = deStar_local_seci(1);*/

					}

					//Compute deStar_nonlocal[]
					this->computeDeStar_nonlocal(deStar_nonlocal_Tot, deStar_local_Tot);

					////todo
					/*opserr << "This is deStar_local_Tot:" << deStar_local_Tot << endln;
					opserr << "This is deStar_nonlocal_Tot:" << deStar_nonlocal_Tot << endln;*/
					//opserr << "This is eu_nonlocal_Tot:" << eu_nonlocal_Tot << endln;

					for (i = 0; i < numSections; i++)
					{

						//Initilization variables needed in this loop
						/*static Vector deStar_nonlocal_isec(NEBD);
						static Vector eu_nonlocal_isec(NEBD);*/

						//Fil the vector with actual values
						/*deStar_nonlocal_isec(0) = deStar_nonlocal_Tot(0, i);
						deStar_nonlocal_isec(1) = deStar_nonlocal_Tot(1, i);

						eu_nonlocal_isec(0) = eu_nonlocal_Tot(0, i);
						eu_nonlocal_isec(1) = eu_nonlocal_Tot(1, i);*/

						// set section deformations
						if (initialFlag != 0)
						{
							eNonLocalSubdivide[i] += deStar_nonlocal_Tot[i];  //e_NL += deStar_nonlocal
							eNonLocalSubdivide[i] += eu_nonlocal_Tot[i];  //e_NL += eu_nonlocal
						}

						eLocalSubdivide[i] += deStar_local_Tot[i] + eu_local_Tot[i];
					}

					//Compute the local section deformations for section state determination
					//this->computeE_local(numSections, eNonLocalSubdivide, H, e_local_Tot);

					//Loop to fill the eLocalSUbdivide vector from the matrix E_local
					//static Vector eLocalSubdivide_isec(2);  //intermediate vector to fill eLocalSUbdivide
					//for (i = 0; i < numSections; i++)
					//{
					//	eLocalSubdivide_isec.Zero();

					//	//Fill the intermediate vector
					//	eLocalSubdivide_isec(0) = e_local_Tot(0, i);
					//	eLocalSubdivide_isec(1) = e_local_Tot(1, i);

					//	//Put the intermediate vector in the final vector
					//	eLocalSubdivide[i] = eLocalSubdivide_isec;
					//}

					for (i = 0; i < numSections; i++)
					{
						//static Vector eu_local_interm(2);  //intermediate vector to fill eu_local_tot
						//eu_local_interm.Zero();

						//Set the section deformations for section state determination
						if (sections[i]->setTrialSectionDeformation(eLocalSubdivide[i]) < 0)
						{
							opserr << "TestNonlocalElement2dDH::update() - section failed in setTrial\n";
							opserr << "This is section: " << i + 1 << endln;
							return -1;
						}

						// get section resisting forces
						srSubdivide[i] = sections[i]->getStressResultant();

						// get section flexibility matrix
						FSectionSubdivide[i] = sections[i]->getSectionFlexibility();

						// calculate section residual deformations de = FSection * (s - sr);
						static Vector s_seci(2); // initialize vector s_secii
						static Vector ds(2);

						ds = s_Tot[i];  //take the corresponding section force from matrix with all section forces
						ds.addVector(1.0, srSubdivide[i], -1.0);  // ds = s - sr[i];

						//compute eu_local for section i
						eu_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);

						//Fill matrix eu_local_tot with eu_local for section i
						/*eu_local_Tot(0, i) = eu_local_interm(0);
						eu_local_Tot(1, i) = eu_local_interm(1);*/

					}

					//Compute eu_non_local_tot
					this->computeEu_nonlocal(eu_nonlocal_Tot, eu_local_Tot);

					//Compute Felement_nonlocal
					this->computeFelement_nonlocal(Felement);
					//Felement = Felement_nonlocal;

					//Initilization of integrale_BeuNL
					/*static Vector integrale_BeuNL(NEBD);
					integrale_BeuNL.Zero();*/

					for (i = 0; i < numSections; i++)
					{

						//This was for local formulation
						// integrate element flexibility matrix f = f + (b^ fs * b) * wtL;

						/*int jj;
						const Matrix& FSec = FSectionSubdivide[i];
						Fb.Zero();
						double tmp;

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
									Felement(0, jj) += Fb(ii, jj);
								break;
							case SECTION_RESPONSE_MZ:
								for (jj = 0; jj < 3; jj++)
								{
									tmp = Fb(ii, jj);
									Felement(1, jj) += xL1 * tmp;
									Felement(2, jj) += xL * tmp;
								}
								break;
							case SECTION_RESPONSE_VY:
								for (jj = 0; jj < 3; jj++)
								{
									tmp = oneOverL * Fb(ii, jj);
									Felement(1, jj) += tmp;
									Felement(2, jj) += tmp;
								}
								break;
							default:
								break;
							}
						}*/

						// Integrate unbalanced deformations vu += (b^ (e + de)) * wtL  vr.addMatrixTransposeVector(1.0, b[i], vs[i] + dvs, wtL);;
						//de.addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0); //used for local formulation
						//de.addVector(1.0, eSubdivide[i], 1.0);   //used for local formulation

						int order = sections[i]->getOrder();
						const ID& code = sections[i]->getType();

						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						double dei;
						/*static Vector dei_interm(2);
						dei_interm = eNonLocalSubdivide[i];*/
						double tmp;

						for (int ii = 0; ii < order; ii++)
						{
							//dei = dei_interm(ii) * wtL;
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
						opserr << "TestNonlocalElement2dDH::update() -- could not invert flexibility\n";
						//opserr << "This is Felement:" <<Felement<<endln;
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
						j = numIters + 1;
						l = 4;
					}
					else //if(dv.Norm() < tolerance)
					{
						// if we have failed to converge for all of our newton schemes - reduce step size by the factor specified

						if (j == (numIters - 1) && (l == 2))
						{
							dvTrial /= factor;
							numSubdivide++;
						}
					}
				}// for (j=0; j<numIters; j++)
			}// if (initialFlag != 2)
		}// for (int l=0; l<2; l++)
	}// while (converged == false)


	// if fail to converge we return an error flag & print an error message
	if (converged == false)
	{
		opserr << "WARNING - TestNonlocalElement2dDH::update - failed to get compatible ";
		opserr << "element forces & deformations for element: ";
		opserr << this->getTag() << "(Norm dv: << " << dv.Norm() << ")\n";
		opserr << this->getTag() << "( dv: << " << dv << ")\n";
		return -1;
	}

	initialFlag = 1;

	return 0;
}

// Method to get force interpolation matrix b
void TestNonlocalElement2dDH::getForceInterpolatMatrix(double xi, Matrix& b, const ID& code)
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
void TestNonlocalElement2dDH::getDistrLoadInterpolatMatrix(double xi, Matrix& bp, const ID& code)
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
TestNonlocalElement2dDH::computeSectionForces(Vector& sp, int isec)
{
	int type;

	double L = crdTransf->getInitialLength();

	//double xi[maxNumSections];
	double* xi;
	xi = new double[numSections];
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
			opserr << "TestNonlocalElement2dDH::addLoad -- load type unknown for element with tag: " <<
				this->getTag() << endln;
		}
	}
}

//Method to get the mass matrix
const Matrix&
TestNonlocalElement2dDH::getMass(void)
{
	theMatrix.Zero();

	double L = crdTransf->getInitialLength();
	//if (rho != 0.0)
		//theMatrix(0, 0) = theMatrix(1, 1) = theMatrix(3, 3) = theMatrix(4, 4) = 0.5 * L * rho;

	return theMatrix; // For now returns matrix 0. need to add rho to .h file 
}

//Method for zero element loads
void
TestNonlocalElement2dDH::zeroLoad(void)
{
	load.Zero();

	numEleLoads = 0;

	return;
}

// Method to add element loads
int
TestNonlocalElement2dDH::addLoad(ElementalLoad* theLoad, double loadFactor)
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
TestNonlocalElement2dDH::getResistingForceIncInertia()
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
TestNonlocalElement2dDH::sendSelf(int commitTag, Channel& theChannel)
{
	// No parallel processing for now
	opserr << "WARNING! TestNonlocalElement2dDH::sendSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for receiving itself for parallel processing
int
TestNonlocalElement2dDH::recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker)
{
	// No parallel processing for now
	opserr << "WARNING! TestNonlocalElement2dDH::recvSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for computing initial element flexibility matrix
int
TestNonlocalElement2dDH::getInitialFlexibility(Matrix& Fe)
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
TestNonlocalElement2dDH::Print(OPS_Stream& s, int flag)
{
	s << "Element Tag: " << this->getTag() << endln;
	s << "Type: TestNonlocalElement2dDH" << endln;
	s << "Connected Node Tags: iNode " << connectedExternalNodes(0)
		<< ", jNode " << connectedExternalNodes(1) << endln;
	s << "Section Tag: " << sections[0]->getTag() << endln;
	s << "Number of Sections: " << numSections << endln;
}

//Method to draw and view the element
int
TestNonlocalElement2dDH::displaySelf(Renderer& theViewer, int displayMode, float fact)
{
	// first determine the end points of the beam based on the display factor 
	const Vector& end1Crd = theNodes[0]->getCrds();
	const Vector& end2Crd = theNodes[1]->getCrds();

	static Vector v1(3);
	static Vector v2(3);

	if (displayMode >= 0) {
		const Vector& end1Disp = theNodes[0]->getDisp();
		const Vector& end2Disp = theNodes[1]->getDisp();

		for (int i = 0; i < 2; i++) {
			v1(i) = end1Crd(i) + end1Disp(i) * fact;
			v2(i) = end2Crd(i) + end2Disp(i) * fact;
		}
	}
	else {
		int mode = displayMode * -1;
		const Matrix& eigen1 = theNodes[0]->getEigenvectors();
		const Matrix& eigen2 = theNodes[1]->getEigenvectors();
		if (eigen1.noCols() >= mode) {
			for (int i = 0; i < 2; i++) {
				v1(i) = end1Crd(i) + eigen1(i, mode - 1) * fact;
				v2(i) = end2Crd(i) + eigen2(i, mode - 1) * fact;
			}
		}
		else {
			for (int i = 0; i < 2; i++) {
				v1(i) = end1Crd(i);
				v2(i) = end2Crd(i);
			}
		}
	}

	return theViewer.drawLine(v1, v2, 1.0, 1.0);
}

//Method to define response parameters
Response*
TestNonlocalElement2dDH::setResponse(const char** argv, int argc, OPS_Stream& output)
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
TestNonlocalElement2dDH::getResponse(int responseID, Information& eleInfo)
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

	default:
		return -1;
	}
}

//Method the set section pointers
void
TestNonlocalElement2dDH::setSectionPointers(int numSec, SectionForceDeformation** secPtrs)
{
	if (numSec > maxNumSections) {
		opserr << "GradientError: ForceBeamColumn2d::setSectionPointers -- max number of sections exceeded";
	}

	numSections = numSec;

	if (secPtrs == 0) {
		opserr << "Error: TestNonlocalElement2dDH::setSectionPointers -- invalid section pointer";
	}

	sections = new SectionForceDeformation * [numSections];
	if (sections == 0) {
		opserr << "Error: TestNonlocalElement2dDH::setSectionPointers -- could not allocate section pointers";
	}

	for (int i = 0; i < numSections; i++) {

		if (secPtrs[i] == 0) {
			opserr << "Error: TestNonlocalElement2dDH::setSectionPointers -- null section pointer " << i << endln;
		}

		sections[i] = secPtrs[i]->getCopy();

		if (sections[i] == 0) {
			opserr << "Error: TestNonlocalElement2dDH::setSectionPointers -- could not create copy of section " << i << endln;
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
TestNonlocalElement2dDH::initCoefficientMatrixH()
{
	double L = crdTransf->getInitialLength();
	double* secX = new double[numSections];
	beamIntegr->getSectionLocations(numSections, L, secX);	// relative locations of sections (x/L)

	double dx = L * (secX[1] - secX[0]);	// spaces between first and second integration points

	Ac4MatrixHTheory = 1 + pow((lc / dx), 2);
	Bc4MatrixHTheory = 0.5 * (1. - Ac4MatrixHTheory);

	double ASection = sections[0]->getSectionArea();
	//WSofteningTol = -1. * numSections * ASection * 0.5 * 378. * 1e-6;
	WSofteningTol = -1. * ASection * 0.5 * 378. * 1e-6;
	//WSofteningTol = -1e-6;

	//opserr << "This is Ac4MatrixHTheory:" << Ac4MatrixHTheory << endln;
	//opserr << "This is Bc4MatrixHTheory:" << Bc4MatrixHTheory << endln;
	//opserr << "This is WSofteningTol:" << WSofteningTol << endln;
}

// Method to compute updated values Ac using exponential smoothing function and Bc for matrix H
void
TestNonlocalElement2dDH::computeCoefficientMatrixH()
{
	//Ac4MatrixH = Ac4MatrixHTheory;

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

	Ac4MatrixH = gXStar * 1 + (1 - gXStar) * Ac4MatrixHTheory;

	Bc4MatrixH = 0.5 * (1. - Ac4MatrixH);

	//opserr << "This is Ac4MatrixH:" << Ac4MatrixH << endln;
	//opserr << "This is Bc4MatrixH:" << Bc4MatrixH << endln;
}

//Method to compute matrix H 
void
TestNonlocalElement2dDH::computeMatrixH()
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
TestNonlocalElement2dDH::computeMatrixH_inv()
{
	H_inv.Zero();
	if (H.Invert(H_inv) < 0)
		opserr << "TestNonlocalElement2dDH::update() -- could not invert matrix H\n";
}

//Method to compute deStar_nonlocal[]
void 
TestNonlocalElement2dDH::computeDeStar_nonlocal(Vector deStar_nonlocal_Tot[], Vector deStar_local_Tot[])
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
TestNonlocalElement2dDH::computeE_local(Matrix& e_local_tot) 
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
TestNonlocalElement2dDH::computeEu_nonlocal(Vector eu_nonlocal_Tot[], Vector eu_local_Tot[])
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
TestNonlocalElement2dDH::computeFelement_nonlocal(Matrix& Felement_nonlocal)
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
	double* xi;
	xi = new double[numSections];
	beamIntegr->getSectionLocations(numSections, L, xi);
	//double wt[maxNumSections];
	double* wt;
	wt = new double[numSections];
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