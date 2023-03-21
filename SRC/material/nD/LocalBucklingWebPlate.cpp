// 
// Created by Diego Heredia on 10.12.2021
// Version 04.03.2023
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
	const unsigned int REQUIRED_NUMBACKSTRESSES = 2;
	const unsigned int BACKSTRESS_SPACE = REQUIRED_NUMBACKSTRESSES * N_PARAM_PER_BACK;
	const unsigned int N_REGULARIZATION_PARAMETERS = 1;

	std::string inputInstructions = "Invalid args, want:\n"
		"nDMaterial LocalBucklingWebPlate "
		"tag? E? nu? fy? QInf? b? DInf? a? "
		"N? C1? gamma1? <C2? gamma2? C3? gamma3? ... C8? gamma8?>"
		"bPlate? tPlate? sigmaC0?"
		"alphaReg?";

	// Containers for the inputs
	int nInputsToRead;
	int nBackstresses[1];  // for N
	int materialTag[N_TAGS];  // for the tag
	double hardeningProps[N_HARDENING_PROPERTIES];  // holds E, nu, fy, QInf, b, DInf, a
	double backstressProps[BACKSTRESS_SPACE];  // holds C's and gamma's
	double softeningProps[N_SOFTENING_PROPERTIES];  // holds bPlate, tPlate, sigmaC0
	double regularizationgProps[N_REGULARIZATION_PARAMETERS];  // holds alphaReg
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
	if (nBackstresses[0] != REQUIRED_NUMBACKSTRESSES) {
		opserr << "WARNING: Number of backstresses should be: " <<
			REQUIRED_NUMBACKSTRESSES << endln <<
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

	// Get regularization parameters alphaReg
	nInputsToRead = N_REGULARIZATION_PARAMETERS;
	if (OPS_GetDoubleInput(&nInputsToRead, regularizationgProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}


	// Allocate the material
	theMaterial = new LocalBucklingWebPlate(materialTag[0],
		hardeningProps[0], hardeningProps[1], hardeningProps[2],
		hardeningProps[3], hardeningProps[4], hardeningProps[5], hardeningProps[6],
		cK, gammaK,
		softeningProps[0], softeningProps[1], softeningProps[2],
		regularizationgProps[0]);

	return theMaterial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

LocalBucklingWebPlate::LocalBucklingWebPlate(int tag, double E, double poissonRatio,
	double sy0, double qInf, double b, double dInf, double a,
	std::vector<double> cK, std::vector<double> gammaK,
	double bPlate, double tPlate, double sigmaC0,
	double alphaReg)
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
	alphaRegularization(alphaReg),
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
	sumEjConverged(0.),
	sumEjTrial(0.),
	c1cConverged(0.),
	c1cTrial(0.),
	/*chi1cConverged(0.),
	chi1cTrial(0.),*/
	b_1tConverged(0.),
	sigmaPrBezierConverged(0.),
	sigmaYrBezierConverged(0.),
	epsilonPB11UnloadConverged(0.),
	backstressAfterCompressionConverged(N_DIMS),
	epsilonPB11MinConverged(0.),
	alphaPrBezierConverged(0.),
	alphaYrBezierConverged(0.),
	kPrBezierConverged(0.),
	kYrBezierConverged(0.),
	rAlphaBackstress1Converged(0.),
	rAlphaBackstress2Converged(0.),
	c1cUnloadConverged(0.),
	ErcConverged(0.),
	sigmaCConverged(0.),
	yieldStressPBConverged(0.),
	sigmaYieldAfterCompressionConverged(0.),
	backstress11TotAfterFullPLRecovConverged(0.),
	sigmaYieldTotAfterFullPLRecovConverged(0.),

	b_1tTrial(0.),
	sigmaPrBezierTrial(0.),
	sigmaYrBezierTrial(0.),
	epsilonPB11UnloadTrial(0.),
	backstressAfterCompressionTrial(N_DIMS),
	epsilonPB11MinTrial(0.),
	alphaPrBezierTrial(0.),
	alphaYrBezierTrial(0.),
	kPrBezierTrial(0.),
	kYrBezierTrial(0.),
	rAlphaBackstress1Trial(0.),
	rAlphaBackstress2Trial(0.),
	c1cUnloadTrial(0.),
	sigmaCTrial(0.),
	yieldStressPBTrial(0.),
	sigmaYieldAfterCompressionTrial(0.),
	backstress11TotAfterFullPLRecovTrial(0.),
	sigmaYieldTotAfterFullPLRecovTrial(0.),

	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticMatrix(Matrix(N_DIMS, N_DIMS)),
	stiffnessInitial(Matrix(N_DIMS, N_DIMS)),
	stiffnessConverged(Matrix(N_DIMS, N_DIMS)),
	stiffnessTrial(Matrix(N_DIMS, N_DIMS)),
	PMat(Matrix(N_DIMS, N_DIMS)),
	pVect(Vector(N_DIMS)),
	ppMat(Matrix(N_DIMS, N_DIMS)),
	qMat(Matrix(N_DIMS, N_DIMS)),
	qMatT(Matrix(N_DIMS, N_DIMS)),
	lambdaC(N_DIMS),
	lambdaP(N_DIMS),
	lambdapp(N_DIMS)
{
	// Set the number of backstresses
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKTrial.push_back(Vector(N_DIMS));
		alphaPKConverged.push_back(Vector(N_DIMS));

		alphaPBKTrial.push_back(Vector(N_DIMS));
		alphaPBKConverged.push_back(Vector(N_DIMS));
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

	//// Set the value of sigmaYrO
	//initializeSigmaYrO();

	// Set the value of Erc
	initializeErc();
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
	alphaRegularization(0.),
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
	sumEjConverged(0.),
	sumEjTrial(0.),
	c1cConverged(0.),
	c1cTrial(0.),

	b_1tConverged(0.),
	sigmaPrBezierConverged(0.),
	sigmaYrBezierConverged(0.),
	epsilonPB11UnloadConverged(0.),
	backstressAfterCompressionConverged(N_DIMS),
	epsilonPB11MinConverged(0.),
	alphaPrBezierConverged(0.),
	alphaYrBezierConverged(0.),
	kPrBezierConverged(0.),
	kYrBezierConverged(0.),
	rAlphaBackstress1Converged(0.),
	rAlphaBackstress2Converged(0.),
	c1cUnloadConverged(0.),
	ErcConverged(0.),
	sigmaCConverged(0.),
	yieldStressPBConverged(0.),
	sigmaYieldAfterCompressionConverged(0.),
	backstress11TotAfterFullPLRecovConverged(0.),
	sigmaYieldTotAfterFullPLRecovConverged(0.),

	b_1tTrial(0.),
	sigmaPrBezierTrial(0.),
	sigmaYrBezierTrial(0.),
	epsilonPB11UnloadTrial(0.),
	backstressAfterCompressionTrial(N_DIMS),
	epsilonPB11MinTrial(0.),
	alphaPrBezierTrial(0.),
	alphaYrBezierTrial(0.),
	kPrBezierTrial(0.),
	kYrBezierTrial(0.),
	rAlphaBackstress1Trial(0.),
	rAlphaBackstress2Trial(0.),
	c1cUnloadTrial(0.),
	sigmaCTrial(0.),
	yieldStressPBTrial(0.),
	sigmaYieldAfterCompressionTrial(0.),
	backstress11TotAfterFullPLRecovTrial(0.),
	sigmaYieldTotAfterFullPLRecovTrial(0.),

	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticMatrix(Matrix(N_DIMS, N_DIMS)),
	stiffnessInitial(Matrix(N_DIMS, N_DIMS)),
	stiffnessConverged(Matrix(N_DIMS, N_DIMS)),
	stiffnessTrial(Matrix(N_DIMS, N_DIMS)),
	PMat(Matrix(N_DIMS, N_DIMS)),
	pVect(Vector(N_DIMS)),
	ppMat(Matrix(N_DIMS, N_DIMS)),
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
		alphaPKTrial.push_back(Vector(N_DIMS));
		alphaPKConverged.push_back(Vector(N_DIMS));

		alphaPBKTrial.push_back(Vector(N_DIMS));
		alphaPBKConverged.push_back(Vector(N_DIMS));
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

	//// Set the value of sigmaYrO
	//initializeSigmaYrO();

	// Set the value of Erc
	initializeErc();

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
	PlRecoveryLoading = 0;
	UVCRecoveryLoading = 0;

	// Initialize all the variables
	int retVal = 0;
	bool convergedMatLaw = false;
	unsigned int iterationNumber_timeIntegration = 0;
	Vector alphaTot = Vector(N_DIMS);
	Vector etaTrial = Vector(N_DIMS);
	Vector deltaStrain_todo = Vector(N_DIMS);
	Vector deltaStrain_trial = Vector(N_DIMS);
	Vector deltaStrain_converged4Peak = Vector(N_DIMS);
	Vector deltaStrain_remaining4Peak = Vector(N_DIMS);
	Vector deltaStrain_fullIncrement = Vector(N_DIMS);
	Vector strain_previous = Vector(N_DIMS);
	Vector strain_nPlus1 = Vector(N_DIMS);
	double triaxiality = 0.;
	Vector xiTrial = Vector(N_DIMS);
	double phiTension = 0.;
	double phiCompression = 0.;
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double f2bar = 0.;
	double chi1c = 0.;
	int cappingPoint = 0;
	double etaTangent = 0.;
	double chi1t = 0.;
	int switchPlRecovUVCPoint = 0;
	int switchUVCRecovUVCPoint = 0;

	// Update the total strain vector
	deltaStrain_todo.Zero();
	deltaStrain_todo = strainTrial - strainConverged;
	deltaStrain_fullIncrement = strainTrial - strainConverged;
	deltaStrain_trial = deltaStrain_todo;
	strain_previous = strainConverged;
	deltaStrain_converged4Peak.Zero(); // works for both capping and switch El-Pl Recov stages
	deltaStrain_remaining4Peak = deltaStrain_trial; // works for both capping and switch El-Pl Recov stages

	//// Initialize sumEjTrial
	//sumEjTrial = sumEjConverged;

	// Compute previous stress vector
	Vector stressPrevious = Vector(N_DIMS);
	etaTangent = calculateEtaTangentReduce();
	stressPrevious = (etaTangent * elasticMatrix) * (strainConverged - strainPlasticConverged - strainPostBucklingConverged);

	/*if (strainConverged(0) <= 0.0011 && strainConverged(0) > 0.0010 && strainTrial(0) >= 0.0012 && strainTrial(0) < 0.0013) {
		double testBreak = 0.;
	}*/

	// Loop for time integration
	while (!convergedMatLaw && iterationNumber_timeIntegration < MAXIMUM_ITERATIONS_TIMEINTEGRATION) {
		iterationNumber_timeIntegration++;

		// Update the total strain vector for time integration iteration
		strain_nPlus1 = strain_previous + deltaStrain_trial;

		// Compute reduction factor for elastic stiffness matrix
		etaTangent = calculateEtaTangentReduce();

		// Compute the yield stress
		yieldStressP = calculateYieldStressPlastic();

		// Elastic trial step
		if (cappingPoint == 0 && switchPlRecovUVCPoint == 0 && switchUVCRecovUVCPoint == 0)
		{
			alphaTot.Zero();
			for (unsigned int i = 0; i < nBackstresses; ++i)
				alphaTot = alphaTot + alphaPKConverged[i] + alphaPBKConverged[i];
			stressTrial = (etaTangent * elasticMatrix) * (strain_nPlus1 - strainPlasticConverged - strainPostBucklingConverged);
			yieldStressTot = yieldStressP + yieldStressPBConverged;
		}
		else // We are at the switch between hardening and softening stage OR switch plastic recovery and UVC stage
		{
			alphaTot.Zero();
			for (unsigned int i = 0; i < nBackstresses; ++i)
				/*alphaTot = alphaTot + alphaPKConverged[i] + alphaPBKConverged[i];*/
				alphaTot = alphaTot + alphaPKTrial[i] + alphaPBKTrial[i];
			stressTrial = (etaTangent * elasticMatrix) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);
			yieldStressTot = yieldStressP + yieldStressPBTrial;
		}

		xiTrial = stressTrial - alphaTot;
		/*triaxiality = 1. / 3. * xiTrial[0];*/
		triaxiality = 1. / 3. * stressTrial(0);
		etaTrial = qMatT * xiTrial;

		// Select which return mapping to do
		if (triaxiality >= 0) { // if in tension
			chi1t = calculateChi1t(yieldStressTot, alphaTot(0));
			phiTension = 3. / 2. * (2. / 3. * pow(xiTrial(0), 2) + 2. * pow(xiTrial(1), 2) + 2. * pow(xiTrial(2), 2)) + chi1t * pow(stressTrial(0), 2) - pow(yieldStressTot, 2);

			// Check if trial state is elastic or if need return map approach
			if (phiTension / (2. / 3. * pow(initialYield, 2)) <= RETURN_MAP_TOL) { //loading is elastic
				//convergedMatLaw = true;
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic(etaTangent);

				// Check if we have done the full strain increment
				deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
				deltaStrain_converged4Peak = deltaStrain_trial;
				if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
					convergedMatLaw = true;
				}
				else { // converged but there is more strain increment to do
					revertToBeforeSwitchPlRecovUVC(switchPlRecovUVCPoint);
					deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
				} // end check if full strain increment has been done

			}
			else { //if not elastic
				if (abs(strainPostBucklingTrial(0)) > SMALL_NUMBER && abs(epsilonPB11UnloadTrial) >= abs(epsilonPB11MinTrial))
				{ // Plastic recovery stage
					PlRecoveryLoading = 1;

					retVal = returnMappingPlRecovStage(strain_nPlus1);

					// Check if we have reduced all the epsiPb11
					if (strainPostBucklingTrial(0) <= 0.) // We don't have reduced too much
					{
						deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
						deltaStrain_converged4Peak = deltaStrain_trial;

						// Check if point swich Pl recov stage UVC is reached
						if (abs(strainPostBucklingTrial(0)) <= SMALL_NUMBER)
						{ // We have reduced all the epsiPb11
							switchPlRecovUVCPoint = 1;
						} // end check if point swich Pl recov stage UVC is reached

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER/1000000.) { // full strain increment has been done
						if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							revertToBeforeSwitchPlRecovUVC(switchPlRecovUVCPoint);
							deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
						} // end check if full strain increment has been done

						//Update deltaStrain_todo if we are at switch point
						if (switchPlRecovUVCPoint == 1)
						{
							deltaStrain_trial = deltaStrain_todo + deltaStrain_converged4Peak;
						} // end Update deltaStrain_todo if we are at switch point

					} // end if we don't have reduced epsiPb11 too much
					else
					{ // if we have reduced epsiPb11 too much 
						revertToBeforeSwitchPlRecovUVC(switchPlRecovUVCPoint);
						//deltaStrain_remaining4Peak /= 2.;
						//deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak;
						deltaStrain_remaining4Peak = deltaStrain_trial - deltaStrain_converged4Peak;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak / 2.;

					} // end if we have reduced epsiPb11 too much 

				} // end Plastic recovery stage

				else if (abs(strainPostBucklingTrial(0)) > SMALL_NUMBER && abs(epsilonPB11UnloadTrial) < abs(epsilonPB11MinTrial))
				{//UVC recovery stage
					UVCRecoveryLoading = 1;

					retVal = returnMappingUVCRecovStage(strain_nPlus1, alphaTot);

					// Check if we have reduced all the epsiPb11
					if (strainPostBucklingTrial(0) <= 0.) // We don't have reduced too much
					{
						deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
						deltaStrain_converged4Peak = deltaStrain_trial;

						// Check if point swich Pl recov stage UVC is reached
						if (abs(strainPostBucklingTrial(0)) <= SMALL_NUMBER)
						{ // We have reduced all the epsiPb11
							switchUVCRecovUVCPoint = 1;
						} // end check if point swich Pl recov stage UVC is reached

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							revertToBeforeSwitchUVCRecovUVC(switchUVCRecovUVCPoint);
							deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
						} // end check if full strain increment has been done

						//Update deltaStrain_todo if we are at switch point
						if (switchUVCRecovUVCPoint == 1)
						{
							deltaStrain_trial = deltaStrain_todo + deltaStrain_converged4Peak;
						} // end Update deltaStrain_todo if we are at switch point

					} // end if we don't have reduced epsiPb11 too much
					else
					{ // if we have reduced epsiPb11 too much 
						revertToBeforeSwitchUVCRecovUVC(switchUVCRecovUVCPoint);
						/*deltaStrain_remaining4Peak /= 2.;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak;*/
						deltaStrain_remaining4Peak = deltaStrain_trial - deltaStrain_converged4Peak;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak / 2.;
					} // end if we have reduced epsiPb11 too much


				} // end UVC recovery stage

				else { //hardening stage
				/*deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
				deltaStrain_converged4Peak = deltaStrain_trial;*/

					plasticLoading = 1;

					deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;

					convergedMatLaw = true;
					retVal = returnMappingHardening(strain_nPlus1, alphaTot, etaTrial, switchUVCRecovUVCPoint);

					// Check if the full strain increment has been done
					//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
					if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
						convergedMatLaw = true;
					}
					else { // converged but there is more strain increment to do
						revertToBeforeSwitchPlRecovUVC(switchPlRecovUVCPoint);
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
					} // end check if full strain increment has been done

				} // end hardening stage
			} // end if not elastic		

			// Cyclic degradation part:
			sumEjTrial = sumEjConverged + 0.5 * (stressPrevious(0) + stressTrial(0)) * (strain_nPlus1(0) - strainConverged(0));
			computeSigmaCDegradation();

		} // end if in tension
		else { // if in compression
			// Compute value of phiCompression
			chi1c = calculateChi1c();
			phiCompression = 3. / 2. * (2. / 3. * pow(xiTrial(0), 2) + 2. * pow(xiTrial(1), 2) + 2. * pow(xiTrial(2), 2)) + chi1c * pow(stressTrial(0), 2) - pow(yieldStressTot, 2);

			// Check if trial state is elastic or if need return map approach
			if (phiCompression / (2. / 3. * pow(initialYield, 2)) <= RETURN_MAP_TOL) { //loading is elastic
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic(etaTangent);

				// Check if the initial capping stress sigmaC0 has been passed
				//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) <= SMALL_NUMBER) { // not yet at capping point
				if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress,2) <= SMALL_NUMBER) { // not yet at capping point
					deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
					deltaStrain_converged4Peak = deltaStrain_trial;

					// Check if the full strain increment has been done
					//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
					if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
						convergedMatLaw = true;
					}
					else { // converged but there is more strain increment to do
						revertToBeforeCapping(cappingPoint);
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
					}

					// Check if capping point is reached
					//double sigmaVM = pow((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2))), 0.5);
					//double diffStress = 3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaC, 2);
					//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) >= -SMALL_NUMBER) { // capping point is reached
					if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) >= -SMALL_NUMBER) { // capping point is reached
						cappingPoint = 1;
						if (convergedMatLaw == 0)
						{
							if (abs(strainPostBucklingTrial(0)) < SMALL_NUMBER)
							{
								strainPostBucklingTrial(0) = -SMALL_NUMBER;
							}
							//strainPostBucklingTrial(0) = -SMALL_NUMBER;
							//calculateC1c(yieldStress, alphaTot(0));
							calculateC1c(yieldStressTot, alphaTot);
						}
						deltaStrain_trial = deltaStrain_todo + deltaStrain_converged4Peak;
					}
				}
				else { // the capping point has been passed
					//deltaStrain_trial /= 2.;
					revertToBeforeCapping(cappingPoint);
					/*deltaStrain_remaining4Peak /= 2.;
					deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak;*/
					deltaStrain_remaining4Peak = deltaStrain_trial - deltaStrain_converged4Peak;
					deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak / 2.;
				}
			}
			else { // if not elastic

				// Check if hardening or softening response
				//if (abs(strainPostBucklingTrial(0)) <SMALL_NUMBER && c1c <= SMALL_NUMBER) {
				if (abs(strainPostBucklingTrial(0)) < SMALL_NUMBER) {
					// Do a step in the hardening direction
					plasticLoading = 1;
					retVal = returnMappingHardening(strain_nPlus1, alphaTot, etaTrial, switchUVCRecovUVCPoint);

					// Check if the initial capping stress sigmaC0 has been passed
					//double sigmaVM = pow((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2))), 0.5);
					//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) <= SMALL_NUMBER) { // not yet at capping point
					if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // not yet at capping point
						deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
						deltaStrain_converged4Peak = deltaStrain_trial;

						// Check if capping point is reached
						//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) >= -SMALL_NUMBER) { // capping point is reached
						if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) >= -SMALL_NUMBER) { // capping point is reached
							cappingPoint = 1;
							strainPostBucklingTrial(0) = -SMALL_NUMBER;
							deltaStrain_trial = deltaStrain_todo + deltaStrain_converged4Peak;
						}

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							/*strain_previous += deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;*/
							if (cappingPoint == 0) {
								revertToBeforeCapping(cappingPoint);
								deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
							}
						}

					}
					else { // the capping point has been passed
						//deltaStrain_trial /= 2.;
						revertToBeforeCapping(cappingPoint);
						/*deltaStrain_remaining4Peak /= 2.;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak;*/
						deltaStrain_remaining4Peak = deltaStrain_trial - deltaStrain_converged4Peak;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak / 2.;
					}
				}
				else { // if chi1c !=0 --> softening stage
					postBucklingLoading = 1;

					retVal = returnMappingSoftening(strain_nPlus1, xiTrial, alphaTot, yieldStressTot);

					//convergedMatLaw = true;

					// Check if the initial capping stress  has been passed (due to reduction in sigmaC)
					//double sigmaVM = pow((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2))), 0.5);
					//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) <= SMALL_NUMBER) { // not yet at capping point
					if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // not yet at capping point
						deltaStrain_todo = deltaStrain_fullIncrement - deltaStrain_trial;
						deltaStrain_converged4Peak = deltaStrain_trial;

						// Check if capping point is reached
						//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) >= -SMALL_NUMBER) { // capping point is reached
						if ((3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) >= -SMALL_NUMBER) { // capping point is reached
							cappingPoint = 1;
							calculateC1c(yieldStressTot, alphaTot);
							deltaStrain_trial = deltaStrain_todo + deltaStrain_converged4Peak;
						}

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						//if (deltaStrain_todo.Norm() <= 0.) { // full strain increment has been done
						if (deltaStrain_todo.Norm() <= pow(SMALL_NUMBER, 2)) { // full strain increment has been done	
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							/*strain_previous += deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;*/
							if (cappingPoint == 0) {
								revertToBeforeCapping(cappingPoint);
								deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_todo / 2.;
							}
						}

					}
					else { // the capping point has been passed
						//deltaStrain_trial /= 2.;
						revertToBeforeCapping(cappingPoint);
						/*deltaStrain_remaining4Peak /= 2.;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak;*/
						deltaStrain_remaining4Peak = deltaStrain_trial - deltaStrain_converged4Peak;
						deltaStrain_trial = deltaStrain_converged4Peak + deltaStrain_remaining4Peak / 2.;
					}

					// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
					double sumEj_4targetStress4PLRecov = sumEjConverged + 0.5 * (stressPrevious(0) + stressTrial(0)) * (strain_nPlus1(0) - strainConverged(0)) - 0.5 * pow(stressTrial(0),2) / (etaTangent * elasticMatrix(0, 0));
					double beta = std::min(1., sumEj_4targetStress4PLRecov / ErcConverged);
					double targetStress4PLRecov = (1 - beta) * sigmaC0Stress;
					setTensileEllipsoidYieldSurf(yieldStressTot, alphaTot, targetStress4PLRecov);
				}
			} // end IF not elastic

			//// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
			//setTensileEllipsoidYieldSurf(yieldStress, alphaTot);

			// Cyclic degradation part:
			sumEjTrial = sumEjConverged + 0.5 * (stressPrevious(0) + stressTrial(0)) * (strain_nPlus1(0) - strainConverged(0));

		} // end IF compression

		/*if (iterationNumber_timeIntegration >= 400) {
			int ErrorVal = -1;
		}*/
	}

	// Warn the user if the algorithm did not converge and return -1
	if (iterationNumber_timeIntegration >= MAXIMUM_ITERATIONS_TIMEINTEGRATION) {
		opserr << "LocalBucklingWebPlate::timeIntegration time integration did not converge!" << endln;
		opserr << "This is strainConverged: " << strainConverged << endln;
		opserr << "This is strainTrial: " << strainTrial << endln;
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::returnMappingHardening(Vector strain_nPlus1, Vector alphaTot, Vector etaTrial, int switchUVCRecovUVCPoint) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
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
	std::vector<Vector> alpha12Tot_Vector;
	double etaTangent = 0.;

	std::vector<Vector> alpha12PK4Use;
	double strainPEq4Use = 0.;
	Vector strainPlastic4Use = Vector(N_DIMS);
	// Chose if use trial or comitted state, this is done for switch UVC recovery to UVC stage
	if (switchUVCRecovUVCPoint == 0)
	{
		alpha12PK4Use = alphaPKConverged;
		strainPEq4Use = strainPEqConverged;
		strainPlastic4Use = strainPlasticConverged;
	}
	else
	{
		alpha12PK4Use = alphaPKTrial;
		strainPEq4Use = strainPEqTrial;
		strainPlastic4Use = strainPlasticTrial;
	}

	etaTangent = calculateEtaTangentReduce();

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		/*alpha12Tot_Vector.push_back(alphaPKConverged[i]+ alphaPBKConverged[i]);*/
		//alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKTrial[i]);
		alpha12Tot_Vector.push_back(alpha12PK4Use[i] + alphaPBKTrial[i]);
	}

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		// Isotropic hardening parameters
		yieldStressP = calculateYieldStressPlastic();
		yieldStressTot = yieldStressP + yieldStressPBTrial;
		isotropicModulus = calculateIsotropicModulus();
		// Kinematic hardening parameters
		beta = 0.;
		alphaTilde.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			/*eK = calculateEk(i);*/
			eK = exp(-gammaK[i] * (strainPEqTrial - strainPEq4Use));
			beta += cK[i] / gammaK[i] * (1. - eK);
			alphaTilde += alpha12Tot_Vector[i] * eK;
		}
		alphaTilde = alphaTot - alphaTilde;
		beta = 1. + beta / yieldStressTot;

		/*etaTangent = calculateEtaTangentReduce();*/

		// Update the relative stress and eta
		gammaDiag(0) = 1. / (beta + consistParam_plastic * 2. / 3. * etaTangent * elasticModulus);
		gammaDiag(1) = 1. / (beta + consistParam_plastic * 2. * etaTangent * shearModulus);
		gammaDiag(2) = gammaDiag(1);

		etaTilde = etaTrial + qMatT * alphaTilde;
		eta = vecMult3(etaTilde, gammaDiag);
		f2bar = 2. / 3. * pow(eta(0), 2) + 2. * pow(eta(1), 2) + 2. * pow(eta(2), 2);
		fBar = sqrt(f2bar);

		// Calculate Newton denominator
		betaPrime = 0.;
		alphaTildePrime.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			/*eK = calculateEk(i);*/
			eK = exp(-gammaK[i] * (strainPEqTrial - strainPEq4Use));
			betaPrime = betaPrime - cK[i] * isotropicModulus / (gammaK[i] * pow(yieldStressTot, 2)) * (1. - eK)
				+ cK[i] * eK / yieldStressTot;
			alphaTildePrime = alphaTildePrime + gammaK[i] * eK * alpha12Tot_Vector[i];
		}
		betaPrime = betaPrime * sqrt(2. / 3.) * fBar;
		alphaTildePrime = alphaTildePrime * sqrt(2. / 3.) * fBar;
		for (unsigned int i = 0; i < N_DIMS; ++i)
			gammaDiagPrime(i) = -pow(gammaDiag(i), 2) * (betaPrime + lambdaP(i) * etaTangent * lambdaC(i));

		consistDenom = dotprod3(vecMult3(lambdaP, eta),
			vecMult3(gammaDiagPrime, etaTilde) + vecMult3(gammaDiag, qMatT * alphaTildePrime))
			- sqrt(2. / 3.) * 2. / 3. * yieldStressTot * isotropicModulus * fBar;

		// Newton step
		phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStressTot, 2);
		consistParam_plastic = consistParam_plastic - phiVM / (consistDenom + SMALL_NUMBER);
		/*strainPEqTrial = strainPEqConverged + sqrt(2. / 3.) * consistParam_plastic * fBar;*/
		strainPEqTrial = strainPEq4Use + sqrt(2. / 3.) * consistParam_plastic * fBar;

		// Check convergence
		if (fabs(phiVM) / (2. / 3. * pow(initialYield, 2)) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Update the variables
	etaTilde = etaTrial + qMatT * alphaTilde;
	eta = vecMult3(gammaDiag, etaTilde);
	stressRelative = qMat * eta;
	yieldStressP = calculateYieldStressPlastic();
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		/*eK = calculateEk(i);*/
		eK = exp(-gammaK[i] * (strainPEqTrial - strainPEq4Use));
		alpha12Tot_Vector[i] = alpha12Tot_Vector[i] * eK + stressRelative / yieldStressTot * cK[i] / gammaK[i] * (1. - eK);
		/*alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKConverged[i];*/
		alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKTrial[i];
	}
	/*strainPlasticTrial = strainPlasticConverged + consistParam_plastic * PMat * stressRelative;*/
	strainPlasticTrial = strainPlastic4Use + consistParam_plastic * PMat * stressRelative;

	/*etaTangent = calculateEtaTangentReduce();*/
	stressTrial = (etaTangent * elasticMatrix) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);

	// Calculate the consistent tangent modulus for hardening stage
	calculateConsistentTangentModulusHardening(consistParam_plastic, fBar, stressRelative);

	// Warn the user if the algorithm did not convergein the return mapping for hardening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiVM / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		opserr << "LocalBucklingWebPlate::returnMappingHardening return mapping hardening stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strain_nPlus1[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strain_nPlus1[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strain_nPlus1[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiVM << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::returnMappingSoftening(Vector strain_nPlus1, Vector relativeStressTrial, Vector backstressTot, double yieldStressTot) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	Vector gammaDiag = Vector(N_DIMS);
	double consistParam_postBuckling = 0.;
	double chi1c = 0.;
	double sigmaSurSigmaY = 0.;
	Vector relativeStressNPlus1 = Vector(N_DIMS);
	double phiComp = 0.;
	double psi = 0.;
	double dSigmaSurSigmaYdEpsilonPB11 = 0.;
	double dChi1cDLambdaPB = 0.;
	Vector gammaDiagPrime = Vector(N_DIMS);
	Vector dXidLambda = Vector(N_DIMS);
	double dPhiCompdLambdaPB = 0.;
	Vector dPhiCompdXi = Vector(N_DIMS);
	double etaTangent = 0.;
	Vector LambdaC_nPlus1Diag = Vector(N_DIMS);
	Vector dCdLambdaPB = Vector(N_DIMS);

	chi1c = calculateChi1c();
	sigmaSurSigmaY = calculateSigmaSurSigmaY();

	Vector strainPostBucklingConvergedWithAddedTol = Vector(N_DIMS);
	if (abs(strainPostBucklingConverged(0)) < SMALL_NUMBER)
	{ // Try to solve issue with epsiPb11<tol after softening stage
		strainPostBucklingConvergedWithAddedTol = strainPostBucklingConverged - pVect * SMALL_NUMBER;
	}
	else {
		strainPostBucklingConvergedWithAddedTol = strainPostBucklingConverged;
	}

	// Do the return mapping algorithm for post buckling loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		etaTangent = calculateEtaTangentReduce();
		LambdaC_nPlus1Diag = etaTangent * lambdaC;

		gammaDiag(0) = 1. / (1. / LambdaC_nPlus1Diag(0) + consistParam_postBuckling * (2. + 2. * chi1c));
		gammaDiag(1) = 1. / (1. / LambdaC_nPlus1Diag(1) + consistParam_postBuckling * 6.);
		gammaDiag(2) = gammaDiag(1);

		relativeStressNPlus1(0) = gammaDiag(0) * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingConvergedWithAddedTol(0) - 2. * chi1c * consistParam_postBuckling * backstressTot(0)) - gammaDiag(0) / LambdaC_nPlus1Diag(0) * backstressTot(0);
		relativeStressNPlus1(1) = gammaDiag(1) * (strain_nPlus1(1) - strainPlasticTrial(1) - strainPostBucklingConvergedWithAddedTol(1)) - gammaDiag(1) / LambdaC_nPlus1Diag(1) * backstressTot(1);
		relativeStressNPlus1(2) = gammaDiag(2) * (strain_nPlus1(2) - strainPlasticTrial(2) - strainPostBucklingConvergedWithAddedTol(2)) - gammaDiag(2) / LambdaC_nPlus1Diag(2) * backstressTot(2);
		stressTrial = relativeStressNPlus1 + backstressTot;

		phiComp = 3. / 2. * (2. / 3. * pow(relativeStressNPlus1(0), 2) + 2. * pow(relativeStressNPlus1(1), 2) + 2. * pow(relativeStressNPlus1(2), 2)) + chi1c * pow(stressTrial(0), 2) - pow(yieldStressTot, 2);

		psi = pow((4. * pow(relativeStressNPlus1(0), 2) + 12. * pow(relativeStressNPlus1(1), 2) + 12. * pow(relativeStressNPlus1(2), 2) + 8. * pow(chi1c, 2) * pow(stressTrial(0), 2)), 0.5);
		dPhiCompdXi(0) = 2. * (relativeStressNPlus1(0) + chi1c * stressTrial(0));
		dPhiCompdXi(1) = 6. * relativeStressNPlus1(1);
		dPhiCompdXi(2) = 6. * relativeStressNPlus1(2);

		dSigmaSurSigmaYdEpsilonPB11 = calculateDSigmaSurSigmaYdEpsilonPB11();

		dChi1cDLambdaPB = dPhiCompdXi(0) * 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;
		//dChi1cDLambdaPB = -dPhiCompdXi(0) * 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;

		dCdLambdaPB = calculateDCdLambdaPB(etaTangent, dPhiCompdXi(0));

		gammaDiagPrime(0) = -pow(gammaDiag(0), 2) * (dCdLambdaPB(0) + 2. * (1. + chi1c) + 2. * consistParam_postBuckling * dChi1cDLambdaPB);
		gammaDiagPrime(1) = -pow(gammaDiag(1), 2) * (dCdLambdaPB(1) + 6.);
		gammaDiagPrime(2) = -pow(gammaDiag(2), 2) * (dCdLambdaPB(2) + 6.);

		dXidLambda(0) = gammaDiagPrime(0) * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingConvergedWithAddedTol(0) - 2. * chi1c * consistParam_postBuckling * backstressTot(0)) - 2 * chi1c * gammaDiag(0) * backstressTot(0) - 2 * consistParam_postBuckling * gammaDiag(0) * backstressTot(0) * dChi1cDLambdaPB - gammaDiagPrime(0) / LambdaC_nPlus1Diag(0) * backstressTot(0) - gammaDiag(0) * dCdLambdaPB(0) * backstressTot(0);
		dXidLambda(1) = gammaDiagPrime(1) * (strain_nPlus1(1) - strainPlasticTrial(1) - strainPostBucklingConvergedWithAddedTol(1)) - gammaDiagPrime(1) / LambdaC_nPlus1Diag(1) * backstressTot(1) - gammaDiag(1) * dCdLambdaPB(1) * backstressTot(1);
		dXidLambda(2) = gammaDiagPrime(2) * (strain_nPlus1(2) - strainPlasticTrial(2) - strainPostBucklingConvergedWithAddedTol(2)) - gammaDiagPrime(2) / LambdaC_nPlus1Diag(2) * backstressTot(2) - gammaDiag(2) * dCdLambdaPB(2) * backstressTot(2);

		dPhiCompdLambdaPB = 2. * dXidLambda(0) * (relativeStressNPlus1(0) + chi1c * stressTrial(0)) + 6. * dXidLambda(1) * relativeStressNPlus1(1) + 6. * dXidLambda(2) * relativeStressNPlus1(2) + pow(stressTrial(0), 2) * dChi1cDLambdaPB;

		// Do the Newton Step
		consistParam_postBuckling = consistParam_postBuckling - phiComp / dPhiCompdLambdaPB;

		strainPBEqTrial = strainPBEqConverged + psi * consistParam_postBuckling;
		strainPostBucklingTrial = strainPostBucklingConvergedWithAddedTol + consistParam_postBuckling * dPhiCompdXi;
		//if (strainPostBucklingConverged.Norm() == 0.)
		//{ // Try to solve issue with epsiPb11<tol after softening stage
		//	strainPostBucklingTrial = pVect * (strainPostBucklingConverged(0)+SMALL_NUMBER) + consistParam_postBuckling * dPhiCompdXi;
		//}

		sigmaSurSigmaY = calculateSigmaSurSigmaY();
		chi1c = calculateChi1c();

		// Check convergence
		if (fabs(phiComp / (2. / 3. * pow(initialYield, 2))) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
		/*if (iterationNumber_ReturnMapping <= MAXIMUM_ITERATIONS_RETURNMAPPING / 2 && fabs(phiComp) < RETURN_MAP_TOL)
		{
			convergedReturnMapping = true;
		}
		else if (iterationNumber_ReturnMapping > MAXIMUM_ITERATIONS_RETURNMAPPING / 2 && fabs(phiComp) < 50 * RETURN_MAP_TOL)
		{
			convergedReturnMapping = true;
		}*/
	}

	/*if (abs(strainPostBucklingTrial(0))<=abs(strainPostBucklingConverged(0)) || abs(strainPostBucklingTrial(0))<=RETURN_MAP_TOL)
	{
		double testError = 0.;
	}*/

	/*if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) > SMALL_NUMBER)
	{
		int testError = 1;
	}*/

	// Calculate the consistent tangent modulus for softening stage
	calculateConsistentTangentModulusSoftening(strain_nPlus1, backstressTot, relativeStressNPlus1, stressTrial, consistParam_postBuckling);

	// Warn the user if the algorithm did not convergein the return mapping for softening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiComp / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		opserr << "LocalBucklingWebPlate::returnMappingSoftening return mapping softening stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strainTrial[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strainTrial[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strainTrial[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiComp << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int LocalBucklingWebPlate::returnMappingPlRecovStage(Vector strain_nPlus1) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	Vector backstressPTot = Vector(N_DIMS);
	Vector backstressPBTot = Vector(N_DIMS);
	Vector backstressTot = Vector(N_DIMS);
	double backstress11Pb_nPlus1 = 0.;
	double consistParam_plRecov = 0.;
	double chi1t = 0.;
	double f1t = 0.;
	double etaTangent = 0.;
	Vector LambdaC_nPlus1Diag = Vector(N_DIMS);
	Vector gammaDiag = Vector(N_DIMS);
	Vector relativeStressNPlus1 = Vector(N_DIMS);
	double phiTens = 0.;
	double psi = 0.;
	Vector dPhiTensdXi = Vector(N_DIMS);
	double tBezier = 0.;
	double sigmaBezier = 0.;
	double dSigmaBezierDtBezier = 0.;
	double dEpsiBezierdtBezier = 0.;
	double dAlpha11TotDLambdaPb = 0.;
	double dSigmaBezierDLambdaPb = 0.;
	double dFchi1tdLambdaPb = 0.;
	double dChi1tDLambdaPB = 0.;
	Vector dCdLambdaPB = Vector(N_DIMS);
	Vector gammaDiagPrime = Vector(N_DIMS);
	Vector dXidLambda = Vector(N_DIMS);
	double dPhiTensdLambdaPB = 0.;
	double yieldStressTot = 0.;
	double dSigmaYieldTotDLambdaPb = 0.;

	// Compute backstress components
	/*backstressPTot = alphaPKConverged[0] + alphaPKConverged[1];
	backstressPBTot = alphaPBKConverged[0] + alphaPBKConverged[1];
	backstressTot = backstressPTot + backstressPBTot;*/

	/*if (strainConverged(0) <= -0.10971 && strainConverged(0) > -0.10972 && strainTrial(0) >= -0.109186 && strainTrial(0) < -0.109185)
	{
		opserr << "This is stressTrial: " << stressTrial << endln;
		opserr << "This is backstressTot: " << backstressTot << endln;
		opserr << "This is strainTrial: " << strainTrial << endln;
		opserr << "This is epsiPConverged: " << strainPlasticConverged << endln;
		opserr << "This is epsiPBEqConverged: " << strainPBEqConverged<< endln;
		opserr << "This is epsiPbConverged: " << strainPostBucklingConverged << endln;
		opserr << "This is chi1t: " << chi1t << endln;
		opserr << "This is sigmaY: " << yieldStress << endln;
		opserr << "This is bPlate: " << bPlateWidth << endln;
		opserr << "This is tPlate: " << tPlateThickness << endln;
		opserr << "This is b_chi1tO: " << b_1tO << endln;
		opserr << "This is b_chi1tS: " << b_1tS << endln;
		opserr << "This is epsilonPB11Unload: " << epsilonPB11Unload << endln;
		opserr << "This is sigmaPrO: " << sigmaPrBezierO << endln;
		opserr << "This is sigmaPrS: " << sigmaPrBezierS << endln;
		opserr << "This is sigmaYrUnscaled: " << sigmaYrBezierO<< endln;
		opserr << "This is backstressPlasticTot: " << backstressPTot << endln;
		opserr << "This is backstressAfterCompression: " << backstressAfterCompression << endln;
		opserr << "This is alphaNormBezierStress: " << (2. * yieldStress - (yieldStress - backstressAfterCompression(0))) << endln;

		double testError = 1.;
	}*/

	tBezier = calculateTBezier();
	sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
	yieldStressTot = computeYieldStressTotPlRecovStage();
	backstressTot = computeBackstressTotPlRecovStage();
	//f1t = 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot(0)), 2)) / (b_1tTrial * pow(sigmaBezier, 2));
	f1t = calculateF1t(yieldStressTot, backstressTot(0));
	chi1t = b_1tTrial * (1 - f1t);

	// Do the return mapping algorithm for plastic recovery stage
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING)
	{
		iterationNumber_ReturnMapping++;

		etaTangent = calculateEtaTangentReduce();
		LambdaC_nPlus1Diag = etaTangent * lambdaC;

		gammaDiag(0) = 1. / (1. / LambdaC_nPlus1Diag(0) + consistParam_plRecov * (2. + 2. * chi1t));
		gammaDiag(1) = 1. / (1. / LambdaC_nPlus1Diag(1) + consistParam_plRecov * 6.);
		gammaDiag(2) = gammaDiag(1);

		relativeStressNPlus1(0) = gammaDiag(0) * (strain_nPlus1(0) - strainPlasticConverged(0) - strainPostBucklingConverged(0) - 2. * chi1t * consistParam_plRecov * backstressTot(0)) - gammaDiag(0) / LambdaC_nPlus1Diag(0) * backstressTot(0);
		relativeStressNPlus1(1) = gammaDiag(1) * (strain_nPlus1(1) - strainPlasticConverged(1) - strainPostBucklingConverged(1)) - gammaDiag(1) / LambdaC_nPlus1Diag(1) * backstressTot(1);
		relativeStressNPlus1(2) = gammaDiag(2) * (strain_nPlus1(2) - strainPlasticConverged(2) - strainPostBucklingConverged(2)) - gammaDiag(2) / LambdaC_nPlus1Diag(2) * backstressTot(2);
		stressTrial = relativeStressNPlus1 + backstressTot;

		phiTens = 3. / 2. * (2. / 3. * pow(relativeStressNPlus1(0), 2) + 2. * pow(relativeStressNPlus1(1), 2) + 2. * pow(relativeStressNPlus1(2), 2)) + chi1t * pow(stressTrial(0), 2) - pow(yieldStressTot, 2);

		psi = pow((4. * pow(relativeStressNPlus1(0), 2) + 12. * pow(relativeStressNPlus1(1), 2) + 12. * pow(relativeStressNPlus1(2), 2) + 8. * pow(chi1t, 2) * pow(stressTrial(0), 2)), 0.5);
		dPhiTensdXi(0) = 2. * (relativeStressNPlus1(0) + chi1t * stressTrial(0));
		dPhiTensdXi(1) = 6. * relativeStressNPlus1(1);
		dPhiTensdXi(2) = 6. * relativeStressNPlus1(2);

		dSigmaBezierDtBezier = -3. * pow((1. - tBezier), 2) * sigmaPrBezierTrial + 3. * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * sigmaYrBezierTrial;
		dEpsiBezierdtBezier = -3. * pow((1. - tBezier), 2) * abs(epsilonPB11UnloadTrial) + 3. * (abs(epsilonPB11UnloadTrial) + alphaPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (0. + alphaYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * 0.;
		dSigmaBezierDLambdaPb = -dSigmaBezierDtBezier / dEpsiBezierdtBezier * dPhiTensdXi(0);

		dAlpha11TotDLambdaPb = computeDAlpha11TotDEpsiPb11PlRecovStage() * dPhiTensdXi(0);
		dSigmaYieldTotDLambdaPb = computeDSigmaYieldTotDEpsiPb11PlRecovStage() * dPhiTensdXi(0);

		dFchi1tdLambdaPb = -1 / pow((b_1tTrial * pow(sigmaBezier, 2)), 2) * ((2 * yieldStressTot * dSigmaYieldTotDLambdaPb - 2 * (dSigmaBezierDLambdaPb - dAlpha11TotDLambdaPb) *
			(sigmaBezier - backstressTot(0))) * (b_1tTrial * pow(sigmaBezier, 2)) - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot(0)), 2)) * 2 * b_1tTrial * dSigmaBezierDLambdaPb * sigmaBezier);
		dChi1tDLambdaPB = -b_1tTrial * dFchi1tdLambdaPb;

		dCdLambdaPB = calculateDCdLambdaPB(etaTangent, dPhiTensdXi(0));

		gammaDiagPrime(0) = -pow(gammaDiag(0), 2) * (dCdLambdaPB(0) + 2. * (1. + chi1t) + 2. * consistParam_plRecov * dChi1tDLambdaPB);
		gammaDiagPrime(1) = -pow(gammaDiag(1), 2) * (dCdLambdaPB(1) + 6.);
		gammaDiagPrime(2) = -pow(gammaDiag(2), 2) * (dCdLambdaPB(2) + 6.);

		dXidLambda(0) = gammaDiagPrime(0) * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingConverged(0) - 2. * chi1t * consistParam_plRecov * backstressTot(0)) - 2 * chi1t * gammaDiag(0) * backstressTot(0) - 2 * consistParam_plRecov * gammaDiag(0) * backstressTot(0) * dChi1tDLambdaPB - gammaDiagPrime(0) / LambdaC_nPlus1Diag(0) * backstressTot(0) - gammaDiag(0) * dCdLambdaPB(0) * backstressTot(0) - gammaDiag(0) * 2. * chi1t * consistParam_plRecov * dAlpha11TotDLambdaPb - gammaDiag(0) / LambdaC_nPlus1Diag(0) * dAlpha11TotDLambdaPb;
		dXidLambda(1) = gammaDiagPrime(1) * (strain_nPlus1(1) - strainPlasticTrial(1) - strainPostBucklingConverged(1)) - gammaDiagPrime(1) / LambdaC_nPlus1Diag(1) * backstressTot(1) - gammaDiag(1) * dCdLambdaPB(1) * backstressTot(1);
		dXidLambda(2) = gammaDiagPrime(2) * (strain_nPlus1(2) - strainPlasticTrial(2) - strainPostBucklingConverged(2)) - gammaDiagPrime(2) / LambdaC_nPlus1Diag(2) * backstressTot(2) - gammaDiag(2) * dCdLambdaPB(2) * backstressTot(2);

		dPhiTensdLambdaPB = 2. * dXidLambda(0) * (relativeStressNPlus1(0) + chi1t * stressTrial(0)) + 6. * dXidLambda(1) * relativeStressNPlus1(1) + 6. * dXidLambda(2) * relativeStressNPlus1(2) + pow(stressTrial(0), 2) * dChi1tDLambdaPB + 2 * chi1t * stressTrial(0) * dAlpha11TotDLambdaPb - 2 * dSigmaYieldTotDLambdaPb * yieldStressTot;

		// Do the Newton Step
		consistParam_plRecov = consistParam_plRecov - phiTens / dPhiTensdLambdaPB;

		strainPBEqTrial = strainPBEqConverged * -psi * consistParam_plRecov;
		strainPostBucklingTrial = strainPostBucklingConverged + consistParam_plRecov * dPhiTensdXi;
		//if (strainPostBucklingTrial(0) > 0)
		//{
		//	break;
		//}

		tBezier = calculateTBezier();
		sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
		yieldStressTot = computeYieldStressTotPlRecovStage();
		backstressTot = computeBackstressTotPlRecovStage();
		//f1t = 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot(0)), 2)) / (b_1tTrial * pow(sigmaBezier, 2));
		f1t = calculateF1t(yieldStressTot, backstressTot(0));
		chi1t = b_1tTrial * (1 - f1t);

		if (iterationNumber_ReturnMapping > MAXIMUM_ITERATIONS_RETURNMAPPING - 2)
		{
			//double errorNb = 1.0;
			strainPostBucklingTrial(0) = -strainPostBucklingConverged(0); // Trick to divide strain increment by 2
			break;
		}

		// Check convergence
		if (fabs(phiTens / (2. / 3. * pow(initialYield, 2))) < RETURN_MAP_TOL) {
			//if (fabs(phiTens) < RETURN_MAP_TOL*2./3.*pow(yieldStress,2)) {
			convergedReturnMapping = true;
		}

	} // end loop for return mapping iterations

	// Compute post-buckling yield stress
	yieldStressP = calculateYieldStressPlastic();
	yieldStressPBTrial = yieldStressTot - yieldStressP;

	// Update each post-buckling backstress
	backstressPTot = alphaPKConverged[0] + alphaPKConverged[1];
	backstress11Pb_nPlus1 = backstressTot(0) - backstressPTot(0);
	Vector backstress1PB_nPlus1 = Vector(N_DIMS);
	Vector backstress2PB_nPlus1 = Vector(N_DIMS);
	backstress1PB_nPlus1(0) = rAlphaBackstress1Trial * backstress11Pb_nPlus1;
	backstress2PB_nPlus1(0) = rAlphaBackstress2Trial * backstress11Pb_nPlus1;
	alphaPBKTrial[0] = backstress1PB_nPlus1;
	alphaPBKTrial[1] = backstress2PB_nPlus1;

	// Update c1c for compressive yield surface
	//c1cTrial = c1cUnloadTrial * (strainPostBucklingTrial(0) / epsilonPB11UnloadTrial);
	computeReduceC1cLinearEvol();

	// Calculate the consistent tangent modulus for softening stage
	calculateConsistentTangentModulusPlRecovStage(strain_nPlus1, consistParam_plRecov, yieldStressTot, relativeStressNPlus1, backstressTot);

	// Warn the user if the algorithm did not convergein the return mapping for plastic recovery stage and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiTens / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		opserr << "LocalBucklingWebPlate::returnMappingPlRecovStage return mapping plastic recovery stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strainTrial[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strainTrial[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strainTrial[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiTens << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;
		retVal = -1;

		opserr << "This is strainTrial: " << strainTrial << endln;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int LocalBucklingWebPlate::returnMappingUVCRecovStage(Vector strain_nPlus1, Vector alphaTot) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	double isotropicModulus = 0.;
	double beta = 0.;
	Vector alphaTilde = Vector(N_DIMS);
	double eK = 0.;
	Vector gammaDiag = Vector(N_DIMS);
	double consistParam_plastic = 0.;
	double f2bar = 0.;
	double fBar = 0.;
	double betaPrime = 0.;
	Vector alphaTildePrime = Vector(N_DIMS);
	Vector gammaDiagPrime = Vector(N_DIMS);
	double consistDenom = 0.;
	double phiVM = 0.;
	std::vector<Vector> alpha12Tot_Vector;
	double etaTangent = 0.;
	Vector LambdaC_nPlus1Diag = Vector(N_DIMS);
	Vector relativeStressNPlus1 = Vector(N_DIMS);
	Vector SumEKAlphaKTerm = Vector(N_DIMS);
	double dEtaTangentdEpsiPb11 = 0.;
	Vector dCdLambdaP = Vector(N_DIMS);
	Vector dXidLambda = Vector(N_DIMS);
	Vector PMatMultrelativeStressNPlus1 = Vector(N_DIMS);
	double yieldStressTot = 0.;

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		/*alpha12Tot_Vector.push_back(alphaPKConverged[i]+ alphaPBKConverged[i]);*/
		alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKTrial[i]);
	}


	/*if (strainConverged(0) <= -0.011138 && strainConverged(0) > -0.011139 && strainTrial(0) >= -0.01078 && strainTrial(0) < -0.01077)
	{
		double testError = 1.;
	}*/

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		etaTangent = calculateEtaTangentReduce();
		LambdaC_nPlus1Diag = etaTangent * lambdaC;

		// Isotropic hardening parameters
		yieldStressP = calculateYieldStressPlastic();
		yieldStressTot = yieldStressP + yieldStressPBTrial;
		isotropicModulus = calculateIsotropicModulus();
		// Kinematic hardening parameters
		beta = 0.;
		alphaTilde.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			beta += cK[i] / gammaK[i] * (1. - eK);
			alphaTilde += alpha12Tot_Vector[i] * eK;
		}
		alphaTilde = alphaTot - alphaTilde;
		beta = 1. + beta / yieldStressTot;

		// Update the relative stress and eta
		gammaDiag(0) = 1. / (beta + consistParam_plastic * 4. / 3. * LambdaC_nPlus1Diag(0));
		gammaDiag(1) = 1. / (beta + consistParam_plastic * 2 * LambdaC_nPlus1Diag(1));
		gammaDiag(2) = 1. / (beta + consistParam_plastic * 2 * LambdaC_nPlus1Diag(2));

		SumEKAlphaKTerm.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			SumEKAlphaKTerm += (alpha12Tot_Vector[i] * eK);
		}
		relativeStressNPlus1(0) = gammaDiag(0) * (LambdaC_nPlus1Diag(0) * (strain_nPlus1(0) - strainPlasticConverged(0) - strainPostBucklingConverged(0)) - SumEKAlphaKTerm(0));
		relativeStressNPlus1(1) = gammaDiag(1) * (LambdaC_nPlus1Diag(1) * (strain_nPlus1(1) - strainPlasticConverged(1) - strainPostBucklingConverged(1)) - SumEKAlphaKTerm(1));
		relativeStressNPlus1(2) = gammaDiag(2) * (LambdaC_nPlus1Diag(2) * (strain_nPlus1(2) - strainPlasticConverged(2) - strainPostBucklingConverged(2)) - SumEKAlphaKTerm(2));

		f2bar = 2. / 3. * pow(relativeStressNPlus1(0), 2) + 2. * pow(relativeStressNPlus1(1), 2) + 2. * pow(relativeStressNPlus1(2), 2);
		fBar = sqrt(f2bar);

		// Calculate Newton denominator
		betaPrime = 0.;
		alphaTildePrime.Zero();
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			betaPrime = betaPrime - cK[i] * isotropicModulus / (gammaK[i] * pow(yieldStressTot, 2)) * (1. - eK)
				+ cK[i] * eK / yieldStressTot;
			alphaTildePrime = alphaTildePrime + gammaK[i] * eK * alpha12Tot_Vector[i];
		}
		betaPrime = betaPrime * sqrt(2. / 3.) * fBar;
		alphaTildePrime = alphaTildePrime * sqrt(2. / 3.) * fBar;

		dEtaTangentdEpsiPb11 = -calculateDEtaTangentdEpsiPb11();
		dCdLambdaP(0) = dEtaTangentdEpsiPb11 * 2 / 3 * relativeStressNPlus1(0) * elasticMatrix(0, 0);
		dCdLambdaP(1) = dEtaTangentdEpsiPb11 * 2 / 3 * relativeStressNPlus1(0) * elasticMatrix(1, 1);
		dCdLambdaP(2) = dEtaTangentdEpsiPb11 * 2 / 3 * relativeStressNPlus1(0) * elasticMatrix(2, 2);

		gammaDiagPrime(0) = -pow(gammaDiag(0), 2) * (betaPrime + 4. / 3. * LambdaC_nPlus1Diag(0) + 4. / 3. * dCdLambdaP(0) * consistParam_plastic);
		gammaDiagPrime(1) = -pow(gammaDiag(1), 2) * (betaPrime + 2. * LambdaC_nPlus1Diag(1) + 2. * dCdLambdaP(1) * consistParam_plastic);
		gammaDiagPrime(2) = -pow(gammaDiag(2), 2) * (betaPrime + 2. * LambdaC_nPlus1Diag(2) + 2. * dCdLambdaP(2) * consistParam_plastic);

		dXidLambda(0) = gammaDiagPrime(0) * (LambdaC_nPlus1Diag(0) * (strain_nPlus1(0) - strainPlasticConverged(0) - strainPostBucklingConverged(0)) - SumEKAlphaKTerm(0)) + gammaDiag(0) * (dCdLambdaP(0) * (strain_nPlus1(0) - strainPlasticConverged(0) - strainPostBucklingConverged(0)) + alphaTildePrime(0));
		dXidLambda(1) = gammaDiagPrime(1) * (LambdaC_nPlus1Diag(1) * (strain_nPlus1(1) - strainPlasticConverged(1) - strainPostBucklingConverged(1)) - SumEKAlphaKTerm(1)) + gammaDiag(1) * (dCdLambdaP(1) * (strain_nPlus1(1) - strainPlasticConverged(1) - strainPostBucklingConverged(1)) + alphaTildePrime(1));
		dXidLambda(2) = gammaDiagPrime(2) * (LambdaC_nPlus1Diag(2) * (strain_nPlus1(2) - strainPlasticConverged(2) - strainPostBucklingConverged(2)) - SumEKAlphaKTerm(2)) + gammaDiag(2) * (dCdLambdaP(2) * (strain_nPlus1(2) - strainPlasticConverged(2) - strainPostBucklingConverged(2)) + alphaTildePrime(2));

		consistDenom = (2. / 3. * relativeStressNPlus1(0) * dXidLambda(0) + 2. * relativeStressNPlus1(1) * dXidLambda(1) + 2. * relativeStressNPlus1(2) * dXidLambda(2))
			- sqrt(2. / 3.) * 2. / 3. * yieldStressTot * isotropicModulus * fBar;

		// Newton step
		phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStressTot, 2);
		consistParam_plastic = consistParam_plastic - phiVM / (consistDenom + SMALL_NUMBER);
		strainPEqTrial = strainPEqConverged + sqrt(2. / 3.) * consistParam_plastic * fBar;

		PMatMultrelativeStressNPlus1 = PMat * relativeStressNPlus1;
		strainPostBucklingTrial(0) = strainPostBucklingConverged(0) + consistParam_plastic * PMatMultrelativeStressNPlus1(0);

		// Check convergence
		if (fabs(phiVM / (2. / 3. * pow(initialYield, 2))) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Update the variables
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		alpha12Tot_Vector[i] = alpha12Tot_Vector[i] * eK + relativeStressNPlus1 / yieldStressTot * cK[i] / gammaK[i] * (1. - eK);
		/*alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKConverged[i];*/
		alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKTrial[i];
	}
	strainPlasticTrial = strainPlasticConverged + consistParam_plastic * PMat * relativeStressNPlus1;

	/*etaTangent = calculateEtaTangentReduce();*/
	stressTrial = (etaTangent * elasticMatrix) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);

	// Update c1c for compressive yield surface
	//c1cTrial = c1cUnloadTrial * (strainPostBucklingTrial(0) / epsilonPB11UnloadTrial);
	computeReduceC1cLinearEvol();

	// Calculate the consistent tangent modulus for hardening stage
	calculateConsistentTangentModulusUVCRecov(strain_nPlus1, consistParam_plastic, fBar, relativeStressNPlus1);

	// Warn the user if the algorithm did not convergein the return mapping for hardening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiVM / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		opserr << "LocalBucklingWebPlate::returnMappingUVCRecov return mapping UVC recovery stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strain_nPlus1[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strain_nPlus1[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strain_nPlus1[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiVM << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateConsistentTangentModulusElastic(double etaTangent) {
	//stiffnessTrial = elasticMatrix;
	stiffnessTrial = etaTangent * elasticMatrix;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateConsistentTangentModulusHardening(double consistParam_plastic, double fBar,
	const Vector& stressRelative) {
	// Initialize the variables
	Matrix iD3 = Matrix(N_DIMS, N_DIMS);
	Matrix complianceMatrix = Matrix(N_DIMS, N_DIMS);
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
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
	double etaTangent = 0.;
	std::vector<Vector> alpha12Tot_Vector;

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKConverged[i]); // Total backstress (P1+P2+Pb1+Pb2)
	}

	iD3.Zero(); // 3x3 indentity matrix
	iD3(0, 0) = iD3(1, 1) = iD3(2, 2) = 1.;
	complianceMatrix = calculateComplianceMatrix();

	// Isotropic hardening parameters
	yieldStressP = calculateYieldStressPlastic();
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	isotropicModulus = calculateIsotropicModulus();

	// Kinematic hardening related parameters
	nHat = stressRelative / fBar;
	for (unsigned int i = 0; i < nBackstresses; ++i)
		beta += cK[i] / gammaK[i] * (1. - eK);
	beta = 1. + beta / yieldStressTot;
	hPrime = -(beta - 1.) * isotropicModulus * stressRelative / yieldStressTot;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		hPrime += cK[i] * eK / yieldStressTot * stressRelative - gammaK[i] * eK * alpha12Tot_Vector[i];
	}
	hPrime *= sqrt(2. / 3.);
	hOutN = hPrime % nHat;
	aMat = matinv3(beta * iD3 + consistParam_plastic * hOutN * PMat);

	nTilde = nHat - consistParam_plastic * aMat * hPrime;

	etaTangent = calculateEtaTangentReduce();

	xiTilde = matinv3(1. / etaTangent * complianceMatrix + consistParam_plastic * PMat * aMat);
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

