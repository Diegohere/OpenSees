// 
// Created by Diego Heredia on 10.12.2021
//

#include "LocalBucklingWebPlate.h"

#include <cmath>
#include <iostream>

#include <elementAPI.h>
#include <Channel.h>
#include <Information.h>
#include <Parameter.h>

#include <elementAPI.h>
#include <OPS_Globals.h>

static int numLocalBucklingWebPlate = 0;


void* OPS_LocalBucklingWebPlate(void) {
	if (numLocalBucklingWebPlate == 0) {
		opserr << "Using the LocalBucklingWebPlate material" << endln;
		numLocalBucklingWebPlate++;
	}
	NDMaterial* theMaterial = 0;

	// Parameters for parsing
	const unsigned int N_TAGS = 1;
	const unsigned int N_HARDENING_PROPERTIES = 7;
	const unsigned int N_SOFTENING_PROPERTIES = 3;
	const unsigned int N_PARAM_PER_BACK = 2;
	const unsigned int MAX_BACKSTRESSES = 8;
	const unsigned int BACKSTRESS_SPACE = MAX_BACKSTRESSES * N_PARAM_PER_BACK;

	std::string inputInstructions = "Invalid args, want:\n"
		"nDMaterial LocalBucklingWebPlate "
		"tag? E? nu? fy? QInf? b? DInf? a? "
		"N? C1? gamma1? <C2? gamma2? C3? gamma3? ... C8? gamma8?>"
		"bPlate? tPlate? sigmaC0? \n";

	// Containers for the inputs
	int nInputsToRead;
	int nBackstresses[1];  // for N
	int materialTag[N_TAGS];  // for the tag
	double hardeningProps[N_HARDENING_PROPERTIES];  // holds E, nu, fy, QInf, b, DInf, a
	double backstressProps[BACKSTRESS_SPACE];  // holds C's and gamma's
	double softeningProps[N_SOFTENING_PROPERTIES];  // holds bPlate, tPlate, sigmaC0
	std::vector<double> cK;
	std::vector<double> gammaK;

	// Get the material tag
	nInputsToRead = N_TAGS;
	if (OPS_GetIntInput(&nInputsToRead, materialTag) != 0) {
		opserr << "WARNING invalid nDMaterial LocalBucklingWebPlate tag" << endln;
		return 0;
	}

	// Get hardening parameters E, nu, fy, qInf, b, DInf, a
	nInputsToRead = N_HARDENING_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, hardeningProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}

	// Get the number of backstresses
	nInputsToRead = 1;
	if (OPS_GetIntInput(&nInputsToRead, nBackstresses) != 0) {
		opserr << "WARNING N must be an integer" <<
			inputInstructions.c_str() << endln;
		return 0;
	}
	if (nBackstresses[0] > MAX_BACKSTRESSES) {
		opserr << "WARNING: Too many backstresses defined, maximum is: " <<
			MAX_BACKSTRESSES << endln <<
			inputInstructions.c_str() << endln;
		return 0;
	}

	// Get the backstress parameters
	nInputsToRead = 2 * nBackstresses[0];
	if (OPS_GetDoubleInput(&nInputsToRead, backstressProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}
	// cK's alternate with gammaK's
	for (unsigned int i = 0; i < nBackstresses[0]; ++i) {
		cK.push_back(backstressProps[2 * i]);
		gammaK.push_back(backstressProps[1 + 2 * i]);
	}

	// Read in the softening stage paramters bPlate, tPlate, sigmaC0
	nInputsToRead = N_SOFTENING_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, softeningProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}

	// Allocate the material
	theMaterial = new LocalBucklingWebPlate(materialTag[0],
		hardeningProps[0], hardeningProps[1], hardeningProps[2],
		hardeningProps[3], hardeningProps[4], hardeningProps[5], hardeningProps[6],
		cK, gammaK,
		softeningProps[0], softeningProps[1], softeningProps[2]);

	return theMaterial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

