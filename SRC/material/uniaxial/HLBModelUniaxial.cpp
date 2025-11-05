// 
// Created by Diego Heredia on 10.02.2025
// Version  11/03/2025
//

#include "HLBModelUniaxial.h"

#include <cmath>
#include <iostream>
#include <complex>

#include <elementAPI.h>
#include <Channel.h>
#include <Information.h>
#include <Parameter.h>

#include <elementAPI.h>
#include <OPS_Globals.h>

static int numHLBModelUniaxial = 0;


void* OPS_HLBModelUniaxial(void) {
	if (numHLBModelUniaxial == 0) {
		opserr << "Using the HLBModelUniaxial material" << endln;
		numHLBModelUniaxial++;
	}
	UniaxialMaterial* theMaterial = 0;

	double numData = OPS_GetNumRemainingInputArgs();

	// Parameters for parsing
	const unsigned int N_TAGS = 1;
	const unsigned int N_HARDENING_PROPERTIES = 6;
	const unsigned int N_SOFTENING_PROPERTIES = 3;
	const unsigned int N_PARAM_PER_BACK = 2;
	const unsigned int REQUIRED_NUMBACKSTRESSES = 2;
	const unsigned int BACKSTRESS_SPACE = REQUIRED_NUMBACKSTRESSES * N_PARAM_PER_BACK;
	const unsigned int N_REGULARIZATION_PARAMETERS = 1;
	const unsigned int N_CYCLIC_PARAMETERS = 23;

	std::string inputInstructions = "Invalid args, want:\n"
		"UniaxialMaterial HLBModelUniaxial "
		"tag? E? fy? QInf? b? DInf? a? "
		"N? C1? gamma1? <C2? gamma2? C3? gamma3? ... C8? gamma8?>"
		"bPlate? tPlate? sigmaC0?"
		"alphaReg? plateType?"
		"<steel type or cyclic parameters?>";

	// Containers for the inputs
	int nInputsToRead;
	int nBackstresses[1];  // for N
	int materialTag[N_TAGS];  // for the tag
	double hardeningProps[N_HARDENING_PROPERTIES];  // holds E, fy, QInf, b, DInf, a
	double backstressProps[BACKSTRESS_SPACE];  // holds C's and gamma's
	double softeningProps[N_SOFTENING_PROPERTIES];  // holds bPlate, tPlate, sigmaC0
	double regularizationgProps[N_REGULARIZATION_PARAMETERS];  // holds alphaReg
	double cyclicProps[N_CYCLIC_PARAMETERS]; // hold cyclic parameters beta1, beta2 and beta3 (regrssion parameters)
	std::vector<double> cK;
	std::vector<double> gammaK;

	// Get the material tag
	nInputsToRead = N_TAGS;
	if (OPS_GetIntInput(&nInputsToRead, materialTag) != 0) {
		opserr << "WARNING invalid UniaxialMaterial HLBModelUniaxial tag" << endln;
		return 0;
	}

	// Get hardening parameters E, fy, qInf, b, DInf, a
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

	// Get plate type
	const char* plateTypePointer = OPS_GetString();
	std::string plateType(plateTypePointer);
	if (plateType != "web" && plateType != "flange") {
		opserr << "Problem with parameters for plate boundary type" << endln;
		return 0;
	}

	if (numData == 18) // using default units (mm and N)
	{
		// Read the steel type
		const char* steelTypePointer = OPS_GetString();
		std::string steelType(steelTypePointer);
		if (steelType != "A992Gr50") {
			opserr << "Problem with parameter for steel material" << endln;
			return 0;
		}

		// Allocate the material
		theMaterial = new HLBModelUniaxial(materialTag[0],
			hardeningProps[0], hardeningProps[1], hardeningProps[2],
			hardeningProps[3], hardeningProps[4], hardeningProps[5], 
			cK, gammaK,
			softeningProps[0], softeningProps[1], softeningProps[2],
			regularizationgProps[0], plateType, steelType, 1.0);
	}
	else if (numData == 20) // units are specified
	{
		// Read the steel type
		const char* steelTypePointer = OPS_GetString();
		std::string steelType(steelTypePointer);
		if (steelType != "A992Gr50") {
			opserr << "Problem with parameter for steel material" << endln;
			return 0;
		}

		// Read the length unit
		double lengthUnitConverter = 0.;
		const char* lengthUnitPointer = OPS_GetString();
		std::string lengthUnit(lengthUnitPointer);
		if (lengthUnit == "mm") {
			lengthUnitConverter = 1.0;
		}
		else if (lengthUnit == "m") {
			lengthUnitConverter = 1000.0;
		}
		else if (lengthUnit == "in") {
			lengthUnitConverter = 25.4;
		}
		else {
			opserr << "Problem with parameter for length units" << endln;
			return 0;
		}

		// Read the force unit
		double forceUnitConverter = 0.;
		const char* forceUnitPointer = OPS_GetString();
		std::string forceUnit(forceUnitPointer);
		if (forceUnit == "N") {
			forceUnitConverter = 1.0;
		}
		else if (forceUnit == "kN") {
			forceUnitConverter = 1000.0;
		}
		else if (forceUnit == "lbf") {
			forceUnitConverter = 4.44822;
		}
		else {
			opserr << "Problem with parameter for force units" << endln;
			return 0;
		}

		// Compute the stress unit scalling factor
		double stressUnitFactor = (lengthUnitConverter * lengthUnitConverter) / forceUnitConverter;

		// Allocate the material
		theMaterial = new HLBModelUniaxial(materialTag[0],
			hardeningProps[0], hardeningProps[1], hardeningProps[2],
			hardeningProps[3], hardeningProps[4], hardeningProps[5],
			cK, gammaK,
			softeningProps[0], softeningProps[1], softeningProps[2],
			regularizationgProps[0], plateType, steelType, stressUnitFactor);
	}
	else if (numData == 40)
	{
		// Get parameters for cyclic loading
		nInputsToRead = N_CYCLIC_PARAMETERS;
		if (OPS_GetDoubleInput(&nInputsToRead, cyclicProps) != 0) {
			opserr << "Problem with parameters for cyclic loading" << endln;
			return 0;
		}

		// Allocate the material
		theMaterial = new HLBModelUniaxial(materialTag[0],
			hardeningProps[0], hardeningProps[1], hardeningProps[2],
			hardeningProps[3], hardeningProps[4], hardeningProps[5],
			cK, gammaK,
			softeningProps[0], softeningProps[1], softeningProps[2],
			regularizationgProps[0], plateType,
			cyclicProps[0], cyclicProps[1], cyclicProps[2], cyclicProps[3], cyclicProps[4], cyclicProps[5], cyclicProps[6], cyclicProps[7], cyclicProps[8], cyclicProps[9],
			cyclicProps[10], cyclicProps[11], cyclicProps[12], cyclicProps[13], cyclicProps[14], cyclicProps[15], cyclicProps[16], cyclicProps[17], cyclicProps[18],
			cyclicProps[19], cyclicProps[20], cyclicProps[21], cyclicProps[22]);
	}


	return theMaterial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

// If cylic properties are not specified
HLBModelUniaxial::HLBModelUniaxial(int tag, double E, 
	double sy0, double qInf, double b, double dInf, double a,
	std::vector<double> cK, std::vector<double> gammaK,
	double bPlate, double tPlate, double sigmaC0,
	double alphaReg, std::string plateType, std::string steelType, double theStressUnitFactor)
	: UniaxialMaterial(tag, MAT_TAG_HLBModelUniaxial),
	elasticModulus(E),
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
	plateType(plateType),
	steelMaterial(steelType),
	stressUnitFactor(theStressUnitFactor),

	strainConverged(0.),
	strainTrial(0.),
	strainPlasticConverged(0.),
	strainPlasticTrial(0.),
	strainPostBucklingConverged(0.),
	strainPostBucklingTrial(0.),
	strainPEqConverged(0.),
	strainPEqTrial(0.),
	strainPBEqConverged(0.),
	strainPBEqTrial(0.),
	strainIncrementDecomposition(3),
	strainDecomposition(3),
	stressConverged(0.),
	stressTrial(0.),
	sumEjConverged(0.),
	sumEjTrial(0.),
	c1cConverged(0.),
	c1cTrial(0.),

	b_1tConverged(0.),
	sigmaPrBezierConverged(0.),
	sigmaYrBezierConverged(0.),
	epsilonPB11UnloadConverged(0.),
	backstressAfterCompressionConverged(0.),
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
	backstressAfterCompressionTrial(0.),
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

	strainIntermed(0.),
	strainPlasticIntermed(0.),
	strainPostBucklingIntermed(0.),
	strainPEqIntermed(0.),
	strainPBEqIntermed(0.),
	stressIntermed(0.),
	sumEjIntermed(0.),
	c1cIntermed(0.),
	b_1tIntermed(0.),
	sigmaPrBezierIntermed(0.),
	sigmaYrBezierIntermed(0.),
	epsilonPB11UnloadIntermed(0.),
	backstressAfterCompressionIntermed(0.),
	epsilonPB11MinIntermed(0.),
	alphaPrBezierIntermed(0.),
	alphaYrBezierIntermed(0.),
	kPrBezierIntermed(0.),
	kYrBezierIntermed(0.),
	rAlphaBackstress1Intermed(0.),
	rAlphaBackstress2Intermed(0.),
	c1cUnloadIntermed(0.),
	sigmaCIntermed(0.),
	yieldStressPBIntermed(0.),
	sigmaYieldAfterCompressionIntermed(0.),
	backstress11TotAfterFullPLRecovIntermed(0.),
	sigmaYieldTotAfterFullPLRecovIntermed(0.),

	elasticLoading(0.),
	plasticLoading(0.),
	postBucklingLoading(0.),
	elasticTangent(0.),
	stiffnessInitial(0.),
	stiffnessConverged(0.),
	stiffnessTrial(0.)
{
	// Set the number of backstresses
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKTrial.push_back(0.);
		alphaPKConverged.push_back(0.);
		alphaPKIntermed.push_back(0.);

		alphaPBKTrial.push_back(0.);
		alphaPBKConverged.push_back(0.);
		alphaPBKIntermed.push_back(0.);
	}

	//Set the value of regression parameters for cyclic loading
	if (plateType == "web") // if web plate
	{
		if (steelType == "A992Gr50") // if A992 Grade 50 steel material
		{
			// For A992 Grade 50 steel for the web plate
			beta1RegressionEuSurEl = 2.6638;
			beta2RegressionEuSurEl = -1.0704;
			beta3RegressionEuSurEl = -0.4351;
			beta1RegressionSigmaPrBezier = 0.0429;
			beta2RegressionSigmaPrBezier = -0.5942;
			beta3RegressionSigmaPrBezier = -0.8667;
			beta1RegressionSigmaYrBezier = 632.9923;
			beta2RegressionSigmaYrBezier = -0.1125;
			beta3RegressionSigmaYrBezier = 0.0414;
			beta1RegressionKPrBezier = -825.8651;
			beta2RegressionKPrBezier = -0.9581;
			beta3RegressionKPrBezier = -0.4764;
			beta1RegressionKYrBezier = -0.2438;
			beta2RegressionKYrBezier = 1.2421;
			beta3RegressionKYrBezier = -0.1793;
			beta1RegressionAlphaPrBezier = -0.0198;
			beta2RegressionAlphaPrBezier = 0.3339;
			beta3RegressionAlphaPrBezier = 0.9841;
			beta1RegressionAlphaYrBezier = 1.0459;
			beta2RegressionAlphaYrBezier = -0.3699;
			beta3RegressionAlphaYrBezier = 0.9629;
			// beta1RegressionErc = 1e20; // very large number so no cyclic degradation
			// beta2RegressionErc = 1.0; // very large number so no cyclic degradation
			beta1RegressionErc = 2.6207e5;
			beta2RegressionErc = -1.9363;
		}
	}
	else if (plateType == "flange") // if flange plate
	{
		if (steelType == "A992Gr50") // if A992 Grade 50 steel material
		{
			// For A992 Grade 50 steel
			beta1RegressionEuSurEl = 2.048;
			beta2RegressionEuSurEl = -1.045;
			beta3RegressionEuSurEl = -0.258;
			beta1RegressionSigmaPrBezier = 0.0141;
			beta2RegressionSigmaPrBezier = 0.0;
			beta3RegressionSigmaPrBezier = -0.7482;
			beta1RegressionSigmaYrBezier = 661.2565;
			beta2RegressionSigmaYrBezier = -0.1378;
			beta3RegressionSigmaYrBezier = 0.0736;
			beta1RegressionKPrBezier = -607.9379;
			beta2RegressionKPrBezier = -0.9333;
			beta3RegressionKPrBezier = -0.3443;
			beta1RegressionKYrBezier = -0.1636;
			beta2RegressionKYrBezier = 1.4685;
			beta3RegressionKYrBezier = -0.4245;
			beta1RegressionAlphaPrBezier = -0.0061;
			beta2RegressionAlphaPrBezier = 0.4908;
			beta3RegressionAlphaPrBezier = 0.6108;
			beta1RegressionAlphaYrBezier = 3.7849;
			beta2RegressionAlphaYrBezier = -0.7960;
			beta3RegressionAlphaYrBezier = 1.1552;
			// beta1RegressionErc = 1e20; // very large number so no cyclic degradation
			// beta2RegressionErc = 1.0; // very large number so no cyclic degradation
			beta1RegressionErc = 1.5093e4;
			beta2RegressionErc = -1.4374;
		}
	}

	// Zero all the vectors and matrices
	revertToStart();

	// Set elastic parameters and elastic stiffness 
	calculateElasticStiffness();
	stiffnessInitial = elasticTangent;
	stiffnessTrial = elasticTangent;
	stiffnessConverged = elasticTangent;

	// Select functions for compressive yield surface evolution during softening based on appropriate plate boundary conditions
	if (plateType == "web") //web plate
	{
		alpha_chi1c = 1. / 3.;
		calculateSigmaSurSigmaY = &HLBModelUniaxial::calculateSigmaSurSigmaY_WebPlate;
		calculateDSigmaSurSigmaYdEpsilonPB11 = &HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_WebPlate;
		initializeFloorF1c = &HLBModelUniaxial::initializeFloorF1c_WebPlate;
	}
	else if (plateType == "flange") // flange plate
	{
		alpha_chi1c = 2. / 3.;
		calculateSigmaSurSigmaY = &HLBModelUniaxial::calculateSigmaSurSigmaY_FlangePlate;
		calculateDSigmaSurSigmaYdEpsilonPB11 = &HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_FlangePlate;
		initializeFloorF1c = &HLBModelUniaxial::initializeFloorF1c_FlangePlate;
	}

	// Set the value of b_chi1c
	initializeBChi1c();

	// Set the value of Erc
	initializeErc();

	// Set the value of floorF1c
	(this->*initializeFloorF1c)();
};

/* ----------------------------------------------------------------------------------------------------------------- */

