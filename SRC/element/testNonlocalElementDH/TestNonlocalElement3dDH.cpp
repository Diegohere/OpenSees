//
// Created by Diego Heredia on 19.06.23
//

#include "TestNonlocalElement3dDH.h"

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
Matrix TestNonlocalElement3dDH::theMatrix(12, 12);
Vector TestNonlocalElement3dDH::theVector(12);
double TestNonlocalElement3dDH::workArea[200];

Vector TestNonlocalElement3dDH::eTotSubdivide[maxNumSections];
Matrix TestNonlocalElement3dDH::FSectionSubdivide[maxNumSections];
Vector TestNonlocalElement3dDH::srSubdivide[maxNumSections];

//Vector TestNonlocalElement3dDH::sSubdivide[maxNumSections];

// Method to read the command arguments
void* OPS_TestNonlocalElement3dDH()
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

	// Initialize the element
	Element* theEle = new TestNonlocalElement3dDH(eleTag, nodeTagI, nodeTagJ, *theCoordTransf, *theBeamIntegration,
		sections, numIntegrPoints, maxNumIters, tolerance,lc);
	delete[] sections;
	return 0;
}

// Constructor 2 (for parallel processing)
TestNonlocalElement3dDH::TestNonlocalElement3dDH() : Element(0, ELE_TAG_TestNonlocalElement3dDH), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
maxIters(0), Tol(0), lc(0), initialFlag(0),
Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(2 * 10, 2 * 10), H_inv(2 * 10, 2 * 10),
FSection(0), eTot(0), sr(0), eTotCommit(0),
numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD),
KelementInitial(0), isTorsion(false), sectionSofteningTrial(false), sectionSofteningCommit(false)
// complete
{
	// Set Node Pointers to 0
	theNodes[0] = 0;
	theNodes[1] = 0;

	load.Zero();
}

// Constructor 1 (for normal processing) invoked by a FEM_ObjectBroker
TestNonlocalElement3dDH::TestNonlocalElement3dDH(int tag, int nodeI, int nodeJ, CrdTransf& CT, BeamIntegration& BI,
	SectionForceDeformation** sec, int numSec, int maxNumIters, double tolerance, double LC)
	:Element(tag, ELE_TAG_TestNonlocalElement3dDH), connectedExternalNodes(2), beamIntegr(0), numSections(0), sections(0), crdTransf(0),
	maxIters(maxNumIters), Tol(tolerance), lc(LC), initialFlag(0),
	Kelement(NEBD, NEBD), q(NEBD), KelementCommit(NEBD, NEBD), qCommit(NEBD), H(6* numSec,6* numSec), H_inv(6 * numSec, 6 * numSec),
	FSection(0), eTot(0), sr(0), eTotCommit(0), 
	numEleLoads(0), sizeEleLoads(0), eleLoads(0), eleLoadFactors(0), load(NEGD),
	KelementInitial(0), isTorsion(false), sectionSofteningTrial(false), sectionSofteningCommit(false)
	// complete
{
	// Pointers to Nodes and Their IDs
	if (connectedExternalNodes.Size() != 2) {
		opserr << "WARNING! TestNonlocalElement3dDH::TestNonlocalElement3dDH(): " << this->getTag() << " - failed to create an ID of size 2\n";
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
		opserr << "WARNING! TestNonlocalElement3dDH::TestNonlocalElement3dDH(): " << this->getTag() << " - could not create copy of beam integration object" << endln;
		exit(-1);
	}

	// get copy of the transformation object   
	crdTransf = CT.getCopy3d();
	if (crdTransf == 0) {
		opserr << "WARNING! TestNonlocalElement3dDH::TestNonlocalElement3dDH(): could not create copy of coordinate transformation object" << endln;
		exit(-1);
	}

	//get copy of sections
	this->setSectionPointers(numSec, sec);
}

// Destructor
//      delete must be invoked on any objects created by the object
TestNonlocalElement3dDH::~TestNonlocalElement3dDH()
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

	if (eTot != 0) {
		delete[] eTot;
	}

	if (sr != 0) {
		delete[] sr;
	}

	if (eTotCommit != 0) {
		delete[] eTotCommit;
	}

	if (crdTransf != 0)
		delete crdTransf;

	if (beamIntegr != 0)
		delete beamIntegr;

	if (KelementInitial != 0)
		delete KelementInitial;
}

int
TestNonlocalElement3dDH::getNumExternalNodes(void) const
{
	return 2;
}

const ID&
TestNonlocalElement3dDH::getExternalNodes(void)
{
	return connectedExternalNodes;
}