LocalBucklingWebPlate::LocalBucklingWebPlate(int tag, double E, double poissonRatio,
	double sy0, double qInf, double b, double dInfm, double a,
	std::vector<double> cK, std::vector<double> gammaK,
	double bPlate, double tPlate, double sigmaC0)
	: NDMaterial(tag, ND_TAG_LocalBucklingWebPlate),
	elasticModulus(E),
	poissonRatio(poissonRatio),
	initialYield(sy0),
	qInf(qInf),
	bIso(b),
	dInf(dInf),
	aIso(a),
	cK(cK),
	gammaK(gammaK),
	bPlateWidth(bPlate),
	tPlateThickness(tPlate),
	sigmaC0Stress(sigmaC0),
	shearModulus(E / (2. * (1. + poissonRatio))),
	bulkModulus(E / (3. * (1. - 2. * poissonRatio))),
	strainConverged(N_DIMS),
	strainTrial(N_DIMS),
	strainPlasticConverged(N_DIMS),
	strainPlasticTrial(N_DIMS),
	strainPostBucklingConverged(N_DIMS),
	strainPostBucklingTrial(N_DIMS),
	strainPEqConverged(0.),
	strainPEqTrial(0.),
	strainPBEqConverged(0.),
	strainPBEqTrial(0.),
	stressConverged(N_DIMS),
	stressTrial(N_DIMS),
	chi1c(0.),
	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticMatrix(Matrix(N_DIMS, N_DIMS)),
	stiffnessInitial(Matrix(N_DIMS, N_DIMS)),
	stiffnessConverged(Matrix(N_DIMS, N_DIMS)),
	stiffnessTrial(Matrix(N_DIMS, N_DIMS)),
	PMat(Matrix(N_DIMS, N_DIMS)),
	pVect(Vector(N_DIMS)),
	qMat(Matrix(N_DIMS, N_DIMS)),
	qMatT(Matrix(N_DIMS, N_DIMS)),
	lambdaC(N_DIMS),
	lambdaP(N_DIMS),
	lambdapp(N_DIMS)
{
	// Set the number of backstresses
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaKTrial.push_back(Vector(N_DIMS));
		alphaKConverged.push_back(Vector(N_DIMS));
	}

	// Zero all the vectors and matrices
	revertToStart();

	// Set the Eigendecomposition matrices
	initializeEigendecompositions();

	// Set elastic parameters and elastic stiffness matrix
	calculateElasticStiffness();
	stiffnessInitial = elasticMatrix;
	stiffnessTrial = elasticMatrix;
	stiffnessConverged = elasticMatrix;
};

/* ----------------------------------------------------------------------------------------------------------------- */

LocalBucklingWebPlate::LocalBucklingWebPlate()
	: NDMaterial(0, ND_TAG_LocalBucklingWebPlate),
	elasticModulus(0.),
	poissonRatio(0.),
	initialYield(0.),
	qInf(0.),
	bIso(0.),
	dInf(0.),
	aIso(0.),
	cK(0.),
	gammaK(0.),
	bPlateWidth(0.),
	tPlateThickness(0.),
	sigmaC0Stress(0.),
	shearModulus(0. / (2. * (1. + poissonRatio))),
	bulkModulus(0. / (3. * (1. - 2. * poissonRatio))),
	strainConverged(N_DIMS),
	strainTrial(N_DIMS),
	strainPlasticConverged(N_DIMS),
	strainPlasticTrial(N_DIMS),
	strainPostBucklingConverged(N_DIMS),
	strainPostBucklingTrial(N_DIMS),
	strainPEqConverged(0.),
	strainPEqTrial(0.),
	strainPBEqConverged(0.),
	strainPBEqTrial(0.),
	stressConverged(N_DIMS),
	stressTrial(N_DIMS),
	chi1c(0.),
	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticMatrix(Matrix(N_DIMS, N_DIMS)),
	stiffnessInitial(Matrix(N_DIMS, N_DIMS)),
	stiffnessConverged(Matrix(N_DIMS, N_DIMS)),
	stiffnessTrial(Matrix(N_DIMS, N_DIMS)),
	PMat(Matrix(N_DIMS, N_DIMS)),
	pVect(Vector(N_DIMS)),
	qMat(Matrix(N_DIMS, N_DIMS)),
	qMatT(Matrix(N_DIMS, N_DIMS)),
	lambdaC(N_DIMS),
	lambdaP(N_DIMS),
	lambdapp(N_DIMS)
{
	// Set the number of backstresses
  //Not tried for UVC parallel processing - probably wont work with parallel processing
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaKTrial.push_back(Vector(N_DIMS));
		alphaKConverged.push_back(Vector(N_DIMS));
	}

	// Zero all the vectors and matrices
	revertToStart();

	// Set the Eigendecomposition matrices
	initializeEigendecompositions();

	// Set elastic stiffness matrix
	calculateElasticStiffness();
	stiffnessInitial = elasticMatrix;
	stiffnessTrial = elasticMatrix;
	stiffnessConverged = elasticMatrix;
}

/* ----------------------------------------------------------------------------------------------------------------- */