// If cylic properties are specified
HLBModelUniaxial::HLBModelUniaxial(int tag, double E,
	double sy0, double qInf, double b, double dInf, double a,
	std::vector<double> cK, std::vector<double> gammaK,
	double bPlate, double tPlate, double sigmaC0,
	double alphaReg, std::string plateType,
	double beta1RegressionEuSurEl, double beta2RegressionEuSurEl, double beta3RegressionEuSurEl,
	double beta1RegressionSigmaPrBezier, double beta2RegressionSigmaPrBezier, double beta3RegressionSigmaPrBezier,
	double beta1RegressionSigmaYrBezier, double beta2RegressionSigmaYrBezier, double beta3RegressionSigmaYrBezier,
	double beta1RegressionKPrBezier, double beta2RegressionKPrBezier, double beta3RegressionKPrBezier,
	double beta1RegressionKYrBezier, double beta2RegressionKYrBezier, double beta3RegressionKYrBezier,
	double beta1RegressionAlphaPrBezier, double beta2RegressionAlphaPrBezier, double beta3RegressionAlphaPrBezier,
	double beta1RegressionAlphaYrBezier, double beta2RegressionAlphaYrBezier, double beta3RegressionAlphaYrBezier,
	double beta1RegressionErc, double beta2RegressionErc)
	: UniaxialMaterial(tag, MAT_TAG_HLBModelUniaxial),
	elasticModulus(E),
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
	plateType(plateType),

	beta1RegressionEuSurEl(beta1RegressionEuSurEl),
	beta2RegressionEuSurEl(beta2RegressionEuSurEl),
	beta3RegressionEuSurEl(beta3RegressionEuSurEl),
	beta1RegressionSigmaPrBezier(beta1RegressionSigmaPrBezier),
	beta2RegressionSigmaPrBezier(beta2RegressionSigmaPrBezier),
	beta3RegressionSigmaPrBezier(beta3RegressionSigmaPrBezier),
	beta1RegressionSigmaYrBezier(beta1RegressionSigmaYrBezier),
	beta2RegressionSigmaYrBezier(beta2RegressionSigmaYrBezier),
	beta3RegressionSigmaYrBezier(beta3RegressionSigmaYrBezier),
	beta1RegressionKPrBezier(beta1RegressionKPrBezier),
	beta2RegressionKPrBezier(beta2RegressionKPrBezier),
	beta3RegressionKPrBezier(beta3RegressionKPrBezier),
	beta1RegressionKYrBezier(beta1RegressionKYrBezier),
	beta2RegressionKYrBezier(beta2RegressionKYrBezier),
	beta3RegressionKYrBezier(beta3RegressionKYrBezier),
	beta1RegressionAlphaPrBezier(beta1RegressionAlphaPrBezier),
	beta2RegressionAlphaPrBezier(beta2RegressionAlphaPrBezier),
	beta3RegressionAlphaPrBezier(beta3RegressionAlphaPrBezier),
	beta1RegressionAlphaYrBezier(beta1RegressionAlphaYrBezier),
	beta2RegressionAlphaYrBezier(beta2RegressionAlphaYrBezier),
	beta3RegressionAlphaYrBezier(beta3RegressionAlphaYrBezier),
	beta1RegressionErc(beta1RegressionErc),
	beta2RegressionErc(beta2RegressionErc),

	strainConverged(0.),
	strainTrial(0.),
	strainPlasticConverged(0.),
	strainPlasticTrial(0.),
	strainPostBucklingConverged(0.),
	strainPostBucklingTrial(0.),
	strainPEqConverged(0.),
	strainPEqTrial(0.),
	strainPBEqConverged(0.),
	strainPBEqTrial(0.),
	strainIncrementDecomposition(0.),
	strainDecomposition(0.),
	stressConverged(0.),
	stressTrial(0.),
	sumEjConverged(0.),
	sumEjTrial(0.),
	c1cConverged(0.),
	c1cTrial(0.),

	b_1tConverged(0.),
	sigmaPrBezierConverged(0.),
	sigmaYrBezierConverged(0.),
	epsilonPB11UnloadConverged(0.),
	backstressAfterCompressionConverged(0.),
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
	backstressAfterCompressionTrial(0.),
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

	strainIntermed(0.),
	strainPlasticIntermed(0.),
	strainPostBucklingIntermed(0.),
	strainPEqIntermed(0.),
	strainPBEqIntermed(0.),
	stressIntermed(0.),
	sumEjIntermed(0.),
	c1cIntermed(0.),
	b_1tIntermed(0.),
	sigmaPrBezierIntermed(0.),
	sigmaYrBezierIntermed(0.),
	epsilonPB11UnloadIntermed(0.),
	backstressAfterCompressionIntermed(0.),
	epsilonPB11MinIntermed(0.),
	alphaPrBezierIntermed(0.),
	alphaYrBezierIntermed(0.),
	kPrBezierIntermed(0.),
	kYrBezierIntermed(0.),
	rAlphaBackstress1Intermed(0.),
	rAlphaBackstress2Intermed(0.),
	c1cUnloadIntermed(0.),
	sigmaCIntermed(0.),
	yieldStressPBIntermed(0.),
	sigmaYieldAfterCompressionIntermed(0.),
	backstress11TotAfterFullPLRecovIntermed(0.),
	sigmaYieldTotAfterFullPLRecovIntermed(0.),

	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticTangent(0.),
	stiffnessInitial(0.),
	stiffnessConverged(0.),
	stiffnessTrial(0.)
{
	// Set the number of backstresses
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKTrial.push_back(0.);
		alphaPKConverged.push_back(0.);
		alphaPKIntermed.push_back(0.);

		alphaPBKTrial.push_back(0.);
		alphaPBKConverged.push_back(0.);
		alphaPBKIntermed.push_back(0.);
	}

	// Zero all the vectors and matrices
	revertToStart();

	// Set elastic parameters and elastic stiffness matrix
	calculateElasticStiffness();
	stiffnessInitial = elasticTangent;
	stiffnessTrial = elasticTangent;
	stiffnessConverged = elasticTangent;

	// Select functions for compressive yield surface evolution during softening based on appropriate plate boundary conditions
	if (plateType == "-web") //web plate
	{
		alpha_chi1c = 1. / 3.;
		calculateSigmaSurSigmaY = &HLBModelUniaxial::calculateSigmaSurSigmaY_WebPlate;
		calculateDSigmaSurSigmaYdEpsilonPB11 = &HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_WebPlate;
		initializeFloorF1c = &HLBModelUniaxial::initializeFloorF1c_WebPlate;
	}
	else if (plateType == "-flange") // flange plate
	{
		alpha_chi1c = 2. / 3.;
		calculateSigmaSurSigmaY = &HLBModelUniaxial::calculateSigmaSurSigmaY_FlangePlate;
		calculateDSigmaSurSigmaYdEpsilonPB11 = &HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_FlangePlate;
		initializeFloorF1c = &HLBModelUniaxial::initializeFloorF1c_FlangePlate;
	}

	// Set the value of b_chi1c
	initializeBChi1c();

	// Set the value of Erc
	initializeErc();

	// Set the value of floorF1c
	(this->*initializeFloorF1c)();
};

/* ----------------------------------------------------------------------------------------------------------------- */

HLBModelUniaxial::HLBModelUniaxial()
	: UniaxialMaterial(0, MAT_TAG_HLBModelUniaxial),
	elasticModulus(0.),
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
	strainConverged(0.),
	strainTrial(0.),
	strainPlasticConverged(0.),
	strainPlasticTrial(0.),
	strainPostBucklingConverged(0.),
	strainPostBucklingTrial(0.),
	strainPEqConverged(0.),
	strainPEqTrial(0.),
	strainPBEqConverged(0.),
	strainPBEqTrial(0.),
	strainIncrementDecomposition(0.),
	strainDecomposition(0.),
	stressConverged(0.),
	stressTrial(0.),
	sumEjConverged(0.),
	sumEjTrial(0.),
	c1cConverged(0.),
	c1cTrial(0.),

	b_1tConverged(0.),
	sigmaPrBezierConverged(0.),
	sigmaYrBezierConverged(0.),
	epsilonPB11UnloadConverged(0.),
	backstressAfterCompressionConverged(0.),
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
	backstressAfterCompressionTrial(0.),
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

	strainIntermed(0.),
	strainPlasticIntermed(0.),
	strainPostBucklingIntermed(0.),
	strainPEqIntermed(0.),
	strainPBEqIntermed(0.),
	stressIntermed(0.),
	sumEjIntermed(0.),
	c1cIntermed(0.),
	b_1tIntermed(0.),
	sigmaPrBezierIntermed(0.),
	sigmaYrBezierIntermed(0.),
	epsilonPB11UnloadIntermed(0.),
	backstressAfterCompressionIntermed(0.),
	epsilonPB11MinIntermed(0.),
	alphaPrBezierIntermed(0.),
	alphaYrBezierIntermed(0.),
	kPrBezierIntermed(0.),
	kYrBezierIntermed(0.),
	rAlphaBackstress1Intermed(0.),
	rAlphaBackstress2Intermed(0.),
	c1cUnloadIntermed(0.),
	sigmaCIntermed(0.),
	yieldStressPBIntermed(0.),
	sigmaYieldAfterCompressionIntermed(0.),
	backstress11TotAfterFullPLRecovIntermed(0.),
	sigmaYieldTotAfterFullPLRecovIntermed(0.),

	elasticLoading(0),
	plasticLoading(0),
	postBucklingLoading(0),
	elasticTangent(0.),
	stiffnessInitial(0.),
	stiffnessConverged(0.),
	stiffnessTrial(0.)
{
	// Set the number of backstresses
  //Not tried for UVC parallel processing - probably wont work with parallel processing
	nBackstresses = cK.size();
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKTrial.push_back(0.);
		alphaPKConverged.push_back(0.);
		alphaPKIntermed.push_back(0.);

		alphaPBKTrial.push_back(0.);
		alphaPBKIntermed.push_back(0.);
	}

	// Zero all the vectors and matrices
	revertToStart();

	// Set elastic stiffness matrix
	calculateElasticStiffness();
	stiffnessInitial = elasticTangent;
	stiffnessTrial = elasticTangent;
	stiffnessConverged = elasticTangent;

	// Set the value of b_chi1c
	initializeBChi1c();

	// Set the value of Erc
	initializeErc();

	// Set the value of floorF1c
	(this->*initializeFloorF1c)();

}

/* ----------------------------------------------------------------------------------------------------------------- */