void LocalBucklingWebPlate::calculateConsistentTangentModulusSoftening(const Vector& strain_nPlus1, const Vector& backstressTot,
	const Vector& relativeStressNPlus1, const Vector& stressTrial, double consistParam_postBuckling) {
	// Initialize the variables
	Vector dPhiCompDSigma = Vector(N_DIMS);
	double chi1c = 0.;
	Vector gammaDiag = Vector(N_DIMS);
	double sigmaSurSigmaY = 0;
	double dSigmaSurSigmaYdEpsilonPB11 = 0;
	Vector dGammaDChi1cDiag = Vector(N_DIMS);
	Vector dXiDChi1c = Vector(N_DIMS);
	double dPhiCompDChi1c = 0.;
	double dChi1cDepsiPB11 = 0.;
	Vector d2PhiCompDSigmaDChi1c = Vector(N_DIMS);
	Vector d2PhiCompDSigma2Diag = Vector(N_DIMS);
	double B = 0.;
	Vector D = Vector(N_DIMS);
	double DPreFactor = 0.;
	Matrix CepTerm1 = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm2 = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm3 = Matrix(N_DIMS, N_DIMS);
	Matrix I = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm3Inverse = Matrix(N_DIMS, N_DIMS);
	double etaTangent = 0.;
	Vector LambdaC_nPlus1Diag = Vector(N_DIMS);
	double dEtaTangentdEpsiPb11 = 0.;
	Vector F = Vector(N_DIMS);

	chi1c = calculateChi1c();

	etaTangent = calculateEtaTangentReduce();
	LambdaC_nPlus1Diag = etaTangent * lambdaC;

	dPhiCompDSigma(0) = 2. * (relativeStressNPlus1(0) + chi1c * stressTrial(0));
	dPhiCompDSigma(1) = 6. * relativeStressNPlus1(1);
	dPhiCompDSigma(2) = 6. * relativeStressNPlus1(2);

	gammaDiag(0) = 1. / (1. / LambdaC_nPlus1Diag(0) + consistParam_postBuckling * (2. + 2. * chi1c));
	gammaDiag(1) = 1. / (1. / LambdaC_nPlus1Diag(1) + consistParam_postBuckling * 6.);
	gammaDiag(2) = gammaDiag(1);

	sigmaSurSigmaY = calculateSigmaSurSigmaY();
	dSigmaSurSigmaYdEpsilonPB11 = calculateDSigmaSurSigmaYdEpsilonPB11();

	dGammaDChi1cDiag.Zero();
	dGammaDChi1cDiag(0) = -2. * consistParam_postBuckling * pow(gammaDiag(0), 2);

	dXiDChi1c.Zero();
	dXiDChi1c(0) = dGammaDChi1cDiag(0) * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingConverged(0) - 2. * chi1c * consistParam_postBuckling * backstressTot(0)) - 2 * consistParam_postBuckling * gammaDiag(0) * backstressTot(0) - dGammaDChi1cDiag(0) / LambdaC_nPlus1Diag(0) * backstressTot(0);

	dPhiCompDChi1c = 2. * dXiDChi1c(0) * (relativeStressNPlus1(0) + chi1c * stressTrial(0)) + 6. * dXiDChi1c(1) * relativeStressNPlus1(1) + 6. * dXiDChi1c(2) * relativeStressNPlus1(2) + pow(stressTrial(0), 2);

	dChi1cDepsiPB11 = 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;

	d2PhiCompDSigma2Diag(0) = 2. * (1. + chi1c);
	d2PhiCompDSigma2Diag(1) = 6.;
	d2PhiCompDSigma2Diag(2) = 6.;

	d2PhiCompDSigmaDChi1c(0) = 2. * (dXiDChi1c(0) * (1. + chi1c) + stressTrial(0));

	B = 1. / (1. - dChi1cDepsiPB11 * consistParam_postBuckling * d2PhiCompDSigmaDChi1c(0));

	dEtaTangentdEpsiPb11 = calculateDEtaTangentdEpsiPb11();

	F(0) = -consistParam_postBuckling * d2PhiCompDSigmaDChi1c(0) + dEtaTangentdEpsiPb11 * 1. / dChi1cDepsiPB11 * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingTrial(0));
	F(1) = dEtaTangentdEpsiPb11 * 1. / dChi1cDepsiPB11 * (strain_nPlus1(1) - strainPlasticTrial(1) - strainPostBucklingTrial(1));
	F(2) = dEtaTangentdEpsiPb11 * 1. / dChi1cDepsiPB11 * (strain_nPlus1(2) - strainPlasticTrial(2) - strainPostBucklingTrial(2));

	DPreFactor = 1. / (dPhiCompDChi1c * dChi1cDepsiPB11 * dPhiCompDSigma(0) * B);
	D(0) = DPreFactor * (dPhiCompDSigma(0) + dPhiCompDChi1c * dChi1cDepsiPB11 * consistParam_postBuckling * d2PhiCompDSigma2Diag(0) * B);
	D(1) = DPreFactor * (dPhiCompDSigma(1));
	D(2) = DPreFactor * (dPhiCompDSigma(2));

	CepTerm1(0, 0) = d2PhiCompDSigma2Diag(0) - dChi1cDepsiPB11 * F(0) * d2PhiCompDSigma2Diag(0) * B;
	CepTerm1(1, 0) = -dChi1cDepsiPB11 * F(1) * d2PhiCompDSigma2Diag(0) * B;
	CepTerm1(1, 1) = d2PhiCompDSigma2Diag(1);
	CepTerm1(2, 0) = -dChi1cDepsiPB11 * F(2) * d2PhiCompDSigma2Diag(0) * B;
	CepTerm1(2, 2) = d2PhiCompDSigma2Diag(2);
	/*CepTerm2 = D * (dPhiCompDSigma + consistParam_postBuckling * A * dPhiCompDSigma(0));*/
	//opserr << "This is dPhiCompDSigma" << dPhiCompDSigma << endln;
	//opserr << "This is D" << D << endln;
	CepTerm2(0, 0) = D(0) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(0) - dPhiCompDSigma(0));
	CepTerm2(0, 1) = D(0) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(1) - dPhiCompDSigma(1));
	CepTerm2(0, 2) = D(0) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(2) - dPhiCompDSigma(2));
	CepTerm2(1, 0) = D(1) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(0) - dPhiCompDSigma(0));
	CepTerm2(1, 1) = D(1) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(1) - dPhiCompDSigma(1));
	CepTerm2(1, 2) = D(1) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(2) - dPhiCompDSigma(2));
	CepTerm2(2, 0) = D(2) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(0) - dPhiCompDSigma(0));
	CepTerm2(2, 1) = D(2) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(1) - dPhiCompDSigma(1));
	CepTerm2(2, 2) = D(2) * (dChi1cDepsiPB11 * dPhiCompDSigma(0) * B * F(2) - dPhiCompDSigma(2));
	//opserr << "This is CepTerm2" << CepTerm2 << endln;

	I(0, 0) = I(1, 1) = I(2, 2) = 1.;
	CepTerm3 = I + elasticMatrix * (consistParam_postBuckling * CepTerm1 + CepTerm2);
	//opserr << "This is CepTerm3" << CepTerm3 << endln;
	CepTerm3Inverse = matinv3(CepTerm3);
	stiffnessTrial.Zero();
	stiffnessTrial = elasticMatrix * CepTerm3Inverse;

	//Take the symmetric approximation
	stiffnessTrial.addMatrixTranspose(0.5, stiffnessTrial, 0.5);
	//opserr << "This is tangentModulusSoftening" << stiffnessTrial << endln;

	return;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateConsistentTangentModulusPlRecovStage(Vector strain_nPlus1, double consistParam_plRecov, double yieldStressTot, Vector relativeStressNPlus1, Vector backstressTot) {
	// Initialize the variables
	Vector dPhiTensDSigma = Vector(N_DIMS);
	double chi1t = 0.;
	Vector gammaDiag = Vector(N_DIMS);
	Vector dGammaDChi1tDiag = Vector(N_DIMS);
	Vector dXiDChi1t = Vector(N_DIMS);
	double dPhiTensDChi1t = 0.;
	double dChi1tDEpsiPB11 = 0.;
	Vector d2PhiTensDSigmaDChi1t = Vector(N_DIMS);
	Vector d2PhiTensDSigma2Diag = Vector(N_DIMS);
	double B = 0.;
	Vector D = Vector(N_DIMS);
	double DPreFactor = 0.;
	Matrix CepTerm1 = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm2 = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm3 = Matrix(N_DIMS, N_DIMS);
	Matrix I = Matrix(N_DIMS, N_DIMS);
	Matrix CepTerm3Inverse = Matrix(N_DIMS, N_DIMS);
	double etaTangent = 0.;
	Vector LambdaC_nPlus1Diag = Vector(N_DIMS);
	double dEtaTangentdEpsiPb11 = 0.;
	Vector F = Vector(N_DIMS);
	double tBezier = 0.;
	double sigmaBezier = 0.;
	double dSigmaBezierDtBezier = 0.;
	double dEpsiBezierDtBezier = 0.;
	double dSigmaBezierDEpsiPb11 = 0.;
	double dAlpha11TotDEpsiPb11 = 0.;
	double dF1tDEpsiPB11 = 0.;
	Vector dPhiTensDAlpha = Vector(N_DIMS);
	Vector d2PhiTensDSigmaDAlphaDiag = Vector(N_DIMS);
	Vector H = Vector(N_DIMS);
	double L = 0.;
	double dSigmaYieldTotDEpsiPb11 = 0.;
	double dPhiTensDSigmaYield = 0.;

	chi1t = calculateChi1t(yieldStressTot, backstressTot(0));

	etaTangent = calculateEtaTangentReduce();
	LambdaC_nPlus1Diag = etaTangent * lambdaC;

	tBezier = calculateTBezier();
	sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1 - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1 - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
	dSigmaBezierDtBezier = -3. * pow((1. - tBezier), 2) * sigmaPrBezierTrial + 3. * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * sigmaYrBezierTrial;
	dEpsiBezierDtBezier = -3. * pow((1. - tBezier), 2) * abs(epsilonPB11UnloadTrial) + 3. * (abs(epsilonPB11UnloadTrial) + alphaPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (0. + alphaYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * 0.;
	dSigmaBezierDEpsiPb11 = -dSigmaBezierDtBezier / dEpsiBezierDtBezier;

	dAlpha11TotDEpsiPb11 = computeDAlpha11TotDEpsiPb11PlRecovStage();
	dSigmaYieldTotDEpsiPb11 = computeDSigmaYieldTotDEpsiPb11PlRecovStage();

	gammaDiag(0) = 1. / (1. / LambdaC_nPlus1Diag(0) + consistParam_plRecov * (2. + 2. * chi1t));
	gammaDiag(1) = 1. / (1. / LambdaC_nPlus1Diag(1) + consistParam_plRecov * 6.);
	gammaDiag(2) = gammaDiag(1);

	dGammaDChi1tDiag.Zero();
	dGammaDChi1tDiag(0) = -2. * consistParam_plRecov * pow(gammaDiag(0), 2);

	dXiDChi1t.Zero();
	dXiDChi1t(0) = dGammaDChi1tDiag(0) * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingConverged(0) - 2. * chi1t * consistParam_plRecov * backstressTot(0)) - 2 * consistParam_plRecov * gammaDiag(0) * backstressTot(0) - dGammaDChi1tDiag(0) / LambdaC_nPlus1Diag(0) * backstressTot(0);

	dF1tDEpsiPB11 = -1 / pow((b_1tTrial * pow(sigmaBezier, 2)), 2) * ((2 * yieldStressTot * dSigmaYieldTotDEpsiPb11 - 2 * (dSigmaBezierDEpsiPb11 - dAlpha11TotDEpsiPb11) *
		(sigmaBezier - backstressTot(0))) * (b_1tTrial * pow(sigmaBezier, 2)) - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot(0)), 2)) * 2 * b_1tTrial * dSigmaBezierDEpsiPb11 * sigmaBezier);
	dChi1tDEpsiPB11 = -b_1tTrial * dF1tDEpsiPB11;

	dPhiTensDSigma(0) = 2. * (relativeStressNPlus1(0) + chi1t * stressTrial(0));
	dPhiTensDSigma(1) = 6. * relativeStressNPlus1(1);
	dPhiTensDSigma(2) = 6. * relativeStressNPlus1(2);

	dPhiTensDChi1t = 2. * dXiDChi1t(0) * (relativeStressNPlus1(0) + chi1t * stressTrial(0)) + 6. * dXiDChi1t(1) * relativeStressNPlus1(1) + 6. * dXiDChi1t(2) * relativeStressNPlus1(2) + pow(stressTrial(0), 2);

	dPhiTensDAlpha(0) = -2. * relativeStressNPlus1(0);
	dPhiTensDAlpha(1) = -6. * relativeStressNPlus1(1);
	dPhiTensDAlpha(2) = -6. * relativeStressNPlus1(2);

	dPhiTensDSigmaYield = -2 * yieldStressTot;

	d2PhiTensDSigma2Diag(0) = 2. * (1. + chi1t);
	d2PhiTensDSigma2Diag(1) = 6.;
	d2PhiTensDSigma2Diag(2) = 6.;

	d2PhiTensDSigmaDChi1t(0) = 2. * (dXiDChi1t(0) * (1. + chi1t) + stressTrial(0));

	d2PhiTensDSigmaDAlphaDiag(0) = -2.;
	d2PhiTensDSigmaDAlphaDiag(1) = -6.;
	d2PhiTensDSigmaDAlphaDiag(2) = -6.;

	B = 1. / (1. + 2 * consistParam_plRecov * dAlpha11TotDEpsiPb11 - dChi1tDEpsiPB11 * consistParam_plRecov * d2PhiTensDSigmaDChi1t(0));

	dEtaTangentdEpsiPb11 = calculateDEtaTangentdEpsiPb11();

	H(0) = -2. / dChi1tDEpsiPB11 * dAlpha11TotDEpsiPb11 + d2PhiTensDSigmaDChi1t(0);

	L = (dPhiTensDAlpha(0) * dAlpha11TotDEpsiPb11 + dPhiTensDSigmaYield * dSigmaYieldTotDEpsiPb11) / dChi1tDEpsiPB11 + dPhiTensDChi1t;

	F(0) = -consistParam_plRecov * H(0) + dEtaTangentdEpsiPb11 * 1. / dChi1tDEpsiPB11 * (strain_nPlus1(0) - strainPlasticTrial(0) - strainPostBucklingTrial(0));
	F(1) = dEtaTangentdEpsiPb11 * 1. / dChi1tDEpsiPB11 * (strain_nPlus1(1) - strainPlasticTrial(1) - strainPostBucklingTrial(1));
	F(2) = dEtaTangentdEpsiPb11 * 1. / dChi1tDEpsiPB11 * (strain_nPlus1(2) - strainPlasticTrial(2) - strainPostBucklingTrial(2));

	DPreFactor = 1. / (L * dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B);
	D(0) = DPreFactor * (dPhiTensDSigma(0) + L * dChi1tDEpsiPB11 * consistParam_plRecov * d2PhiTensDSigma2Diag(0) * B);
	D(1) = DPreFactor * (dPhiTensDSigma(1));
	D(2) = DPreFactor * (dPhiTensDSigma(2));

	CepTerm1(0, 0) = d2PhiTensDSigma2Diag(0) - dChi1tDEpsiPB11 * F(0) * d2PhiTensDSigma2Diag(0) * B;
	CepTerm1(1, 0) = -dChi1tDEpsiPB11 * F(1) * d2PhiTensDSigma2Diag(0) * B;
	CepTerm1(1, 1) = d2PhiTensDSigma2Diag(1);
	CepTerm1(2, 0) = -dChi1tDEpsiPB11 * F(2) * d2PhiTensDSigma2Diag(0) * B;
	CepTerm1(2, 2) = d2PhiTensDSigma2Diag(2);
	/*CepTerm2 = D * (dPhiCompDSigma + consistParam_postBuckling * A * dPhiCompDSigma(0));*/
	//opserr << "This is dPhiCompDSigma" << dPhiCompDSigma << endln;
	//opserr << "This is D" << D << endln;
	CepTerm2(0, 0) = D(0) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(0) - dPhiTensDSigma(0));
	CepTerm2(0, 1) = D(0) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(1) - dPhiTensDSigma(1));
	CepTerm2(0, 2) = D(0) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(2) - dPhiTensDSigma(2));
	CepTerm2(1, 0) = D(1) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(0) - dPhiTensDSigma(0));
	CepTerm2(1, 1) = D(1) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(1) - dPhiTensDSigma(1));
	CepTerm2(1, 2) = D(1) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(2) - dPhiTensDSigma(2));
	CepTerm2(2, 0) = D(2) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(0) - dPhiTensDSigma(0));
	CepTerm2(2, 1) = D(2) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(1) - dPhiTensDSigma(1));
	CepTerm2(2, 2) = D(2) * (dChi1tDEpsiPB11 * dPhiTensDSigma(0) * B * F(2) - dPhiTensDSigma(2));
	//opserr << "This is CepTerm2" << CepTerm2 << endln;

	I(0, 0) = I(1, 1) = I(2, 2) = 1.;
	CepTerm3 = I + elasticMatrix * (consistParam_plRecov * CepTerm1 + CepTerm2);
	//opserr << "This is CepTerm3" << CepTerm3 << endln;
	CepTerm3Inverse = matinv3(CepTerm3);
	stiffnessTrial.Zero();
	stiffnessTrial = elasticMatrix * CepTerm3Inverse;

	//Take the symmetric approximation
	stiffnessTrial.addMatrixTranspose(0.5, stiffnessTrial, 0.5);
	/*opserr << "This is tangentModulusPlRecovStage" << stiffnessTrial << endln;
	opserr << "This is strain vector:" << strainTrial << endln;*/

	return;
}