Node**
TestNonlocalElement3dDH::getNodePtrs()
{
	return theNodes;
}

int
TestNonlocalElement3dDH::getNumDOF(void)
{
	return NEGD;
}

// Definition of setDomain()
void
TestNonlocalElement3dDH::setDomain(Domain* theDomain)
{
	// check Domain is not null - invoked when object removed from a domain
	if (theDomain == 0) {
		theNodes[0] = 0;
		theNodes[1] = 0;

		opserr << "ERROR! TestNonlocalElement3dDH::setDomain():  theDomain = 0 ";
		exit(0);
	}

	// Get pointers to the nodes
	int Nd1 = connectedExternalNodes(0);
	int Nd2 = connectedExternalNodes(1);

	theNodes[0] = theDomain->getNode(Nd1);
	theNodes[1] = theDomain->getNode(Nd2);

	if (theNodes[0] == 0) {
		opserr << "ERROR! TestNonlocalElement3dDH::setDomain: Nd1: ";
		opserr << Nd1 << "does not exist in model\n";
		exit(0);
	}

	if (theNodes[1] == 0) {
		opserr << "ERROR! TestNonlocalElement3dDH::setDomain: Nd2: ";
		opserr << Nd2 << "does not exist in model\n";
		exit(0);
	}

	// call the DomainComponent class method 
	this->DomainComponent::setDomain(theDomain);

	// ensure connected nodes have correct number of dof's
	int dofNode1 = theNodes[0]->getNumberDOF();
	int dofNode2 = theNodes[1]->getNumberDOF();

	if (dofNode1 != NND) {
		opserr << "ERROR! TestNonlocalElement3dDH::setDomain() - element: " << this->getTag() << " - node " << Nd1 << " does not have 6 DOFs\n";
		exit(0);
	}

	if (dofNode2 != NND) {
		opserr << "ERROR! TestNonlocalElement3dDH::setDomain() - element: " << this->getTag() << " - node " << Nd2 << " does not have 6 DOFs\n";
		exit(0);
	}

	// Initialize Coordinate Transformation
	if (crdTransf->initialize(theNodes[0], theNodes[1])) {
		opserr << "WARNING! TestNonlocalElement3dDH::setDomain() - element: " << this->getTag() << " - Error initializing coordinate transformation\n";
		exit(0);
	}

	// get element length
	double L = crdTransf->getInitialLength();
	if (L == 0.0) {
		opserr << "WARNING! TestNonlocalElement3dDH::setDomain(): element has zero length:" << this->getTag();
		exit(0);
	}

	if (initialFlag == 0)
		this->initializeSectionHistoryVariables();
}

//Function to commit state of the element
int
TestNonlocalElement3dDH::commitState()
{
	int err = 0;

	// Element commitState()
	if ((err = this->Element::commitState()))
		opserr << "WARNING! TestNonlocalElement3dDH::commitState() - element: " << this->getTag() << " - failed in committing base class\n";

	// Commit section state variables
	for (int i = 0; i < numSections; i++) {
		err += sections[i]->commitState();
		eTotCommit[i] = eTot[i];
	}

	// Commit the element variables state
	KelementCommit = Kelement;
	qCommit = q;

	// Commit the transformation between coord. systems
	if ((err = crdTransf->commitState()) != 0)
		opserr << "WARNING! TestNonlocalElement3dDH::commitState() - element: " << this->getTag() << " - failed to commit coordinate transformation object\n";

	// Commit if at least one section experiences softening
	sectionSofteningCommit = sectionSofteningTrial;

	// Complete committing the variables
	return err;
}

//Function to revert to last commit
int
TestNonlocalElement3dDH::revertToLastCommit(void)
{
	int err = 0;
	// Revert section state variables to last committed state
	for (int i = 0; i < numSections; i++) {
		err += sections[i]->revertToLastCommit();
		eTot[i] = eTotCommit[i];

		sections[i]->setTrialSectionDeformation(eTot[i]);
		sr[i] = sections[i]->getStressResultant();
		FSection[i] = sections[i]->getSectionFlexibility();
	}
	// Revert coordinate transformation object to last committed state
	if ((err = crdTransf->revertToLastCommit()))
		opserr << "WARNING! TestNonlocalElement3dDH::revertToLastCommit() - element: " << this->getTag() << " - coordinate transformation object failed to revert to last committed state\n";

	// Revert the element variables state
	Kelement = KelementCommit;
	q = qCommit;

	// Revert if at least one section experiences softening
	sectionSofteningTrial = sectionSofteningCommit;

	initialFlag = 0;

	// complete reverting the variables
	return err;
}