HLBModelUniaxial::~HLBModelUniaxial() {

}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
//#pragma optimize("", off)  // Disable optimization for this function
int HLBModelUniaxial::timeIntegration() {
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
	double alphaTot = 0.;
	double etaTrial = 0.;
	double deltaStrain_todo = 0.;
	double deltaStrain_trial = 0.;
	double deltaStrain_fullIncrement = 0.;
	double strainIntermed =0.; // strain_previous in Matlab
	double strain_nPlus1 = 0.;
	double xiTrial = 0.;
	double phiTension = 0.;
	double phiCompression = 0.;
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double f2bar = 0.;
	double chi1c = 0.;
	double etaTangent = 0.;
	double chi1t = 0.;

	// Update the total strain vector
	strainIntermed = strainConverged;
	deltaStrain_todo = strainTrial - strainConverged;
	deltaStrain_fullIncrement = strainTrial - strainConverged;
	deltaStrain_trial = deltaStrain_todo;

	/*if (strainConverged(0) <= -0.000308844 && strainConverged(0) > -0.000308846 && strainTrial(0) <= -0.000209417 && strainTrial(0) > -0.000209419) {
		double testBreak = 0.;
	}*/

	// Loop for time integration
	while (!convergedMatLaw && iterationNumber_timeIntegration < MAXIMUM_ITERATIONS_TIMEINTEGRATION) {
		iterationNumber_timeIntegration++;

		if (isnan(strainTrial))
		{
			iterationNumber_timeIntegration = MAXIMUM_ITERATIONS_TIMEINTEGRATION + 1;
		}

		// Update the total strain for time integration iteration
		strain_nPlus1 = strainIntermed + deltaStrain_trial;

		// Compute reduction factor for elastic stiffness matrix
		etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingIntermed);

		// Compute the yield stress
		yieldStressP = calculateYieldStressPlastic(strainPEqIntermed);

		// Elastic trial step
		alphaTot=0.;
		for (unsigned int i = 0; i < nBackstresses; ++i)
			alphaTot = alphaTot + alphaPKIntermed[i] + alphaPBKIntermed[i];
		stressTrial = (etaTangent * elasticTangent) * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed);
		yieldStressTot = yieldStressP + yieldStressPBIntermed;

		xiTrial = stressTrial - alphaTot;
		etaTrial = xiTrial;

		// Select which return mapping to do
		if (stressTrial >= 0) { // if in tension
			chi1t = calculateChi1t(yieldStressTot, alphaTot, alphaRegularization * strainPostBucklingIntermed);
			phiTension = pow(xiTrial, 2) + chi1t * pow(stressTrial, 2) - pow(yieldStressTot, 2);

			// Check if trial state is elastic or if need return map approach
			if (phiTension / (2. / 3. * pow(initialYield, 2)) <= RETURN_MAP_TOL) { //loading is elastic
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic(etaTangent);

				// Check if we have done the full strain increment
				deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;
				if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
					convergedMatLaw = true;
				}
				else { // converged but there is more strain increment to do
					strainIntermed = strainIntermed + deltaStrain_trial;
					deltaStrain_trial = deltaStrain_todo;
				} // end check if full strain increment has been done

			}
			else { //if not elastic
				if (abs(strainPostBucklingIntermed) > SMALL_NUMBER && abs(epsilonPB11UnloadIntermed) >= abs(epsilonPB11MinIntermed))
				{ // Plastic recovery stage
					PlRecoveryLoading = 1;

					retVal = returnMappingPlRecovStage(strain_nPlus1);

					// Check if we have reduced all the epsiPb11
					if (retVal == 0 && (strainPostBucklingTrial <= 0. || abs(strainPostBucklingTrial) <= SMALL_NUMBER)) // We don't have reduced too much
					{
						deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

						// Check if the full strain increment has been done
						if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							strainIntermed = strainIntermed + deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;
							strainPBEqIntermed = strainPBEqTrial;
							strainPostBucklingIntermed = strainPostBucklingTrial;
							alphaPBKIntermed = alphaPBKTrial;
							yieldStressPBIntermed = yieldStressPBTrial;
							c1cIntermed = c1cTrial;
						} // end check if full strain increment has been done

						// If we have reduced all the epsiPb11-->switch PlRecov to UVC hardening
						if (abs(strainPostBucklingTrial) <= SMALL_NUMBER)
						{
							strainPBEqIntermed = strainPBEqTrial;
							strainPostBucklingIntermed = strainPostBucklingTrial;
							alphaPBKIntermed = alphaPBKTrial;
							yieldStressPBIntermed = yieldStressPBTrial;
							c1cIntermed = c1cTrial;
						} // end if we have reduced all the epsiPb11-->switch PlRecov to UVC hardening

					} // end if we don't have reduced epsiPb11 too much
					else
					{ // if we have reduced epsiPb11 too much or if we have not converged
						deltaStrain_trial = deltaStrain_trial / 2.;

					} // end if we have reduced epsiPb11 too much or if we have not converged 

				} // end Plastic recovery stage

				else if (abs(strainPostBucklingIntermed) > SMALL_NUMBER && abs(epsilonPB11UnloadTrial) < abs(epsilonPB11MinTrial))
				{//UVC recovery stage
					UVCRecoveryLoading = 1;

					retVal = returnMappingUVCRecovStage(strain_nPlus1, alphaTot);

					// Check if we have reduced all the epsiPb11
					if (retVal == 0 && (strainPostBucklingTrial <= 0. || abs(strainPostBucklingTrial) <= SMALL_NUMBER)) // We don't have reduced too much
					{
						deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							strainIntermed = strainIntermed + deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;
							strainPBEqIntermed = strainPBEqTrial;
							strainPostBucklingIntermed = strainPostBucklingTrial;
							strainPlasticIntermed = strainPlasticTrial;
							strainPEqIntermed = strainPEqTrial;
							alphaPKIntermed = alphaPKTrial;
							c1cIntermed = c1cTrial;
						} // end check if full strain increment has been done

						// If we have reduced all the epsiPb11-->switch UVCRecov to UVC hardening
						if (abs(strainPostBucklingTrial) <= SMALL_NUMBER)
						{
							strainPBEqIntermed = strainPBEqTrial;
							strainPostBucklingIntermed = strainPostBucklingTrial;
							strainPlasticIntermed = strainPlasticTrial;
							strainPEqIntermed = strainPEqTrial;
							alphaPKIntermed = alphaPKTrial;
							c1cIntermed = c1cTrial;
						} // end if we have reduced all the epsiPb11-->switch UVCRecov to UVC hardening

					} // end if we don't have reduced epsiPb11 too much
					else
					{ // if we have reduced epsiPb11 too much or if we have not converged
						deltaStrain_trial = deltaStrain_trial / 2.;
					} // end if we have reduced epsiPb11 too much or if we have not converged


				} // end UVC recovery stage

				else { //hardening stage
					plasticLoading = 1;

					retVal = returnMappingHardening(strain_nPlus1, alphaTot, etaTrial);

					// Check if we have converged
					if (retVal == 0) // We have converged
					{
						deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							strainIntermed = strainIntermed + deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;
							strainPlasticIntermed = strainPlasticTrial;
							strainPEqIntermed = strainPEqTrial;
							alphaPKIntermed = alphaPKTrial;
						} // end check if full strain increment has been done

					} // end if we have converged
					else
					{ // if we have not converged
						deltaStrain_trial = deltaStrain_trial / 2.;
					} // end if we have not converged

				} // end hardening stage
			} // end if not elastic		

			// Cyclic degradation part:
			sumEjTrial = sumEjConverged + 0.5 * (stressConverged + stressTrial) * (strain_nPlus1 - strainConverged);
			computeSigmaCDegradation();

		} // end if in tension
		else { // if in compression
			// Compute value of phiCompression
			chi1c = calculateChi1c(strainPostBucklingIntermed);
			phiCompression = pow(xiTrial, 2) + chi1c * pow(stressTrial, 2) - pow(yieldStressTot, 2);

			// Check if trial state is elastic or if need return map approach
			if (phiCompression / (2. / 3. * pow(initialYield, 2)) <= RETURN_MAP_TOL) { //loading is elastic
				elasticLoading = 1;

				// Update the stiffness for elastic loading
				calculateConsistentTangentModulusElastic(etaTangent);

				// Check if the initial capping stress sigmaC0 has been passed
				if ((pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // not yet at capping point
					deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

					// Check if the full strain increment has been done
					//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
					if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
						convergedMatLaw = true;
					}
					else { // converged but there is more strain increment to do
						strainIntermed = strainIntermed + deltaStrain_trial;
						deltaStrain_trial = deltaStrain_todo;
					}

					// Check if capping point is reached
					if (abs(pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // capping point is reached
						if (abs(strainPostBucklingIntermed) < SMALL_NUMBER)
						{
							strainPostBucklingIntermed = -SMALL_NUMBER;
							strainPostBucklingTrial = strainPostBucklingIntermed;
						}
						calculateC1c(yieldStressTot, alphaTot, strainPostBucklingIntermed);
					}
				}
				else { // the capping point has been passed
					deltaStrain_trial = deltaStrain_trial / 2.;
					//Try solving issue with high shear strains 05.02.2025
					if (iterationNumber_timeIntegration >= 0.2 * MAXIMUM_ITERATIONS_TIMEINTEGRATION)
					{
						//sigmaCTrial = yieldStressTot;
						sigmaCTrial = stressTrial;
					}
				}
			}
			else { // if not elastic

				// Check if hardening or softening response
				if (abs(strainPostBucklingIntermed) < SMALL_NUMBER) {
					// Do a step in the hardening direction
					plasticLoading = 1;
					retVal = returnMappingHardening(strain_nPlus1, alphaTot, etaTrial);

					// Check if the initial capping stress sigmaC0 has been passed
					if (retVal == 0 && (pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // not yet at capping point
						deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							strainIntermed = strainIntermed + deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;
							strainPlasticIntermed = strainPlasticTrial;
							strainPEqIntermed = strainPEqTrial;
							alphaPKIntermed = alphaPKTrial;
						}

						// Check if capping point is reached
						//if (3. / 2. * (2. / 3. * pow(stressTrial(0), 2) + 2. * pow(stressTrial(1), 2) + 2. * pow(stressTrial(2), 2)) - pow(sigmaCTrial, 2) >= -SMALL_NUMBER) { // capping point is reached
						if (abs(pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // capping point is reached
							strainPostBucklingIntermed = -SMALL_NUMBER;
							strainPostBucklingTrial = strainPostBucklingIntermed;
							strainPlasticIntermed = strainPlasticTrial;
							strainPEqIntermed = strainPEqTrial;
							alphaPKIntermed = alphaPKTrial;
						}

					}
					else { // the capping point has been passed or we have not converged
						//deltaStrain_trial /= 2.;
						deltaStrain_trial = deltaStrain_trial / 2.;
						//Try solving issue with high shear strains 18.12.2023
						if (iterationNumber_timeIntegration >= 0.2 * MAXIMUM_ITERATIONS_TIMEINTEGRATION)
						{
							//sigmaCTrial = yieldStressTot;
							sigmaCTrial = stressTrial;
						}
					}
				}
				else { // if chi1c !=0 --> softening stage
					postBucklingLoading = 1;

					retVal = returnMappingSoftening(strain_nPlus1, xiTrial, alphaTot, yieldStressTot);

					// Check if the initial capping stress  has been passed (due to reduction in sigmaC)
					if (retVal == 0 && (pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // not yet at capping point
						deltaStrain_todo = deltaStrain_todo - deltaStrain_trial;

						// Check if the full strain increment has been done
						//if (deltaStrain_todo.Norm() <= SMALL_NUMBER) { // full strain increment has been done
						if (abs(deltaStrain_todo) <= 0.) { // full strain increment has been done
							convergedMatLaw = true;
						}
						else { // converged but there is more strain increment to do
							strainIntermed = strainIntermed + deltaStrain_trial;
							deltaStrain_trial = deltaStrain_todo;
							strainPostBucklingIntermed = strainPostBucklingTrial;
							strainPBEqIntermed = strainPBEqTrial;
						}

						// Check if capping point is reached
						if (abs(pow(stressTrial, 2) - pow(sigmaCTrial, 2)) / pow(sigmaC0Stress, 2) <= SMALL_NUMBER) { // capping point is reached
							calculateC1c(yieldStressTot, alphaTot, strainPostBucklingIntermed);
						}
					}
					else { // the capping point has been passed or if we have not converged
						deltaStrain_trial = deltaStrain_trial / 2.;
						//Try solving issue with high shear strains 18.12.2023
						if (iterationNumber_timeIntegration >= 0.2 * MAXIMUM_ITERATIONS_TIMEINTEGRATION)
						{
							//sigmaCTrial = yieldStressTot;
							sigmaCTrial = stressTrial;
						}
					}

					// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
					double sumEj_4targetStress4PLRecov = sumEjConverged + 0.5 * (stressConverged + stressTrial) * (strain_nPlus1 - strainConverged) - 0.5 * pow(stressTrial, 2) / (etaTangent * elasticTangent);
					double beta = std::min(1., sumEj_4targetStress4PLRecov / ErcConverged);
					double targetStress4PLRecov = (1 - beta) * sigmaC0Stress;
					setTensileEllipsoidYieldSurf(yieldStressTot, alphaTot, targetStress4PLRecov);
				}
			} // end IF not elastic

			//// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
			//setTensileEllipsoidYieldSurf(yieldStress, alphaTot);

			// Cyclic degradation part:
			sumEjTrial = sumEjConverged + 0.5 * (stressConverged+ stressTrial) * (strain_nPlus1 - strainConverged);

		} // end IF compression

		/*if (iterationNumber_timeIntegration >= 400) {
			int ErrorVal = -1;
		}*/
	}

	// Warn the user if the algorithm did not converge and return -1
	if (iterationNumber_timeIntegration >= MAXIMUM_ITERATIONS_TIMEINTEGRATION) {
		opserr << "HLBModelUniaxial::timeIntegration time integration did not converge!" << endln;
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
int HLBModelUniaxial::returnMappingHardening(double strain_nPlus1, double alphaTot, double etaTrial) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double isotropicModulus = 0.;
	double beta = 0.;
	double alphaTilde = 0.;
	double eK = 0.;
	double gammaDiag = 0.;
	double consistParam_plastic = 0.;
	double etaTilde = 0.;
	double eta = 0.;
	double f2bar = 0.;
	double fBar = 0.;
	double betaPrime = 0.;
	double alphaTildePrime = 0.;
	double gammaDiagPrime = 0.;
	double consistDenom = 0.;
	double phiVM = 0.;
	double stressRelative = 0.;
	std::vector<double> alpha12Tot_Vector;
	double etaTangent = 0.;

	etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingIntermed);

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKIntermed[i] + alphaPBKIntermed[i]);
	}

	strainPEqTrial = strainPEqIntermed;

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		// Isotropic hardening parameters
		yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
		yieldStressTot = yieldStressP + yieldStressPBTrial;
		isotropicModulus = calculateIsotropicModulus(strainPEqTrial);
		// Kinematic hardening parameters
		beta = 0.;
		alphaTilde=0.;
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			/*eK = calculateEk(i);*/
			eK = exp(-gammaK[i] * (strainPEqTrial - strainPEqIntermed));
			beta += cK[i] / gammaK[i] * (1. - eK);
			alphaTilde += alpha12Tot_Vector[i] * eK;
		}
		alphaTilde = alphaTot - alphaTilde;
		beta = 1. + beta / yieldStressTot;

		/*etaTangent = calculateEtaTangentReduce();*/

		// Update the relative stress and eta
		gammaDiag = 1. / (beta + consistParam_plastic * 2. / 3. * etaTangent * elasticModulus);

		etaTilde = etaTrial + alphaTilde;
		eta = etaTilde * gammaDiag;
		f2bar = 2. / 3. * pow(eta, 2);
		fBar = sqrt(f2bar);

		// Calculate Newton denominator
		betaPrime = 0.;
		alphaTildePrime = 0.;
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			/*eK = calculateEk(i);*/
			eK = exp(-gammaK[i] * (strainPEqTrial - strainPEqIntermed));
			betaPrime = betaPrime - cK[i] * isotropicModulus / (gammaK[i] * pow(yieldStressTot, 2)) * (1. - eK)
				+ cK[i] * eK / yieldStressTot;
			alphaTildePrime = alphaTildePrime + gammaK[i] * eK * alpha12Tot_Vector[i];
		}
		betaPrime = betaPrime * sqrt(2. / 3.) * fBar;
		alphaTildePrime = alphaTildePrime * sqrt(2. / 3.) * fBar;
		gammaDiagPrime = -pow(gammaDiag, 2) * (betaPrime + 2./3. * etaTangent * elasticTangent);

		consistDenom = 2./.3* eta*(	gammaDiagPrime* etaTilde + gammaDiag*alphaTildePrime)
			- sqrt(2. / 3.) * 2. / 3. * yieldStressTot * isotropicModulus * fBar;

		// Newton step
		phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStressTot, 2);
		consistParam_plastic = consistParam_plastic - phiVM / (consistDenom + SMALL_NUMBER);
		/*strainPEqTrial = strainPEqConverged + sqrt(2. / 3.) * consistParam_plastic * fBar;*/
		strainPEqTrial = strainPEqIntermed + sqrt(2. / 3.) * consistParam_plastic * fBar;

		// Check convergence
		if (fabs(phiVM) / (2. / 3. * pow(initialYield, 2)) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Update the variables
	etaTilde = etaTrial + alphaTilde;
	eta = gammaDiag* etaTilde;
	stressRelative = eta;
	yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		/*eK = calculateEk(i);*/
		eK = exp(-gammaK[i] * (strainPEqTrial - strainPEqIntermed));
		alpha12Tot_Vector[i] = alpha12Tot_Vector[i] * eK + stressRelative / yieldStressTot * cK[i] / gammaK[i] * (1. - eK);
		/*alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKConverged[i];*/
		alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKIntermed[i];
	}
	/*strainPlasticTrial = strainPlasticConverged + consistParam_plastic * PMat * stressRelative;*/
	strainPlasticTrial = strainPlasticIntermed + consistParam_plastic * 2./3. * stressRelative;

	/*etaTangent = calculateEtaTangentReduce();*/
	stressTrial = (etaTangent * elasticTangent) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingIntermed);

	// Calculate the consistent tangent modulus for hardening stage
	calculateConsistentTangentModulusHardening(consistParam_plastic, fBar, stressRelative);

	// Warn the user if the algorithm did not convergein the return mapping for hardening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiVM / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		/*opserr << "HLBModelUniaxial::returnMappingHardening return mapping hardening stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strain_nPlus1[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strain_nPlus1[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strain_nPlus1[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiVM << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;*/
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int HLBModelUniaxial::returnMappingSoftening(double strain_nPlus1, double relativeStressTrial, double backstressTot, double yieldStressTot) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double gammaDiag = 0.;
	double consistParam_postBuckling = 0.;
	double chi1c = 0.;
	double sigmaSurSigmaY = 0.;
	double relativeStressNPlus1 = 0.;
	double phiComp = 0.;
	double psi = 0.;
	double dSigmaSurSigmaYdEpsilonPB11 = 0.;
	double dChi1cDLambdaPB = 0.;
	double gammaDiagPrime = 0.;
	double dXidLambda = 0.;
	double dPhiCompdLambdaPB = 0.;
	double dPhiCompdXi = 0.;
	double etaTangent = 0.;
	double LambdaC_nPlus1Diag = 0.;
	double dCdLambdaPB = 0.;

	strainPostBucklingTrial = strainPostBucklingIntermed;

	chi1c = calculateChi1c(strainPostBucklingTrial);
	sigmaSurSigmaY = (this->*calculateSigmaSurSigmaY)(strainPostBucklingTrial);
	//(obj.*funcPtr)()
	//calculateSigmaSurSigmaY(strainPostBucklingTrial(0));