/* ----------------------------------------------------------------------------------------------------------------- */
void LocalBucklingWebPlate::calculateConsistentTangentModulusUVCRecov(Vector strain_nPlus1, double consistParam_plastic, double fBar,
	const Vector relativeStressNPlus1) {
	// Initialize the variables
	Matrix iD3 = Matrix(N_DIMS, N_DIMS);
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double isotropicModulus = 0.;
	Vector nHat = Vector(N_DIMS);
	double eK = 0.;
	double beta = 0.;
	Vector hPrime = Vector(N_DIMS);
	Matrix hOutN = Matrix(N_DIMS, N_DIMS);
	Matrix aMat = Matrix(N_DIMS, N_DIMS);
	Matrix xiTilde = Matrix(N_DIMS, N_DIMS);
	Matrix xiTildeA = Matrix(N_DIMS, N_DIMS);
	double theta_2 = 0.;
	Vector theta_1_intermVector = Vector(N_DIMS);
	double theta_1 = 0.;
	Matrix nOutN = Matrix(N_DIMS, N_DIMS);
	double etaTangent = 0.;
	std::vector<Vector> alpha12Tot_Vector;
	Vector F = Vector(N_DIMS);
	double dEtaTangentdEpsiPb11 = 0.;
	Matrix lambdappMat = Matrix(N_DIMS, N_DIMS);
	Vector theta_3 = Vector(N_DIMS);
	Vector theta_3_intermVector = Vector(N_DIMS);
	Matrix PMultXiTildeA = Matrix(N_DIMS, N_DIMS);
	Matrix FOutTheta3 = Matrix(3, 3);

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKConverged[i]); // Total backstress (P1+P2+Pb1+Pb2)
	}

	iD3.Zero(); // 3x3 indentity matrix
	iD3(0, 0) = iD3(1, 1) = iD3(2, 2) = 1.;
	lambdappMat.Zero();
	lambdappMat(0, 0) = 1.;

	// Isotropic hardening parameters
	yieldStressP = calculateYieldStressPlastic();
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	isotropicModulus = calculateIsotropicModulus();

	// Kinematic hardening related parameters
	nHat = relativeStressNPlus1 / fBar;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		beta += cK[i] / gammaK[i] * (1. - eK);
	}
	beta = 1. + beta / yieldStressTot;
	hPrime = -(beta - 1.) * isotropicModulus * relativeStressNPlus1 / yieldStressTot;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		eK = calculateEk(i);
		hPrime += cK[i] * eK / yieldStressTot * relativeStressNPlus1 - gammaK[i] * eK * alpha12Tot_Vector[i];
	}
	hPrime *= sqrt(2. / 3.);
	hOutN = hPrime % nHat;
	aMat = matinv3(beta * iD3 + consistParam_plastic * hOutN * PMat);

	dEtaTangentdEpsiPb11 = -calculateDEtaTangentdEpsiPb11();

	F = -1. * (iD3 + lambdappMat) * PMat * relativeStressNPlus1 + consistParam_plastic * (iD3 + lambdappMat) * PMat * fBar * aMat * hPrime + dEtaTangentdEpsiPb11 * 2. / 3. * relativeStressNPlus1(0) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);
	/*opserr << "This is F" << F << endln;*/

	xiTilde = matinv3(matinv3(elasticMatrix) + consistParam_plastic * (iD3 + lambdappMat) * PMat * aMat);
	xiTildeA = aMat * xiTilde;
	/*opserr << "This is xiTilde" << xiTilde << endln;
	opserr << "This is xiTildeA" << xiTildeA << endln;*/

	theta_2 = 1. - 2. / 3. * isotropicModulus * consistParam_plastic;
	theta_1_intermVector = PMat * aMat * (xiTilde * F - fBar * aMat * hPrime);
	/*opserr << "This is theta_1_intermVector" << theta_1_intermVector << endln;*/
	theta_1 = theta_2 * dotprod3(nHat, theta_1_intermVector) - 2. / 3. * fBar * isotropicModulus;
	//opserr << "This is theta_1" << theta_1 << endln;

	PMultXiTildeA = PMat * xiTildeA;
	theta_3_intermVector.Zero();
	theta_3_intermVector.addMatrixVector(0., PMultXiTildeA, nHat, 1.0);
	theta_3 = -theta_2 * theta_3_intermVector;
	//opserr << "This is theta_3" << theta_3 << endln;

	stiffnessTrial.Zero();
	FOutTheta3 = F % theta_3;
	stiffnessTrial = xiTilde * (iD3 + FOutTheta3 * 1. / theta_1);
	//opserr << "This is stiffnessTrial" << stiffnessTrial << endln;

	// Take the symmetric approximation
	stiffnessTrial.addMatrixTranspose(0.5, stiffnessTrial, 0.5);

	return;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v new total strain vector.