//Function to revert to start
int
TestNonlocalElement3dDH::revertToStart(void)
{
	// revert the sections state variables to start
	int err = 0;

	for (int i = 0; i < numSections; i++) {
		err += sections[i]->revertToStart();

		FSection[i].Zero();
		eTot[i].Zero();
		sr[i].Zero();
	}

	// revert the transformation to start
	if ((err = crdTransf->revertToStart()) != 0)
		opserr << "WARNING! TestNonlocalElement3dDH::revertToStart() - element: " << this->getTag() << " - failed to revert to start coordinate transformation object\n";

	// revert the element state variables to start
	qCommit.Zero();
	KelementCommit.Zero();
	q.Zero();
	Kelement.Zero();

	// Revert if at least one section experiences softening
	sectionSofteningTrial = false;
	sectionSofteningCommit = false;

	initialFlag = 0;
	return err;
}

//Function to get initial element stiffness matrix in basic reference frame
const Matrix&
TestNonlocalElement3dDH::getInitialStiff(void)
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
TestNonlocalElement3dDH::getTangentStiff(void)
{
	crdTransf->update();

	//opserr << "This is Kelement:" << Kelement << endln;

	return crdTransf->getGlobalStiffMatrix(Kelement, q);
}

//Method to get reaction due to element loads
void
TestNonlocalElement3dDH::computeReactions(double* p0)
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
TestNonlocalElement3dDH::getResistingForce(void)
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
TestNonlocalElement3dDH::initializeSectionHistoryVariables(void)
{
	for (int i = 0; i < numSections; i++) {
		int order = sections[i]->getOrder();

		FSection[i] = Matrix(order, order);
		eTot[i] = Vector(order);
		sr[i] = Vector(order);
		eTotCommit[i] = Vector(order);

		//sSubdivide[i] = Vector(order);
	}
}