// Do the return mapping algorithm for post buckling loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingTrial);
		LambdaC_nPlus1Diag = etaTangent * elasticTangent;

		gammaDiag = 1. / (1. / LambdaC_nPlus1Diag + consistParam_postBuckling * (2. + 2. * chi1c));

		relativeStressNPlus1 = gammaDiag * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed - 2. * chi1c * consistParam_postBuckling * backstressTot) - gammaDiag / LambdaC_nPlus1Diag * backstressTot;
		stressTrial = relativeStressNPlus1 + backstressTot;

		phiComp = pow(relativeStressNPlus1, 2) + chi1c * pow(stressTrial, 2) - pow(yieldStressTot, 2);

		psi = pow((4. * pow(relativeStressNPlus1, 2) + 8. * pow(chi1c, 2) * pow(stressTrial, 2)), 0.5);
		dPhiCompdXi = 2. * (relativeStressNPlus1 + chi1c * stressTrial);

		//dSigmaSurSigmaYdEpsilonPB11 = calculateDSigmaSurSigmaYdEpsilonPB11();
		dSigmaSurSigmaYdEpsilonPB11 = (this->*calculateDSigmaSurSigmaYdEpsilonPB11)();

		dChi1cDLambdaPB = dPhiCompdXi * 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;
		//dChi1cDLambdaPB = -dPhiCompdXi(0) * 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;

		dCdLambdaPB = calculateDCdLambdaPB(etaTangent, dPhiCompdXi);

		gammaDiagPrime = -pow(gammaDiag, 2) * (dCdLambdaPB + 2. * (1. + chi1c) + 2. * consistParam_postBuckling * dChi1cDLambdaPB);

		dXidLambda = gammaDiagPrime * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed - 2. * chi1c * consistParam_postBuckling * backstressTot) - 2 * chi1c * gammaDiag * backstressTot - 2 * consistParam_postBuckling * gammaDiag * backstressTot * dChi1cDLambdaPB - gammaDiagPrime / LambdaC_nPlus1Diag * backstressTot - gammaDiag * dCdLambdaPB * backstressTot;

		dPhiCompdLambdaPB = 2. * dXidLambda * (relativeStressNPlus1 + chi1c * stressTrial) + pow(stressTrial, 2) * dChi1cDLambdaPB;

		// Do the Newton Step
		consistParam_postBuckling = consistParam_postBuckling - phiComp / dPhiCompdLambdaPB;

		strainPBEqTrial = strainPBEqIntermed + psi * consistParam_postBuckling;
		strainPostBucklingTrial = strainPostBucklingIntermed + consistParam_postBuckling * dPhiCompdXi;
		//if (strainPostBucklingConverged.Norm() == 0.)
		//{ // Try to solve issue with epsiPb11<tol after softening stage
		//	strainPostBucklingTrial = pVect * (strainPostBucklingConverged(0)+SMALL_NUMBER) + consistParam_postBuckling * dPhiCompdXi;
		//}

		//sigmaSurSigmaY = calculateSigmaSurSigmaY(strainPostBucklingTrial(0));
		sigmaSurSigmaY = (this->*calculateSigmaSurSigmaY)(strainPostBucklingTrial);
		chi1c = calculateChi1c(strainPostBucklingTrial);

		// Check convergence
		if (fabs(phiComp / (2. / 3. * pow(initialYield, 2))) < RETURN_MAP_TOL) {
			convergedReturnMapping = true;
		}
	}

	// Calculate the consistent tangent modulus for softening stage
	calculateConsistentTangentModulusSoftening(strain_nPlus1, backstressTot, relativeStressNPlus1, stressTrial, consistParam_postBuckling);

	// Warn the user if the algorithm did not convergein the return mapping for softening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiComp / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		/*opserr << "HLBModelUniaxial::returnMappingSoftening return mapping softening stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strainTrial[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strainTrial[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strainTrial[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiComp << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;*/
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int HLBModelUniaxial::returnMappingPlRecovStage(double strain_nPlus1) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	double backstressPTot = 0.;
	double backstressPBTot = 0.;
	double backstressTot = 0.;
	double backstress11Pb_nPlus1 = 0.;
	double consistParam_plRecov = 0.;
	double chi1t = 0.;
	double f1t = 0.;
	double etaTangent = 0.;
	double LambdaC_nPlus1Diag = 0.;
	double gammaDiag = 0.;
	double relativeStressNPlus1 = 0.;
	double phiTens = 0.;
	double psi = 0.;
	double dPhiTensdXi = 0.;
	double tBezier = 0.;
	double sigmaBezier = 0.;
	double dSigmaBezierDtBezier = 0.;
	double dEpsiBezierdtBezier = 0.;
	double dAlpha11TotDLambdaPb = 0.;
	double dSigmaBezierDLambdaPb = 0.;
	double dFchi1tdLambdaPb = 0.;
	double dChi1tDLambdaPB = 0.;
	double dCdLambdaPB = 0.;
	double gammaDiagPrime = 0.;
	double dXidLambda = 0.;
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

	strainPostBucklingTrial = strainPostBucklingIntermed;

	tBezier = calculateTBezier(alphaRegularization * strainPostBucklingTrial);
	sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
	yieldStressTot = computeYieldStressTotPlRecovStage(alphaRegularization * strainPostBucklingTrial);
	backstressTot = computeBackstressTotPlRecovStage(alphaRegularization * strainPostBucklingTrial);
	f1t = calculateF1t(yieldStressTot, backstressTot, alphaRegularization * strainPostBucklingTrial);
	chi1t = b_1tTrial * (1 - f1t);

	// Do the return mapping algorithm for plastic recovery stage
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING)
	{
		iterationNumber_ReturnMapping++;

		etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingTrial);
		LambdaC_nPlus1Diag = etaTangent * elasticTangent;

		gammaDiag = 1. / (1. / LambdaC_nPlus1Diag + consistParam_plRecov * (2. + 2. * chi1t));

		relativeStressNPlus1 = gammaDiag * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed - 2. * chi1t * consistParam_plRecov * backstressTot) - gammaDiag / LambdaC_nPlus1Diag * backstressTot;
		stressTrial = relativeStressNPlus1 + backstressTot;

		phiTens = pow(relativeStressNPlus1, 2) + chi1t * pow(stressTrial, 2) - pow(yieldStressTot, 2);

		psi = pow((4. * pow(relativeStressNPlus1, 2) + 8. * pow(chi1t, 2) * pow(stressTrial, 2)), 0.5);
		dPhiTensdXi = 2. * (relativeStressNPlus1 + chi1t * stressTrial);

		dSigmaBezierDtBezier = -3. * pow((1. - tBezier), 2) * sigmaPrBezierTrial + 3. * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * sigmaYrBezierTrial;
		dEpsiBezierdtBezier = -3. * pow((1. - tBezier), 2) * abs(epsilonPB11UnloadTrial) + 3. * (abs(epsilonPB11UnloadTrial) + alphaPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (0. + alphaYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * 0.;
		dSigmaBezierDLambdaPb = -alphaRegularization * dSigmaBezierDtBezier / (dEpsiBezierdtBezier + RETURN_MAP_TOL) * dPhiTensdXi;

		dAlpha11TotDLambdaPb = alphaRegularization * computeDAlpha11TotDEpsiPb11PlRecovStage() * dPhiTensdXi;
		dSigmaYieldTotDLambdaPb = alphaRegularization * computeDSigmaYieldTotDEpsiPb11PlRecovStage() * dPhiTensdXi;

		dFchi1tdLambdaPb = -1 / pow((b_1tTrial * pow(sigmaBezier, 2)), 2) * ((2 * yieldStressTot * dSigmaYieldTotDLambdaPb - 2 * (dSigmaBezierDLambdaPb - dAlpha11TotDLambdaPb) *
			(sigmaBezier - backstressTot)) * (b_1tTrial * pow(sigmaBezier, 2)) - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot), 2)) * 2 * b_1tTrial * dSigmaBezierDLambdaPb * sigmaBezier);
		dChi1tDLambdaPB = -b_1tTrial * dFchi1tdLambdaPb;

		dCdLambdaPB = alphaRegularization * calculateDCdLambdaPB(etaTangent, dPhiTensdXi);

		gammaDiagPrime = -pow(gammaDiag, 2) * (dCdLambdaPB + 2. * (1. + chi1t) + 2. * consistParam_plRecov * dChi1tDLambdaPB);

		dXidLambda = gammaDiagPrime * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed - 2. * chi1t * consistParam_plRecov * backstressTot) - 2 * chi1t * gammaDiag * backstressTot - 2 * consistParam_plRecov * gammaDiag * backstressTot * dChi1tDLambdaPB - gammaDiagPrime / LambdaC_nPlus1Diag * backstressTot - gammaDiag * dCdLambdaPB * backstressTot - gammaDiag * 2. * chi1t * consistParam_plRecov * dAlpha11TotDLambdaPb - gammaDiag / LambdaC_nPlus1Diag * dAlpha11TotDLambdaPb;

		dPhiTensdLambdaPB = 2. * dXidLambda * (relativeStressNPlus1 + chi1t * stressTrial) + pow(stressTrial, 2) * dChi1tDLambdaPB + 2 * chi1t * stressTrial * dAlpha11TotDLambdaPb - 2 * dSigmaYieldTotDLambdaPb * yieldStressTot;

		// Do the Newton Step
		consistParam_plRecov = consistParam_plRecov - phiTens / dPhiTensdLambdaPB;

		strainPBEqTrial = strainPBEqIntermed * -psi * consistParam_plRecov;
		strainPostBucklingTrial = strainPostBucklingIntermed + consistParam_plRecov * dPhiTensdXi;
		if (strainPostBucklingTrial > 0)
		{
			break;
		}

		tBezier = calculateTBezier(alphaRegularization * strainPostBucklingTrial);
		sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
		yieldStressTot = computeYieldStressTotPlRecovStage(alphaRegularization * strainPostBucklingTrial);
		backstressTot = computeBackstressTotPlRecovStage(alphaRegularization * strainPostBucklingTrial);
		f1t = calculateF1t(yieldStressTot, backstressTot, alphaRegularization * strainPostBucklingTrial);
		chi1t = b_1tTrial * (1 - f1t);

		//if (iterationNumber_ReturnMapping > MAXIMUM_ITERATIONS_RETURNMAPPING - 2)
		//{
		//	strainPostBucklingTrial(0) = -strainPostBucklingIntermed(0); // Trick to divide strain increment by 2
		//	break;
		//}

		// Check convergence
		if (fabs(phiTens / (2. / 3. * pow(initialYield, 2))) < RETURN_MAP_TOL) {
			//if (fabs(phiTens) < RETURN_MAP_TOL*2./3.*pow(yieldStress,2)) {
			convergedReturnMapping = true;
		}

	} // end loop for return mapping iterations

	// Compute post-buckling yield stress
	yieldStressP = calculateYieldStressPlastic(strainPEqIntermed);
	yieldStressPBTrial = yieldStressTot - yieldStressP;

	// Update each post-buckling backstress
	backstressPTot = alphaPKIntermed[0] + alphaPKIntermed[1];
	backstress11Pb_nPlus1 = backstressTot - backstressPTot;
	double backstress1PB_nPlus1 = 0.;
	double backstress2PB_nPlus1 = 0.;
	backstress1PB_nPlus1 = rAlphaBackstress1Trial * backstress11Pb_nPlus1;
	backstress2PB_nPlus1 = rAlphaBackstress2Trial * backstress11Pb_nPlus1;
	alphaPBKTrial[0] = backstress1PB_nPlus1;
	alphaPBKTrial[1] = backstress2PB_nPlus1;

	// Update c1c for compressive yield surface
	//c1cTrial = c1cUnloadTrial * (strainPostBucklingTrial(0) / epsilonPB11UnloadTrial);
	computeReduceC1cLinearEvol();

	// Calculate the consistent tangent modulus for softening stage
	calculateConsistentTangentModulusPlRecovStage(strain_nPlus1, consistParam_plRecov, yieldStressTot, relativeStressNPlus1, backstressTot);

	// Warn the user if the algorithm did not convergein the return mapping for plastic recovery stage and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiTens / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		/*opserr << "HLBModelUniaxial::returnMappingPlRecovStage return mapping plastic recovery stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strainTrial[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strainTrial[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strainTrial[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiTens << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;
		retVal = -1;

		opserr << "This is strainTrial: " << strainTrial << endln;*/

		retVal = -1;
	}

	//// Try fix issue with nan 05.02.2025
	//if (isnan(phiTens))
	//{
	//	retVal = -1;
	//}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