LocalBucklingWebPlate::~LocalBucklingWebPlate() {

}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::timeIntegration() {
	// Initialize the variables for loading stage selection
	elasticLoading = 0;
	plasticLoading = 0;
	postBucklingLoading = 0;

	// Initialize all the variables
	int retVal = 0;
	bool convergedMatLaw = false;
	unsigned int iterationNumber_timeIntegration = 0;
	Vector alpha = Vector(N_DIMS);
	Vector etaTrial = Vector(N_DIMS);
	Vector deltaStrain_todo = Vector(N_DIMS);
	Vector deltaStrain_trial = Vector(N_DIMS);
	Vector strain_nPlus1 = Vector(N_DIMS);
	double triaxiality = 0.;
	Vector xi_trial = Vector(N_DIMS);
	double phiVM = 0., phiELL = 0.;
	double yieldStress = 0.;
	double f2bar = 0.;

	// Update the total strain vector
	deltaStrain_todo.Zero();
	deltaStrain_todo = strainTrial - strainConverged;
	deltaStrain_trial = deltaStrain_todo;

	// Loop for time integration
	while (!convergedMatLaw && iterationNumber_timeIntegration < MAXIMUM_ITERATIONS_TIMEINTEGRATION) {

		// Update the total strain vector for time integration iteration
		strain_nPlus1 = strainConverged + deltaStrain_trial;

		// Elastic trial step
		alpha.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i)
			alpha = alpha + alphaKConverged[i];
		stressTrial = elasticMatrix * (strain_nPlus1 - strainPlasticConverged - strainPostBucklingConverged);
		xi_trial = stressTrial - alpha;
		triaxiality = 1. / 3. * xi_trial[0];
		etaTrial = qMatT * xi_trial;

		// Select which return mapping to do
		if (triaxiality >= 0) { // if in tension
			f2bar= 2. / 3. * pow(etaTrial(0), 2) + 2. * pow(etaTrial(1), 2) + 2. * pow(etaTrial(2), 2);
			yieldStress = calculateYieldStress();
			phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStress, 2);
			convergedMatLaw = true;

			// Check if trial state is elastic or if need return map approach
			if (phiVM > RETURN_MAP_TOL) { //loading is plastic -->return mapping
				retVal = returnMappingHardening(strain_nPlus1, alpha, etaTrial);
			}
			else {
				elasticLoading = 1;
			}
			// TODO: STOPPED HERE 13.12.2021
		}

	}

}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::returnMappingHardening(Vector strain_nPlus1, Vector alpha, Vector etaTrial) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStress = 0.;
	double isotropicModulus = 0.;
	double beta = 0.;
	Vector alphaTilde = Vector(N_DIMS);
	double eK = 0.;
	Vector gammaDiag = Vector(N_DIMS);
	double consistParam_plastic = 0.;
	Vector etaTilde = Vector(N_DIMS);
	Vector eta = Vector(N_DIMS);
	double f2bar = 0.;
	double fBar = 0.;
	double betaPrime = 0.;
	Vector alphaTildePrime = Vector(N_DIMS);
	Vector gammaDiagPrime = Vector(N_DIMS);
	double consistDenom = 0.;
	double yieldFunction = 0.;
	Vector stressRelative = Vector(N_DIMS);

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		// Isotropic hardening parameters
		yieldStress = calculateYieldStress();
		isotropicModulus = calculateIsotropicModulus();
		// Kinematic hardening parameters
		beta = 0.;
		alphaTilde.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			beta += cK[i] / gammaK[i] * (1. - eK);
			alphaTilde += alphaKConverged[i] * eK;
		}
		alphaTilde = alpha - alphaTilde;
		beta = 1. + beta / yieldStress;

		// Update the relative stress and eta
		gammaDiag(0) = 1. / (beta + consistParam_plastic * 2. / 3. * elasticModulus);
		gammaDiag(1) = 1. / (beta + consistParam_plastic * 2. * shearModulus);
		gammaDiag(2) = gammaDiag(1);

		etaTilde = etaTrial + qMatT * alphaTilde;
		eta = vecMult3(etaTilde, gammaDiag);
		f2bar = 2. / 3. * pow(etaTrial(0), 2) + 2. * pow(etaTrial(1), 2) + 2. * pow(etaTrial(2), 2);
		fBar = sqrt(f2bar);

		// Calculate Newton denominator
		betaPrime = 0.;
		alphaTildePrime.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			betaPrime = betaPrime - cK[i] * isotropicModulus / (gammaK[i] * pow(yieldStress, 2)) * (1. - eK)
				+ cK[i] * eK / yieldStress;
			alphaTildePrime = alphaTildePrime + gammaK[i] * eK * alphaKConverged[i];
		}
		betaPrime = betaPrime * sqrt(2. / 3.) * fBar;
		alphaTildePrime = alphaTildePrime * sqrt(2. / 3.) * fBar;
		for (unsigned int i = 0; i < N_DIMS; ++i)
			gammaDiagPrime(i) = -pow(gammaDiag(i), 2) * (betaPrime + lambdaP(i) * lambdaC(i));

		consistDenom = dotprod3(vecMult3(lambdaP, eta),
			vecMult3(gammaDiagPrime, etaTilde) + vecMult3(gammaDiag, qMatT * alphaTildePrime))
			- sqrt(2. / 3.) * 2. / 3. * yieldStress * isotropicModulus * fBar;

		// Newton step
		yieldFunction = 1. / 2. * f2bar - 1. / 3. * pow(yieldStress, 2);
		consistParam_plastic = consistParam_plastic - yieldFunction / (consistDenom + RETURN_MAP_TOL);
		strainPEqTrial = strainPEqConverged + sqrt(2. / 3.) * consistParam_plastic * fBar;

		// Check convergence
		if (fabs(yieldFunction) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Update the variables
	plasticLoading = 1; //hardening stage
	etaTilde = etaTrial + qMatT * alphaTilde;
	eta = vecMult3(gammaDiag, etaTilde);
	stressRelative = qMat * eta;
	yieldStress = calculateYieldStress();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		alphaKTrial[i] = alphaKConverged[i] * eK + stressRelative / yieldStress * cK[i] / gammaK[i] * (1. - eK);
	}
	strainPlasticTrial = strainPlasticConverged + consistParam_plastic * PMat * stressRelative;
	stressTrial = elasticMatrix * (strainTrial - strainPlasticTrial - strainPostBucklingConverged);

	// Update the stiffness
	calculateStiffness(consistParam_plastic, fBar, stressRelative);
	// TODO: STOPPED HERE 13.12.2021
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::revertToStart() {
	strainConverged.Zero();
	strainPlasticConverged.Zero();
	strainPEqConverged = 0.;
	strainPostBucklingConverged.Zero();
	strainPEqConverged = 0.;
	strainPBEqConverged = 0.;
	chi1c = 0.;
	stressConverged.Zero();
	plasticLoading = false;
	stiffnessConverged.Zero();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaKConverged[i].Zero();
	}
	revertToLastCommit();
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateElasticStiffness() {
	double eDenom = elasticModulus / (2. +2. * poissonRatio);
	elasticMatrix.Zero();
	elasticMatrix(0, 0) = (2. + 2. * poissonRatio) * eDenom;
	elasticMatrix(1, 1) = 1. * eDenom;
	elasticMatrix(2, 2) = 1. * eDenom;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::initializeEigendecompositions() {

	// Orthogonal matrix (eigenvectors)
	double qDenom = sqrt(2.);
	qMat.Zero();
	qMat(0, 0) = 1. / qDenom;  qMat(0, 1) = -1. / qDenom; qMat(0, 2) = 0;
	qMat(1, 0) = 1. / qDenom;  qMat(1, 1) = 1. / qDenom; qMat(1, 2) = 0;
	qMat(2, 0) = 0;  qMat(2, 1) = 0; qMat(2, 2) = 1.;
	// Transpose
	qMatT.Zero();
	qMatT.addMatrixTranspose(0., qMat, 1.0);

	// Projection matrix
	PMat.Zero();
	PMat(0, 0) = 2. / 3.;
	PMat(1, 1) = 2.;
	PMat(2, 2) = 2.;
	lambdaP.Zero();
	lambdaP(0) = 2. / 3.;
	lambdaP(1) = 2.;
	lambdaP(2) = 2.;

	// Projection vector
	pVect.Zero();
	pVect(0) = 1.;
	lambdapp.Zero();
	lambdaP(0) = 1.;

	// Elastic matrix, diagonal
	lambdaC.Zero();
	lambdaC(0) = elasticModulus;
	lambdaC(1) = shearModulus;
	lambdaC(2) = shearModulus;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v1 length 3 vector
* @param v2 length 3 vector
* @return the dot product of the two vectors
*
*/
double LocalBucklingWebPlate::dotprod3(const Vector& v1, const Vector& v2) {
	double res = 0.;
	for (unsigned int i = 0; i < N_DIMS; ++i)
		res += v1(i) * v2(i);
	return res;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v1 length 3 vector
* @param v2 length 3 vector
* @return vector containing the component-wise multiplication of the two vectors
*
*/
Vector LocalBucklingWebPlate::vecMult3(const Vector& v1, const Vector& v2) {
	Vector res = Vector(N_DIMS);
	for (unsigned int i = 0; i < N_DIMS; ++i)
		res(i) = v1(i) * v2(i);
	return res;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateYieldStress() {
	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * strainPEqTrial));
	sigmaY2 = dInf * (1. - exp(-aIso * strainPEqTrial));
	return initialYield + sigmaY1 - sigmaY2;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateIsotropicModulus() {
	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * strainPEqTrial));
	sigmaY2 = dInf * (1. - exp(-aIso * strainPEqTrial));
	return bIso * (qInf - sigmaY1) - aIso * (dInf - sigmaY2);
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param i the i'th backstress
* @return computed eK factor
*
*/
double LocalBucklingWebPlate::calculateEk(unsigned int i) {
	return exp(-gammaK[i] * (strainPEqTrial - strainPEqConverged));
}

/* ----------------------------------------------------------------------------------------------------------------- */