//Method to solve for nodal forces
int
TestNonlocalElement3dDH::update(void)
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

	double* xi;
	xi = new double[numSections];
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

	static Vector s_seci(NEBD);
	static Matrix s_All(NEBD, numSections);
	static Vector ds(NEBD);
	Vector su(NEBD);
	static Matrix Fb(NEBD, NEBD);
	Vector deltaETot_isec(NEBD);
	Vector eu_isec(NEBD);

	Matrix deltaETot_All(NEBD, numSections);
	Matrix eu_All(NEBD, numSections);
	deltaETot_All.Zero();
	eu_All.Zero();

	//Determination of matrix H
	H.Zero();
	this->computeMatrixH(H);

	//Determination of matrix H_inv
	H_inv.Zero();
	this->computeMatrixH_inv(H, H_inv);

	double WDot ;

	//todo
	/*opserr << "this is matrix h: " << H << endln;
	opserr << "this is matrix h_inv: " << H_inv << endln;*/

	////Initialization of array of vector and matrices
	//Vector* s_Tot = new Vector[numSections];
	//for (int ii = 0; ii < numSections; ii++) {
	//	int order = sections[ii]->getOrder();

	//	s_Tot[ii] = Vector(order);
	//}


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
				eTotSubdivide[i] = eTot[i];
				FSectionSubdivide[i] = FSection[i];
				srSubdivide[i] = sr[i];

				sectionSofteningTrial = sectionSofteningCommit;

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
				int numIters = maxIters;
				if (l == 1)
					numIters = 10 * maxIters; // allow 10 times more iterations for initial tangent

				for (j = 0; j < numIters; j++)
				{
					// initialize f and vr for integration
					Felement.Zero();
					vu.Zero();

					/*opserr << "This is iteration:" << j << endln;
					opserr << "This is qTrial:" << qTrial << endln;
					opserr << "This is dq:" << dq << endln;*/

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

						s_seci.Zero();
						ds.Zero();
						su.Zero();
						eu_isec.Zero();
						Fb.Zero();
						deltaETot_isec.Zero();


						double xL = xi[i];
						double xL1 = xL - 1.0;
						double wtL = wt[i] * L;

						// calculate total section forces s = b*q + bp*currDistrLoad;
						int ii;
						for (ii = 0; ii < order; ii++) {
							switch (code(ii)) {
							case SECTION_RESPONSE_P:
								s_seci(ii) = qTrial(0);
								break;
							case SECTION_RESPONSE_MZ:
								s_seci(ii) = xL1 * qTrial(1) + xL * qTrial(2);
								break;
							case SECTION_RESPONSE_VY:
								s_seci(ii) = oneOverL * (qTrial(1) + qTrial(2));
								break;
							case SECTION_RESPONSE_MY:
								s_seci(ii) = xL1 * qTrial(3) + xL * qTrial(4);
								break;
							case SECTION_RESPONSE_VZ:
								s_seci(ii) = oneOverL * (qTrial(3) + qTrial(4));
								break;
							case SECTION_RESPONSE_T:
								s_seci(ii) = qTrial(5);
								break;
							default:
								s_seci(ii) = 0.0;
								break;
							}
						}
						// Add the effects of element loads, if present s = b*q + sp
						if (numEleLoads > 0)
							this->computeSectionForces(s_seci, i);

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
								ds(ii) = oneOverL * (dq(1) + dq(2));
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

						////Add s_seci to matrix containing all section forces
						//s_Tot[i] = s_seci;

						////todo
						//opserr << "This is s_seci:" << s_seci << endln;

						// compute local section deformation increments
						if (l == 0)
						{
							//  regular newton de += fs * ds;     
							deltaETot_isec.addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);
						}
						else if (l == 2)
						{
							//  newton with initial tangent if first iteration e += FSection0 * ds;     
							//  otherwise regular newton e += FSection * ds;    
							if (j == 0)
							{
								const Matrix& FSection0 = sections[i]->getInitialFlexibility();

								deltaETot_isec.addMatrixVector(0.0, FSection0, ds, 1.0);
							}
							else
							{
								deltaETot_isec.addMatrixVector(0.0, FSectionSubdivide[i], ds, 1.0);
							}
						}
						else
						{
							//  newton with initial tangent e += FSection0 * ds;    
							const Matrix& FSection0 = sections[i]->getInitialFlexibility();
							deltaETot_isec.addMatrixVector(0.0, FSection0, ds, 1.0);
						}

						// Add unbalanced section deformation
						for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++) {
							deltaETot_isec(iiLineComponent) += eu_All(iiLineComponent, i);
						}

						// Add to matrix with all sections
						for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						{
							deltaETot_All(iiLineComponent, i) = deltaETot_isec(iiLineComponent);
							s_All(iiLineComponent, i) = s_seci(iiLineComponent);
						}
					}

					//Nonlocal part if a section experiences softening
					if (sectionSofteningTrial)
					{
						//opserr << "This is deltaETot_isec:" << deltaETot_isec << endln;
						deltaETot_All = computeDENonlocalAll(deltaETot_All);
					}

					for (i = 0; i < numSections; i++)
						{
						//Take the column corresponding to section
						for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						{
							deltaETot_isec(iiLineComponent) = deltaETot_All(iiLineComponent, i);
							s_seci(iiLineComponent) = s_All(iiLineComponent, i);
						}

						// Update total section deformations
						if (initialFlag != 0)
							eTotSubdivide[i] += deltaETot_isec;
						/*opserr << "This is ds:" << ds << endln;
						opserr << "This is deltaETot_isec:" << deltaETot_isec << endln;
						opserr << "This is eTotSubdivide:" << eTotSubdivide[i] << endln;
						opserr << "This is FSectionSubdivide[i]:" << FSectionSubdivide[i] << endln;*/

						////Add each delta e_star_local to matrix containing all sections
						//for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						//{
						//	deStar_local_Tot(iiLineComponent, i) = deStar_local_seci(iiLineComponent);
						//}						

						////Fil the vector with actual values
						//for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						//{
						//	deStar_nonlocal_isec(iiLineComponent) = deStar_nonlocal_Tot(iiLineComponent,i);
						//	eu_nonlocal_isec(iiLineComponent) = eu_nonlocal_Tot(iiLineComponent, i);
						//}

						//Set the section deformations for section state determination
						if (sections[i]->setTrialSectionDeformation(eTotSubdivide[i]) < 0)
						{
							opserr << "TestNonlocalElement3dDH::update() - section failed in setTrial\n";
							opserr << "This is section: " << i + 1 << endln;
							return -1;
						}

						// get section resisting forces
						srSubdivide[i] = sections[i]->getStressResultant();

						// get section flexibility matrix
						FSectionSubdivide[i] = sections[i]->getSectionFlexibility();

						// calculate section residual deformations de = FSection * (s - sr);
						su = s_seci;  //take the corresponding section force from matrix with all section forces
						su.addVector(1.0, srSubdivide[i], -1.0);  // ds = s - sr[i];
						/*opserr << "This is s_seci: " << s_seci << endln;
						opserr << "This is srSubdivide[i]: " << srSubdivide[i] << endln;
						opserr << "This is su: " << su << endln;*/

						//compute eu_local for section i
						eu_isec.addMatrixVector(0.0, FSectionSubdivide[i], su, 1.0);
						// Add to matrix with all sections
						for (int iiLineComponent = 0; iiLineComponent < NEBD; iiLineComponent++)
						{
							eu_All(iiLineComponent, i) = eu_isec(iiLineComponent);
						}
						//opserr << "This is eu_isec: " << eu_isec << endln;

						//This is from local formulation
						//integrate element flexibility matrix f = f + (b^ fs * b) * wtL;

					}

					if (sectionSofteningTrial)
					{
						//Compute Felement_nonlocal
						computeFelement_nonlocal(Felement, H_inv, FSectionSubdivide);
						//opserr << "This matrix Felement after call function:" << Felement << endln;

						for (i = 0; i < numSections; i++)
						{
							//Compute unbalance element deformations
							int order = sections[i]->getOrder();
							const ID& code = sections[i]->getType();
							double xL = xi[i];
							double xL1 = xL - 1.0;
							double wtL = wt[i] * L;
							double tmp;

							double dei;

							for (int ii = 0; ii < order; ii++) {
								//dei = eu_isec(ii) * wtL;
								dei = eu_All(ii, i) * wtL;
								switch (code(ii)) {
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
					}
					else
					{
						for (i = 0; i < numSections; i++)
						{
							int order = sections[i]->getOrder();
							const ID& code = sections[i]->getType();
							double xL = xi[i];
							double xL1 = xL - 1.0;
							double wtL = wt[i] * L;

							int ii;
							int jj;
							const Matrix& FSec = FSectionSubdivide[i];
							Fb.Zero();
							double tmp;
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
										tmp = oneOverL * FSec(jj, ii) * wtL;
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
										Felement(0, jj) += Fb(ii, jj);
									break;
								case SECTION_RESPONSE_MZ:
									for (jj = 0; jj < NEBD; jj++) {
										tmp = Fb(ii, jj);
										Felement(1, jj) += xL1 * tmp;
										Felement(2, jj) += xL * tmp;
									}
									break;
								case SECTION_RESPONSE_VY:
									for (jj = 0; jj < NEBD; jj++) {
										tmp = oneOverL * Fb(ii, jj);
										Felement(1, jj) += tmp;
										Felement(2, jj) += tmp;
									}
									break;
								case SECTION_RESPONSE_MY:
									for (jj = 0; jj < NEBD; jj++) {
										tmp = Fb(ii, jj);
										Felement(3, jj) += xL1 * tmp;
										Felement(4, jj) += xL * tmp;
									}
									break;
								case SECTION_RESPONSE_VZ:
									for (jj = 0; jj < NEBD; jj++) {
										tmp = oneOverL * Fb(ii, jj);
										Felement(3, jj) += tmp;
										Felement(4, jj) += tmp;
									}
									break;
								case SECTION_RESPONSE_T:
									for (jj = 0; jj < NEBD; jj++)
										Felement(5, jj) += Fb(ii, jj);
									break;
								default:
									break;
								}
							}

							// Integrate unbalanced deformations vu += (b^ (e + de)) * wtL  vr.addMatrixTransposeVector(1.0, b[i], vs[i] + dvs, wtL);;
							double dei;

							for (int ii = 0; ii < order; ii++) {
								//dei = eu_isec(ii) * wtL;
								dei = eu_All(ii, i) * wtL;
								switch (code(ii)) {
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
							//opserr << "This is vu:" << vu << endln;
						}
					}

					// Check if section experiences softening
					for (i = 0; i < numSections; i++)
					{
						WDot = 0.;
						for (int iComp = 0; iComp < NEBD; iComp++)
						{
							WDot += 0.5 * (srSubdivide[i](iComp) - sr[i](iComp)) * (eTotSubdivide[i](iComp) - eTotCommit[i](iComp));
						}
						//opserr << "This is WDot:" << WDot << endln;
						if (WDot < 0. && abs(WDot)>1)
						{
							sectionSofteningTrial = true;
						}
					}

					// calculate element stiffness matrix invert3by3Matrix(F, Kelement);	  
					if (Felement.Solve(I, KelementTrial) < 0) {
						opserr << "TestNonlocalElement3dDH::update() -- could not invert flexibility\n";
						//opserr << "This is Felement:" <<Felement<<endln;
					}
					//opserr << "This is KelementTrial:" << KelementTrial << endln;

					//todo 
					//opserr << "This is the element flexibility matrix:" << Felement << endln;
					//opserr << "This is the element stiffness matrix:" << KelementTrial << endln;

					dv.addVector(0.0, vu, -1.0);

					/*opserr << "This is qTrial:" << qTrial << endln;
					opserr << "This is dq:" << dq << endln;
					opserr << "This is vu:" << vu << endln;
					opserr << "This is dv:" << dv << endln;*/

					dq.addMatrixVector(0.0, KelementTrial, dv, 1.0);

					qTrial += dq;

					// check for convergence of this interval
					//opserr << "This is dv:" << dv << endln;
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
							eTot[k] = eTotSubdivide[k];
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
		opserr << "WARNING - TestNonlocalElement3dDH::update - failed to get compatible ";
		opserr << "element forces & deformations for element: ";
		opserr << this->getTag() << "(Norm dv: << " << dv.Norm() << ")\n";
		opserr << this->getTag() << "( dv: << " << dv << ")\n";
		return -1;
	}

	initialFlag = 1;

	return 0;
}

// Method to get force interpolation matrix b
void TestNonlocalElement3dDH::getForceInterpolatMatrix(double xi, Matrix& b, const ID& code)
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
void TestNonlocalElement3dDH::getDistrLoadInterpolatMatrix(double xi, Matrix& bp, const ID& code)
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
TestNonlocalElement3dDH::computeSectionForces(Vector& sp, int isec)
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
			opserr << "TestNonlocalElement3dDH::addLoad -- load type unknown for element with tag: " <<
				this->getTag() << endln;
		}
	}
}

