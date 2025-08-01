//
// Created by Diego Heredia on 22.05.2025
//

#include "FBCElemSGINUS3d.h"

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

#define DefaultLoverGJ 1.0e-10

// Initialize class wide variables
Matrix FBCElemSGINUS3d::theMatrix(12, 12);
Vector FBCElemSGINUS3d::theVector(12);
double FBCElemSGINUS3d::workArea[200];

Vector FBCElemSGINUS3d::eNonLocalSubdivide[maxNumSections];
Vector FBCElemSGINUS3d::eLocalSubdivide[maxNumSections];
Matrix FBCElemSGINUS3d::FSectionSubdivide[maxNumSections];
Vector FBCElemSGINUS3d::srSubdivide[maxNumSections];

// Method to read the command arguments
void* OPS_FBCElemSGINUS3d()
{
	// Check if sufficient arguments
	if (OPS_GetNumRemainingInputArgs() < 10) {
		opserr << "WARNING! insufficient arguments: eleTag, nodeI, nodeJ, coordTransf, beamIntegr, integrSecTag, numSec, maxNumIters, tolerance, lc\n";
		return 0;
	}

	// Get dimensions and nb DOFs
	int ndm = OPS_GetNDM();
	int ndf = OPS_GetNDF();
	if (ndm != 3 || ndf != 6) {
		opserr << "WARNING! dimension must be 3d and nb DOF must be 6\n";
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
	Element* theEle = new FBCElemSGINUS3d(eleTag, nodeTagI, nodeTagJ, *theCoordTransf, *theBeamIntegration,
		sections, numIntegrPoints, maxNumIters, tolerance, lc);
	delete[] sections;
	return 0;
}

// Constructor 2 (for parallel processing)
FBCElemSGINUS3d::FBCElemSGINUS3d() : Element(0, ELE_TAG_FBCElemSGINUS3d), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
maxIters(0), Tol(0), lc(0), initialFlag(0),
Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), coeffs_H_GI(10, 3), coeffs_H(10, 3),
FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0), 
isTorsion(false)
// complete
{
	// Set Node Pointers to 0
	theNodes[0] = 0;
	theNodes[1] = 0;

	load.Zero();
}

// Constructor 1 (for normal processing) invoked by a FEM_ObjectBroker
FBCElemSGINUS3d::FBCElemSGINUS3d(int tag, int nodeI, int nodeJ, CrdTransf& CT, BeamIntegration& BI,
	SectionForceDeformation** sec, int numSec, int maxNumIters, double tolerance, double LC)
	:Element(tag, ELE_TAG_FBCElemSGINUS3d), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
	maxIters(maxNumIters), Tol(tolerance), lc(LC), initialFlag(0),
	Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), coeffs_H_GI(numSec, 3), coeffs_H(numSec, 3),
	FSection(0), eNonlocal(0), sr(0), eNonlocalCommit(0), eLocalCommit(0), eLocal(0), srCommit(0),
	numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD), KelementInitial(0),
	WSofteningCommit(0), WSofteningTrial(0), WSofteningTol(0),
	isTorsion(false)

	// complete
{
	// Pointers to Nodes and Their IDs
	if (connectedExternalNodes.Size() != 2) {
		opserr << "WARNING! FBCElemSGINUS3d::FBCElemSGINUS3d(): " << this->getTag() << " - failed to create an ID of size 2\n";
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
		opserr << "WARNING! FBCElemSGINUS3d::FBCElemSGINUS3d(): " << this->getTag() << " - could not create copy of beam integration object" << endln;
		exit(-1);
	}

	// get copy of the transformation object   
	crdTransf = CT.getCopy3d();
	if (crdTransf == 0) {
		opserr << "WARNING! FBCElemSGINUS3d::FBCElemSGINUS3d(): could not create copy of coordinate transformation object" << endln;
		exit(-1);
	}

	//get copy of sections
	this->setSectionPointers(numSec, sec);
}

// Destructor
//      delete must be invoked on any objects created by the object
FBCElemSGINUS3d::~FBCElemSGINUS3d()
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
FBCElemSGINUS3d::getNumExternalNodes(void) const
{
	return 2;
}

const ID&
FBCElemSGINUS3d::getExternalNodes(void)
{
	return connectedExternalNodes;
}

Node**
FBCElemSGINUS3d::getNodePtrs()
{
	return theNodes;
}

int
FBCElemSGINUS3d::getNumDOF(void)
{
	return NEGD;
}

// Definition of setDomain()
void
FBCElemSGINUS3d::setDomain(Domain* theDomain)
{
	// check Domain is not null - invoked when object removed from a domain
	if (theDomain == 0) {
		theNodes[0] = 0;
		theNodes[1] = 0;

		opserr << "ERROR! FBCElemSGINUS3d::setDomain():  theDomain = 0 ";
		exit(0);
	}

	// Get pointers to the nodes
	int Nd1 = connectedExternalNodes(0);
	int Nd2 = connectedExternalNodes(1);

	theNodes[0] = theDomain->getNode(Nd1);
	theNodes[1] = theDomain->getNode(Nd2);

	if (theNodes[0] == 0) {
		opserr << "ERROR! FBCElemSGINUS3d::setDomain: Nd1: ";
		opserr << Nd1 << "does not exist in model\n";
		exit(0);
	}

	if (theNodes[1] == 0) {
		opserr << "ERROR! FBCElemSGINUS3d::setDomain: Nd2: ";
		opserr << Nd2 << "does not exist in model\n";
		exit(0);
	}

	// call the DomainComponent class method 
	this->DomainComponent::setDomain(theDomain);

	// ensure connected nodes have correct number of dof's
	int dofNode1 = theNodes[0]->getNumberDOF();
	int dofNode2 = theNodes[1]->getNumberDOF();

	if (dofNode1 != NND) {
		opserr << "ERROR! FBCElemSGINUS3d::setDomain() - element: " << this->getTag() << " - node " << Nd1 << " does not have 6 DOFs\n";
		exit(0);
	}

	if (dofNode2 != NND) {
		opserr << "ERROR! FBCElemSGINUS3d::setDomain() - element: " << this->getTag() << " - node " << Nd2 << " does not have 6 DOFs\n";
		exit(0);
	}

	// Initialize Coordinate Transformation
	if (crdTransf->initialize(theNodes[0], theNodes[1])) {
		opserr << "WARNING! FBCElemSGINUS3d::setDomain() - element: " << this->getTag() << " - Error initializing coordinate transformation\n";
		exit(0);
	}

	// get element length
	double L = crdTransf->getInitialLength();
	if (L == 0.0) {
		opserr << "WARNING! FBCElemSGINUS3d::setDomain(): element has zero length:" << this->getTag();
		exit(0);
	}

	if (initialFlag == 0)
	{
		this->initializeSectionHistoryVariables();

		// Initialize values of Ac and Bc for matrix H
		initCoefficientMatrixH();
	}
}

//Function to commit state of the element
int
FBCElemSGINUS3d::commitState()
{
	int err = 0;

	// Element commitState()
	if ((err = this->Element::commitState()))
		opserr << "WARNING! FBCElemSGINUS3d::commitState() - element: " << this->getTag() << " - failed in committing base class\n";

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
		opserr << "WARNING! FBCElemSGINUS3d::commitState() - element: " << this->getTag() << " - failed to commit coordinate transformation object\n";

	WSofteningCommit = WSofteningTrial;

	// Complete committing the variables
	return err;
}