* @return 0 if successful, -1 if return mapping did not converge.
*/
int LocalBucklingWebPlate::setTrialStrain(const Vector& v) {

	int rm_convergence;
	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial = v;

	// Do the return mapping and calculate the tangent modulus
	rm_convergence = timeIntegration();

	return rm_convergence;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v new total strain vector
* @param v new strain rate vector - unused
* @return 0 if successful
*
* Note that this material model is rate independent.
*/
int LocalBucklingWebPlate::setTrialStrain(const Vector& v, const Vector& r) {

	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial = v;

	// Do the return mapping and calculate the tangent modulus
	timeIntegration();

	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v strain increment vector
* @return 0 if successful
*/
int LocalBucklingWebPlate::setTrialStrainIncr(const Vector& v) {

	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial += v;

	// Do the return mapping and calculate the tangent modulus
	timeIntegration();

	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v strain increment vector
* @param v strain rate vector - unused
* @return 0 if successful
*
* Note that this material model is rate independent.
*/
int LocalBucklingWebPlate::setTrialStrainIncr(const Vector& v, const Vector& r) {

	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial += v;

	// Do the return mapping and calculate the tangent modulus
	timeIntegration();

	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

const Vector& LocalBucklingWebPlate::getStrain() {

	return strainTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

const Vector& LocalBucklingWebPlate::getStress() {

	return stressTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

const Matrix& LocalBucklingWebPlate::getTangent() {

	return stiffnessTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::getYieldStress() {

	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	yieldStressP = calculateYieldStressPlastic();
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	return yieldStressTot;

}

/* ----------------------------------------------------------------------------------------------------------------- */

const Matrix& LocalBucklingWebPlate::getInitialTangent() {

	// todo: can make more efficient by changing this to elasticMatrix and removing stiffnessInitial as a variable
	return stiffnessInitial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::commitState() {
	strainConverged = strainTrial;
	strainPlasticConverged = strainPlasticTrial;
	strainPEqConverged = strainPEqTrial;
	strainPostBucklingConverged = strainPostBucklingTrial;
	strainPBEqConverged = strainPBEqTrial;
	stressConverged = stressTrial;
	alphaPKConverged = alphaPKTrial;
	alphaPBKConverged = alphaPBKTrial;
	stiffnessConverged = stiffnessTrial;
	sumEjConverged = sumEjTrial;
	c1cConverged = c1cTrial;

	b_1tConverged = b_1tTrial;
	sigmaPrBezierConverged = sigmaPrBezierTrial;
	sigmaYrBezierConverged = sigmaYrBezierTrial;
	epsilonPB11UnloadConverged = epsilonPB11UnloadTrial;
	backstressAfterCompressionConverged = backstressAfterCompressionTrial;
	epsilonPB11MinConverged = epsilonPB11MinTrial;
	alphaPrBezierConverged = alphaPrBezierTrial;
	alphaYrBezierConverged = alphaYrBezierTrial;
	kPrBezierConverged = kPrBezierTrial;
	kYrBezierConverged = kYrBezierTrial;
	rAlphaBackstress1Converged = rAlphaBackstress1Trial;
	rAlphaBackstress2Converged = rAlphaBackstress2Trial;
	c1cUnloadConverged = c1cUnloadTrial;
	ErcConverged = ErcTrial;
	sigmaCConverged = sigmaCTrial;
	yieldStressPBConverged = yieldStressPBTrial;
	sigmaYieldAfterCompressionConverged = sigmaYieldAfterCompressionTrial;
	backstress11TotAfterFullPLRecovConverged = backstress11TotAfterFullPLRecovTrial;
	sigmaYieldTotAfterFullPLRecovConverged = sigmaYieldTotAfterFullPLRecovTrial;
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::revertToLastCommit() {

	strainTrial = strainConverged;
	strainPlasticTrial = strainPlasticConverged;
	strainPEqTrial = strainPEqConverged;
	strainPostBucklingTrial = strainPostBucklingConverged;
	strainPBEqTrial = strainPBEqConverged;
	stressTrial = stressConverged;
	alphaPKTrial = alphaPKConverged;
	alphaPBKTrial = alphaPBKConverged;
	stiffnessTrial = stiffnessConverged;
	sumEjTrial = sumEjConverged;
	c1cTrial = c1cConverged;

	b_1tTrial = b_1tConverged;
	sigmaPrBezierTrial = sigmaPrBezierConverged;
	sigmaYrBezierTrial = sigmaYrBezierConverged;
	epsilonPB11UnloadTrial = epsilonPB11UnloadConverged;
	backstressAfterCompressionTrial = backstressAfterCompressionConverged;
	epsilonPB11MinTrial = epsilonPB11MinConverged;
	alphaPrBezierTrial = alphaPrBezierConverged;
	alphaYrBezierTrial = alphaYrBezierConverged;
	kPrBezierTrial = kPrBezierConverged;
	kYrBezierTrial = kYrBezierConverged;
	rAlphaBackstress1Trial = rAlphaBackstress1Converged;
	rAlphaBackstress2Trial = rAlphaBackstress2Converged;
	c1cUnloadTrial = c1cUnloadConverged;
	ErcTrial = ErcConverged;
	sigmaCTrial = sigmaCConverged;
	yieldStressPBTrial = yieldStressPBConverged;
	sigmaYieldAfterCompressionTrial = sigmaYieldAfterCompressionConverged;
	backstress11TotAfterFullPLRecovTrial = backstress11TotAfterFullPLRecovConverged;
	sigmaYieldTotAfterFullPLRecovTrial = sigmaYieldTotAfterFullPLRecovConverged;
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int LocalBucklingWebPlate::revertToBeforeCapping(bool cappingPoint) {
	if (cappingPoint == 0)
	{
		strainPlasticTrial = strainPlasticConverged;
		strainPEqTrial = strainPEqConverged;
		strainPostBucklingTrial = strainPostBucklingConverged;
		strainPBEqTrial = strainPBEqConverged;
		alphaPKTrial = alphaPKConverged;
		alphaPBKTrial = alphaPBKConverged;
		stiffnessTrial = stiffnessConverged;
		sumEjTrial = sumEjConverged;
		c1cTrial = c1cConverged;
	}
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int LocalBucklingWebPlate::revertToBeforeSwitchPlRecovUVC(bool switchPlRecovUVCPoint) {
	if (switchPlRecovUVCPoint == 0)
	{
		strainPlasticTrial = strainPlasticConverged;
		strainPEqTrial = strainPEqConverged;
		strainPostBucklingTrial = strainPostBucklingConverged;
		strainPBEqTrial = strainPBEqConverged;
		alphaPKTrial = alphaPKConverged;
		alphaPBKTrial = alphaPBKConverged;
		stiffnessTrial = stiffnessConverged;
		sumEjTrial = sumEjConverged;
		c1cTrial = c1cConverged;
		yieldStressPBTrial = yieldStressPBConverged;
	}
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int LocalBucklingWebPlate::revertToBeforeSwitchUVCRecovUVC(bool switchUVCRecovUVCPoint) {
	if (switchUVCRecovUVCPoint == 0)
	{
		strainPlasticTrial = strainPlasticConverged;
		strainPEqTrial = strainPEqConverged;
		strainPostBucklingTrial = strainPostBucklingConverged;
		strainPBEqTrial = strainPBEqConverged;
		alphaPKTrial = alphaPKConverged;
		alphaPBKTrial = alphaPBKConverged;
		stiffnessTrial = stiffnessConverged;
		sumEjTrial = sumEjConverged;
		c1cTrial = c1cConverged;
	}
	return 0;
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
	stressConverged.Zero();
	plasticLoading = false;
	stiffnessConverged.Zero();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKConverged[i].Zero();
		alphaPBKConverged[i].Zero();
	}
	sumEjConverged = 0.;
	c1cConverged = 0.;

	b_1tConverged = 0.;
	sigmaPrBezierConverged = 0.;
	sigmaYrBezierConverged = 0.;
	epsilonPB11UnloadConverged = 0.;
	backstressAfterCompressionConverged.Zero();
	epsilonPB11MinConverged = 0.;
	alphaPrBezierConverged = 0.;
	alphaYrBezierConverged = 0.;
	kPrBezierConverged = 0.;
	kYrBezierConverged = 0.;
	rAlphaBackstress1Converged = 0.;
	rAlphaBackstress2Converged = 0.;
	c1cUnloadConverged = 0.;
	ErcConverged = 0.;
	sigmaCConverged = 0.;
	yieldStressPBConverged = 0.;
	sigmaYieldAfterCompressionConverged = 0.;
	backstress11TotAfterFullPLRecovConverged = 0.;
	sigmaYieldTotAfterFullPLRecovConverged = 0.;

	revertToLastCommit();
	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
* Returns a new NDMaterial with all the internal values copied.
* @return a to pointer to the copy
*
* This is called by GenericSectionXD
*/
NDMaterial* LocalBucklingWebPlate::getCopy() {

	LocalBucklingWebPlate* theCopy;
	theCopy = new LocalBucklingWebPlate(this->getTag(), elasticModulus, poissonRatio,
		initialYield, qInf, bIso, dInf, aIso, cK, gammaK,
		bPlateWidth, tPlateThickness, sigmaC0Stress, alphaRegularization);

	// Copy all the internals
	theCopy->strainConverged = strainConverged;
	theCopy->strainTrial = strainTrial;
	theCopy->strainPlasticConverged = strainPlasticConverged;
	theCopy->strainPlasticTrial = strainPlasticTrial;
	theCopy->strainPEqConverged = strainPEqConverged;
	theCopy->strainPEqTrial = strainPEqTrial;
	theCopy->strainPostBucklingConverged = strainPostBucklingConverged;
	theCopy->strainPostBucklingTrial = strainPostBucklingTrial;
	theCopy->strainPBEqConverged = strainPBEqConverged;
	theCopy->strainPBEqTrial = strainPBEqTrial;
	theCopy->stressConverged = stressConverged;
	theCopy->stressTrial = stressTrial;
	theCopy->alphaPKConverged = alphaPKConverged;
	theCopy->alphaPKTrial = alphaPKTrial;
	theCopy->alphaPBKConverged = alphaPBKConverged;
	theCopy->alphaPBKTrial = alphaPBKTrial;
	theCopy->stiffnessConverged = stiffnessConverged;
	theCopy->stiffnessTrial = stiffnessTrial;
	theCopy->elasticLoading = elasticLoading;
	theCopy->plasticLoading = plasticLoading;
	theCopy->postBucklingLoading = postBucklingLoading;
	theCopy->sumEjConverged = sumEjConverged;
	theCopy->sumEjTrial = sumEjTrial;
	theCopy->c1cConverged = c1cConverged;
	theCopy->c1cTrial = c1cTrial;

	theCopy->b_1tConverged = b_1tConverged;
	theCopy->sigmaPrBezierConverged = sigmaPrBezierConverged;
	theCopy->sigmaYrBezierConverged = sigmaYrBezierConverged;
	theCopy->epsilonPB11UnloadConverged = epsilonPB11UnloadConverged;
	theCopy->backstressAfterCompressionConverged = backstressAfterCompressionConverged;
	theCopy->epsilonPB11MinConverged = epsilonPB11MinConverged;
	theCopy->alphaPrBezierConverged = alphaPrBezierConverged;
	theCopy->alphaYrBezierConverged = alphaYrBezierConverged;
	theCopy->kPrBezierConverged = kPrBezierConverged;
	theCopy->kYrBezierConverged = kYrBezierConverged;
	theCopy->rAlphaBackstress1Converged = rAlphaBackstress1Converged;
	theCopy->rAlphaBackstress2Converged = rAlphaBackstress2Converged;
	theCopy->c1cUnloadConverged = c1cUnloadConverged;
	theCopy->ErcConverged = ErcConverged;
	theCopy->sigmaCConverged = sigmaCConverged;
	theCopy->yieldStressPBConverged = yieldStressPBConverged;
	theCopy->sigmaYieldAfterCompressionConverged = sigmaYieldAfterCompressionConverged;
	theCopy->backstress11TotAfterFullPLRecovConverged = backstress11TotAfterFullPLRecovConverged;
	theCopy->sigmaYieldTotAfterFullPLRecovConverged = sigmaYieldTotAfterFullPLRecovConverged;

	theCopy->b_1tTrial = b_1tTrial;
	theCopy->sigmaPrBezierTrial = sigmaPrBezierTrial;
	theCopy->sigmaYrBezierTrial = sigmaYrBezierTrial;
	theCopy->epsilonPB11UnloadTrial = epsilonPB11UnloadTrial;
	theCopy->backstressAfterCompressionTrial = backstressAfterCompressionTrial;
	theCopy->epsilonPB11MinTrial = epsilonPB11MinTrial;
	theCopy->alphaPrBezierTrial = alphaPrBezierTrial;
	theCopy->alphaYrBezierTrial = alphaYrBezierTrial;
	theCopy->kPrBezierTrial = kPrBezierTrial;
	theCopy->kYrBezierTrial = kYrBezierTrial;
	theCopy->rAlphaBackstress1Trial = rAlphaBackstress1Trial;
	theCopy->rAlphaBackstress2Trial = rAlphaBackstress2Trial;
	theCopy->c1cUnloadTrial = c1cUnloadTrial;
	theCopy->ErcTrial = ErcTrial;
	theCopy->sigmaCTrial = sigmaCTrial;
	theCopy->yieldStressPBTrial = yieldStressPBTrial;
	theCopy->sigmaYieldAfterCompressionTrial = sigmaYieldAfterCompressionTrial;
	theCopy->backstress11TotAfterFullPLRecovTrial = backstress11TotAfterFullPLRecovTrial;
	theCopy->sigmaYieldTotAfterFullPLRecovTrial = sigmaYieldTotAfterFullPLRecovTrial;

	return theCopy;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
* Returns a new NDMaterial if the code matches the type specification.
* @param code the type specification of the material copy requested
* @return a to pointer to the copy
*
* This is called by the continuum elements.
*/
NDMaterial* LocalBucklingWebPlate::getCopy(const char* code) {
	if (strcmp(code, getType()) == 0) {
		LocalBucklingWebPlate* theCopy;
		theCopy = new LocalBucklingWebPlate(this->getTag(), elasticModulus, poissonRatio,
			initialYield, qInf, bIso, dInf, aIso, cK, gammaK,
			bPlateWidth, tPlateThickness, sigmaC0Stress, alphaRegularization);
		return theCopy;
	}
	else {
		// Throw an error if failed to make copy
		opserr << "LocalBucklingWebPlate::getCopy invalid NDMaterial type, expecting " << code << endln;
		return 0;
	}
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
* Not yet implemented for paralleliziation
* @param commitTag
* @param theChannel
* @return 0 if successful
*/
int LocalBucklingWebPlate::sendSelf(int commitTag, Channel& theChannel) {
	// Throw error to let the user know that paralleliziation not yet implemented
	opserr << "Fatal: Paralleliziation for LocalBucklingWebPlate is not implemented yet!" << endln;
	return -1;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
* Not yet implemented for paralleliziation
* @param commitTag
* @param theChannel
* @param theBroker
* @return 0 if successful
*/
int LocalBucklingWebPlate::recvSelf(int commitTag, Channel& theChannel,
	FEM_ObjectBroker& theBroker) {
	// Throw error to let the user know that paralleliziation not yet implemented
	opserr << "Fatal: Paralleliziation for LocalBucklingWebPlate is not implemented yet!" << endln;
	return -1;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param s the opensees output stream
* @param flag is 2 for standard output, 25000 for JSON output
(see OPS_Globals.h)
*/
void LocalBucklingWebPlate::Print(OPS_Stream& s, int flag) {

	// if (flag == OPS_PRINT_PRINTMODEL_MATERIAL) {
	if (flag == 2) {
		s << "LocalBucklingWebPlate tag: " << this->getTag() << endln;
		s << "   E: " << elasticModulus << " ";
		s << "  fy: " << initialYield << " ";
		s << "   Qinf: " << qInf << " ";
		s << "   b: " << bIso << " ";
		s << "   Dinf: " << dInf << " ";
		s << "   a: " << aIso << " ";
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			s << "  C" << (i + 1) << ": " << cK[i] << " ";
			s << "gam" << (i + 1) << ": " << gammaK[i] << " ";
		}
		s << "   bPlate: " << bPlateWidth << " ";
		s << "   tPlate: " << tPlateThickness << " ";
		s << "   sigmaC0: " << sigmaC0Stress << " ";
	}

	// if (flag == OPS_PRINT_PRINTMODEL_JSON) {
	if (flag == 25000) {
		s << "\t\t\t{";
		s << "\"name\": \"" << this->getTag() << "\", ";
		s << "\"type\": \"LocalBucklingWebPlate\", ";
		s << "\"E\": " << elasticModulus << ", ";
		s << "\"fy\": " << initialYield << ", ";
		s << "\"Qinf\": " << qInf << ", ";
		s << "\"b\": " << bIso << ", ";
		s << "\"Dinf\": " << dInf << ", ";
		s << "\"a\": " << aIso << ", ";
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			s << "\"C\": " << cK[i] << ", ";
			s << "\"gam\": " << gammaK[i] << ", ";
		}
		s << "\"bPlate\": " << bPlateWidth << ", ";
		s << "\"tPlate\": " << tPlateThickness << ", ";
		s << "\"sigmaC0\": " << sigmaC0Stress << ", ";
	}

}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateElasticStiffness() {
	double eDenom = elasticModulus / (2. + 2. * poissonRatio);
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
	qMat.Zero();
	qMat(0, 0) = 1.;
	qMat(1, 1) = 1.;
	qMat(2, 2) = 1.;
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
	lambdapp(0) = 1.;
	ppMat.Zero();
	ppMat(0, 0) = 1.;

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

double LocalBucklingWebPlate::calculateYieldStressPlastic() {
	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * strainPEqTrial));
	sigmaY2 = dInf * (1. - exp(-aIso * strainPEqTrial));
	return initialYield + sigmaY1 - sigmaY2;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateIsotropicModulus() {
	double IsotropicModulus = 0.0;

	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * strainPEqTrial));
	sigmaY2 = dInf * (1. - exp(-aIso * strainPEqTrial));
	IsotropicModulus = bIso * (qInf - sigmaY1) - aIso * (dInf - sigmaY2);

	//double IsotropicModulus=0.0;
	//IsotropicModulus = (qInf * bIso * exp(-bIso * strainPEqTrial)) - (dInf * aIso * exp(-aIso * strainPEqTrial));

	/*opserr << "This is qInf:" << qInf << endln;
	opserr << "This is bIso:" << bIso << endln;
	opserr << "This is dInf:" << qInf << endln;
	opserr << "This is aIso:" << bIso << endln;
	opserr << "This is term 1:" << (qInf * bIso * exp(-bIso * strainPEqTrial)) << endln;
	opserr << "This is term 2:" << (dInf * aIso * exp(-aIso * strainPEqTrial)) << endln;
	opserr << "This is IsotropicModulus K:" << IsotropicModulus << endln;*/

	return IsotropicModulus;
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

	/*chi1c = b_chi1c * pow((1.0 - sigmaSurSigmaY), 2);*/
	chi1c = b_chi1c * pow((1.0 - sigmaSurSigmaY), 2) + c1cTrial;

	return chi1c;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateSigmaSurSigmaY() {
	double sigmaSurSigmaY = 0.;
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;
	double strainPB11TrialRegularized = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2. * tan(alphaAngle));

	strainPB11TrialRegularized = abs(strainPostBucklingTrial(0)) * alphaRegularization;

	//// Method 1
	//double p4eq = 0., q4eq = 0.;
	//double Delta0eq = 0.;
	//double Delta1eq = 0.;

	//// Check if strainPBEqTrial is equal to 0 
	//if (abs(strainPostBucklingTrial(0)) < 1e-10) { // if equal to 0 --> sigmaSurSigmaY=1
	//	sigmaSurSigmaY = 1.;
	//}
	//else {
	/*AHat = (2. * pow(tPlateThickness, 2) * (1. - strainPB11TrialRegularized)) / (sin(2. * alphaAngle) * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
	BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - 2. * cPlate)) / (bPlateWidth * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
	CHat = (tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2. * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2))), 2)) - bPlateWidth * tPlateThickness);*/

	//	DHat = -pow((BHat), 2);
	//	EHat = 2. * BHat * CHat;
	//	FHat = -pow((AHat), 2) + 2. * pow((BHat), 2) - pow(CHat, 2);
	//	GHat = -2. * BHat * CHat;
	//	HHat = pow(AHat, 2) - pow(BHat, 2);

	//	p4eq = (8. * DHat * FHat - 3. * pow(EHat, 2)) / (8. * pow(DHat, 2));
	//	q4eq = (pow(EHat, 3) - 4. * DHat * EHat * FHat + 8. * pow(DHat, 2) * GHat) / (8. * pow(DHat, 3));

	//	Delta0eq = pow(FHat, 2) - 3. * EHat * GHat + 12. * DHat * HHat;
	//	Delta1eq = 2. * pow(FHat, 3) - 9. * EHat * FHat * GHat + 27. * pow(EHat, 2) * HHat + 27. * DHat * pow(GHat, 2) - 72. * DHat * FHat * HHat;

	//	std::complex<double> Delta0eqComplex(Delta0eq, 0.);
	//	std::complex<double> Delta1eqComplex(Delta1eq, 0.);
	//	std::complex<double> fourComplex(4., 0.);
	//	std::complex<double> twoComplex(2., 0.);
	//	std::complex<double> Q4eq = pow(((Delta1eqComplex + sqrt(pow(Delta1eqComplex, 2) - fourComplex * pow(Delta0eqComplex, 3))) / twoComplex), 1.0 / 3.0);

	//	std::complex<double> oneDivTwoComplex(0.5, 0.);
	//	std::complex<double> twoDivThreeComplex(2.0 / 3.0, 0.);
	//	std::complex<double> oneComplex(1., 0.);
	//	std::complex<double> threeComplex(3., 0.);
	//	std::complex<double> p4eqComplex(p4eq, 0.);
	//	std::complex<double> DHatComplex(DHat, 0.);
	//	std::complex<double> q4eqComplex(q4eq, 0.);
	//	std::complex<double> S4eq = oneDivTwoComplex * sqrt(-twoDivThreeComplex * p4eqComplex + oneComplex / (threeComplex * DHatComplex) * (Q4eq + Delta0eqComplex / Q4eq));

	//	std::complex<double> EHatComplex(EHat, 0.);
	//	std::complex<double> sol4eq3 = -EHatComplex / (fourComplex * DHatComplex) + S4eq + oneDivTwoComplex * sqrt(-fourComplex * pow(S4eq, 2) - twoComplex * p4eqComplex - q4eqComplex / S4eq);

	//	sigmaSurSigmaY = real(sol4eq3);
	//}


	// Method 2
	double alpha = 0.;
	double beta = 0.;
	double gamma = 0.;
	double P = 0.;
	double Q = 0.;
	double R = 0.;
	double U = 0.;
	double y = 0.;
	double W = 0.;
	//double sol4eq1_V02 = 0.;

	// Check if strainPBEqTrial is equal to 0 
	if (abs(strainPostBucklingTrial(0)) < 1e-10) { // if equal to 0 --> sigmaSurSigmaY=1
		sigmaSurSigmaY = 1.;
	}
	else {
		AHat = (2. * pow(tPlateThickness, 2) * (1. - strainPB11TrialRegularized)) / (sin(2. * alphaAngle) * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
		BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - 2. * cPlate)) / (bPlateWidth * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
		CHat = (tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2. * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2))), 2)) - bPlateWidth * tPlateThickness);

		DHat = -pow((BHat), 2);
		EHat = 2. * BHat * CHat;
		FHat = -pow((AHat), 2) + 2. * pow((BHat), 2) - pow(CHat, 2);
		GHat = -2. * BHat * CHat;
		HHat = pow(AHat, 2) - pow(BHat, 2);

		alpha = -3. * pow(EHat, 2) / (8. * pow(DHat, 2)) + FHat / DHat;
		beta = pow(EHat, 3) / (8. * pow(DHat, 3)) - (EHat * FHat) / (2. * pow(DHat, 2)) + GHat / DHat;
		gamma = -3. * pow(EHat, 4) / (256. * pow(DHat, 4)) + (pow(EHat, 2) * FHat) / (16. * pow(DHat, 3)) - (EHat * GHat) / (4. * pow(DHat, 2)) + HHat / DHat;

		P = -pow(alpha, 2) / 12. - gamma;
		Q = -pow(alpha, 3) / 108. + alpha * gamma / 3 - pow(beta, 2) / 8.;
		R = -Q / 2. + sqrt(pow(Q, 2) / 4. + pow(P, 3) / 27.);
		U = pow(R, (1. / 3.));

		if (U == 0.)
		{
			y = -5. / 6. * alpha - pow(Q, (1. / 3.));
		}
		else
		{
			y = -5. / 6. * alpha + U - P / (3. * U);
		}
		W = sqrt(alpha + 2. * y);

		sigmaSurSigmaY = -EHat / (4. * DHat) + (+W + sqrt(-(3. * alpha + 2. * y + 2. * beta / W))) / 2.;
	}



	return sigmaSurSigmaY;

}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateDSigmaSurSigmaYdEpsilonPB11() {
	double dSigmaSurSigmaYdEpsilonPBeq = 0.;
	double hStep = 1e-10;
	double alphaAngle = 0.;
	double cPlate = 0.;

	// Transform epsilonPBeq from double to complex number
	std::complex<double> epsilonPB11Regularized(alphaRegularization * abs(strainPostBucklingTrial(0)), alphaRegularization * hStep);

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2 * tan(alphaAngle));

	std::complex<double> oneDivTwoComplex(0.5, 0);
	//std::complex<double> twoDivThreeComplex(2.0 / 3.0, 0);
	std::complex<double> fiveDivSixComplex(5.0 / 6.0, 0);
	std::complex<double> oneComplex(1, 0);
	std::complex<double> twoComplex(2, 0);
	std::complex<double> threeComplex(3, 0);
	std::complex<double> fourComplex(4, 0);
	std::complex<double> eightComplex(8, 0);
	//std::complex<double> nineComplex(9, 0);
	std::complex<double> twelveComplex(12, 0);
	std::complex<double> sixteenComplex(16, 0);
	std::complex<double> twentySevenComplex(27, 0);
	//std::complex<double> seventyTwoComplex(72, 0);
	std::complex<double> oneZeroEightComplex(108, 0);
	std::complex<double> twoFiveSixComplex(256, 0);
	std::complex<double> tPlateComplex(tPlateThickness, 0);
	std::complex<double> bPlateComplex(bPlateWidth, 0);
	std::complex<double> cPlateComplex(cPlate, 0);
	std::complex<double> sinTwoAlphaComplex(sin(2 * alphaAngle), 0);

	std::complex<double> AHat = (twoComplex * pow(tPlateComplex, 2) * (oneComplex - epsilonPB11Regularized)) / (sinTwoAlphaComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2)));
	std::complex<double> BHat = (pow(tPlateComplex, 2) * (bPlateComplex - twoComplex * cPlateComplex)) / (bPlateComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2)));
	std::complex<double> CHat = (tPlateComplex * sqrt(pow(cPlateComplex, 2) + pow((bPlateComplex / twoComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2))), 2)) - bPlateComplex * tPlateComplex);

	std::complex<double> DHat = -pow((BHat), 2);
	std::complex<double> EHat = twoComplex * BHat * CHat;
	std::complex<double> FHat = -pow((AHat), 2) + twoComplex * pow((BHat), 2) - pow(CHat, 2);
	std::complex<double> GHat = -twoComplex * BHat * CHat;
	std::complex<double> HHat = pow(AHat, 2) - pow(BHat, 2);


	//// Method 01
	//std::complex<double> p4eq = (eightComplex * DHat * FHat - threeComplex * pow(EHat, 2)) / (eightComplex * pow(DHat, 2));
	//std::complex<double> q4eq = (pow(EHat, 3) - fourComplex * DHat * EHat * FHat + eightComplex * pow(DHat, 2) * GHat) / (eightComplex * pow(DHat, 3));

	//std::complex<double> Delta0eq = pow(FHat, 2) - threeComplex * EHat * GHat + twelveComplex * DHat * HHat;
	//std::complex<double> Delta1eq = twoComplex * pow(FHat, 3) - nineComplex * EHat * FHat * GHat + twentySevenComplex * pow(EHat, 2) * HHat + twentySevenComplex * DHat * pow(GHat, 2) - seventyTwoComplex * DHat * FHat * HHat;

	//std::complex<double> Q4eq = pow(((Delta1eq + sqrt(pow(Delta1eq, 2) - fourComplex * pow(Delta0eq, 3))) / twoComplex), 1.0 / 3.0);
	//std::complex<double> S4eq = oneDivTwoComplex * sqrt(-twoDivThreeComplex * p4eq + oneComplex / (threeComplex * DHat) * (Q4eq + Delta0eq / Q4eq));

	//std::complex<double> sol4eq3 = -EHat / (fourComplex * DHat) + S4eq + oneDivTwoComplex * sqrt(-fourComplex * pow(S4eq, 2) - twoComplex * p4eq - q4eq / S4eq);

	//dSigmaSurSigmaYdEpsilonPBeq = imag(sol4eq3) / hStep;


	// Method 02
	std::complex<double> alpha = -threeComplex * pow(EHat, 2) / (eightComplex * pow(DHat, 2)) + FHat / DHat;
	std::complex<double> beta = pow(EHat, 3) / (eightComplex * pow(DHat, 3)) - (EHat * FHat) / (twoComplex * pow(DHat, 2)) + GHat / DHat;
	std::complex<double> gamma = -threeComplex * pow(EHat, 4) / (twoFiveSixComplex * pow(DHat, 4)) + (pow(EHat, 2) * FHat) / (sixteenComplex * pow(DHat, 3)) - (EHat * GHat) / (fourComplex * pow(DHat, 2)) + HHat / DHat;

	std::complex<double> P = -pow(alpha, 2) / twelveComplex - gamma;
	std::complex<double> Q = -pow(alpha, 3) / oneZeroEightComplex + alpha * gamma / threeComplex - pow(beta, 2) / eightComplex;
	std::complex<double> R = -Q / twoComplex + sqrt(pow(Q, 2) / fourComplex + pow(P, 3) / twentySevenComplex);
	std::complex<double>U = pow(R, (1. / 3.));

	std::complex<double> y(0, 0);
	if (U == 0.)
	{
		y = -fiveDivSixComplex * alpha - pow(Q, (1. / 3.));
	}
	else
	{
		y = -fiveDivSixComplex * alpha + U - P / (threeComplex * U);
	}
	std::complex<double>W = sqrt(alpha + twoComplex * y);

	std::complex<double> sol4eq1_V02 = -EHat / (fourComplex * DHat) + (+W + sqrt(-(threeComplex * alpha + twoComplex * y + twoComplex * beta / W))) / twoComplex;

	dSigmaSurSigmaYdEpsilonPBeq = imag(sol4eq1_V02) / hStep;

	return dSigmaSurSigmaYdEpsilonPBeq;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::initializeBChi1c() {
	b_chi1c = (pow(sigmaC0Stress, 2)) / ((pow(sigmaC0Stress, 2) - pow(sigmaDMStress, 2)) * pow(alpha_chi1c, 2));
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateEtaTangentReduce() {
	double etaTangent = 0.;

	double epsiPb11_min = pow(1. / beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), -beta2RegressionEuSurEl), 1 / beta3RegressionEuSurEl);

	/*if (abs(strainPostBucklingTrial(0))<=epsiPb11_min)
	{
		etaTangent = 1;
	}
	else
	{
		etaTangent = beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionEuSurEl);
	}*/

	// Try to solve oscillation trap
	double bound4Smoothin = 50. / 100. * abs(epsiPb11_min);

	double a1XTilda = 1.;
	double a2XTilda = beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionEuSurEl);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) - epsiPb11_min + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + epsiPb11_min + bound4Smoothin) / (2. * bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*double etaTangentIntermed = gXTilda * a2XTilda + (1. - gXTilda) * a1XTilda;*/
	double etaTangentIntermed = gXTilda * a1XTilda + (1. - gXTilda) * a2XTilda;
	etaTangent = std::min(1., etaTangentIntermed);

	return etaTangent;
}