//Method to get the mass matrix
const Matrix&
TestNonlocalElement3dDH::getMass(void)
{
	theMatrix.Zero();

	double L = crdTransf->getInitialLength();
	//if (rho != 0.0)
		//theMatrix(0, 0) = theMatrix(1, 1) = theMatrix(3, 3) = theMatrix(4, 4) = 0.5 * L * rho;

	return theMatrix; // For now returns matrix 0. need to add rho to .h file 
}

//Method for zero element loads
void
TestNonlocalElement3dDH::zeroLoad(void)
{
	load.Zero();

	numEleLoads = 0;

	return;
}

// Method to add element loads
int
TestNonlocalElement3dDH::addLoad(ElementalLoad* theLoad, double loadFactor)
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
TestNonlocalElement3dDH::getResistingForceIncInertia()
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
TestNonlocalElement3dDH::sendSelf(int commitTag, Channel& theChannel)
{
	// No parallel processing for now
	opserr << "WARNING! TestNonlocalElement3dDH::sendSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for receiving itself for parallel processing
int
TestNonlocalElement3dDH::recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker)
{
	// No parallel processing for now
	opserr << "WARNING! TestNonlocalElement3dDH::recvSelf() - element: " << this->getTag() << " - no parallel processing for now\n";
	return -1;
}