//Function to revert to last commit
int
FBCElemSGINUS3d::revertToLastCommit(void)
{
	int err = 0;
	// Revert section state variables to last committed state
	for (int i = 0; i < numSections; i++) {
		err += sections[i]->revertToLastCommit();
		eNonlocal[i] = eNonlocalCommit[i];
		eLocal[i] = eLocalCommit[i];

		// Modified DH 24.07.2025
		//sections[i]->setTrialSectionDeformation(eNonlocal[i]);
		sections[i]->setTrialSectionDeformation(eLocal[i]);
		//sections[i]->setTrialSectionDeformation(eNonlocal[i], eNonlocalCommit[i], allSectionFibersDSigma11Dx[i]);
		//sr[i] = sections[i]->getStressResultant();
		sr[i] = srCommit[i];
		FSection[i] = sections[i]->getSectionFlexibility();
	}
	// Revert coordinate transformation object to last committed state
	if ((err = crdTransf->revertToLastCommit()))
		opserr << "WARNING! FBCElemSGINUS3d::revertToLastCommit() - element: " << this->getTag() << " - coordinate transformation object failed to revert to last committed state\n";

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
FBCElemSGINUS3d::revertToStart(void)
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
		opserr << "WARNING! FBCElemSGINUS3d::revertToStart() - element: " << this->getTag() << " - failed to revert to start coordinate transformation object\n";

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
FBCElemSGINUS3d::getInitialStiff(void)
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
FBCElemSGINUS3d::getTangentStiff(void)
{
	crdTransf->update();

	//opserr << "This is Kelement:" << Kelement << endln;

	return crdTransf->getGlobalStiffMatrix(Kelement, q);
}

//Method to get reaction due to element loads
void
FBCElemSGINUS3d::computeReactions(double* p0)
{
	int type;
	double L = crdTransf->getInitialLength();

	for (int i = 0; i < numEleLoads; i++) {

		double loadFactor = eleLoadFactors[i];
		const Vector& data = eleLoads[i]->getData(type, loadFactor);

		if (type == LOAD_TAG_Beam3dUniformLoad) {
			double wy = data(0) * loadFactor;  // Transverse
			double wz = data(1) * loadFactor;  // Transverse
			double wa = data(2) * loadFactor;  // Axial

			p0[0] -= wa * L;
			double V = 0.5 * wy * L;
			p0[1] -= V;
			p0[2] -= V;
			V = 0.5 * wz * L;
			p0[3] -= V;
			p0[4] -= V;
		}
		else if (type == LOAD_TAG_Beam3dPartialUniformLoad) {
			double wa = data(2) * loadFactor;  // Axial
			double wy = data(0) * loadFactor;  // Transverse
			double wz = data(1) * loadFactor;  // Transverse
			double a = data(3) * L;
			double b = data(4) * L;

			p0[0] -= wa * (b - a);
			double Fy = wy * (b - a);
			double c = a + 0.5 * (b - a);
			p0[1] -= Fy * (1 - c / L);
			p0[2] -= Fy * c / L;
			double Fz = wz * (b - a);
			p0[3] -= Fz * (1 - c / L);
			p0[4] -= Fz * c / L;
		}
		else if (type == LOAD_TAG_Beam3dPointLoad) {
			double Py = data(0) * loadFactor;
			double Pz = data(1) * loadFactor;
			double N = data(2) * loadFactor;
			double aOverL = data(3);

			if (aOverL < 0.0 || aOverL > 1.0)
				continue;

			double V1 = Py * (1.0 - aOverL);
			double V2 = Py * aOverL;
			p0[0] -= N;
			p0[1] -= V1;
			p0[2] -= V2;
			V1 = Pz * (1.0 - aOverL);
			V2 = Pz * aOverL;
			p0[3] -= V1;
			p0[4] -= V2;
		}
	}
}

//Function to get element resisting force vector global reference frame
const Vector&
FBCElemSGINUS3d::getResistingForce(void)
{
	double p0[5];
	Vector p0Vec(p0, 5);
	p0Vec.Zero();

	if (numEleLoads > 0)
		this->computeReactions(p0);

	crdTransf->update();
	return crdTransf->getGlobalResistingForce(q, p0Vec);
}

//Method to initialize section state variables
void
FBCElemSGINUS3d::initializeSectionHistoryVariables(void)
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
FBCElemSGINUS3d::update(void)
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
	//opserr << "This is v:" << v << endln;
	//opserr << "This is dv:" << dv << endln;

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

	//I.Zero();
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
	/*opserr << "this is matrix h: " << H << endln;
	opserr << "this is matrix h_inv: " << H_inv << endln;*/

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

	static double factor =10;

	maxSubdivisions = 20;

	while (converged == false && numSubdivide <= maxSubdivisions)
	{
		// try regular newton (if l==0), or
	  // initial tangent iterations (if l==1), or

		for (int l = 0; l < 2; l++) {

			qTrial = q;
			KelementTrial = Kelement;

			//// Try to fix issue oscillations 04/07/2025
			//int isIllCondition = 0;

			for (i = 0; i < numSections; i++)
			{
				eNonLocalSubdivide[i] = eNonlocal[i];
				eLocalSubdivide[i] = eLocal[i];
				FSectionSubdivide[i] = FSection[i];
				srSubdivide[i] = sr[i];

				// Added 23.07.2025
				eu_local_Tot[i].Zero();
				eu_nonlocal_Tot[i].Zero();

				//opserr << "This is FSectionSubdivide:" << FSectionSubdivide[i] << endln;
			}

			// calculate nodal force increments and update nodal forces dq=KelementTrial*dvTrial
			dq.addMatrixVector(0.0, KelementTrial, dvTrial, 1.0);
			qTrial += dq;

			//todo
			/*opserr << "This is dvTrial" << dvTrial << endln;
			opserr << "This is KelementTrial" << KelementTrial << endln;
			opserr << "This is qTrial:" << qTrial<< endln;*/

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
						Vector ds(NEBD);
						//static Vector deStar_local_seci(NEBD);
						Matrix Fb(NEBD, NEBD);

						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						// calculate total section forces s = b*q + bp*currDistrLoad;
						int ii;
						for (ii = 0; ii < order; ii++) {
							switch (code(ii)) {
							case SECTION_RESPONSE_P:
								s_Tot[i](ii) = qTrial(0);
								break;
							case SECTION_RESPONSE_MZ:
								s_Tot[i](ii) = xL1 * qTrial(1) + xL * qTrial(2);
								break;
							case SECTION_RESPONSE_VY:
								/*s_Tot[i](ii) = oneOverL * (qTrial(1) + qTrial(2));*/
								s_Tot[i](ii) = -oneOverL * (qTrial(1) + qTrial(2)); // Diego Heredia 09.08.2024
								break;
							case SECTION_RESPONSE_MY:
								s_Tot[i](ii) = xL1 * qTrial(3) + xL * qTrial(4);
								break;
							case SECTION_RESPONSE_VZ:
								s_Tot[i](ii) = oneOverL * (qTrial(3) + qTrial(4));
								break;
							case SECTION_RESPONSE_T:
								s_Tot[i](ii) = qTrial(5);
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
						for (ii = 0; ii < order; ii++) {
							switch (code(ii)) {
							case SECTION_RESPONSE_P:
								ds(ii) = dq(0);
								break;
							case SECTION_RESPONSE_MZ:
								ds(ii) = xL1 * dq(1) + xL * dq(2);
								break;
							case SECTION_RESPONSE_VY:
								/*ds(ii) = oneOverL * (dq(1) + dq(2));*/
								ds(ii) = -oneOverL * (dq(1) + dq(2)); // Diego Heredia 09.08.2024
								break;
							case SECTION_RESPONSE_MY:
								ds(ii) = xL1 * dq(3) + xL * dq(4);
								break;
							case SECTION_RESPONSE_VZ:
								ds(ii) = oneOverL * (dq(3) + dq(4));
								break;
							case SECTION_RESPONSE_T:
								ds(ii) = dq(5);
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
						deStar_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);

						//opserr << "This is deStar_local_sec:" << deStar_local_seci << endln;
					}

					//Compute deStar_nonlocal[]
					this->computeDeStar_nonlocal(deStar_nonlocal_Tot, deStar_local_Tot);

					//todo
					/*for (int i = 0; i < numSections; i++) {
						opserr << "Section:" << i << endln;
						opserr << "This is deStar_local_Tot:" << deStar_local_Tot[i] << endln;
						opserr << "This is deStar_nonlocal_Tot:" << deStar_nonlocal_Tot[i] << endln;
						opserr << "This is eu_local_Tot:" << eu_local_Tot[i] << endln;
					}*/

					for (i = 0; i < numSections; i++)
					{
						// set section deformations
						if (initialFlag != 0)
						{
							eNonLocalSubdivide[i] += deStar_nonlocal_Tot[i];  //e_NL += deStar_nonlocal
							eNonLocalSubdivide[i] += eu_nonlocal_Tot[i];  //e_NL += eu_nonlocal
						}
						//opserr << "This is eNonLocalSubdivide:" << eNonLocalSubdivide[i] << endln;

						eLocalSubdivide[i] += deStar_local_Tot[i] + eu_local_Tot[i];
					}

					for (i = 0; i < numSections; i++)
					{
						//static Vector eu_local_interm(NEBD);  //intermediate vector to fill eu_local_tot
						//eu_local_interm.Zero();

						//Set the section deformations for section state determination
						if (sections[i]->setTrialSectionDeformation(eLocalSubdivide[i]) < 0)
							//if (sections[i]->setTrialSectionDeformation(eLocalSubdivide[i], eNonlocalCommit[i], allSectionFibersDSigma11Dx[i]) < 0)
						{
							opserr << "FBCElemSGINUS3d::update() - section failed in setTrial\n";
							opserr << "This is element: " << this->getTag() << endln;
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
							//opserr << "This is Ksection: " << Ksection << endln;

							// Try to fix issue oscillations 04/07/2025
							int isIllCondition = Ksection.checkIllCondition(1e-8);
							//if (isIllCondition == 0) {// The matrix is not ill-conditioned 
							//	isIllCondition = Ksection.checkIllCondition(1e-8);
							//}

							if (isIllCondition == 0) {// The matrix is not ill-conditioned 
								FSectionSubdivide[i] = sections[i]->getSectionFlexibility();
							}
							else // The matrix singular (ill-conditioned)
							{
								const Matrix& Fsection_elastic = sections[i]->getInitialFlexibility();
								const Matrix& Ksection_elastic = sections[i]->getInitialTangent();
								Matrix Ksection_intermed1 = Ksection - Ksection_elastic;
								Matrix Ksection_intermed1_inverse = Matrix(6, 6);
								Ksection_intermed1.Invert(Ksection_intermed1_inverse);
								Matrix Ksection_plastic = Ksection - Ksection * Ksection_intermed1_inverse * Ksection;
								/*opserr << "This is Ksection: " << Ksection << endln;
								opserr << "This is Ksection_intermed1: " << Ksection_intermed1 << endln;
								opserr << "This is Ksection_intermed1_inverse: " << Ksection_intermed1_inverse << endln;
								opserr << "This is Ksection_plastic: " << Ksection_plastic << endln;*/
								Matrix Fsection_plastic = Matrix(6, 6);
								if (Ksection_plastic.computePseudoInverseSymmetric(Fsection_plastic, 1e-2) < 0)
								{
									return -1; // matrix has nan (modified DH 18.03.2025)
								}
								FSectionSubdivide[i] = Fsection_elastic + Fsection_plastic;
								//opserr << "This is Ksection: " << Ksection << endln;
								/*opserr << "This is Fsection_elastic: " << Fsection_elastic << endln;
								opserr << "This is Fsection_plastic: " << Fsection_plastic << endln;
								opserr << "This is Fsection: " << FSectionSubdivide[i] << endln;*/

								//FSectionSubdivide[i] = sections[i]->getInitialFlexibility();

								// Increase the maximum number of iterations because Modified Newton
								numItersMax = 10 * maxIters;

								//FSectionSubdivide[i] = sections[i]->getSectionFlexibility();
							}
							/*const Matrix& Fsection_elastic = sections[i]->getInitialFlexibility();
							double alphaTangent = 0.5;
							FSectionSubdivide[i] = alphaTangent * Fsection_elastic + (1.0 - alphaTangent) * FSectionSubdivide[i];

							numItersMax = 20 * maxIters;*/
						}

						// calculate section residual deformations de = FSection * (s - sr);
						static Vector s_seci(NEBD); // initialize vector s_secii
						static Vector ds(NEBD);

						ds = s_Tot[i];  //take the corresponding section force from matrix with all section forces
						ds.addVector(1.0, srSubdivide[i], -1.0);  // ds = s - sr[i];

						//compute eu_local for section i
						eu_local_Tot[i].addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);

						//Fill matrix eu_local_tot with eu_local for section i
						/*eu_local_Tot(0, i) = eu_local_interm(0);
						eu_local_Tot(1, i) = eu_local_interm(1);*/
						/*for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						{
							eu_local_Tot(iiLineComponent, i) = eu_local_interm(iiLineComponent);
						}*/

					}

					//Compute eu_non_local_tot
					this->computeEu_nonlocal(eu_nonlocal_Tot, eu_local_Tot);

					//Compute Felement_nonlocal
					this->computeFelement_nonlocal(Felement);
					//Felement = Felement_nonlocal;
					//opserr << "This is Felement:" << Felement << endln;

					for (i = 0; i < numSections; i++)
					{
						int order = sections[i]->getOrder();
						const ID& code = sections[i]->getType();

						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						double dei;
						double tmp;

						for (int ii = 0; ii < order; ii++) {
							dei = eu_nonlocal_Tot[i](ii) * wtL;
							switch (code(ii)) {
							case SECTION_RESPONSE_P:
								vu(0) += dei;
								break;
							case SECTION_RESPONSE_MZ:
								vu(1) += xL1 * dei;
								vu(2) += xL * dei;
								break;
							case SECTION_RESPONSE_VY:
								/*tmp = oneOverL * dei;*/
								tmp = -oneOverL * dei; // Diego Heredia 09.08.2024
								vu(1) += tmp;
								vu(2) += tmp;
								break;
							case SECTION_RESPONSE_MY:
								vu(3) += xL1 * dei;
								vu(4) += xL * dei;
								break;
							case SECTION_RESPONSE_VZ:
								tmp = oneOverL * dei;
								vu(3) += tmp;
								vu(4) += tmp;
								break;
							case SECTION_RESPONSE_T:
								vu(5) += dei;
								break;
							default:
								break;
							}
						}
					}
					//vu.Zero();
					//vu = v - integrale_BeuNL;
					//vu = integrale_BeuNL; //using definition below

					// calculate element stiffness matrix invert3by3Matrix(F, Kelement);	  
					if (Felement.Solve(I, KelementTrial) < 0) {
						opserr << "FBCElemSGINUS3d::update() -- could not invert flexibility\n";
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
						for (int iComp = 0; iComp < NEBD; iComp++)
						{
							WDot_isec += 0.5 * (srSubdivide[i](iComp) - srCommit[i](iComp)) * (eLocalSubdivide[i](iComp) - eLocalCommit[i](iComp));
						}
						//opserr << "This is WDot:" << WDot << endln;
						//if (WDot_isec < 0. && abs(WDot_isec)>1)
						if (WDot_isec < 0.)
						{
							WDot_cumulativeSoft += WDot_isec;
						}
						/*else if (eLocalSubdivide[i].Norm() - eLocalCommit[i].Norm() < 0.)
						{
							elasticUnload += 1;
							WDot_cumulativeElasticUnload += WDot_isec;
						}*/
						// Try to fix issue oscillations 04/07/2025
						int component_unload = 0;
						for (int iComp = 0; iComp < NEBD; iComp++)
						{
							if (eLocalSubdivide[i](iComp)* eLocalCommit[i](iComp) > 0 && fabs(eLocalSubdivide[i](iComp))<=fabs(eLocalCommit[i](iComp)))
							{
								component_unload += 1;
							}
						}
						if (component_unload==NEBD)
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
					/*opserr << "This is the element flexibility matrix:" << Felement << endln;
					opserr << "This is the element stiffness matrix:" << KelementTrial << endln;*/

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

					//double dW = dv ^ dq;

					// check for convergence of this interval
					if (dv.Norm() < Tol)
					//if (fabs(dW) < Tol) 
					//if ((vu.Norm() < Tol) && (dq.Norm() < 100000 * Tol))
					//if (abs(vu^q)<Tol)
					/*double normalizedResid_disp = 0.;
					double normalizedResid_force = 0.;
					for (int cc = 0; cc < NEBD; cc++)
					{
						normalizedResid_disp += abs(vu(cc) / (vin(cc) + 1e-6));
						normalizedResid_force += abs(dq(cc) / (q(cc) + 1e-6));
					}
					if ((normalizedResid_disp<Tol)&& (normalizedResid_force < Tol))*/
					//if (dq.Norm()< 100000 * Tol)
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
							//numSubdivide = 1;
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
		opserr << "WARNING - FBCElemSGINUS3d::update - failed to get compatible ";
		opserr << "element forces & deformations for element: ";
		opserr << this->getTag() << "(Norm dv: << " << dv.Norm() << ")\n";
		opserr << this->getTag() << "( dv: << " << dv << ")\n";
		return -1;
	}

	initialFlag = 1;

	return 0;
}

// Method to get force interpolation matrix b
void FBCElemSGINUS3d::getForceInterpolatMatrix(double xi, Matrix& b, const ID& code)
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
			/*b(i, 1) = b(i, 2) = 1.0 / L;*/
			b(i, 1) = b(i, 2) = -1.0 / L; // Diego Heredia 09.08.2024
			break;
		case SECTION_RESPONSE_MY:              // Moment, My, interpolation
			b(i, 3) = xi - 1.0;
			b(i, 4) = xi;
			break;
		case SECTION_RESPONSE_VZ:              // Shear, Vz, interpolation
			b(i, 3) = b(i, 4) = 1.0 / L;
			break;
		case SECTION_RESPONSE_T:               // Torque, T, interpolation
			b(i, 5) = 1.0;
			break;
		default:
			break;
		}
	}
}

