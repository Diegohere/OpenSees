// 
// Created by Diego Heredia on 10.12.2021
//

#include "LocalBucklingWebPlate.h"

#include <cmath>
#include <iostream>
#include <complex>

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
	/*chi1cConverged(0.),
	chi1cTrial(0.),*/
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

	// Set the value of b_chi1c
	initializeBChi1c();
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
	/*chi1cConverged(0.),
	chi1cTrial(0.),*/
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

	// Set the value of b_chi1c
	initializeBChi1c();
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
	Vector strain_previous = Vector(N_DIMS);
	Vector strain_nPlus1 = Vector(N_DIMS);
	double triaxiality = 0.;
	Vector xiTrial = Vector(N_DIMS);
	double phiVM = 0., phiELL = 0.;
	double yieldStress = 0.;
	double f2bar = 0.;
	double chi1c = 0.;

	// Update the total strain vector
	deltaStrain_todo.Zero();
	deltaStrain_todo = strainTrial - strainConverged;
	deltaStrain_trial = deltaStrain_todo;
	strain_previous = strainConverged;

	// Loop for time integration
	while (!convergedMatLaw && iterationNumber_timeIntegration < MAXIMUM_ITERATIONS_TIMEINTEGRATION) {

		// Update the total strain vector for time integration iteration
		strain_nPlus1 = strain_previous + deltaStrain_trial;

		// Elastic trial step
		alpha.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i)
			alpha = alpha + alphaKConverged[i];
		stressTrial = elasticMatrix * (strain_nPlus1 - strainPlasticConverged - strainPostBucklingConverged);
		xiTrial = stressTrial - alpha;
		triaxiality = 1. / 3. * xiTrial[0];
		etaTrial = qMatT * xiTrial;
		yieldStress = calculateYieldStress();

		// Select which return mapping to do
		if (triaxiality >= 0) { // if in tension
			f2bar= 2. / 3. * pow(etaTrial(0), 2) + 2. * pow(etaTrial(1), 2) + 2. * pow(etaTrial(2), 2);
			phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStress, 2);
			convergedMatLaw = true;

			// Check if trial state is elastic or if need return map approach
			if (phiVM > RETURN_MAP_TOL) { //loading is plastic -->return mapping
				plasticLoading = 1; //hardening stage
				retVal = returnMappingHardening(strain_nPlus1, alpha, etaTrial);
			}
			else { //loading is elastic
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic();
			}
		}
		else { // if in compression
			// Compute value of phiELL
			chi1c = calculateChi1c();
			phiELL = 3. / 2. * (2. / 3. * pow(xiTrial(0), 2) + 2. * pow(xiTrial(1), 2) + 2. * pow(xiTrial(2), 2)) + chi1c * pow(stressTrial(0), 2) - pow(yieldStress, 2);

			// Check if trial state is elastic or if need return map approach
			if (phiELL <= RETURN_MAP_TOL) { //loading is elastic
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic();

				// Check if buckling before initial yield (this is elastic buckling)
				if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaC0Stress, 2) <= RETURN_MAP_TOL) { // not yet at capping point
					deltaStrain_todo -= deltaStrain_trial;

					// Check if the full strain increment has been done
					if (deltaStrain_todo.Norm() <= RETURN_MAP_TOL) { // full strain increment has been done
						convergedMatLaw = true;
					}
					else { // converged but there is more strain increment to do
						strain_previous += deltaStrain_trial;
						deltaStrain_trial = deltaStrain_todo;
					}

					// Check if capping point is reached
					if (abs(3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaC0Stress, 2)) <= RETURN_MAP_TOL) { // capping point is reached
						chi1c = RETURN_MAP_TOL;
					}
				}
				else { // the capping point has been passed
					deltaStrain_trial /= 2.;
				}
			}
			else { // if not elastic
				
				// Check if hardening or softening response
				if (chi1c == 0) { // Do a step in the hardening direction
					plasticLoading = 1;
					retVal = returnMappingHardening(strain_nPlus1, alpha, etaTrial);
				}
				else { // if chi1c !=0 --> softening stage
					postBucklingLoading = 1;
					retVal = returnMappingSoftening(strain_nPlus1, stressTrial, alpha);
				}
			}
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
	double phiVM = 0.;
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
		phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStress, 2);
		consistParam_plastic = consistParam_plastic - phiVM / (consistDenom + RETURN_MAP_TOL);
		strainPEqTrial = strainPEqConverged + sqrt(2. / 3.) * consistParam_plastic * fBar;

		// Check convergence
		if (fabs(phiVM) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Update the variables
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

	// Calculate the consistent tangent modulus for hardening stage
	calculateConsistentTangentModulusHardening(consistParam_plastic, fBar, stressRelative);

	// Warn the user if the algorithm did not convergein the return mapping for hardening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiVM) > RETURN_MAP_TOL) {
		opserr << "LocalBucklingWebPlate::returnMappingHardening return mapping hardening stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strainTrial[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strainTrial[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strainTrial[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiVM << " > " << RETURN_MAP_TOL << endln;
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::returnMappingSoftening(Vector strain_nPlus1, Vector stressTrial, Vector alpha) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	Vector gammaDiag = Vector(N_DIMS);
	double consistParam_postBuckling = 0.;
	double chi1c = 0.;
	Vector xi_nPlus = Vector(N_DIMS);

	chi1c = calculateChi1c();

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		gammaDiag(0) = 1. / (1. / elasticModulus + consistParam_postBuckling * (2. + 2 * chi1c));
		gammaDiag(1) = 1. / (1. / shearModulus + consistParam_postBuckling * 6.);
		gammaDiag(2) = gammaDiag(1);

	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateConsistentTangentModulusElastic() {
	stiffnessTrial = elasticMatrix;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateConsistentTangentModulusHardening(double consistParam_plastic, double fBar,
	const Vector& stressRelative) {
	// Initialize the variables
	Matrix iD3 = Matrix(N_DIMS, N_DIMS);
	Matrix complianceMatrix = Matrix(N_DIMS, N_DIMS);
	double yieldStress = 0.;
	double isotropicModulus = 0.;
	Vector nHat = Vector(N_DIMS);
	double eK = 0.;
	double beta = 0.;
	Vector hPrime = Vector(N_DIMS);
	Matrix hOutN = Matrix(N_DIMS, N_DIMS);
	Matrix aMat = Matrix(N_DIMS, N_DIMS);
	Vector nTilde = Vector(N_DIMS);
	Matrix xiTilde = Matrix(N_DIMS, N_DIMS);
	Matrix xiTildeA = Matrix(N_DIMS, N_DIMS);
	double theta_2 = 0.;
	Vector hTilde = Vector(N_DIMS);
	double theta_1 = 0.;
	Matrix nOutN = Matrix(N_DIMS, N_DIMS);
	
	iD3.Zero(); // 3x3 indentity matrix
	iD3(0, 0) = iD3(1, 1) = iD3(2, 2) = 1.;
	complianceMatrix = calculateComplianceMatrix();

	// Isotropic hardening parameters
	yieldStress = calculateYieldStress();
	isotropicModulus = calculateIsotropicModulus();

	// Kinematic hardening related parameters
	nHat = stressRelative / fBar;
	for (unsigned int i = 0; i < nBackstresses; ++i)
		beta += cK[i] / gammaK[i] * (1. - eK);
	beta = 1. + beta / yieldStress;
	hPrime = -(beta - 1.) * isotropicModulus * stressRelative / yieldStress;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		hPrime += cK[i] * eK / yieldStress * stressRelative - gammaK[i] * eK * alphaKConverged[i];
	}
	hPrime *= sqrt(2. / 3.);
	hOutN = hPrime % nHat;
	aMat = matinv3(beta * iD3 + consistParam_plastic * hOutN * PMat);

	nTilde = nHat - consistParam_plastic * aMat * hPrime;
	xiTilde = matinv3(complianceMatrix + consistParam_plastic * PMat * aMat);
	xiTildeA = aMat * xiTilde;

	theta_2 = 1. - 2. / 3. * isotropicModulus * consistParam_plastic;
	hTilde = hPrime + xiTilde * (PMat * nTilde);
	theta_1 = 2. / 3. * isotropicModulus + theta_2 * dotprod3(nHat, PMat * (aMat * hTilde));
	nOutN = nTilde % nHat;
	stiffnessTrial.Zero();
	stiffnessTrial = xiTilde - theta_2 / theta_1 * xiTilde * PMat * nOutN * PMat * xiTildeA;

	// Take the symmetric approximation
	stiffnessTrial.addMatrixTranspose(0.5, stiffnessTrial, 0.5);

	return;
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
	/*chi1cConverged = 0.;
	chi1cTrial = 0.;*/
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

Matrix LocalBucklingWebPlate::calculateComplianceMatrix() {
	double eDenom = 1.0 / elasticModulus;
	Matrix complianceMatrix = Matrix(N_DIMS, N_DIMS);
	complianceMatrix.Zero();
	complianceMatrix(0, 0) = 1.0 * eDenom;
	complianceMatrix(1, 1) = complianceMatrix(2, 2) = 2. * (1. + poissonRatio) * eDenom;
	return complianceMatrix;
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

double LocalBucklingWebPlate::calculateChi1c() {
	double chi1c = 0.;
	double sigmaSurSigmaY = 0.;

	sigmaSurSigmaY = calculateSigmaSurSigmaY();

	chi1c = b_chi1c * pow((1 - sigmaSurSigmaY), 2);

	return chi1c;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateSigmaSurSigmaY() {
	double sigmaSurSigmaY = 0.;
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;
	double p4eq = 0., q4eq = 0.;
	double Delta0eq = 0., double Delta1eq = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2 * tan(alphaAngle));

	AHat = (2 * pow(tPlateThickness, 2) * (1 - strainPBEqTrial)) / (sin(2 * alphaAngle) * sqrt(1 - pow((1 - strainPBEqTrial), 2)));
	BHat = (pow(tPlateThickness, 2) * (bPlateWidth - 2 * cPlate)) / (bPlateWidth * sqrt(1 - pow((1 - strainPBEqTrial), 2)));
	CHat = (tPlateThickness * sqrt(pow(cPlate, 2) + pow((bPlateWidth / 2 * sqrt(1 - pow((1 - strainPBEqTrial), 2))), 2)) - bPlateWidth * tPlateThickness);

	DHat = -pow((BHat), 2);
	EHat = 2 * BHat * CHat;
	FHat = -pow((AHat), 2) + 2 * pow((BHat), 2) - pow(CHat, 2);
	GHat = -2 * BHat * CHat;
	HHat = pow(AHat, 2) - pow(BHat, 2);

	p4eq = (8 * DHat * FHat - 3 * pow(EHat, 2)) / (8 * pow(DHat, 2));
	q4eq = (pow(EHat, 3) - 4 * DHat * EHat * FHat + 8 * pow(DHat, 2) * GHat) / (8 * pow(DHat, 3));

	Delta0eq = pow(FHat, 2) - 3 * EHat * GHat + 12 * DHat * HHat;
	Delta1eq = 2 * pow(FHat, 3) - 9 * EHat * FHat * GHat + 27 * pow(EHat, 2) * HHat + 27 * DHat * pow(GHat, 2) - 72 * DHat * FHat * HHat;

	std::complex<double> Delta0eqComplex(Delta0eq, 0);
	std::complex<double> Delta1eqComplex(Delta1eq, 0);
	std::complex<double> fourComplex(4, 0);
	std::complex<double> twoComplex(2, 0);
	std::complex<double> Q4eq = pow(((Delta1eqComplex + sqrt(pow(Delta1eqComplex, 2) - fourComplex * pow(Delta0eqComplex, 3))) / twoComplex), 1.0 / 3.0);

	std::complex<double> oneDivTwoComplex(0.5, 0);
	std::complex<double> twoDivThreeComplex(2.0 / 3.0, 0);
	std::complex<double> oneComplex(1, 0);
	std::complex<double> threeComplex(3, 0);
	std::complex<double> p4eqComplex(p4eq, 0);
	std::complex<double> DHatComplex(DHat, 0);
	std::complex<double> q4eqComplex(q4eq, 0);
	std::complex<double> S4eq = oneDivTwoComplex * sqrt(-twoDivThreeComplex * p4eqComplex + oneComplex / (threeComplex * DHatComplex) * (Q4eq + Delta0eqComplex / Q4eq));

	std::complex<double> EHatComplex(EHat, 0);
	std::complex<double> sol4eq3 = -EHatComplex / (fourComplex * DHatComplex) + S4eq + oneDivTwoComplex * sqrt(-fourComplex * pow(S4eq, 2) - twoComplex * p4eqComplex - q4eqComplex / S4eq);

	sigmaSurSigmaY = real(sol4eq3);

	return sigmaSurSigmaY;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::initializeBChi1c() {
	b_chi1c = (pow(sigmaC0Stress, 2)) / ((pow(sigmaC0Stress, 2) - pow(sigmaDMStress, 2)) * pow(alpha_chi1c, 2));
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param A a 3x3 invertible matrix
* @return the inverse of A
*
*/
Matrix LocalBucklingWebPlate::matinv3(const Matrix& A) {
	double detInv;
	Matrix B = Matrix(3, 3);

	// Calculate the determinant
	detInv = 1. /
		(A(0, 0) * A(1, 1) * A(2, 2) - A(0, 0) * A(1, 2) * A(2, 1)
			- A(0, 1) * A(1, 0) * A(2, 2) + A(0, 1) * A(1, 2) * A(2, 0)
			+ A(0, 2) * A(1, 0) * A(2, 1) - A(0, 2) * A(1, 1) * A(2, 0));

	// Calculate the inverse
	B(0, 0) = +detInv * (A(1, 1) * A(2, 2) - A(1, 2) * A(2, 1));
	B(1, 0) = -detInv * (A(1, 0) * A(2, 2) - A(1, 2) * A(2, 0));
	B(2, 0) = +detInv * (A(1, 0) * A(2, 1) - A(1, 1) * A(2, 0));
	B(0, 1) = -detInv * (A(0, 1) * A(2, 2) - A(0, 2) * A(2, 1));
	B(1, 1) = +detInv * (A(0, 0) * A(2, 2) - A(0, 2) * A(2, 0));
	B(2, 1) = -detInv * (A(0, 0) * A(2, 1) - A(0, 1) * A(2, 0));
	B(0, 2) = +detInv * (A(0, 1) * A(1, 2) - A(0, 2) * A(1, 1));
	B(1, 2) = -detInv * (A(0, 0) * A(1, 2) - A(0, 2) * A(1, 0));
	B(2, 2) = +detInv * (A(0, 0) * A(1, 1) - A(0, 1) * A(1, 0));

	return B;
}

/* ----------------------------------------------------------------------------------------------------------------- */