//Method for computing initial element flexibility matrix
int
TestNonlocalElement3dDH::getInitialFlexibility(Matrix& Fe)
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
					tmp = oneOverL * FSec(jj, ii) * wtL;
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
					tmp = oneOverL * Fb(ii, jj);
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
TestNonlocalElement3dDH::Print(OPS_Stream& s, int flag)
{
	s << "Element Tag: " << this->getTag() << endln;
	s << "Type: TestNonlocalElement3dDH" << endln;
	s << "Connected Node Tags: iNode " << connectedExternalNodes(0)
		<< ", jNode " << connectedExternalNodes(1) << endln;
	s << "Section Tag: " << sections[0]->getTag() << endln;
	s << "Number of Sections: " << numSections << endln;
}

//Method to draw and view the element
int
TestNonlocalElement3dDH::displaySelf(Renderer& theViewer, int displayMode, float fact, const char** displayModes, int numMode)
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
TestNonlocalElement3dDH::setResponse(const char** argv, int argc, OPS_Stream& output)
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

		theResponse = new ElementResponse(this, 3, Vector(3));
	}

	//Total section deformations
	else if (strcmp(argv[0], "NonlocalSectionDeformations") == 0)
	{
		//int order = sections[0]->getOrder();  //use section 0 to get order
		theResponse = new ElementResponse(this, 4, Matrix(6, numSections));
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
		theResponse = new ElementResponse(this, 5, theVector);
	}

	return theResponse;
}