int HLBModelUniaxial::returnMappingUVCRecovStage(double strain_nPlus1, double alphaTot) {
	// Initialize all the variables
	int retVal = 0;
	bool convergedReturnMapping = false;
	unsigned int iterationNumber_ReturnMapping = 0;
	double yieldStressP = 0.;
	double isotropicModulus = 0.;
	double beta = 0.;
	double alphaTilde = 0.;
	double eK = 0.;
	double gammaDiag = 0.;
	double consistParam_plastic = 0.;
	double f2bar = 0.;
	double fBar = 0.;
	double betaPrime = 0.;
	double alphaTildePrime = 0.;
	double gammaDiagPrime = 0.;
	double consistDenom = 0.;
	double phiVM = 0.;
	std::vector<double> alpha12Tot_Vector;
	double etaTangent = 0.;
	double LambdaC_nPlus1Diag = 0.;
	double relativeStressNPlus1 = 0.;
	double SumEKAlphaKTerm = 0.;
	double dEtaTangentdEpsiPb11 = 0.;
	double dCdLambdaP = 0.;
	double dXidLambda = 0.;
	double yieldStressTot = 0.;

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKIntermed[i] + alphaPBKIntermed[i]);
	}


	/*if (strainConverged(0) <= -0.011138 && strainConverged(0) > -0.011139 && strainTrial(0) >= -0.01078 && strainTrial(0) < -0.01077)
	{
		double testError = 1.;
	}*/

	strainPEqTrial = strainPEqIntermed;
	strainPostBucklingTrial = strainPostBucklingIntermed;

	// Do the return mapping algorithm for plastic loading
	while (!convergedReturnMapping && iterationNumber_ReturnMapping < MAXIMUM_ITERATIONS_RETURNMAPPING) {
		iterationNumber_ReturnMapping++;

		//etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingTrial(0));
		// Try solve issue with positive strainPostBucklingTrial(0) giving wrong etaTangent 05.02.2025
		etaTangent = 1.;
		LambdaC_nPlus1Diag = etaTangent * elasticTangent;

		// Isotropic hardening parameters
		yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
		yieldStressTot = yieldStressP + yieldStressPBTrial;
		isotropicModulus = calculateIsotropicModulus(strainPEqTrial);
		// Kinematic hardening parameters
		beta = 0.;
		alphaTilde=0.;
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			beta += cK[i] / gammaK[i] * (1. - eK);
			alphaTilde += alpha12Tot_Vector[i] * eK;
		}
		alphaTilde = alphaTot - alphaTilde;
		beta = 1. + beta / yieldStressTot;

		// Update the relative stress and eta
		gammaDiag = 1. / (beta + consistParam_plastic * 4. / 3. * LambdaC_nPlus1Diag);

		SumEKAlphaKTerm=0.;
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			SumEKAlphaKTerm += (alpha12Tot_Vector[i] * eK);
		}
		relativeStressNPlus1 = gammaDiag * (LambdaC_nPlus1Diag * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed) - SumEKAlphaKTerm);

		f2bar = 2. / 3. * pow(relativeStressNPlus1, 2);
		fBar = sqrt(f2bar);

		// Calculate Newton denominator
		betaPrime = 0.;
		alphaTildePrime=0.;
		for (unsigned int i = 0; i < nBackstresses; ++i) {
			eK = calculateEk(i);
			betaPrime = betaPrime - cK[i] * isotropicModulus / (gammaK[i] * pow(yieldStressTot, 2)) * (1. - eK)
				+ cK[i] * eK / yieldStressTot;
			alphaTildePrime = alphaTildePrime + gammaK[i] * eK * alpha12Tot_Vector[i];
		}
		betaPrime = betaPrime * sqrt(2. / 3.) * fBar;
		alphaTildePrime = alphaTildePrime * sqrt(2. / 3.) * fBar;

		//dEtaTangentdEpsiPb11 = -calculateDEtaTangentdEpsiPb11();
		// Try solve issue with positive strainPostBucklingTrial(0) giving wrong etaTangent 05.02.2025
		dEtaTangentdEpsiPb11 = 0.;
		dCdLambdaP = dEtaTangentdEpsiPb11 * 2 / 3 * relativeStressNPlus1 * elasticTangent;

		gammaDiagPrime = -pow(gammaDiag, 2) * (betaPrime + 4. / 3. * LambdaC_nPlus1Diag + 4. / 3. * dCdLambdaP * consistParam_plastic);

		dXidLambda = gammaDiagPrime * (LambdaC_nPlus1Diag * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed) - SumEKAlphaKTerm) + gammaDiag * (dCdLambdaP * (strain_nPlus1 - strainPlasticIntermed - strainPostBucklingIntermed) + alphaTildePrime);

		consistDenom = (2. / 3. * relativeStressNPlus1 * dXidLambda)- sqrt(2. / 3.) * 2. / 3. * yieldStressTot * isotropicModulus * fBar;

		// Newton step
		phiVM = 1. / 2. * f2bar - 1. / 3. * pow(yieldStressTot, 2);
		consistParam_plastic = consistParam_plastic - phiVM / (consistDenom + SMALL_NUMBER);
		strainPEqTrial = strainPEqIntermed + sqrt(2. / 3.) * consistParam_plastic * fBar;

		strainPostBucklingTrial = strainPostBucklingIntermed + consistParam_plastic * 2./3. * relativeStressNPlus1;

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
		alphaPKTrial[i] = alpha12Tot_Vector[i] - alphaPBKIntermed[i];
	}
	strainPlasticTrial = strainPlasticIntermed + consistParam_plastic * 2./3. * relativeStressNPlus1;

	/*etaTangent = calculateEtaTangentReduce();*/
	stressTrial = (etaTangent * elasticTangent) * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);

	// Update c1c for compressive yield surface
	//c1cTrial = c1cUnloadTrial * (strainPostBucklingTrial(0) / epsilonPB11UnloadTrial);
	computeReduceC1cLinearEvol();

	// Calculate the consistent tangent modulus for hardening stage
	calculateConsistentTangentModulusUVCRecov(strain_nPlus1, consistParam_plastic, fBar, relativeStressNPlus1);

	// Warn the user if the algorithm did not convergein the return mapping for hardening and return -1
	if (iterationNumber_ReturnMapping >= MAXIMUM_ITERATIONS_RETURNMAPPING && fabs(phiVM / (2. / 3. * pow(initialYield, 2))) > RETURN_MAP_TOL) {
		/*opserr << "HLBModelUniaxial::returnMappingUVCRecov return mapping UVC recovery stage did not converge!" << endln;
		opserr << "\tDelta epsilon 11 = " << strain_nPlus1[0] - strainConverged[0] << endln;
		opserr << "\tDelta epsilon 12 = " << strain_nPlus1[1] - strainConverged[1] << endln;
		opserr << "\tDelta epsilon 13 = " << strain_nPlus1[2] - strainConverged[2] << endln;
		opserr << "\tExiting with yield function = " << phiVM << " > " << RETURN_MAP_TOL * (2. / 3. * pow(initialYield, 2)) << endln;*/
		retVal = -1;
	}

	return retVal;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::calculateConsistentTangentModulusElastic(double etaTangent) {
	//stiffnessTrial = elasticMatrix;
	stiffnessTrial = etaTangent * elasticTangent;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::calculateConsistentTangentModulusHardening(double consistParam_plastic, double fBar,
	double stressRelative) {
	// Initialize the variables
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double isotropicModulus = 0.;
	double nHat = 0.;
	double eK = 0.;
	double beta = 0.;
	double hPrime = 0.;
	double aMat = 0.;
	double nTilde = 0.;
	double xiTilde = 0.;
	double xiTildeA = 0.;
	double theta_2 = 0.;
	double hTilde = 0.;
	double theta_1 = 0.;
	double etaTangent = 0.;
	std::vector<double> alpha12Tot_Vector;

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKConverged[i]); // Total backstress (P1+P2+Pb1+Pb2)
	}

	// Isotropic hardening parameters
	yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	isotropicModulus = calculateIsotropicModulus(strainPEqTrial);

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
	aMat = 1.0/(beta + consistParam_plastic * hPrime * nHat * 2./3.);

	nTilde = nHat - consistParam_plastic * aMat * hPrime;

	etaTangent = calculateEtaTangentReduce(strainPostBucklingTrial);

	xiTilde = 1./(1. / etaTangent * 1./elasticTangent + consistParam_plastic * 2./3. * aMat);
	xiTildeA = aMat * xiTilde;

	theta_2 = 1. - 2. / 3. * isotropicModulus * consistParam_plastic;
	hTilde = hPrime + xiTilde * (2./3. * nTilde);
	theta_1 = 2. / 3. * isotropicModulus + theta_2 * nHat * 2. / 3. * (aMat * hTilde);
	stiffnessTrial = xiTilde - theta_2 / theta_1 * xiTilde * 2./3. * nTilde * nHat * 2./3. * xiTildeA;

	//// Try to fix flat tangent issue
	//double alphaElastic = 0.01;
	//stiffnessTrial = alphaElastic * elasticMatrix + (1.- alphaElastic) * stiffnessTrial;

	return;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::calculateConsistentTangentModulusSoftening(double strain_nPlus1, double backstressTot,
	double relativeStressNPlus1, double stressTrial, double consistParam_postBuckling) {
	// Initialize the variables
	double dPhiCompDSigma = 0.;
	double chi1c = 0.;
	double gammaDiag = 0.;
	double sigmaSurSigmaY = 0;
	double dSigmaSurSigmaYdEpsilonPB11 = 0;
	double dGammaDChi1cDiag = 0.;
	double dXiDChi1c = 0.;
	double dPhiCompDChi1c = 0.;
	double dChi1cDepsiPB11 = 0.;
	double d2PhiCompDSigmaDChi1c = 0.;
	double d2PhiCompDSigma2Diag = 0.;
	double B = 0.;
	double D = 0.;
	double DPreFactor = 0.;
	double CepTerm1 = 0.;
	double CepTerm2 = 0.;
	double CepTerm3 = 0.;
	double etaTangent = 0.;
	double LambdaC_nPlus1Diag = 0.;
	double dEtaTangentdEpsiPb11 = 0.;
	double F = 0.;

	chi1c = calculateChi1c(strainPostBucklingTrial);

	etaTangent = calculateEtaTangentReduce(strainPostBucklingTrial);
	LambdaC_nPlus1Diag = etaTangent * elasticTangent;

	dPhiCompDSigma = 2. * (relativeStressNPlus1 + chi1c * stressTrial);

	gammaDiag = 1. / (1. / LambdaC_nPlus1Diag + consistParam_postBuckling * (2. + 2. * chi1c));

	//sigmaSurSigmaY = calculateSigmaSurSigmaY(strainPostBucklingTrial(0));
	sigmaSurSigmaY = (this->*calculateSigmaSurSigmaY)(strainPostBucklingTrial);
	//dSigmaSurSigmaYdEpsilonPB11 = calculateDSigmaSurSigmaYdEpsilonPB11();
	dSigmaSurSigmaYdEpsilonPB11 = (this->*calculateDSigmaSurSigmaYdEpsilonPB11)();

	dGammaDChi1cDiag = -2. * consistParam_postBuckling * pow(gammaDiag, 2);

	dXiDChi1c = dGammaDChi1cDiag * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingConverged - 2. * chi1c * consistParam_postBuckling * backstressTot) - 2 * consistParam_postBuckling * gammaDiag * backstressTot - dGammaDChi1cDiag / LambdaC_nPlus1Diag * backstressTot;

	dPhiCompDChi1c = 2. * dXiDChi1c * (relativeStressNPlus1 + chi1c * stressTrial) + pow(stressTrial, 2);

	dChi1cDepsiPB11 = 2. * b_chi1c * (1. - sigmaSurSigmaY) * dSigmaSurSigmaYdEpsilonPB11;

	d2PhiCompDSigma2Diag = 2. * (1. + chi1c);

	d2PhiCompDSigmaDChi1c = 2. * (dXiDChi1c * (1. + chi1c) + stressTrial);

	B = 1. / (1. - dChi1cDepsiPB11 * consistParam_postBuckling * d2PhiCompDSigmaDChi1c);

	dEtaTangentdEpsiPb11 = calculateDEtaTangentdEpsiPb11();

	F = -consistParam_postBuckling * d2PhiCompDSigmaDChi1c + dEtaTangentdEpsiPb11 * 1. / dChi1cDepsiPB11 * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);

	DPreFactor = 1. / (dPhiCompDChi1c * dChi1cDepsiPB11 * dPhiCompDSigma * B);
	D = DPreFactor * (dPhiCompDSigma + dPhiCompDChi1c * dChi1cDepsiPB11 * consistParam_postBuckling * d2PhiCompDSigma2Diag * B);

	CepTerm1 = d2PhiCompDSigma2Diag - dChi1cDepsiPB11 * F * d2PhiCompDSigma2Diag* B;
	/*CepTerm2 = D * (dPhiCompDSigma + consistParam_postBuckling * A * dPhiCompDSigma(0));*/
	//opserr << "This is dPhiCompDSigma" << dPhiCompDSigma << endln;
	//opserr << "This is D" << D << endln;
	CepTerm2 = D * (dChi1cDepsiPB11 * dPhiCompDSigma * B * F - dPhiCompDSigma);
	//opserr << "This is CepTerm2" << CepTerm2 << endln;

	CepTerm3 = 1. + elasticTangent * (consistParam_postBuckling * CepTerm1 + CepTerm2);
	//opserr << "This is CepTerm3" << CepTerm3 << endln;
	stiffnessTrial = elasticTangent * 1./CepTerm3;

	// Try to fix flat tangent issue
	//stiffnessTrial = 0.5 * (elasticMatrix + stiffnessTrial);
	//stiffnessTrial = 0.05 * elasticMatrix + 0.95 * stiffnessTrial;

	return;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::calculateConsistentTangentModulusPlRecovStage(double strain_nPlus1, double consistParam_plRecov, double yieldStressTot, double relativeStressNPlus1, double backstressTot) {
	// Initialize the variables
	double dPhiTensDSigma = 0.;
	double chi1t = 0.;
	double gammaDiag = 0.;
	double dGammaDChi1tDiag = 0.;
	double dXiDChi1t = 0.;
	double dPhiTensDChi1t = 0.;
	double dChi1tDEpsiPB11 = 0.;
	double d2PhiTensDSigmaDChi1t = 0.;
	double d2PhiTensDSigma2Diag = 0.;
	double B = 0.;
	double D = 0.;
	double DPreFactor = 0.;
	double CepTerm1 = 0.;
	double CepTerm2 = 0.;
	double CepTerm3 = 0.;
	double etaTangent = 0.;
	double LambdaC_nPlus1Diag = 0.;
	double dEtaTangentdEpsiPb11 = 0.;
	double F = 0.;
	double tBezier = 0.;
	double sigmaBezier = 0.;
	double dSigmaBezierDtBezier = 0.;
	double dEpsiBezierDtBezier = 0.;
	double dSigmaBezierDEpsiPb11 = 0.;
	double dAlpha11TotDEpsiPb11 = 0.;
	double dF1tDEpsiPB11 = 0.;
	double dPhiTensDAlpha = 0.;
	double d2PhiTensDSigmaDAlphaDiag = 0.;
	double H = 0.;
	double L = 0.;
	double dSigmaYieldTotDEpsiPb11 = 0.;
	double dPhiTensDSigmaYield = 0.;

	chi1t = calculateChi1t(yieldStressTot, backstressTot, alphaRegularization * strainPostBucklingTrial);

	etaTangent = calculateEtaTangentReduce(alphaRegularization * strainPostBucklingTrial);
	LambdaC_nPlus1Diag = etaTangent * elasticTangent;

	tBezier = calculateTBezier(alphaRegularization * strainPostBucklingTrial);
	sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierTrial + 3. * pow((1 - tBezier), 2) * tBezier * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1 - tBezier) * pow(tBezier, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tBezier, 3) * sigmaYrBezierTrial;
	dSigmaBezierDtBezier = -3. * pow((1. - tBezier), 2) * sigmaPrBezierTrial + 3. * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * sigmaYrBezierTrial;
	dEpsiBezierDtBezier = -3. * pow((1. - tBezier), 2) * abs(epsilonPB11UnloadTrial) + 3. * (abs(epsilonPB11UnloadTrial) + alphaPrBezierTrial) * (3. * pow(tBezier, 2) - 4. * tBezier + 1.) + 3. * (0. + alphaYrBezierTrial) * (2. - 3. * tBezier) * tBezier + 3. * pow(tBezier, 2) * 0.;
	dSigmaBezierDEpsiPb11 = -alphaRegularization * dSigmaBezierDtBezier / dEpsiBezierDtBezier;

	dAlpha11TotDEpsiPb11 = alphaRegularization * computeDAlpha11TotDEpsiPb11PlRecovStage();
	dSigmaYieldTotDEpsiPb11 = alphaRegularization * computeDSigmaYieldTotDEpsiPb11PlRecovStage();

	gammaDiag = 1. / (1. / LambdaC_nPlus1Diag + consistParam_plRecov * (2. + 2. * chi1t));

	dGammaDChi1tDiag = -2. * consistParam_plRecov * pow(gammaDiag, 2);

	dXiDChi1t = dGammaDChi1tDiag * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingConverged - 2. * chi1t * consistParam_plRecov * backstressTot) - 2 * consistParam_plRecov * gammaDiag * backstressTot - dGammaDChi1tDiag / LambdaC_nPlus1Diag * backstressTot;

	dF1tDEpsiPB11 = -1 / pow((b_1tTrial * pow(sigmaBezier, 2)), 2) * ((2 * yieldStressTot * dSigmaYieldTotDEpsiPb11 - 2 * (dSigmaBezierDEpsiPb11 - dAlpha11TotDEpsiPb11) *
		(sigmaBezier - backstressTot)) * (b_1tTrial * pow(sigmaBezier, 2)) - (pow(yieldStressTot, 2) - pow((sigmaBezier - backstressTot), 2)) * 2 * b_1tTrial * dSigmaBezierDEpsiPb11 * sigmaBezier);
	dChi1tDEpsiPB11 = -b_1tTrial * dF1tDEpsiPB11;

	dPhiTensDSigma = 2. * (relativeStressNPlus1 + chi1t * stressTrial);

	dPhiTensDChi1t = 2. * dXiDChi1t * (relativeStressNPlus1 + chi1t * stressTrial) + pow(stressTrial, 2);

	dPhiTensDAlpha = -2. * relativeStressNPlus1;

	dPhiTensDSigmaYield = -2 * yieldStressTot;

	d2PhiTensDSigma2Diag = 2. * (1. + chi1t);

	d2PhiTensDSigmaDChi1t = 2. * (dXiDChi1t * (1. + chi1t) + stressTrial);

	d2PhiTensDSigmaDAlphaDiag = -2.;

	B = 1. / (1. + 2 * consistParam_plRecov * dAlpha11TotDEpsiPb11 - dChi1tDEpsiPB11 * consistParam_plRecov * d2PhiTensDSigmaDChi1t);

	dEtaTangentdEpsiPb11 = alphaRegularization * calculateDEtaTangentdEpsiPb11();

	H = -2. / dChi1tDEpsiPB11 * dAlpha11TotDEpsiPb11 + d2PhiTensDSigmaDChi1t;

	L = (dPhiTensDAlpha * dAlpha11TotDEpsiPb11 + dPhiTensDSigmaYield * dSigmaYieldTotDEpsiPb11) / dChi1tDEpsiPB11 + dPhiTensDChi1t;

	F = -consistParam_plRecov * H + dEtaTangentdEpsiPb11 * 1. / dChi1tDEpsiPB11 * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);

	DPreFactor = 1. / (L * dChi1tDEpsiPB11 * dPhiTensDSigma * B);
	D = DPreFactor * (dPhiTensDSigma + L * dChi1tDEpsiPB11 * consistParam_plRecov * d2PhiTensDSigma2Diag * B);

	CepTerm1 = d2PhiTensDSigma2Diag - dChi1tDEpsiPB11 * F * d2PhiTensDSigma2Diag * B;
	/*CepTerm2 = D * (dPhiCompDSigma + consistParam_postBuckling * A * dPhiCompDSigma(0));*/
	//opserr << "This is dPhiCompDSigma" << dPhiCompDSigma << endln;
	//opserr << "This is D" << D << endln;
	CepTerm2 = D * (dChi1tDEpsiPB11 * dPhiTensDSigma * B * F - dPhiTensDSigma);
	//opserr << "This is CepTerm2" << CepTerm2 << endln;

	CepTerm3 = 1. + elasticTangent * (consistParam_plRecov * CepTerm1 + CepTerm2);
	//opserr << "This is CepTerm3" << CepTerm3 << endln;
	stiffnessTrial = elasticTangent * 1./CepTerm3;

	// Try to fix flat tangent issue
	//stiffnessTrial = 0.5 * (elasticMatrix + stiffnessTrial);
	//stiffnessTrial = 0.05 * elasticMatrix + 0.95 * stiffnessTrial;

	return;
}