// Method to get force interpolation matrix bp due to distributed loads
void FBCElemSGINUS3d::getDistrLoadInterpolatMatrix(double xi, Matrix& bp, const ID& code)
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
		case SECTION_RESPONSE_MY:              // Moment, My, interpolation
			bp(i, 2) = xi * (1 - xi) * L * L / 2;
			break;
		case SECTION_RESPONSE_VZ:              // Shear, Vz, interpolation
			bp(i, 2) = (0.5 - xi) * L;
			break;
		case SECTION_RESPONSE_T:               // Torsion, T, interpolation
			break;
		default:
			break;
		}
	}
}

//Method to compute section forces
void
FBCElemSGINUS3d::computeSectionForces(Vector& sp, int isec)
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

		if (type == LOAD_TAG_Beam3dUniformLoad)
		{
			double wy = data(0) * loadFactor;  // Transverse
			double wz = data(1) * loadFactor;  // Transverse
			double wa = data(2) * loadFactor;  // Axial

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
				case SECTION_RESPONSE_MY:
					sp(ii) += wz * 0.5 * x * (L - x);
					break;
				case SECTION_RESPONSE_VZ:
					sp(ii) += wz * (0.5 * L - x);
					break;
				default:
					break;
				}
			}
		}
		else if (type == LOAD_TAG_Beam3dPartialUniformLoad)
		{
			double wa = data(2) * loadFactor;  // Axial
			double wy = data(0) * loadFactor;  // Transverse
			double wz = data(1) * loadFactor;  // Transverse
			double a = data(3) * L;
			double b = data(4) * L;

			double Fa = wa * (b - a); // resultant axial load
			double Fy = wy * (b - a); // resultant transverse load
			double Fz = wz * (b - a); // resultant transverse load
			double c = a + 0.5 * (b - a);
			double VyI = Fy * (1 - c / L);
			double VyJ = Fy * c / L;
			double VzI = Fz * (1 - c / L);
			double VzJ = Fz * c / L;

			for (int ii = 0; ii < order; ii++)
			{
				if (x <= a) {
					switch (code(ii)) {
					case SECTION_RESPONSE_P:
						sp(ii) += Fa;
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) -= VyI * x;
						break;
					case SECTION_RESPONSE_MY:
						sp(ii) += VzI * x;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) -= VyI;
						break;
					case SECTION_RESPONSE_VZ:
						sp(ii) -= VzI;
						break;
					default:
						break;
					}
				}
				else if (x >= b) {
					switch (code(ii)) {
					case SECTION_RESPONSE_MZ:
						sp(ii) += VyJ * (x - L);
						break;
					case SECTION_RESPONSE_MY:
						sp(ii) -= VzJ * (x - L);
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += VyJ;
						break;
					case SECTION_RESPONSE_VZ:
						sp(ii) += VzJ;
						break;
					default:
						break;
					}
				}
				else {
					switch (code(ii)) {
					case SECTION_RESPONSE_P:
						sp(ii) += Fa - wa * (x - a);
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) += -VyI * x + 0.5 * wy * x * x + wy * a * (0.5 * a - x);
						break;
					case SECTION_RESPONSE_MY:
						sp(ii) += VzI * x - 0.5 * wz * x * x - wz * a * (0.5 * a - x);
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += -VyI + wy * (x - a);
						break;
					case SECTION_RESPONSE_VZ:
						sp(ii) += -VzI + wz * (x - a);
						break;
					default:
						break;
					}
				}
			}
		}
		else if (type == LOAD_TAG_Beam3dPointLoad) {
			double Py = data(0) * loadFactor;
			double Pz = data(1) * loadFactor;
			double N = data(2) * loadFactor;
			double aOverL = data(3);

			if (aOverL < 0.0 || aOverL > 1.0)
				continue;

			double a = aOverL * L;

			double Vy1 = Py * (1.0 - aOverL);
			double Vy2 = Py * aOverL;

			double Vz1 = Pz * (1.0 - aOverL);
			double Vz2 = Pz * aOverL;

			for (int ii = 0; ii < order; ii++) {

				if (x <= a) {
					switch (code(ii)) {
					case SECTION_RESPONSE_P:
						sp(ii) += N;
						break;
					case SECTION_RESPONSE_MZ:
						sp(ii) -= x * Vy1;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) -= Vy1;
						break;
					case SECTION_RESPONSE_MY:
						sp(ii) += x * Vz1;
						break;
					case SECTION_RESPONSE_VZ:
						sp(ii) -= Vz1;
						break;
					default:
						break;
					}
				}
				else {
					switch (code(ii)) {
					case SECTION_RESPONSE_MZ:
						sp(ii) -= (L - x) * Vy2;
						break;
					case SECTION_RESPONSE_VY:
						sp(ii) += Vy2;
						break;
					case SECTION_RESPONSE_MY:
						sp(ii) += (L - x) * Vz2;
						break;
					case SECTION_RESPONSE_VZ:
						sp(ii) += Vz2;
						break;
					default:
						break;
					}
				}
			}
		}
		else
		{
			opserr << "FBCElemSGINUS3d::addLoad -- load type unknown for element with tag: " <<
				this->getTag() << endln;
		}
	}
}