//Method to get the response parameters
int
TestNonlocalElement3dDH::getResponse(int responseID, Information& eleInfo)
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

	case 4: //Total section deformations
	{
		Matrix eTotOutput(6, numSections);
		eTotOutput.Zero();
		Vector eTotOutput_int(6);  //intermediate vector to fill
		for (int i = 0; i < numSections; i++)
		{
			eTotOutput_int = eTotCommit[i];
			eTotOutput(0, i) = eTotOutput_int(0);
			eTotOutput(1, i) = eTotOutput_int(1);
			eTotOutput(2, i) = eTotOutput_int(2);
			eTotOutput(3, i) = eTotOutput_int(3);
			eTotOutput(4, i) = eTotOutput_int(4);
			eTotOutput(5, i) = eTotOutput_int(5);
		}
		//todo
		/*opserr << "This is eTotOutput"<< eTotOutput << endln;*/
		return eleInfo.setMatrix(eTotOutput);
	}

	case 5:
		return eleInfo.setVector(this->getRayleighDampingForces());

	default:
		return -1;
	}
}

//Method the set section pointers
void
TestNonlocalElement3dDH::setSectionPointers(int numSec, SectionForceDeformation** secPtrs)
{
	if (numSec > maxNumSections) {
		opserr << "Error: TestNonlocalElement3dDH::setSectionPointers -- max number of sections exceeded";
	}

	numSections = numSec;

	if (secPtrs == 0) {
		opserr << "Error: TestNonlocalElement3dDH::setSectionPointers -- invalid section pointer";
	}

	sections = new SectionForceDeformation * [numSections];
	if (sections == 0) {
		opserr << "Error: TestNonlocalElement3dDH::setSectionPointers -- could not allocate section pointers";
	}

	for (int i = 0; i < numSections; i++) {

		if (secPtrs[i] == 0) {
			opserr << "Error: TestNonlocalElement3dDH::setSectionPointers -- null section pointer " << i << endln;
		}

		sections[i] = secPtrs[i]->getCopy();

		if (sections[i] == 0) {
			opserr << "Error: TestNonlocalElement3dDH::setSectionPointers -- could not create copy of section " << i << endln;
		}
	}

	// allocate section flexibility matrices and section deformation vectors
	FSection = new Matrix[numSections];
	if (FSection == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate fs array";
	}

	eTot = new Vector[numSections];
	if (eTot == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vs array";
	}

	sr = new Vector[numSections];
	if (sr == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate Ssr array";
	}

	eTotCommit = new Vector[numSections];
	if (eTotCommit == 0) {
		opserr << "TestNonlocalElement3dDH::setSectionPointers -- failed to allocate vscommit array";
	}

}

//Method to compute matrix H
void
TestNonlocalElement3dDH::computeMatrixH(Matrix& H)
{
	H.Zero(); // initialize matrix H

	double L = crdTransf->getInitialLength();
	double* secX = new double[numSections];
	beamIntegr->getSectionLocations(numSections, L, secX);	// relative locations of sections (x/L)
	int order = sections[0]->getOrder();   // use first section to get the order

	Vector dx(numSections - 1);	// spaces between integration points

	for (int j = 0; j < numSections - 1; j++)
	{
		dx(j) = L * (secX[j + 1] - secX[j]);
	}

	// 2nd Order PDE, Dirichlet BCs
	for (int i = 0; i < order; i++) {
		H(i, i) = 1.0;
		H(order * numSections - i - 1, order * numSections - i - 1) = 1.0;
	}

	for (int j = 1; j < numSections - 1; j++) {
		for (int i = 0; i < order; i++) {
			H(j * order + i, (j - 1) * order + i) = -pow(lc, 2) / (dx(j - 1) * (dx(j - 1) + dx(j)));
			H(j * order + i, j * order + i) = 1 + pow(lc, 2) / (dx(j - 1) * dx(j));
			H(j * order + i, (j + 1) * order + i) = -pow(lc, 2) / (dx(j) * (dx(j - 1) + dx(j)));
		}
	}
}

//Method to compute H_inv
void
TestNonlocalElement3dDH::computeMatrixH_inv(Matrix H, Matrix& H_inv)
{
	H_inv.Zero();
	if (H.Invert(H_inv) < 0)
		opserr << "TestNonlocalElement3dDH::update() -- could not invert matrix H\n";
}