/* ----------------------------------------------------------------------------------------------------------------- */
void HLBModelUniaxial::calculateConsistentTangentModulusUVCRecov(double strain_nPlus1, double consistParam_plastic, double fBar,
	double relativeStressNPlus1) {
	// Initialize the variables
	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	double isotropicModulus = 0.;
	double nHat = 0.;
	double eK = 0.;
	double beta = 0.;
	double hPrime = 0.;
	double aMat = 0.;
	double xiTilde = 0.;
	double xiTildeA = 0.;
	double theta_2 = 0.;
	double theta_1_intermVector = 0.;
	double theta_1 = 0.;
	double etaTangent = 0.;
	std::vector<double> alpha12Tot_Vector;
	double F = 0.;
	double dEtaTangentdEpsiPb11 = 0.;
	double lambdappMat = 0.;
	double theta_3 = 0.;

	// Fill alphaTot_Vector with the two vector
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alpha12Tot_Vector.push_back(alphaPKConverged[i] + alphaPBKConverged[i]); // Total backstress (P1+P2+Pb1+Pb2)
	}

	// Isotropic hardening parameters
	yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	isotropicModulus = calculateIsotropicModulus(strainPEqTrial);

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
	aMat = 1./(beta + consistParam_plastic * hPrime * nHat * 2./3.);

	dEtaTangentdEpsiPb11 = -calculateDEtaTangentdEpsiPb11();

	F = -1. * (1. + lambdappMat) * 2./3. * relativeStressNPlus1 + consistParam_plastic * (1. + lambdappMat) * 2./3. * fBar * aMat * hPrime + dEtaTangentdEpsiPb11 * 2. / 3. * relativeStressNPlus1 * (strain_nPlus1 - strainPlasticTrial - strainPostBucklingTrial);
	/*opserr << "This is F" << F << endln;*/

	xiTilde = 1./(1./elasticTangent + consistParam_plastic * (1. + lambdappMat) * 2./3. * aMat);
	xiTildeA = aMat * xiTilde;
	/*opserr << "This is xiTilde" << xiTilde << endln;
	opserr << "This is xiTildeA" << xiTildeA << endln;*/

	theta_2 = 1. - 2. / 3. * isotropicModulus * consistParam_plastic;
	theta_1_intermVector = 2./3. * aMat * (xiTilde * F - fBar * aMat * hPrime);
	/*opserr << "This is theta_1_intermVector" << theta_1_intermVector << endln;*/
	theta_1 = theta_2 * nHat* theta_1_intermVector - 2. / 3. * fBar * isotropicModulus;
	//opserr << "This is theta_1" << theta_1 << endln;

	theta_3 = -theta_2 * 2. / 3. * xiTildeA* nHat;
	//opserr << "This is theta_3" << theta_3 << endln;

	stiffnessTrial = xiTilde * (1. + F * theta_3 * 1. / theta_1);
	//opserr << "This is stiffnessTrial" << stiffnessTrial << endln;

	return;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param v new total strain vector.