//Method to get the mass matrix
const Matrix&
FBCElemSGINUS3d::getMass(void)
{
	theMatrix.Zero();

	double L = crdTransf->getInitialLength();
	//if (rho != 0.0)
		//theMatrix(0, 0) = theMatrix(1, 1) = theMatrix(3, 3) = theMatrix(4, 4) = 0.5 * L * rho;

	return theMatrix; // For now returns matrix 0. need to add rho to .h file 
}

//Method for zero element loads
void
FBCElemSGINUS3d::zeroLoad(void)
{
	load.Zero();

	numEleLoads = 0;

	return;
}

// Method to add element loads
int
FBCElemSGINUS3d::addLoad(ElementalLoad* theLoad, double loadFactor)
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
FBCElemSGINUS3d::getResistingForceIncInertia()
{
	// Compute the current resisting force
	theVector = this->getResistingForce();

	// add the damping forces if rayleigh damping
	if (betaK != 0.0 || betaK0 != 0.0 || betaKc != 0.0)
		theVector += this->getRayleighDampingForces();

	/*Vector testDampingForces = this->getRayleighDampingForces();
	double testNormDampingForces = testDampingForces.Norm();
	if (testNormDampingForces>0.)
	{
		opserr << "This is testDampingForces:" << testDampingForces << endln;
	}*/


	return theVector;
}