//Method to compute computeDENonlocalAll
Matrix
TestNonlocalElement3dDH::computeDENonlocalAll(Matrix deltaETot_All)
{
	Vector dELocalAll_Vector = Vector(NEBD * numSections);
	Vector dENonlocalAll_Vector = Vector(NEBD * numSections);
	Matrix dENonlocalAll = Matrix(NEBD, numSections);

	// Fill the vector with all the local section deformations
	for (int i = 0; i < numSections; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			dELocalAll_Vector(i * NEBD + j) = deltaETot_All(j, i);
		}
	}
	//opserr << "This is dELocalAll_Vector:" << dELocalAll_Vector << endln;

	// Compute the vector with all the nonlocal section deformations
	dENonlocalAll_Vector = H_inv * dELocalAll_Vector;
	//opserr << "This is dENonlocalAll_Vector:" << dENonlocalAll_Vector << endln;

	//Fill the matrix eu_nonlocal
	for (int i = 0; i < numSections; i++)
	{
		for (int j = 0; j < NEBD; j++)
		{
			dENonlocalAll(j, i) = dENonlocalAll_Vector(i * NEBD + j);
		}
	}
	//opserr << "This is deltaETot_All" << deltaETot_All << endln;
	//opserr << "This is dENonlocalAll:" << dENonlocalAll << endln;

	return dENonlocalAll;
}


//Method to compute Felement_nonlocal
void 
TestNonlocalElement3dDH::computeFelement_nonlocal(Matrix& Felement, Matrix H_inv, Matrix FSectionSubdivide[])
{
	Felement.Zero();
	Matrix b(NEBD, NEBD);
	Matrix B_Q(NEBD * numSections, NEBD);
	Matrix B_q(NEBD, NEBD * numSections);
	Matrix Fsection_Tot(NEBD * numSections, NEBD * numSections);
	B_Q.Zero();
	B_q.Zero();
	Fsection_Tot.Zero();

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
		Matrix Fsection_interm(NEBD, NEBD); //intermediate matrix to fill Fsection_Tot
		Fsection_interm = FSectionSubdivide[i];

		//opserr << "This matrix Fsection_interm:" << Fsection_interm << endln;

		for (int j = 0; j < NEBD; j++) //loop to over the lines of Fsection_interm
		{
			for (int k = 0; k < NEBD; k++) //loop to over the columns of Fsection_interm
			{
				Fsection_Tot(i * NEBD + j, i * NEBD + k) = Fsection_interm(j, k);
			}
		}
	}

	//compute the matrix multiplication F_element_nonLocal=B_q*inv(H)*Fsection_Tot*B_Q;
	Felement = B_q * H_inv * Fsection_Tot * B_Q;

	//opserr << "This matrix B_q:" << B_q << endln;
	//opserr << "This matrix H:" << H << endln;
	//opserr << "This matrix H_inv:" << H_inv << endln;
	//opserr << "This matrix H_inv*Fsection_Tot:" << H_inv * Fsection_Tot << endln;
	//opserr << "This matrix Fsection_Tot:" << Fsection_Tot << endln;
	//opserr << "This matrix B_Q:" << B_Q << endln;
	//opserr << "This matrix Felement_nonlocal:" << Felement << endln;
}


////Method to compute e_local[]
//void
//TestNonlocalElement3dDH::computeE_local(int numSections, Vector eNonLocalSubdivide[], Matrix H, Matrix& e_local_tot)
//{
//	e_local_tot.Zero(); 
//	Vector eNonLocal_SectionI_temp = Vector(NEBD);
//	Vector eNonLocal_MatrixFormALLSections = Vector(NEBD * numSections);
//	Vector eLocal_MatrixFormALLSections = Vector(NEBD * numSections);
//
//	// Fill the vector with all the nonlocal section deformations
//	for (int i = 0; i < numSections; i++)
//	{	
//		eNonLocal_SectionI_temp = eNonLocalSubdivide[i];
//		//opserr << "This is eNonLocal_SectionI_temp:" << eNonLocal_SectionI_temp << endln;
//
//		for (int j = 0; j < NEBD; j++)
//		{
//			eNonLocal_MatrixFormALLSections(i * NEBD + j) = eNonLocal_SectionI_temp(j);
//			//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln;
//		}
//	}
//
//	//opserr << "This is eNonLocal_MatrixFormALLSections:" << eNonLocal_MatrixFormALLSections << endln; 
//
//	// Compute the vector with all the local section deformations
//	eLocal_MatrixFormALLSections = H * eNonLocal_MatrixFormALLSections;
//
//	//opserr << "This is eLocal_MatrixFormALLSections:" << eLocal_MatrixFormALLSections << endln; 
//
//	//Fill the matrix e_local_tot
//	for (int i = 0; i < numSections; i++)
//	{
//		for (int j = 0; j < NEBD; j++)
//		{
//			e_local_tot(j, i) = eLocal_MatrixFormALLSections(i * NEBD + j);
//		}
//	}
//
//	/*opserr << "This is e_local_tot:" << e_local_tot << endln;
//	double test = 0.;*/
//}