/* ----------------------------------------------------------------------------------------------------------------- */

Vector LocalBucklingWebPlate::calculateDCdLambdaPB(double etaTangent, double dPhiCompdXiVector11) {
	Vector dCdLambdaPB = Vector(N_DIMS);
	dCdLambdaPB.Zero();
	double dEtaTangentdEpsiPb11 = 0.;

	double epsiPb11_min = pow(1. / beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), -beta2RegressionEuSurEl), 1 / beta3RegressionEuSurEl);

	/*if (abs(strainPostBucklingTrial(0)) <= epsiPb11_min)
	{
		dEtaTangentdEpsiPb11 = 0.;
	}
	else
	{
		dEtaTangentdEpsiPb11 = beta3RegressionEuSurEl * beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(strainPostBucklingTrial(0)), (beta3RegressionEuSurEl - 1.));
	}*/
	dEtaTangentdEpsiPb11 = calculateDEtaTangentdEpsiPb11();

	dCdLambdaPB(0) = 1. / pow(etaTangent, 2) * dPhiCompdXiVector11 * dEtaTangentdEpsiPb11 * 1 / elasticMatrix(0, 0);
	dCdLambdaPB(1) = 1. / pow(etaTangent, 2) * dPhiCompdXiVector11 * dEtaTangentdEpsiPb11 * 1 / elasticMatrix(1, 1);
	dCdLambdaPB(2) = 1. / pow(etaTangent, 2) * dPhiCompdXiVector11 * dEtaTangentdEpsiPb11 * 1 / elasticMatrix(2, 2);

	return dCdLambdaPB;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateDEtaTangentdEpsiPb11() {
	double dEtaTangentdEpsiPb11 = 0.;

	double epsiPb11_min = pow(1. / beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), -beta2RegressionEuSurEl), 1 / beta3RegressionEuSurEl);

	/*if (abs(strainPostBucklingTrial(0)) <= epsiPb11_min)
	{
		dEtaTangentdEpsiPb11 = 0.;
	}
	else
	{
		dEtaTangentdEpsiPb11 = beta3RegressionEuSurEl * beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(strainPostBucklingTrial(0)), (beta3RegressionEuSurEl - 1.));
	}*/

	// Try to solve oscillation trap
	double bound4Smoothin = 50. / 100. * abs(epsiPb11_min);
	double a2XTilda = beta3RegressionEuSurEl * beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(strainPostBucklingTrial(0)), (beta3RegressionEuSurEl - 1.));

	/*double xTilda = (abs(strainPostBucklingTrial(0)) - epsiPb11_min + bound4Smoothin) / (2 * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + epsiPb11_min + bound4Smoothin) / (2 * bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	double ans = 1. - xTilda;
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1 / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*dEtaTangentdEpsiPb11 = gXTilda * a2XTilda;*/
	dEtaTangentdEpsiPb11 = (1. - gXTilda) * a2XTilda;

	return dEtaTangentdEpsiPb11;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateC1c(double yieldStress, Vector alphaTot) {
	/*c1c = (pow(yieldStress, 2) - pow((-sigmaC0Stress - alphaTot11), 2)) / pow((-sigmaC0Stress), 2);*/
	//c1c = (pow(yieldStress, 2) - pow((-sigmaC - alphaTot11), 2)) / pow((-sigmaC), 2);

	//double stressTol = elasticMatrix(0,0)* SMALL_NUMBER; // Additional stress component due to tolerance
	//double stress4C1c = -sigmaC + stressTol;
	//c1cTrial = (pow(yieldStress, 2) - pow((-stress4C1c - alphaTot11), 2)) / pow((-stress4C1c), 2);

	//double stressTol = elasticMatrix(0,0)* SMALL_NUMBER; // Additional stress component due to tolerance
	//double stress4C1c = stressTrial(0) + stressTol;
	//c1cTrial = (pow(yieldStress, 2) - pow((-sigmaC + stressTol), 2)) / pow(stress4C1c, 2);

	double stressTol = elasticMatrix(0, 0) * SMALL_NUMBER; // Additional stress component due to tolerance
	//double stressTol = 0.; // Additional stress component due to tolerance
	double sigma11UpdatedTol = stressTrial(0) + stressTol;
	Vector xiTrial = (stressTrial + pVect * stressTol) - alphaTot;
	double xiVonMisesSquared = 3. / 2. * (2. / 3. * pow(xiTrial(0), 2) + 2. * pow(xiTrial(1), 2) + 2. * pow(xiTrial(2), 2));

	double chi_1c = (pow(yieldStress, 2) - xiVonMisesSquared) / pow(sigma11UpdatedTol, 2);

	//c1cTrial = (pow(yieldStress, 2) - xiVonMisesSquared) / pow(sigma11UpdatedTol, 2);

	double sigmaSurSigmaY = calculateSigmaSurSigmaY();
	double sigmaSurSigmaYTerm = b_chi1c * pow((1. - sigmaSurSigmaY), 2);
	c1cTrial = chi_1c - sigmaSurSigmaYTerm;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::setTensileEllipsoidYieldSurf(double yieldStressTot, Vector alphaTot, double targetStress4PLRecov) {
	double sigmaPr_regression = 0.;
	double scaleFactorBezierStress = 0.;

	//Determine the stress at wich would reach Von-Mises yield surface
	scaleFactorBezierStress = 2 * yieldStressTot - (yieldStressTot - alphaTot(0));

	// Set quantities for Bezier curve
	alphaPrBezierTrial = beta1RegressionAlphaPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionAlphaPrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionAlphaPrBezier);
	alphaYrBezierTrial = beta1RegressionAlphaYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionAlphaYrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionAlphaYrBezier);
	sigmaYrBezierTrial = beta1RegressionSigmaYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionSigmaYrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionSigmaYrBezier);
	kPrBezierTrial = beta1RegressionKPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKPrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionKPrBezier) * sigmaYrBezierTrial;
	kYrBezierTrial = beta1RegressionKYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKYrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionKYrBezier) * sigmaYrBezierTrial;

	// Determine different stresses sigmaPr
	sigmaPr_regression = beta1RegressionSigmaPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionSigmaPrBezier) * pow(abs(strainPostBucklingTrial(0)), beta3RegressionSigmaPrBezier);
	sigmaPrBezierTrial = std::min(scaleFactorBezierStress, sigmaPr_regression * sigmaYrBezierTrial);

	// Determine epsiPb11Min
	//epsilonPB11MinTrial = -pow((1. / sigmaYrBezierTrial * scaleFactorBezierStress * 1. / beta1RegressionSigmaPrBezier * pow((bPlateWidth / tPlateThickness), -beta2RegressionSigmaPrBezier)), (1. / beta3RegressionSigmaPrBezier));
	epsilonPB11MinTrial = -pow((scaleFactorBezierStress * 1. / (beta1RegressionSigmaPrBezier * beta1RegressionSigmaYrBezier) * pow((bPlateWidth / tPlateThickness), -(beta2RegressionSigmaPrBezier + beta2RegressionSigmaYrBezier))),
		1. / (beta3RegressionSigmaPrBezier + beta3RegressionSigmaYrBezier));

	// Compute b_1t
	if (strainPostBucklingTrial(0) < epsilonPB11MinTrial)
	{
		b_1tTrial = (pow(yieldStressTot, 2) - pow((sigmaPrBezierTrial - alphaTot(0)), 2)) / pow(sigmaPrBezierTrial, 2);
	}
	else
	{
		b_1tTrial = 0.;
	}

	// Set epsilonPb11Unload
	epsilonPB11UnloadTrial = strainPostBucklingTrial(0);

	// Compute yield surface center and radius after compression stage
	backstressAfterCompressionTrial = alphaTot;
	sigmaYieldAfterCompressionTrial = yieldStressTot;

	// Compute yield surface center and radius after full plastic recovery stage
	/*backstress11TotAfterFullPLRecovTrial = 0.5 * (sigmaYrBezierTrial + (-targetStress4PLRecov));
	sigmaYieldTotAfterFullPLRecovTrial = 0.5 * (sigmaYrBezierTrial - (-targetStress4PLRecov));*/
	sigmaYieldTotAfterFullPLRecovTrial = std::max(initialYield, 0.5 * (sigmaYrBezierTrial - (-targetStress4PLRecov)));
	backstress11TotAfterFullPLRecovTrial = sigmaYrBezierTrial - sigmaYieldTotAfterFullPLRecovTrial;

	//Compute ratios for backstress update during plastic recovery stage
	calculateRatioAlphaBackstress();

	// Set c1cUnload
	c1cUnloadTrial = c1cTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateChi1t(double yieldStressTot, double alphaTot11) {
	double chi1t = 0.;
	double f1t = 0.;

	f1t = calculateF1t(yieldStressTot, alphaTot11);

	chi1t = b_1tTrial * (1. - f1t);

	return chi1t;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateF1t(double yieldStressTot, double alphaTot11) {
	double f1t = 0.;
	double tBezier = 0.;
	double sigmaBezier = 0.;

	if (b_1tTrial > 0.) // tensile yield surface is ellipsoid
	{
		tBezier = calculateTBezier();
		sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;

		//f1t = 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - alphaTot11), 2)) / (b_1tTrial * pow(sigmaBezier, 2));
		f1t = std::min(1., 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - alphaTot11), 2)) / (b_1tTrial * pow(sigmaBezier, 2)));
	}
	else // tensile yield surface is Von-Mises cylinder
	{
		f1t = 0.;
	}

	// Update f1t if no post-buckling strain
	if (abs(strainPostBucklingTrial(0)) < SMALL_NUMBER)
	{
		f1t = 1.; // I do this because during tensile hardening stage alphaTot11 and yieldStress change --> f1t not equal 1
	}

	return f1t;

	/*if (f1t > 1) {
		int testError = 1;
	}*/
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::calculateTBezier() {
	double tBezier = 0;

	std::complex<double> oneComplex(1., 0);
	std::complex<double> twoComplex(2., 0);
	std::complex<double> threeComplex(3., 0);
	std::complex<double> fourComplex(4., 0);
	std::complex<double> sixComplex(6., 0);
	std::complex<double> nineComplex(9., 0);
	std::complex<double> twentySevenComplex(27., 0);

	std::complex<double> a = threeComplex * alphaPrBezierTrial - threeComplex * alphaYrBezierTrial + twoComplex * abs(epsilonPB11UnloadTrial);
	std::complex<double> b = -sixComplex * alphaPrBezierTrial + threeComplex * alphaYrBezierTrial - threeComplex * abs(epsilonPB11UnloadTrial);
	std::complex<double> c = threeComplex * alphaPrBezierTrial;
	std::complex<double> d = abs(epsilonPB11UnloadTrial) - abs(strainPostBucklingTrial(0));

	std::complex<double> Delta0 = pow(b, 2.) - threeComplex * a * c;
	std::complex<double> Delta1 = twoComplex * pow(b, 3.) - nineComplex * a * b * c + twentySevenComplex * pow(a, 2) * d;
	std::complex<double> Delta2 = pow(((Delta1 + sqrt(pow(Delta1, 2) - fourComplex * pow(Delta0, 3))) / 2.), (1. / 3.));

	std::complex<double> xiCubic = ((-oneComplex) + sqrt(-threeComplex)) / twoComplex;

	std::complex<double> x1SolCubic = -oneComplex / (threeComplex * a) * (b + pow(xiCubic, 0) * Delta2 + Delta0 / (pow(xiCubic, 0) * Delta2));
	std::complex<double> x2SolCubic = -oneComplex / (threeComplex * a) * (b + pow(xiCubic, 1) * Delta2 + Delta0 / (pow(xiCubic, 1) * Delta2));
	std::complex<double> x3SolCubic = -oneComplex / (threeComplex * a) * (b + pow(xiCubic, 2) * Delta2 + Delta0 / (pow(xiCubic, 2) * Delta2));

	if (imag(x1SolCubic) <= SMALL_NUMBER && real(x1SolCubic) >= 0. - SMALL_NUMBER && real(x1SolCubic) <= 1. + SMALL_NUMBER) {
		tBezier = real(x1SolCubic);
	}
	else if (imag(x2SolCubic) <= SMALL_NUMBER && real(x2SolCubic) >= 0. - SMALL_NUMBER && real(x2SolCubic) <= 1. + SMALL_NUMBER) {
		tBezier = real(x2SolCubic);
	}
	else if (imag(x3SolCubic) <= SMALL_NUMBER && real(x3SolCubic) >= 0. - SMALL_NUMBER && real(x3SolCubic) <= 1. + SMALL_NUMBER) {
		tBezier = real(x3SolCubic);
	}

	if (abs(strainPostBucklingTrial(0)) > abs(epsilonPB11UnloadTrial))
	{
		tBezier = 0.;
	}

	return tBezier;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::calculateRatioAlphaBackstress() {
	double dSigmaBezierDEpsiPb11 = 0.;
	double backstressPb11_endPlRecovStage = 0.; // total backstress component at end of plastic recovery stage
	Vector backstressP1 = Vector(N_DIMS);
	Vector backstressP2 = Vector(N_DIMS);
	Vector backstressP = Vector(N_DIMS); // vector of plastic backstress alphaP1 + alphaP2 at time when computing
	double theta1 = 0.;
	double KPrime = 0.;
	double hPrime11 = 0.;
	double kYr = 0.;

	// Compute tangent Bezier curve
	kYr = beta1RegressionKYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKYrBezier) * pow(abs(epsilonPB11UnloadTrial), beta3RegressionKYrBezier);
	dSigmaBezierDEpsiPb11 = -kYr * sigmaYrBezierTrial;

	// Compute variables for UVC tangent
	backstressP1 = alphaPKConverged[0];
	backstressP2 = alphaPKConverged[1];
	backstressP = backstressP1 + backstressP2;
	backstressPb11_endPlRecovStage = backstress11TotAfterFullPLRecovTrial - backstressP(0);

	theta1 = 2. * elasticModulus / 3. * 1. / (1. - 1. / elasticModulus * dSigmaBezierDEpsiPb11);
	KPrime = qInf * bIso * exp(-bIso * strainPEqConverged) - dInf * aIso * exp(-aIso * strainPEqConverged);
	hPrime11 = sqrt(3. / 2.) * theta1 - sqrt(2. / 3.) * (KPrime + elasticModulus);

	// Compute ratios for update of post-buckling backstress during plastic recovery stage
	rAlphaBackstress1Trial = 1 / (backstressPb11_endPlRecovStage * (gammaK[0] - gammaK[1])) * (cK[0] + cK[1] - gammaK[0] * backstressP1(0) - gammaK[1] * backstressP2(0) - gammaK[1] * backstressPb11_endPlRecovStage - sqrt(3. / 2.) * hPrime11);
	rAlphaBackstress2Trial = 1. - rAlphaBackstress1Trial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::initializeErc() {
	ErcConverged = beta1RegressionErc * pow(bPlateWidth / tPlateThickness, beta2RegressionErc);

	sigmaCConverged = sigmaC0Stress;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void LocalBucklingWebPlate::computeSigmaCDegradation() {
	double betaDegradationParam = 0.;

	betaDegradationParam = sumEjTrial / ErcTrial;
	sigmaCTrial = (1 - betaDegradationParam) * sigmaC0Stress;
}

/* ----------------------------------------------------------------------------------------------------------------- */
Vector LocalBucklingWebPlate::computeBackstressTotPlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = backstress11TotAfterFullPLRecovTrial;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (backstressAfterCompressionTrial(0) - backstress11TotAfterFullPLRecovTrial) * strainPostBucklingTrial(0) + backstress11TotAfterFullPLRecovTrial;

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	Vector alphaP = alphaPBKTrial[0] + alphaPBKTrial[1];
	/*double alpha11Pb_nPlus1 = gXTilda * a2XTilda + (1. - gXTilda) * a1XTilda - alphaP(0);*/
	double alpha11Pb_nPlus1 = gXTilda * a1XTilda + (1. - gXTilda) * a2XTilda - alphaP(0);
	Vector alphaPb_nPlus1 = Vector(N_DIMS);
	alphaPb_nPlus1(0) = alpha11Pb_nPlus1;
	Vector BackstressTot = alphaP + alphaPb_nPlus1;

	return BackstressTot;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double LocalBucklingWebPlate::computeYieldStressTotPlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = sigmaYieldTotAfterFullPLRecovTrial;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (sigmaYieldAfterCompressionTrial - sigmaYieldTotAfterFullPLRecovTrial) * strainPostBucklingTrial(0) + sigmaYieldTotAfterFullPLRecovTrial;

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*double yieldStressTot = gXTilda * a2XTilda + (1 - gXTilda) * a1XTilda;*/
	double yieldStressTot = gXTilda * a1XTilda + (1 - gXTilda) * a2XTilda;

	return yieldStressTot;
}

/* ----------------------------------------------------------------------------------------------------------------- */
double LocalBucklingWebPlate::computeDAlpha11TotDEpsiPb11PlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (backstressAfterCompressionTrial(0) - backstress11TotAfterFullPLRecovTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*double dAlpha11TotDEpsiPb11 = gXTilda * a2XTilda + (1. - gXTilda) * a1XTilda;*/
	double dAlpha11TotDEpsiPb11 = gXTilda * a1XTilda + (1. - gXTilda) * a2XTilda;

	return dAlpha11TotDEpsiPb11;
}

/* ----------------------------------------------------------------------------------------------------------------- */
double LocalBucklingWebPlate::computeDSigmaYieldTotDEpsiPb11PlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (sigmaYieldAfterCompressionTrial - sigmaYieldTotAfterFullPLRecovTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*double dSigmaYieldTotDEpsiPb11 = gXTilda * a2XTilda + (1 - gXTilda) * a1XTilda;*/
	double dSigmaYieldTotDEpsiPb11 = gXTilda * a1XTilda + (1 - gXTilda) * a2XTilda;

	return dSigmaYieldTotDEpsiPb11;
}

/* ----------------------------------------------------------------------------------------------------------------- */
void LocalBucklingWebPlate::computeReduceC1cLinearEvol() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = c1cUnloadTrial * (strainPostBucklingTrial(0) / epsilonPB11UnloadTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (strainPostBucklingTrial(0) + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
	double fXTilda = 0.;
	double f1MinusXTilda = 0.;
	if (xTilda > 0.)
	{
		fXTilda = exp(-1. / xTilda);
	}
	if (1. - xTilda > 0.)
	{
		f1MinusXTilda = exp(-1. / (1. - xTilda));
	}
	double gXTilda = fXTilda / (fXTilda + f1MinusXTilda);

	/*c1cTrial = gXTilda * a2XTilda + (1 - gXTilda) * a1XTilda;*/
	c1cTrial = gXTilda * a1XTilda + (1 - gXTilda) * a2XTilda;

	double test = 0.;

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