//Method for sending itself for parallel processing
int
FBCElemSGINUS3d::sendSelf(int commitTag, Channel& theChannel)
{
	// No parallel processing for now
	opserr << "WARNING! FBCElemSGINUS3d::sendSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for receiving itself for parallel processing
int
FBCElemSGINUS3d::recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker)
{
	// No parallel processing for now
	opserr << "WARNING! FBCElemSGINUS3d::recvSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for computing initial element flexibility matrix
int
FBCElemSGINUS3d::getInitialFlexibility(Matrix& Fe)
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

		Matrix Fb(workArea, order, NEBD);

		double xL = xi[i];
		double xL1 = xL - 1.0;
		double wtL = wt[i] * L;

		const Matrix& FSec = sections[i]->getInitialFlexibility();
		Fb.Zero();
		double tmp;
		int ii, jj;
		for (ii = 0; ii < order; ii++) {
			switch (code(ii)) {
			case SECTION_RESPONSE_P:
				for (jj = 0; jj < order; jj++)
					Fb(jj, 0) += FSec(jj, ii) * wtL;
				break;
			case SECTION_RESPONSE_MZ:
				for (jj = 0; jj < order; jj++) {
					tmp = FSec(jj, ii) * wtL;
					Fb(jj, 1) += xL1 * tmp;
					Fb(jj, 2) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VY:
				for (jj = 0; jj < order; jj++) {
					/*tmp = oneOverL * FSec(jj, ii) * wtL;*/
					tmp = -oneOverL * FSec(jj, ii) * wtL; // Diego Heredia 09.08.2024
					Fb(jj, 1) += tmp;
					Fb(jj, 2) += tmp;
				}
				break;
			case SECTION_RESPONSE_MY:
				for (jj = 0; jj < order; jj++) {
					tmp = FSec(jj, ii) * wtL;
					Fb(jj, 3) += xL1 * tmp;
					Fb(jj, 4) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VZ:
				for (jj = 0; jj < order; jj++) {
					tmp = oneOverL * FSec(jj, ii) * wtL;
					Fb(jj, 3) += tmp;
					Fb(jj, 4) += tmp;
				}
				break;
			case SECTION_RESPONSE_T:
				for (jj = 0; jj < order; jj++)
					Fb(jj, 5) += FSec(jj, ii) * wtL;
				break;
			default:
				break;
			}
		}
		for (ii = 0; ii < order; ii++) {
			switch (code(ii)) {
			case SECTION_RESPONSE_P:
				for (jj = 0; jj < NEBD; jj++)
					Fe(0, jj) += Fb(ii, jj);
				break;
			case SECTION_RESPONSE_MZ:
				for (jj = 0; jj < NEBD; jj++) {
					tmp = Fb(ii, jj);
					Fe(1, jj) += xL1 * tmp;
					Fe(2, jj) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VY:
				for (jj = 0; jj < NEBD; jj++) {
					/*tmp = oneOverL * Fb(ii, jj);*/
					tmp = -oneOverL * Fb(ii, jj); // Diego Heredia 09.08.2024
					Fe(1, jj) += tmp;
					Fe(2, jj) += tmp;
				}
				break;
			case SECTION_RESPONSE_MY:
				for (jj = 0; jj < NEBD; jj++) {
					tmp = Fb(ii, jj);
					Fe(3, jj) += xL1 * tmp;
					Fe(4, jj) += xL * tmp;
				}
				break;
			case SECTION_RESPONSE_VZ:
				for (jj = 0; jj < NEBD; jj++) {
					tmp = oneOverL * Fb(ii, jj);
					Fe(3, jj) += tmp;
					Fe(4, jj) += tmp;
				}
				break;
			case SECTION_RESPONSE_T:
				for (jj = 0; jj < NEBD; jj++)
					Fe(5, jj) += Fb(ii, jj);
				break;
			default:
				break;
			}
		}
	}

	if (!isTorsion)
		Fe(5, 5) = DefaultLoverGJ;

	//opserr << "This is Fe:" << Fe << endln;

	return 0;
}

//Method for printing 
void
FBCElemSGINUS3d::Print(OPS_Stream& s, int flag)
{
	s << "Element Tag: " << this->getTag() << endln;
	s << "Type: FBCElemSGINUS3d" << endln;
	s << "Connected Node Tags: iNode " << connectedExternalNodes(0)
		<< ", jNode " << connectedExternalNodes(1) << endln;
	s << "Section Tag: " << sections[0]->getTag() << endln;
	s << "Number of Sections: " << numSections << endln;
}

//Method to draw and view the element
int
FBCElemSGINUS3d::displaySelf(Renderer& theViewer, int displayMode, float fact, const char** displayModes, int numMode)
{
	//// first determine the end points of the beam based on the display factor 
	//const Vector& end1Crd = theNodes[0]->getCrds();
	//const Vector& end2Crd = theNodes[1]->getCrds();

	//static Vector v1(3);
	//static Vector v2(3);

	//if (displayMode >= 0) {
	//	const Vector& end1Disp = theNodes[0]->getDisp();
	//	const Vector& end2Disp = theNodes[1]->getDisp();

	//	for (int i = 0; i < 2; i++) {
	//		v1(i) = end1Crd(i) + end1Disp(i) * fact;
	//		v2(i) = end2Crd(i) + end2Disp(i) * fact;
	//	}
	//}
	//else {
	//	int mode = displayMode * -1;
	//	const Matrix& eigen1 = theNodes[0]->getEigenvectors();
	//	const Matrix& eigen2 = theNodes[1]->getEigenvectors();
	//	if (eigen1.noCols() >= mode) {
	//		for (int i = 0; i < 2; i++) {
	//			v1(i) = end1Crd(i) + eigen1(i, mode - 1) * fact;
	//			v2(i) = end2Crd(i) + eigen2(i, mode - 1) * fact;
	//		}
	//	}
	//	else {
	//		for (int i = 0; i < 2; i++) {
	//			v1(i) = end1Crd(i);
	//			v2(i) = end2Crd(i);
	//		}
	//	}
	//}

	//return theViewer.drawLine(v1, v2, 1.0, 1.0);

	static Vector v1(3);
	static Vector v2(3);

	theNodes[0]->getDisplayCrds(v1, fact, displayMode);
	theNodes[1]->getDisplayCrds(v2, fact, displayMode);
	float d1 = 0.0;
	float d2 = 0.0;
	int res = 0;

	if (displayMode > 0 && numMode == 0)
		res += theViewer.drawLine(v1, v2, d1, d1, this->getTag(), 0);
	else if (displayMode < 0)
		return theViewer.drawLine(v1, v2, 0.0, 0.0, this->getTag(), 0);

}

//Method to define response parameters
Response*
FBCElemSGINUS3d::setResponse(const char** argv, int argc, OPS_Stream& output)
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
		output.tag("ResponseType", "Pz_1");
		output.tag("ResponseType", "Mx_1");
		output.tag("ResponseType", "My_1");
		output.tag("ResponseType", "Mz_1");
		output.tag("ResponseType", "Px_2");
		output.tag("ResponseType", "Py_2");
		output.tag("ResponseType", "Pz_2");
		output.tag("ResponseType", "Mx_2");
		output.tag("ResponseType", "My_2");
		output.tag("ResponseType", "Mz_2");

		theResponse = new ElementResponse(this, 1, theVector);
	}

	// Local forces
	else if (strcmp(argv[0], "localForce") == 0 || strcmp(argv[0], "localForces") == 0)
	{
		output.tag("ResponseType", "N_1");
		output.tag("ResponseType", "Vy_1");
		output.tag("ResponseType", "Vz_1");
		output.tag("ResponseType", "T_1");
		output.tag("ResponseType", "My_1");
		output.tag("ResponseType", "Mz_1");
		output.tag("ResponseType", "N_2");
		output.tag("ResponseType", "Vy_2");
		output.tag("ResponseType", "Vz_2");
		output.tag("ResponseType", "T_2");
		output.tag("ResponseType", "My_2");
		output.tag("ResponseType", "Mz_2");

		theResponse = new ElementResponse(this, 2, theVector);
	}

	// Basic forces
	else if (strcmp(argv[0], "basicForce") == 0 || strcmp(argv[0], "basicForces") == 0)
	{
		output.tag("ResponseType", "N");
		output.tag("ResponseType", "Mz_1");
		output.tag("ResponseType", "Mz_2");
		output.tag("ResponseType", "My_1");
		output.tag("ResponseType", "My_2");
		output.tag("ResponseType", "T");

		theResponse = new ElementResponse(this, 3, Vector(6));
	}

	//Nonlocal section deformations
	else if (strcmp(argv[0], "NonlocalSectionDeformations") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 4, Matrix(6, numSections));
	}

	//Local section deformations
	else if (strcmp(argv[0], "LocalSectionDeformations") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 5, Matrix(6, numSections));
	}

	//Local section curvatures
	else if (strcmp(argv[0], "LocalSectionCurvature") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 6, Matrix(2, numSections));
	}

	//Nonlocal section curvatures
	else if (strcmp(argv[0], "NonlocalSectionCurvature") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 7, Matrix(2, numSections));
	}

	// Moment distribution along length
	else if (strcmp(argv[0], "momentDistribution") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 8, Matrix(2, numSections));
	}

	// Element basic deformations
	else if (strcmp(argv[0], "basicDeformation") == 0)
	{
		output.tag("ResponseType", "eps");
		output.tag("ResponseType", "thetaZ_1");
		output.tag("ResponseType", "thetaZ_2");
		output.tag("ResponseType", "thetaY_1");
		output.tag("ResponseType", "thetaY_2");
		output.tag("ResponseType", "thetaX");

		theResponse = new ElementResponse(this, 9, Vector(6));
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

	// Global Damping Forces
	else if (strcmp(argv[0], "dampingForce") == 0 || strcmp(argv[0], "dampingForces") == 0) {
		theResponse = new ElementResponse(this, 6, theVector);
	}

	return theResponse;
}