* @return 0 if successful, -1 if return mapping did not converge.
*/
int HLBModelUniaxial::setTrialStrain(double v) {

	int rm_convergence;
	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial = v;

	// Do the return mapping and calculate the tangent modulus
	rm_convergence = timeIntegration();

	//// Get the strain increment decomposition
	//strainIncrementDecomposition = getStrainIncrementDecomposition();

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
int HLBModelUniaxial::setTrialStrain(double v, double r) {

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
int HLBModelUniaxial::setTrialStrainIncr(double v) {

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
int HLBModelUniaxial::setTrialStrainIncr(double v, double r) {

	// Reset the trial state
	revertToLastCommit();

	// Set the trial strain
	strainTrial += v;

	// Do the return mapping and calculate the tangent modulus
	timeIntegration();

	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::getStrain() {

	return strainTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::getStress() {

	//return stressTrial;
	stressOut = stressUnitFactor * stressTrial;
	return stressOut;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::getTangent() {

	//return stiffnessTrial;
	tangentOut = stressUnitFactor * stiffnessTrial;
	return tangentOut;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::getYieldStress() {

	double yieldStressP = 0.;
	double yieldStressTot = 0.;
	yieldStressP = calculateYieldStressPlastic(strainPEqTrial);
	yieldStressTot = yieldStressP + yieldStressPBTrial;
	//return yieldStressTot;
	return stressUnitFactor * yieldStressTot;

}

/* ----------------------------------------------------------------------------------------------------------------- */

Vector& HLBModelUniaxial::getStrainIncrementDecomposition() {

	//Compute each increment
	double deltaEpsiP = strainPlasticTrial - strainPlasticConverged;
	double deltaEpsiPb = strainPostBucklingTrial - strainPostBucklingConverged;
	double deltaEpsiE = strainTrial - strainConverged - deltaEpsiP - deltaEpsiPb;

	// Put everything in the vector
	strainIncrementDecomposition(0) = deltaEpsiE;
	strainIncrementDecomposition(1) = deltaEpsiP;
	strainIncrementDecomposition(2) = deltaEpsiPb;

	return strainIncrementDecomposition;
}

/* ----------------------------------------------------------------------------------------------------------------- */

Vector& HLBModelUniaxial::getStrainDecomposition() {

	//Compute each increment
	/*Vector epsiP = strainPlasticTrial;
	Vector epsiPb = strainPostBucklingTrial;
	Vector epsiE = strainTrial - epsiP - epsiPb;*/
	double epsiP = strainPlasticConverged;
	double epsiPb = strainPostBucklingConverged;
	double epsiE = strainConverged - epsiP - epsiPb;

	// Put everything in the matrix
	strainDecomposition(0) = epsiE;
	strainDecomposition(1) = epsiP;
	strainDecomposition(2) = epsiPb;

	return strainDecomposition;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::getPlasticStrains() {
	return strainPlasticTrial;
}

/* ----------------------------------------------------------------------------------------------------------------- */


double HLBModelUniaxial::getInitialTangent() {

	// todo: can make more efficient by changing this to elasticMatrix and removing stiffnessInitial as a variable
	//return stiffnessInitial;
	initialTangentOut = stressUnitFactor * stiffnessInitial;
	return initialTangentOut;
}

/* ----------------------------------------------------------------------------------------------------------------- */


double HLBModelUniaxial::getConvergedTangent() {
	//return stiffnessConverged;
	convergedTangentOut = stressUnitFactor * stiffnessConverged;
	return convergedTangentOut;
}


/* ----------------------------------------------------------------------------------------------------------------- */


double HLBModelUniaxial::getConvergedStress() {
	//return stressConverged;
	convergedStressOut = stressUnitFactor * stressConverged;
	return convergedStressOut;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int HLBModelUniaxial::commitState() {
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
int HLBModelUniaxial::revertToLastCommit() {

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

	setIntermediateVariables();

	return 0;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::setIntermediateVariables() {
	strainIntermed = strainConverged;
	strainPlasticIntermed = strainPlasticConverged;
	strainPEqIntermed = strainPEqConverged;
	strainPostBucklingIntermed = strainPostBucklingConverged;
	strainPBEqIntermed = strainPBEqConverged;
	stressIntermed = stressConverged;
	alphaPKIntermed = alphaPKConverged;
	alphaPBKIntermed = alphaPBKConverged;
	stiffnessIntermed = stiffnessConverged;
	sumEjIntermed = sumEjConverged;
	c1cIntermed = c1cConverged;

	b_1tIntermed = b_1tConverged;
	sigmaPrBezierIntermed = sigmaPrBezierConverged;
	sigmaYrBezierIntermed = sigmaYrBezierConverged;
	epsilonPB11UnloadIntermed = epsilonPB11UnloadConverged;
	backstressAfterCompressionIntermed = backstressAfterCompressionConverged;
	epsilonPB11MinIntermed = epsilonPB11MinConverged;
	alphaPrBezierIntermed = alphaPrBezierConverged;
	alphaYrBezierIntermed = alphaYrBezierConverged;
	kPrBezierIntermed = kPrBezierConverged;
	kYrBezierIntermed = kYrBezierConverged;
	rAlphaBackstress1Intermed = rAlphaBackstress1Converged;
	rAlphaBackstress2Intermed = rAlphaBackstress2Converged;
	c1cUnloadIntermed = c1cUnloadConverged;
	ErcIntermed = ErcConverged;
	sigmaCIntermed = sigmaCConverged;
	yieldStressPBIntermed = yieldStressPBConverged;
	sigmaYieldAfterCompressionIntermed = sigmaYieldAfterCompressionConverged;
	backstress11TotAfterFullPLRecovIntermed = backstress11TotAfterFullPLRecovConverged;
	sigmaYieldTotAfterFullPLRecovIntermed = sigmaYieldTotAfterFullPLRecovConverged;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @return 0 if successful
*/
int HLBModelUniaxial::revertToStart() {

	strainConverged=0.;
	strainPlasticConverged=0.;
	strainPEqConverged = 0.;
	strainPostBucklingConverged=0.;
	strainPEqConverged = 0.;
	strainPBEqConverged = 0.;
	stressConverged = 0.;
	plasticLoading = false;
	stiffnessConverged = 0.;
	for (unsigned int i = 0; i < nBackstresses; ++i) {
		alphaPKConverged[i] = 0.;
		alphaPBKConverged[i] = 0.;
	}
	sumEjConverged = 0.;
	c1cConverged = 0.;

	b_1tConverged = 0.;
	sigmaPrBezierConverged = 0.;
	sigmaYrBezierConverged = 0.;
	epsilonPB11UnloadConverged = 0.;
	backstressAfterCompressionConverged = 0.;
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
* Returns a new UniaxialMaterial with all the internal values copied.
* @return a to pointer to the copy
*
* This is called by GenericSectionXD
*/
UniaxialMaterial* HLBModelUniaxial::getCopy() {

	HLBModelUniaxial* theCopy;
	/*theCopy = new HLBModelUniaxial(this->getTag(), elasticModulus, poissonRatio,
			initialYield, qInf, bIso, dInf, aIso, cK, gammaK,
			bPlateWidth, tPlateThickness, sigmaC0Stress, alphaRegularization, plateType,
			beta1RegressionEuSurEl, beta2RegressionEuSurEl, beta3RegressionEuSurEl,
			beta1RegressionSigmaPrBezier, beta2RegressionSigmaPrBezier, beta3RegressionSigmaPrBezier,
			beta1RegressionSigmaYrBezier, beta2RegressionSigmaYrBezier, beta3RegressionSigmaYrBezier,
			beta1RegressionKPrBezier, beta2RegressionKPrBezier, beta3RegressionKPrBezier,
			beta1RegressionKYrBezier, beta2RegressionKYrBezier, beta3RegressionKYrBezier,
			beta1RegressionAlphaPrBezier, beta2RegressionAlphaPrBezier, beta3RegressionAlphaPrBezier,
			beta1RegressionAlphaYrBezier, beta2RegressionAlphaYrBezier, beta3RegressionAlphaYrBezier,
			beta1RegressionErc, beta2RegressionErc);*/
	theCopy = new HLBModelUniaxial(this->getTag(), elasticModulus,
		initialYield, qInf, bIso, dInf, aIso, cK, gammaK,
		bPlateWidth, tPlateThickness, sigmaC0Stress, alphaRegularization, plateType, steelMaterial, stressUnitFactor);

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

	theCopy->strainIntermed = strainIntermed;
	theCopy->strainPlasticIntermed = strainPlasticIntermed;
	theCopy->strainPEqIntermed = strainPEqIntermed;
	theCopy->strainPostBucklingIntermed = strainPostBucklingIntermed;
	theCopy->strainPBEqIntermed = strainPBEqIntermed;
	theCopy->stressIntermed = stressIntermed;
	theCopy->alphaPKIntermed = alphaPKIntermed;
	theCopy->alphaPBKIntermed = alphaPBKIntermed;
	theCopy->stiffnessIntermed = stiffnessIntermed;
	theCopy->sumEjIntermed = sumEjIntermed;
	theCopy->c1cIntermed = c1cIntermed;

	theCopy->b_1tIntermed = b_1tIntermed;
	theCopy->sigmaPrBezierIntermed = sigmaPrBezierIntermed;
	theCopy->sigmaYrBezierIntermed = sigmaYrBezierIntermed;
	theCopy->epsilonPB11UnloadIntermed = epsilonPB11UnloadIntermed;
	theCopy->backstressAfterCompressionIntermed = backstressAfterCompressionIntermed;
	theCopy->epsilonPB11MinIntermed = epsilonPB11MinIntermed;
	theCopy->alphaPrBezierIntermed = alphaPrBezierIntermed;
	theCopy->alphaYrBezierIntermed = alphaYrBezierIntermed;
	theCopy->kPrBezierIntermed = kPrBezierIntermed;
	theCopy->kYrBezierIntermed = kYrBezierIntermed;
	theCopy->rAlphaBackstress1Intermed = rAlphaBackstress1Intermed;
	theCopy->rAlphaBackstress2Intermed = rAlphaBackstress2Intermed;
	theCopy->c1cUnloadIntermed = c1cUnloadIntermed;
	theCopy->ErcIntermed = ErcIntermed;
	theCopy->sigmaCIntermed = sigmaCIntermed;
	theCopy->yieldStressPBIntermed = yieldStressPBIntermed;
	theCopy->sigmaYieldAfterCompressionIntermed = sigmaYieldAfterCompressionIntermed;
	theCopy->backstress11TotAfterFullPLRecovIntermed = backstress11TotAfterFullPLRecovIntermed;
	theCopy->sigmaYieldTotAfterFullPLRecovIntermed = sigmaYieldTotAfterFullPLRecovIntermed;


	return theCopy;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
* Not yet implemented for paralleliziation
* @param commitTag
* @param theChannel
* @return 0 if successful
*/
int HLBModelUniaxial::sendSelf(int commitTag, Channel& theChannel) {
	// Throw error to let the user know that paralleliziation not yet implemented
	opserr << "Fatal: Paralleliziation for HLBModelUniaxial is not implemented yet!" << endln;
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
int HLBModelUniaxial::recvSelf(int commitTag, Channel& theChannel,
	FEM_ObjectBroker& theBroker) {
	// Throw error to let the user know that paralleliziation not yet implemented
	opserr << "Fatal: Paralleliziation for HLBModelUniaxial is not implemented yet!" << endln;
	return -1;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param s the opensees output stream
* @param flag is 2 for standard output, 25000 for JSON output
(see OPS_Globals.h)
*/
void HLBModelUniaxial::Print(OPS_Stream& s, int flag) {

	// if (flag == OPS_PRINT_PRINTMODEL_MATERIAL) {
	if (flag == 2) {
		s << "HLBModelUniaxial tag: " << this->getTag() << endln;
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
		s << "\"type\": \"HLBModelUniaxial\", ";
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

void HLBModelUniaxial::calculateElasticStiffness() {
	elasticTangent = elasticModulus;
}
/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateYieldStressPlastic(double epsiPeq) {
	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * epsiPeq));
	sigmaY2 = dInf * (1. - exp(-aIso * epsiPeq));
	return initialYield + sigmaY1 - sigmaY2;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateIsotropicModulus(double epsiPeq) {
	double IsotropicModulus = 0.0;

	double sigmaY1, sigmaY2;
	sigmaY1 = qInf * (1. - exp(-bIso * epsiPeq));
	sigmaY2 = dInf * (1. - exp(-aIso * epsiPeq));
	IsotropicModulus = bIso * (qInf - sigmaY1) - aIso * (dInf - sigmaY2);

	return IsotropicModulus;
}

/* ----------------------------------------------------------------------------------------------------------------- */

/**
*
* @param i the i'th backstress
* @return computed eK factor
*
*/
double HLBModelUniaxial::calculateEk(unsigned int i) {
	return exp(-gammaK[i] * (strainPEqTrial - strainPEqConverged));
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateChi1c(double epsiPb11) {
	double chi1c = 0.;
	double sigmaSurSigmaY = 0.;

	//sigmaSurSigmaY = calculateSigmaSurSigmaY(epsiPb11);
	sigmaSurSigmaY = (this->*calculateSigmaSurSigmaY)(epsiPb11);

	/*chi1c = b_chi1c * pow((1.0 - sigmaSurSigmaY), 2);*/
	chi1c = b_chi1c * pow((1.0 - sigmaSurSigmaY), 2) + c1cTrial;

	return chi1c;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateSigmaSurSigmaY_WebPlate(double epsiPb11) {
	double sigmaSurSigmaY = 0.;
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;
	double strainPB11TrialRegularized = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2. * tan(alphaAngle));

	strainPB11TrialRegularized = abs(epsiPb11) * alphaRegularization;

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
	if (abs(epsiPb11) < 1e-10) { // if equal to 0 --> sigmaSurSigmaY=1
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
		if (pow(Q, 2) / 4. + pow(P, 3) / 27. < 0)
		{
			R = -Q / 2.;
		}
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


		double bound4Smoothin = 2. * SMALL_NUMBER;

		double sigmaSurSigmaY1XTilda = -EHat / (4. * DHat) + (+W + sqrt(-(3. * alpha + 2. * y + 2. * beta / W))) / 2.;
		if (-(3. * alpha + 2. * y + 2. * beta / W) < 0)
		{
			double sigmaSurSigmaY1XTilda = -EHat / (4. * DHat) + (+W) / 2.;
		}
		double sigmaSurSigmaY2XTilda = floorF1c + (strainPB11TrialRegularized - 1) * 1. / 1000.;

		double xTilda = (strainPB11TrialRegularized - 1. + SMALL_NUMBER) / bound4Smoothin;
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

		//sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda + (1. - gXTilda) * sigmaSurSigmaY1XTilda;
		if (gXTilda == 1.0)
		{
			sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda;
		}
		else
		{
			sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda + (1. - gXTilda) * sigmaSurSigmaY1XTilda;
		}

	}

	return sigmaSurSigmaY;

}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateSigmaSurSigmaY_FlangePlate(double epsiPb11) {
	double sigmaSurSigmaY = 0.;
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;
	double strainPB11TrialRegularized = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2. * tan(alphaAngle));

	strainPB11TrialRegularized = abs(epsiPb11) * alphaRegularization;

	//// Method 1
	//double p4eq = 0., q4eq = 0.;
	//double Delta0eq = 0.;
	//double Delta1eq = 0.;

	//// Check if strainPBEqTrial is equal to 0 
	//if (abs(strainPostBucklingTrial(0)) < 1e-10) { // if equal to 0 --> sigmaSurSigmaY=1
	//	sigmaSurSigmaY = 1.;
	//}
	//else {
	//	AHat = (pow(tPlateThickness, 2) * (1. - strainPB11TrialRegularized)) / (sin(2. * alphaAngle) * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
	//	BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - cPlate)) / (bPlateWidth * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
	//	CHat = (1. / 2. * tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2. * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2))), 2)) - bPlateWidth * tPlateThickness);

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
	if (abs(strainPostBucklingTrial) < 1e-10) { // if equal to 0 --> sigmaSurSigmaY=1
		sigmaSurSigmaY = 1.;
	}
	else {
		AHat = (pow(tPlateThickness, 2) * (1. - strainPB11TrialRegularized)) / (sin(2. * alphaAngle) * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
		BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - cPlate)) / (bPlateWidth * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2)));
		CHat = (1. / 2. * tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2. * sqrt(1. - pow((1. - strainPB11TrialRegularized), 2))), 2)) - bPlateWidth * tPlateThickness);

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
		if (pow(Q, 2) / 4. + pow(P, 3) / 27. < 0)
		{
			R = -Q / 2.;
		}
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


		double bound4Smoothin = 2. * SMALL_NUMBER;

		double sigmaSurSigmaY1XTilda = -EHat / (4. * DHat) + (+W + sqrt(-(3. * alpha + 2. * y + 2. * beta / W))) / 2.;
		if (-(3. * alpha + 2. * y + 2. * beta / W) < 0)
		{
			double sigmaSurSigmaY1XTilda = -EHat / (4. * DHat) + (+W) / 2.;
		}
		double sigmaSurSigmaY2XTilda = floorF1c + (strainPB11TrialRegularized - 1) * 1. / 1000.;

		double xTilda = (strainPB11TrialRegularized - 1. + SMALL_NUMBER) / bound4Smoothin;
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

		//sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda + (1. - gXTilda) * sigmaSurSigmaY1XTilda;
		if (gXTilda == 1.0)
		{
			sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda;
		}
		else
		{
			sigmaSurSigmaY = gXTilda * sigmaSurSigmaY2XTilda + (1. - gXTilda) * sigmaSurSigmaY1XTilda;
		}

	}

	return sigmaSurSigmaY;

}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_WebPlate() {
	double dSigmaSurSigmaYdEpsilonPB11 = 0.;
	double hStep = 1e-10;
	double alphaAngle = 0.;
	double cPlate = 0.;

	// Transform epsilonPBeq from double to complex number
	std::complex<double> epsilonPB11Regularized(alphaRegularization * abs(strainPostBucklingTrial), alphaRegularization * hStep);

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



	double bound4Smoothin = 2. * SMALL_NUMBER;

	double dSigmaSurSigmaYdEpsilonPBeq1XTilda = imag(sol4eq1_V02) / hStep;
	double dSigmaSurSigmaYdEpsilonPBeq2XTilda = 1. / 1000.;

	double xTilda = (real(epsilonPB11Regularized) - 1. + SMALL_NUMBER) / bound4Smoothin;
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

	dSigmaSurSigmaYdEpsilonPB11 = gXTilda * dSigmaSurSigmaYdEpsilonPBeq2XTilda + (1. - gXTilda) * dSigmaSurSigmaYdEpsilonPBeq1XTilda;



	return dSigmaSurSigmaYdEpsilonPB11;

}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateDSigmaSurSigmaYdEpsilonPB11_FlangePlate() {
	double dSigmaSurSigmaYdEpsilonPB11 = 0.;
	double hStep = 1e-10;
	double alphaAngle = 0.;
	double cPlate = 0.;

	// Transform epsilonPBeq from double to complex number
	std::complex<double> epsilonPB11Regularized(alphaRegularization * abs(strainPostBucklingTrial), alphaRegularization * hStep);

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

	std::complex<double> AHat = (pow(tPlateComplex, 2) * (oneComplex - epsilonPB11Regularized)) / (sinTwoAlphaComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2)));
	std::complex<double> BHat = (pow(tPlateComplex, 2) * (bPlateComplex - cPlateComplex)) / (bPlateComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2)));
	std::complex<double> CHat = (oneDivTwoComplex * tPlateComplex * sqrt(pow(cPlateComplex, 2) + pow((bPlateComplex / twoComplex * sqrt(oneComplex - pow((oneComplex - epsilonPB11Regularized), 2))), 2)) - bPlateComplex * tPlateComplex);

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



	double bound4Smoothin = 2. * SMALL_NUMBER;

	double dSigmaSurSigmaYdEpsilonPBeq1XTilda = imag(sol4eq1_V02) / hStep;
	double dSigmaSurSigmaYdEpsilonPBeq2XTilda = 1. / 1000.;

	double xTilda = (real(epsilonPB11Regularized) - 1. + SMALL_NUMBER) / bound4Smoothin;
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

	dSigmaSurSigmaYdEpsilonPB11 = gXTilda * dSigmaSurSigmaYdEpsilonPBeq2XTilda + (1. - gXTilda) * dSigmaSurSigmaYdEpsilonPBeq1XTilda;



	return dSigmaSurSigmaYdEpsilonPB11;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::initializeBChi1c() {
	b_chi1c = (pow(sigmaC0Stress, 2)) / ((pow(sigmaC0Stress, 2) - pow(sigmaDMStress, 2)) * pow(alpha_chi1c, 2));
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::initializeFloorF1c_WebPlate() {
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2. * tan(alphaAngle));

	double alpha = 0.;
	double beta = 0.;
	double gamma = 0.;
	double P = 0.;
	double Q = 0.;
	double R = 0.;
	double U = 0.;
	double y = 0.;
	double W = 0.;

	BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - 2. * cPlate)) / (bPlateWidth);
	CHat = (tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2.), 2)) - bPlateWidth * tPlateThickness);

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
	if (pow(Q, 2) / 4. + pow(P, 3) / 27. < 0)
	{
		R = -Q / 2.;
	}
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


	floorF1c = -EHat / (4. * DHat) + (+W) / 2.;


}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::initializeFloorF1c_FlangePlate() {
	double alphaAngle = 0.;
	double cPlate = 0.;
	double AHat = 0., BHat = 0., CHat = 0.;
	double DHat = 0., EHat = 0., FHat = 0., GHat = 0., HHat = 0.;

	alphaAngle = 55. * 3.1416 / 180.;
	cPlate = bPlateWidth / (2. * tan(alphaAngle));

	double alpha = 0.;
	double beta = 0.;
	double gamma = 0.;
	double P = 0.;
	double Q = 0.;
	double R = 0.;
	double U = 0.;
	double y = 0.;
	double W = 0.;

	BHat = (pow(tPlateThickness, 2.) * (bPlateWidth - cPlate)) / (bPlateWidth);
	CHat = (1. / 2. * tPlateThickness * sqrt(pow(cPlate, 2.) + pow((bPlateWidth / 2.), 2)) - bPlateWidth * tPlateThickness);

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
	if (pow(Q, 2) / 4. + pow(P, 3) / 27. < 0)
	{
		R = -Q / 2.;
	}
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


	floorF1c = -EHat / (4. * DHat) + (+W) / 2.;


}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateEtaTangentReduce(double epsiPb11) {
	double etaTangent = 0.;

	double epsiPb11_min = pow(1. / beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), -beta2RegressionEuSurEl), 1 / beta3RegressionEuSurEl);

	// Try to solve oscillation trap
	double bound4Smoothin = 50. / 100. * abs(epsiPb11_min);

	double a1XTilda = 1.;
	double a2XTilda = beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(abs(epsiPb11), beta3RegressionEuSurEl);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) - epsiPb11_min + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (epsiPb11 + epsiPb11_min + bound4Smoothin) / (2. * bound4Smoothin);
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

double HLBModelUniaxial::calculateDCdLambdaPB(double etaTangent, double dPhiCompdXiVector11) {
	double dCdLambdaPB = 0.;
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

	dCdLambdaPB= 1. / pow(etaTangent, 2) * dPhiCompdXiVector11 * dEtaTangentdEpsiPb11 * 1 / elasticTangent;

	return dCdLambdaPB;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateDEtaTangentdEpsiPb11() {
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
	double a2XTilda = beta3RegressionEuSurEl * beta1RegressionEuSurEl * pow((bPlateWidth / tPlateThickness), beta2RegressionEuSurEl) * pow(alphaRegularization * abs(strainPostBucklingTrial), (beta3RegressionEuSurEl - 1.));

	/*double xTilda = (abs(strainPostBucklingTrial(0)) - epsiPb11_min + bound4Smoothin) / (2 * bound4Smoothin);*/
	double xTilda = (alphaRegularization * strainPostBucklingTrial + epsiPb11_min + bound4Smoothin) / (2 * bound4Smoothin);
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

void HLBModelUniaxial::calculateC1c(double yieldStress, double alphaTot, double epsiPb11) {
	/*c1c = (pow(yieldStress, 2) - pow((-sigmaC0Stress - alphaTot11), 2)) / pow((-sigmaC0Stress), 2);*/
	//c1c = (pow(yieldStress, 2) - pow((-sigmaC - alphaTot11), 2)) / pow((-sigmaC), 2);

	//double stressTol = elasticMatrix(0,0)* SMALL_NUMBER; // Additional stress component due to tolerance
	//double stress4C1c = -sigmaC + stressTol;
	//c1cTrial = (pow(yieldStress, 2) - pow((-stress4C1c - alphaTot11), 2)) / pow((-stress4C1c), 2);

	//double stressTol = elasticMatrix(0,0)* SMALL_NUMBER; // Additional stress component due to tolerance
	//double stress4C1c = stressTrial(0) + stressTol;
	//c1cTrial = (pow(yieldStress, 2) - pow((-sigmaC + stressTol), 2)) / pow(stress4C1c, 2);

	double stressTol = elasticTangent * SMALL_NUMBER; // Additional stress component due to tolerance
	//double stressTol = 0.; // Additional stress component due to tolerance
	double sigma11UpdatedTol = stressTrial + stressTol;
	double xiTrial = (stressTrial + stressTol) - alphaTot;
	double xiVonMisesSquared = pow(xiTrial, 2);

	double chi_1c = (pow(yieldStress, 2) - xiVonMisesSquared) / pow(sigma11UpdatedTol, 2);
	//double chi_1c= (pow(yieldStress, 2) - pow((sigma11UpdatedTol - alphaTot(0)), 2)) / pow(sigma11UpdatedTol, 2);

	//c1cTrial = (pow(yieldStress, 2) - xiVonMisesSquared) / pow(sigma11UpdatedTol, 2);

	//double sigmaSurSigmaY = calculateSigmaSurSigmaY(epsiPb11);
	double sigmaSurSigmaY = (this->*calculateSigmaSurSigmaY)(epsiPb11);
	double sigmaSurSigmaYTerm = b_chi1c * pow((1. - sigmaSurSigmaY), 2);
	c1cTrial = chi_1c - sigmaSurSigmaYTerm;

}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::setTensileEllipsoidYieldSurf(double yieldStressTot, double alphaTot, double targetStress4PLRecov) {
	double sigmaPr_regression = 0.;
	double scaleFactorBezierStress = 0.;

	//Determine the stress at wich would reach Von-Mises yield surface
	scaleFactorBezierStress = 2 * yieldStressTot - (yieldStressTot - alphaTot);

	// Set quantities for Bezier curve
	alphaPrBezierTrial = beta1RegressionAlphaPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionAlphaPrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionAlphaPrBezier);
	alphaYrBezierTrial = beta1RegressionAlphaYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionAlphaYrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionAlphaYrBezier);
	sigmaYrBezierTrial = beta1RegressionSigmaYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionSigmaYrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionSigmaYrBezier);
	kPrBezierTrial = beta1RegressionKPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKPrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionKPrBezier) * sigmaYrBezierTrial;
	kYrBezierTrial = beta1RegressionKYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKYrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionKYrBezier) * sigmaYrBezierTrial;

	// Determine different stresses sigmaPr
	sigmaPr_regression = beta1RegressionSigmaPrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionSigmaPrBezier) * pow(alphaRegularization * abs(strainPostBucklingTrial), beta3RegressionSigmaPrBezier);
	sigmaPrBezierTrial = std::min(scaleFactorBezierStress, sigmaPr_regression * sigmaYrBezierTrial);

	// Check if Bezier curve becomes larger than sigmaY + alphaAfterCompression(1) this fixes issue with f1t > 1
	double AderivSigmaBezier = 6. * sigmaPrBezierTrial - 6. * sigmaYrBezierTrial + 9. * alphaPrBezierTrial * kPrBezierTrial - 9. * alphaYrBezierTrial * kYrBezierTrial;
	double BderivSigmaBezier = 6. * sigmaYrBezierTrial - 6. * sigmaPrBezierTrial - 12. * alphaPrBezierTrial * kPrBezierTrial + 6. * alphaYrBezierTrial * kYrBezierTrial;
	double CderivSigmaBezier = 3. * alphaPrBezierTrial * kPrBezierTrial;
	double tHat1 = (-BderivSigmaBezier + sqrt(pow(BderivSigmaBezier, 2.) - 4. * AderivSigmaBezier * CderivSigmaBezier)) / (2. * AderivSigmaBezier);
	double tHat2 = (-BderivSigmaBezier - sqrt(pow(BderivSigmaBezier, 2.) - 4. * AderivSigmaBezier * CderivSigmaBezier)) / (2. * AderivSigmaBezier);
	double sigmaBezierSAtTHat1 = pow((1. - tHat1), 3) * sigmaPrBezierTrial + 3. * pow((1. - tHat1), 2) * tHat1 * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tHat1) * pow(tHat1, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tHat1, 3) * sigmaYrBezierTrial;
	double sigmaBezierSAtTHat2 = pow((1. - tHat2), 3) * sigmaPrBezierTrial + 3. * pow((1. - tHat2), 2) * tHat2 * (sigmaPrBezierTrial + alphaPrBezierTrial * kPrBezierTrial) + 3. * (1. - tHat2) * pow(tHat2, 2) * (sigmaYrBezierTrial + alphaYrBezierTrial * kYrBezierTrial) + pow(tHat2, 3) * sigmaYrBezierTrial;
	/*if (sigmaBezierSAtTHat1 < sigmaPrBezierTrial || sigmaBezierSAtTHat2 < sigmaPrBezierTrial)*/
	if (sigmaBezierSAtTHat1 < 0. || sigmaBezierSAtTHat2 < 0.)
	{
		alphaPrBezierTrial = 0;
		alphaYrBezierTrial = 0;
	}

	// Determine epsiPb11Min
	//epsilonPB11MinTrial = -pow((1. / sigmaYrBezierTrial * scaleFactorBezierStress * 1. / beta1RegressionSigmaPrBezier * pow((bPlateWidth / tPlateThickness), -beta2RegressionSigmaPrBezier)), (1. / beta3RegressionSigmaPrBezier));
	epsilonPB11MinTrial = -pow((scaleFactorBezierStress * 1. / (beta1RegressionSigmaPrBezier * beta1RegressionSigmaYrBezier) * pow((bPlateWidth / tPlateThickness), -(beta2RegressionSigmaPrBezier + beta2RegressionSigmaYrBezier))),
		1. / (beta3RegressionSigmaPrBezier + beta3RegressionSigmaYrBezier));

	// Compute b_1t
	if (alphaRegularization * strainPostBucklingTrial < epsilonPB11MinTrial)
	{
		b_1tTrial = (pow(yieldStressTot, 2) - pow((sigmaPrBezierTrial - alphaTot), 2)) / pow(sigmaPrBezierTrial, 2);
	}
	else
	{
		b_1tTrial = 0.;
	}

	// Set epsilonPb11Unload
	epsilonPB11UnloadTrial = alphaRegularization * strainPostBucklingTrial;

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