//Method to get the response parameters
int
FBCElemSGINUS3d::getResponse(int responseID, Information& eleInfo)
{
	switch (responseID)
	{
	case 1: // Global forces
		return eleInfo.setVector(this->getResistingForce());

	case 2: // Local forces
		double p0[5]; p0[0] = p0[1] = p0[2] = p0[3] = p0[4] = 0.0;
		if (numEleLoads > 0)
			this->computeReactions(p0);
		// Axial
		theVector(6) = q(0);
		theVector(0) = -q(0) + p0[0];

		// Torsion
		theVector(3) = -q(5);

		// Moments about z and shears along y
		theVector(5) = q(1);
		theVector(11) = q(2);
		double V;
		V = (q(1) + q(2)) / crdTransf->getInitialLength();
		theVector(1) = V + p0[1];
		theVector(7) = -V + p0[2];

		// Moments about y and shears along z
		theVector(4) = q(3);
		theVector(10) = q(4);
		V = (q(3) + q(4)) / crdTransf->getInitialLength();
		theVector(2) = -V + p0[3];
		theVector(8) = V + p0[4];

		return eleInfo.setVector(theVector);

	case 3: // Basic forces
		return eleInfo.setVector(q);

	case 4: //nonlocal section deformations
	{
		Matrix eNonlocalOutput(6, numSections);
		eNonlocalOutput.Zero();
		Vector eNonlocalOutput_int(6);  //intermediate vector to fill
		for (int i = 0; i < numSections; i++)
		{
			eNonlocalOutput_int = eNonlocalCommit[i];
			eNonlocalOutput(0, i) = eNonlocalOutput_int(0);
			eNonlocalOutput(1, i) = eNonlocalOutput_int(1);
			eNonlocalOutput(2, i) = eNonlocalOutput_int(2);
			eNonlocalOutput(3, i) = eNonlocalOutput_int(3);
			eNonlocalOutput(4, i) = eNonlocalOutput_int(4);
			eNonlocalOutput(5, i) = eNonlocalOutput_int(5);
		}
		//todo
		/*opserr << "This is eNonlocalOutput"<< eNonlocalOutput << endln;*/
		return eleInfo.setMatrix(eNonlocalOutput);
	}

	case 5: //local section deformations
	{
		Matrix eLocalOutput(6, numSections);
		this->computeE_local(eLocalOutput);
		//todo
		/*opserr << "This is eLocalOutput" << eLocalOutput << endln;*/
		return eleInfo.setMatrix(eLocalOutput);
	}

	/*case 6:
		return eleInfo.setVector(this->getRayleighDampingForces());*/

	case 6: //local section curvatures
	{
		Matrix localCurvatureOutput(2, numSections);
		for (int i = 0; i < numSections; i++)
		{
			localCurvatureOutput(0, i) = eLocal[i](1); //y axis
			localCurvatureOutput(1, i) = eLocal[i](2); //z axis
		}
		//todo
		//opserr << "This is localCurvatureOutput" << localCurvatureOutput << endln;
		return eleInfo.setMatrix(localCurvatureOutput);
	}

	case 7: //nonlocal section curvatures
	{
		Matrix nonlocalCurvatureOutput(2, numSections);
		for (int i = 0; i < numSections; i++)
		{
			nonlocalCurvatureOutput(0, i) = eNonlocal[i](1); //y axis
			nonlocalCurvatureOutput(1, i) = eNonlocal[i](2); //z axis
		}
		//todo
		//opserr << "This is nonlocalCurvatureOutput" << nonlocalCurvatureOutput << endln;
		return eleInfo.setMatrix(nonlocalCurvatureOutput);
	}

	case 8: //moment distribution
	{
		Matrix momentDistributionOutput(2, numSections);
		for (int i = 0; i < numSections; i++)
		{
			momentDistributionOutput(0, i) = sr[i](1); //y axis
			momentDistributionOutput(1, i) = sr[i](2); //z axis
		}
		//todo
		//opserr << "This is localCurvatureOutput" << localCurvatureOutput << endln;
		return eleInfo.setMatrix(momentDistributionOutput);
	}

	case 9: //element basic deformations
	{
		Vector vp(6);
		vp = crdTransf->getBasicTrialDisp();
		return eleInfo.setVector(vp);
	}

	default:
		return -1;
	}
}