double HLBModelUniaxial::calculateChi1t(double yieldStressTot, double alphaTot11, double epsiPb11) {
	double chi1t = 0.;
	double f1t = 0.;

	f1t = calculateF1t(yieldStressTot, alphaTot11, epsiPb11);

	chi1t = b_1tIntermed * (1. - f1t);

	return chi1t;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateF1t(double yieldStressTot, double alphaTot11, double epsiPb11) {
	double f1t = 0.;
	double tBezier = 0.;
	double sigmaBezier = 0.;

	if (b_1tTrial > 0.) // tensile yield surface is ellipsoid
	{
		tBezier = calculateTBezier(epsiPb11);
		sigmaBezier = pow((1. - tBezier), 3) * sigmaPrBezierIntermed + 3. * pow((1. - tBezier), 2) * tBezier * (sigmaPrBezierIntermed + alphaPrBezierIntermed * kPrBezierIntermed) + 3. * (1. - tBezier) * pow(tBezier, 2) * (sigmaYrBezierIntermed + alphaYrBezierIntermed * kYrBezierIntermed) + pow(tBezier, 3) * sigmaYrBezierIntermed;

		//f1t = 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - alphaTot11), 2)) / (b_1tTrial * pow(sigmaBezier, 2));
		f1t = std::min(1., 1. - (pow(yieldStressTot, 2) - pow((sigmaBezier - alphaTot11), 2)) / (b_1tIntermed * pow(sigmaBezier, 2)));
	}
	else // tensile yield surface is Von-Mises cylinder
	{
		f1t = 0.;
	}

	// Update f1t if no post-buckling strain
	if (abs(epsiPb11) < SMALL_NUMBER)
	{
		f1t = 1.; // I do this because during tensile hardening stage alphaTot11 and yieldStress change --> f1t not equal 1
	}

	return f1t;

	/*if (f1t > 1) {
		int testError = 1;
	}*/
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::calculateTBezier(double epsiPb11) {
	double tBezier = 0;

	std::complex<double> oneComplex(1., 0);
	std::complex<double> twoComplex(2., 0);
	std::complex<double> threeComplex(3., 0);
	std::complex<double> fourComplex(4., 0);
	std::complex<double> sixComplex(6., 0);
	std::complex<double> nineComplex(9., 0);
	std::complex<double> twentySevenComplex(27., 0);

	std::complex<double> a = threeComplex * alphaPrBezierIntermed - threeComplex * alphaYrBezierIntermed + twoComplex * abs(epsilonPB11UnloadTrial);
	std::complex<double> b = -sixComplex * alphaPrBezierIntermed + threeComplex * alphaYrBezierIntermed - threeComplex * abs(epsilonPB11UnloadTrial);
	std::complex<double> c = threeComplex * alphaPrBezierIntermed;
	std::complex<double> d = abs(epsilonPB11UnloadTrial) - abs(epsiPb11);

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

	if (abs(epsiPb11) > abs(epsilonPB11UnloadIntermed))
	{
		tBezier = 0.;
	}

	return tBezier;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::calculateRatioAlphaBackstress() {
	double dSigmaBezierDEpsiPb11 = 0.;
	double backstressPb11_endPlRecovStage = 0.; // total backstress component at end of plastic recovery stage
	double backstressP1 = 0.;
	double backstressP2 = 0.;
	double backstressP = 0.; // vector of plastic backstress alphaP1 + alphaP2 at time when computing
	double theta1 = 0.;
	double KPrime = 0.;
	double hPrime11 = 0.;
	double kYr = 0.;

	// Compute tangent Bezier curve
	kYr = beta1RegressionKYrBezier * pow((bPlateWidth / tPlateThickness), beta2RegressionKYrBezier) * pow(abs(epsilonPB11UnloadTrial), beta3RegressionKYrBezier);
	dSigmaBezierDEpsiPb11 = -kYr * sigmaYrBezierTrial * alphaRegularization;

	// Compute variables for UVC tangent
	backstressP1 = alphaPKConverged[0];
	backstressP2 = alphaPKConverged[1];
	backstressP = backstressP1 + backstressP2;
	backstressPb11_endPlRecovStage = backstress11TotAfterFullPLRecovTrial - backstressP;

	theta1 = 2. * elasticModulus / 3. * 1. / (1. - 1. / elasticModulus * dSigmaBezierDEpsiPb11);
	KPrime = qInf * bIso * exp(-bIso * strainPEqConverged) - dInf * aIso * exp(-aIso * strainPEqConverged);
	hPrime11 = sqrt(3. / 2.) * theta1 - sqrt(2. / 3.) * (KPrime + elasticModulus);

	// Compute ratios for update of post-buckling backstress during plastic recovery stage
	rAlphaBackstress1Trial = 1 / (backstressPb11_endPlRecovStage * (gammaK[0] - gammaK[1])) * (cK[0] + cK[1] - gammaK[0] * backstressP1 - gammaK[1] * backstressP2 - gammaK[1] * backstressPb11_endPlRecovStage - sqrt(3. / 2.) * hPrime11);
	rAlphaBackstress2Trial = 1. - rAlphaBackstress1Trial;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::initializeErc() {
	ErcConverged = beta1RegressionErc * pow(bPlateWidth / tPlateThickness, beta2RegressionErc);

	sigmaCConverged = sigmaC0Stress;
}

/* ----------------------------------------------------------------------------------------------------------------- */

void HLBModelUniaxial::computeSigmaCDegradation() {
	double betaDegradationParam = 0.;

	betaDegradationParam = std::min(1., sumEjTrial / ErcTrial);
	sigmaCTrial = (1 - betaDegradationParam) * sigmaC0Stress;
}

/* ----------------------------------------------------------------------------------------------------------------- */
double HLBModelUniaxial::computeBackstressTotPlRecovStage(double epsiPb11) {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = backstress11TotAfterFullPLRecovTrial;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (backstressAfterCompressionTrial - backstress11TotAfterFullPLRecovTrial) * epsiPb11 + backstress11TotAfterFullPLRecovTrial;

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (epsiPb11 + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
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

	double alphaP = alphaPKIntermed[0] + alphaPKIntermed[1];
	/*double alpha11Pb_nPlus1 = gXTilda * a2XTilda + (1. - gXTilda) * a1XTilda - alphaP(0);*/
	double alphaPb_nPlus1 = gXTilda * a1XTilda + (1. - gXTilda) * a2XTilda - alphaP;
	double BackstressTot = alphaP + alphaPb_nPlus1;

	return BackstressTot;
}

/* ----------------------------------------------------------------------------------------------------------------- */

double HLBModelUniaxial::computeYieldStressTotPlRecovStage(double epsiPb11) {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = sigmaYieldTotAfterFullPLRecovTrial;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (sigmaYieldAfterCompressionTrial - sigmaYieldTotAfterFullPLRecovTrial) * epsiPb11 + sigmaYieldTotAfterFullPLRecovTrial;

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (epsiPb11 + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
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
double HLBModelUniaxial::computeDAlpha11TotDEpsiPb11PlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (backstressAfterCompressionTrial - backstress11TotAfterFullPLRecovTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (alphaRegularization * strainPostBucklingTrial + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
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
double HLBModelUniaxial::computeDSigmaYieldTotDEpsiPb11PlRecovStage() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = 1 / epsilonPB11UnloadTrial * (sigmaYieldAfterCompressionTrial - sigmaYieldTotAfterFullPLRecovTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (alphaRegularization * strainPostBucklingTrial + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
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
void HLBModelUniaxial::computeReduceC1cLinearEvol() {
	/*double bound4Smoothin = 5. / 100. * abs(SMALL_NUMBER);*/
	double bound4Smoothin = 200. / 100. * abs(SMALL_NUMBER);

	double a1XTilda = 0.;
	double a2XTilda = c1cUnloadTrial * (alphaRegularization * strainPostBucklingTrial / epsilonPB11UnloadTrial);

	/*double xTilda = (abs(strainPostBucklingTrial(0)) + SMALL_NUMBER + bound4Smoothin) / (2. * bound4Smoothin);*/
	double xTilda = (alphaRegularization * strainPostBucklingTrial + SMALL_NUMBER + bound4Smoothin) / (bound4Smoothin);
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