//Method the set section pointers
void
FBCElemSGINUS3d::setSectionPointers(int numSec, SectionForceDeformation** secPtrs)
{
	if (numSec > maxNumSections) {
		opserr << "Error: FBCElemSGINUS3d::setSectionPointers -- max number of sections exceeded";
	}

	numSections = numSec;

	if (secPtrs == 0) {
		opserr << "Error: FBCElemSGINUS3d::setSectionPointers -- invalid section pointer";
	}

	sections = new SectionForceDeformation * [numSections];
	if (sections == 0) {
		opserr << "Error: FBCElemSGINUS3d::setSectionPointers -- could not allocate section pointers";
	}

	for (int i = 0; i < numSections; i++) {

		if (secPtrs[i] == 0) {
			opserr << "Error: FBCElemSGINUS3d::setSectionPointers -- null section pointer " << i << endln;
		}

		sections[i] = secPtrs[i]->getCopy();

		if (sections[i] == 0) {
			opserr << "Error: FBCElemSGINUS3d::setSectionPointers -- could not create copy of section " << i << endln;
		}
	}

	// allocate section flexibility matrices and section deformation vectors
	FSection = new Matrix[numSections];
	if (FSection == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate fs array";
	}

	eNonlocal = new Vector[numSections];
	if (eNonlocal == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate vs array";
	}

	sr = new Vector[numSections];
	if (sr == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate Ssr array";
	}

	eNonlocalCommit = new Vector[numSections];
	if (eNonlocalCommit == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate vscommit array";
	}

	eLocal = new Vector[numSections];
	if (eLocal == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate vs array";
	}

	srCommit = new Vector[numSections];
	if (srCommit == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate Ssr array";
	}

	eLocalCommit = new Vector[numSections];
	if (eLocalCommit == 0) {
		opserr << "FBCElemSGINUS3d::setSectionPointers -- failed to allocate eLocalCommit array";
	}

}

// Method to compute theroy values Ac and Bc for matrix H
void
FBCElemSGINUS3d::initCoefficientMatrixH()
{
	double L = crdTransf->getInitialLength();
	double secX[maxNumSections];
	beamIntegr->getSectionLocations(numSections, L, secX);

	Vector allDx(numSections-1);	// spaces between all integration points
	for (int i = 0; i < numSections; i++)
	{
		allDx[i] = L * (secX[i + 1] - secX[i]);
	}

	double bc_GI = 0.;
	double ac_GI = 0.;
	double cc_GI = 0.;
	coeffs_H_GI(0, 0) = 1.;
	for (int i = 1; i < numSections-1; i++)
	{
		bc_GI = -pow(lc, 2) / (allDx[i - 1] * (allDx[i] + allDx[i - 1]));
		ac_GI = 1. + pow(lc, 2) / (allDx[i - 1] * allDx[i]);
		cc_GI = -pow(lc, 2) / (allDx[i] * (allDx[i] + allDx[i - 1]));
		coeffs_H_GI(i, 0) = bc_GI;
		coeffs_H_GI(i, 1) = ac_GI;
		coeffs_H_GI(i, 2) = cc_GI;
	}
	coeffs_H_GI(numSections-1, 2) = 1.;
	//opserr << "This is coeffs_H_GI:" << coeffs_H_GI << endln;

	double ASection = abs(sections[0]->getSectionArea());
	//WSofteningTol = -1. * numSections * ASection * 0.5 * 378. * 1e-6;
	WSofteningTol = -1. * ASection * 0.5 * 378. * 1e-6;
	/*double alphaSoftTol = 1e3;
	WSofteningTol = alphaSoftTol * WSofteningTol;*/
}

// Method to compute updated values Ac using exponential smoothing function and Bc for matrix H
void
FBCElemSGINUS3d::computeCoefficientMatrixH()
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

	coeffs_H(0, 0) = 1.;
	for (int i = 1; i < numSections - 1; i++)
	{
		coeffs_H(i, 0) = gXStar * 0 + (1 - gXStar) * coeffs_H_GI(i, 0);
		coeffs_H(i, 1) = gXStar * 1 + (1 - gXStar) * coeffs_H_GI(i, 1);
		coeffs_H(i, 2) = gXStar * 0 + (1 - gXStar) * coeffs_H_GI(i, 2);
	}
	coeffs_H(numSections - 1, 2) = 1.;

	//opserr << "This is coeffs_H:" << coeffs_H << endln;
}


//Method to compute deStar_nonlocal[]
void
FBCElemSGINUS3d::computeDeStar_nonlocal(Vector deStar_nonlocal_Tot[], Vector deStar_local_Tot[])
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
		for (int j = 1; j < numSections - 1; j++)
		{
			beta4LU(j) = coeffs_H(j, 0) / alpha4LU(j - 1);
			alpha4LU(j) = coeffs_H(j, 1) - beta4LU(j) * coeffs_H(j - 1, 2);
		}
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		// Boundary conditions
		deStar_nonlocal_Tot[0] = deStar_local_Tot[0];
		deStar_nonlocal_Tot[numSections - 1] = deStar_local_Tot[numSections - 1];

		Vector y4LU(numSections);
		for (int i = 0; i < NEBD; i++)
		{
			y4LU(0) = deStar_local_Tot[0](i);
			for (int j = 1; j < numSections; j++)
			{
				y4LU(j) = deStar_local_Tot[j](i) - beta4LU(j) * y4LU(j - 1);
			}

			for (int j = numSections - 2; j > 0; j--)
			{
				deStar_nonlocal_Tot[j](i) = (y4LU(j) - coeffs_H(j, 2) * deStar_nonlocal_Tot[j + 1](i)) / alpha4LU(j);
			}
		}
		/*for (int j = 0; j < numSections; j++) {
			opserr << "Section:" << j << endln;
			opserr << "This is deStar_local_Tot:" << deStar_local_Tot[j] << endln;
			opserr << "This is deStar_nonlocal_Tot:" << deStar_nonlocal_Tot[j] << endln;
		}*/
	}
}


//Method to compute e_local[] 
void
FBCElemSGINUS3d::computeE_local(Matrix& e_local_tot)
{
	e_local_tot.Zero();
	//Vector eNonLocal_SectionI_temp = Vector(NEBD);
	//Vector eNonLocal_MatrixFormALLSections = Vector(NEBD * numSections);
	//Vector eLocal_MatrixFormALLSections = Vector(NEBD * numSections);

	//// Fill the vector with all the nonlocal section deformations
	//for (int i = 0; i < numSections; i++)
	//{
	//	eNonLocal_SectionI_temp = eNonLocalSubdivide[i];
	//	//opserr << "This is eNonLocal_SectionI_temp:" << eNonLocal_SectionI_temp << endln;

	//	for (int j = 0; j < NEBD; j++)
	//	{
	//		eNonLocal_MatrixFormALLSections(i * NEBD + j) = eNonLocal_SectionI_temp(j);
	//		//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln;
	//	}
	//}

	//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln; 

	// Compute the vector with all the local section deformations
	//eLocal_MatrixFormALLSections = H * eNonLocal_MatrixFormALLSections;
	for (int i = 1; i < numSections - 1; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			int global_idx = i * NEBD + j;
			e_local_tot(j, i) = coeffs_H(i, 0) * eNonLocalSubdivide[i - 1](j) + coeffs_H(i, 1) * eNonLocalSubdivide[i](j) + coeffs_H(i, 2) * eNonLocalSubdivide[i + 1](j);
		}
	}
	for (int j = 0; j < NEBD; j++) // Boundary conditions
	{
		e_local_tot(j, 0) = eNonLocalSubdivide[0](j);
		e_local_tot(j, numSections - 1) = eNonLocalSubdivide[numSections - 1](j);
	}
	//opserr << "This is eLocal_MatrixFormALLSections:" << eLocal_MatrixFormALLSections << endln; 

	////Fill the matrix e_local_tot
	//for (int i = 0; i < numSections; i++)
	//{
	//	for (int j = 0; j < NEBD; j++)
	//	{
	//		e_local_tot(j, i) = eLocal_MatrixFormALLSections(i * NEBD + j);
	//	}
	//}

	/*opserr << "This is e_local_tot:" << e_local_tot << endln;
	double test = 0.;*/
}

//Method to compute eu_nonlocal_Tot
void
FBCElemSGINUS3d::computeEu_nonlocal(Vector eu_nonlocal_Tot[], Vector eu_local_Tot[])
{
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
		for (int j = 1; j < numSections - 1; j++)
		{
			beta4LU(j) = coeffs_H(j, 0) / alpha4LU(j - 1);
			alpha4LU(j) = coeffs_H(j, 1) - beta4LU(j) * coeffs_H(j - 1, 2);
		}
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		// Boundary conditions
		eu_nonlocal_Tot[0] = eu_local_Tot[0];
		eu_nonlocal_Tot[numSections - 1] = eu_local_Tot[numSections - 1];

		Vector y4LU(numSections);
		for (int i = 0; i < NEBD; i++)
		{
			y4LU(0) = eu_local_Tot[0](i);
			for (int j = 1; j < numSections; j++)
			{
				y4LU(j) = eu_local_Tot[j](i) - beta4LU(j) * y4LU(j - 1);
			}

			for (int j = numSections - 2; j > 0; j--)
			{
				eu_nonlocal_Tot[j](i) = (y4LU(j) - coeffs_H(j, 2) * eu_nonlocal_Tot[j + 1](i)) / alpha4LU(j);
			}
		}
		/*for (int j = 0; j < numSections; j++) {
			opserr << "Section:" << j << endln;
			opserr << "This is eu_local_Tot:" << eu_local_Tot[j] << endln;
			opserr << "This is eu_nonlocal_Tot:" << eu_nonlocal_Tot[j] << endln;
		}*/
	}
	/*for (int j = 0; j < numSections; j++) {
		opserr << "Section:" << j << endln;
		opserr << "This is eu_local_Tot:" << eu_local_Tot[j] << endln;
		opserr << "This is eu_nonlocal_Tot:" << eu_nonlocal_Tot[j] << endln;
	}*/
}

//Method to compute nonlocal element flexibility matrix
void
FBCElemSGINUS3d::computeFelement_nonlocal(Matrix& Felement_nonlocal)
{
	Felement_nonlocal.Zero();
	Matrix b(NEBD, NEBD);
	Matrix B_Q(NEBD * numSections, NEBD);
	Matrix B_q(NEBD, NEBD * numSections);
	Matrix Fsection_Tot(NEBD * numSections, NEBD * numSections);
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

	for (int i = 0; i < numSections; i++)
	{
		//compute matrix b
		b.Zero();
		const ID& code = sections[i]->getType();
		this->getForceInterpolatMatrix(xi[i], b, code);

		//compute matrices B_Q and B_q
		double wtL = wt[i] * L;

		for (int j = 0; j < NEBD; j++) //loop to over the lines of b
		{
			for (int k = 0; k < NEBD; k++) //loop to over the columns of b
			{
				B_Q(i * NEBD + j, k) = b(j, k);
				B_q(k, i * NEBD + j) = wtL * b(j, k);
			}
		}

		//assemble matrix Fsection_Tot
		//Matrix Fsection_interm(NEBD, NEBD); //intermediate matrix to fill Fsection_Tot
		//Fsection_interm = FSectionSubdivide[i];

		//opserr << "This matrix Fsection_interm:" << Fsection_interm << endln;

		for (int j = 0; j < NEBD; j++) //loop to over the lines of Fsection_interm
		{
			for (int k = 0; k < NEBD; k++) //loop to over the columns of Fsection_interm
			{
				//Fsection_Tot(i * NEBD + j, i * NEBD + k) = Fsection_interm(j, k);
				Fsection_Tot(i * NEBD + j, i * NEBD + k) = FSectionSubdivide[i](j, k);
			}
		}
	}

	Matrix Hinv_multFsection_Tot(NEBD * numSections, NEBD * numSections);

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
		for (int j = 1; j < numSections - 1; j++)
		{
			beta4LU(j) = coeffs_H(j, 0) / alpha4LU(j - 1);
			alpha4LU(j) = coeffs_H(j, 1) - beta4LU(j) * coeffs_H(j - 1, 2);
		}
		beta4LU(numSections - 1) = 0;
		alpha4LU(numSections - 1) = 1;

		// Boundary conditions
		for (int i = 0; i < NEBD; i++)
		{
			for (int j = 0; j < NEBD; j++)
			{
				Hinv_multFsection_Tot(i, j) = Fsection_Tot(i, j);
				Hinv_multFsection_Tot(NEBD * numSections - 1 - i, NEBD * numSections - 1 - j) = Fsection_Tot(NEBD * numSections - 1 - i, NEBD * numSections - 1 - j);
			}
		}

		// Thomas algorithm
		Vector y4LU(NEBD * numSections);
		for (int i = 0; i < NEBD * numSections; i++)
		{
			for (int k = 0; k < NEBD; k++)
			{
				y4LU(k) = Fsection_Tot(k, i);
			}
			for (int j = NEBD; j < NEBD * numSections; j++)
			{
				y4LU(j) = Fsection_Tot(j, i) - beta4LU(j / NEBD) * y4LU(j - NEBD);
			}
			for (int j = NEBD * numSections - NEBD - 1; j > NEBD - 1; j--)
			{
				Hinv_multFsection_Tot(j, i) = (y4LU(j) - coeffs_H(j / NEBD, 2) * Hinv_multFsection_Tot(j + NEBD, i)) / alpha4LU(j / NEBD);
			}
		}

	}

	Felement_nonlocal = B_q * Hinv_multFsection_Tot * B_Q;

	//compute the matrix multiplication F_element_nonLocal=B_q*inv(H)*Fsection_Tot*B_Q;
	/*computeMatrixH();
	computeMatrixH_inv();
	Matrix Felement_nonlocal_target = B_q * H_inv * Fsection_Tot * B_Q;*/

	/*opserr << "This matrix FHinv_multFsection_Target:" << H_inv * Fsection_Tot << endln;
	opserr << "This Hinv_multFsection_Tot:" << Hinv_multFsection_Tot << endln;*/
	/*opserr << "This matrix Felement_nonlocal_target:" << Felement_nonlocal_target << endln;
	opserr << "This matrix Felement_nonlocal:" << Felement_nonlocal << endln;*/

	//opserr << "This matrix B_q:" << B_q << endln;
	//opserr << "This matrix H:" << H << endln;
	//opserr << "This matrix H_inv:" << H_inv << endln;
	//opserr << "This matrix H_inv*Fsection_Tot:" << H_inv * Fsection_Tot << endln;
	//opserr << "This matrix Fsection_Tot:" << Fsection_Tot << endln;
	//opserr << "This matrix B_Q:" << B_Q << endln;
	//opserr << "This matrix Felement_nonlocal:" << Felement_nonlocal << endln;
	//double test = 0.;
}



