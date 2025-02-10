// 
// Created by Diego Heredia on 03.05.2024
// Version 03.05.2024
//

#ifndef CPP_HLBModel_H
#define CPP_HLBModel_H

#include <vector>
#include <string>
#include "NDMaterial.h"
#include <OPS_Globals.h>
#include <elementAPI.h>
#include "Matrix.h"
#include "Vector.h"

/* ------------------------------------------------------------------------ */

class HLBModel : public NDMaterial
{

	/* ------------------------------------------------------------------------ */
	/* Constructors/Destructors                                                 */
	/* ------------------------------------------------------------------------ */

public:
	// Constructor, called by clients
	HLBModel(int tag, double E, double poissonRatio, double sy0,
		double qInf, double b, double dInf, double a,
		std::vector<double> cK, std::vector<double> gammaK,
		double bPlate, double tPlate, double sigmaC0, double alphaReg, std::string plateType, std::string steelType);

	HLBModel(int tag, double E, double poissonRatio, double sy0,
		double qInf, double b, double dInf, double a,
		std::vector<double> cK, std::vector<double> gammaK,
		double bPlate, double tPlate, double sigmaC0, double alphaReg, std::string plateType,
		double beta1RegressionEuSurEl, double beta2RegressionEuSurEl, double beta3RegressionEuSurEl,
		double beta1RegressionSigmaPrBezier, double beta2RegressionSigmaPrBezier, double beta3RegressionSigmaPrBezier,
		double beta1RegressionSigmaYrBezier, double beta2RegressionSigmaYrBezier, double beta3RegressionSigmaYrBezier,
		double beta1RegressionKPrBezier, double beta2RegressionKPrBezier, double beta3RegressionKPrBezier,
		double beta1RegressionKYrBezier, double beta2RegressionKYrBezier, double beta3RegressionKYrBezier,
		double beta1RegressionAlphaPrBezier, double beta2RegressionAlphaPrBezier, double beta3RegressionAlphaPrBezier,
		double beta1RegressionAlphaYrBezier, double beta2RegressionAlphaYrBezier, double beta3RegressionAlphaYrBezier,
		double beta1RegressionErc, double beta2RegressionErc);

	// Constructor, parallel processing
	HLBModel(void);

	// Destructor
	~HLBModel();

	/* ------------------------------------------------------------------------ */
	/* Methods                                                                  */
	/* ------------------------------------------------------------------------ */

public:
	// Returns the class type
	const char* getClassType(void) const { return "HLBModel"; };

	// Returns the type of ND material
	const char* getType() const { return "BeamFiber"; };

	// Return the number of vector components
	int getOrder() const { return N_DIMS; };

	// Calculates the trial strain and stress, provided the total strain
	int setTrialStrain(const Vector& v);
	int setTrialStrain(const Vector& v, const Vector& r);

	// Calculates the trial strain and stress, provided the strain increment
	int setTrialStrainIncr(const Vector& v);
	int setTrialStrainIncr(const Vector& v, const Vector& r);

	// Returns the trial strain
	const Vector& getStrain(void);

	// Returns the trial stress
	const Vector& getStress(void);

	// Returns the trial elastoplastic tangent modulus
	const Matrix& getTangent(void);

	// Returns the total yield stress (plastic + post-buckling)
	double getYieldStress(void);
	//const Vector getYieldStress(void);

	// Returns the tangent modulus in the undeformed configuration
	const Matrix& getInitialTangent(void);

	// Returns the mass density of the material - zero mass assumed
	double getRho(void) { return 0.; };

	// Sets the converged state to be the current trial state
	int commitState(void);

	// Sets the trial state to be the converged state
	int revertToLastCommit(void);

	// Sets the converged state to the undeformed configuration
	int revertToStart(void);

	// Returns a copy of the material in the current state
	NDMaterial* getCopy(void);

	// Returns a copy of the material without copying the state variables
	NDMaterial* getCopy(const char* code);

	// sendSelf function
	int sendSelf(int commitTag, Channel& theChannel);

	// recvSelf function
	int recvSelf(int commitTag, Channel& theChannel,
		FEM_ObjectBroker& theBroker);

	// Adds the print information to the stream
	void Print(OPS_Stream& s, int flag = 0);

	// Return strain increment decomposition Vector(epsiE, epsiP, epsiPb)
	Matrix& getStrainIncrementDecomposition(void);

	// Return strain decomposition Vector(epsiE, epsiP, epsiPb)
	Matrix& getStrainDecomposition(void);

	// Return plastic strain components (11,12,13)
	Vector& getPlasticStrains(void);

	// Returns the commited elastoplastic tangent modulus
	const Matrix& getConvergedTangent(void);

	// Returns the commited stress vector
	const Vector& getConvergedStress(void);

private:
	// Determines the trial stress for the given strain increment and which return mapping could be needed
	int timeIntegration();

	// Sets the intermediate variables
	void setIntermediateVariables();

	// Return mapping for hardening stage
	int returnMappingHardening(Vector strain_nPlus1, Vector alphaTot, Vector eta_trial);

	// Return mapping for softening stage
	int returnMappingSoftening(Vector strain_nPlus1, Vector relativeStressTrial, Vector backstressTot, double yieldStressTot);

	//! Sets the elastoplastic tangent modulus for elastic stage
	void calculateConsistentTangentModulusElastic(double etaTangent);

	// Sets the elastoplastic tangent modulus for hardening stage
	void calculateConsistentTangentModulusHardening(double consistParam, double fBar,
		const Vector& stressRelative);

	// Sets the consistent tangent modulus for softening stage
	void calculateConsistentTangentModulusSoftening(const Vector& strain_nPlus1, const Vector& backstressTot, const Vector& relativeStressNPlus1, const Vector& stressTrial, double consistParam);

	// Returns the dot product of two length 3 vectors
	double dotprod3(const Vector& v1, const Vector& v2);

	// Calculates the elastic stiffness matrix
	void calculateElasticStiffness(void);

	// Calculates the compliance matrix
	Matrix calculateComplianceMatrix(void);

	// Initialize eigendecomposition matrices and diagonal matrices
	void initializeEigendecompositions(void);

	// Returns the current yield stress
	double calculateYieldStressPlastic(double epsiPeq);

	// Returns the isotropic hardening modulus
	double calculateIsotropicModulus(double epsiPeq);

	// Returns the current eK value
	double calculateEk(unsigned int i);

	// Returns the current value of chi1c
	double calculateChi1c(double epsiPb11);

	// Returns the current value of the ratio sigmaSurSigmaY
	double calculateSigmaSurSigmaY_WebPlate(double epsiPb11);
	double calculateSigmaSurSigmaY_FlangePlate(double epsiPb11);
	double (HLBModel::*calculateSigmaSurSigmaY) (double epsiPb11);

	// Returns the current value of the derivative dSigmaSurSigmaYdEpsilonPBeq
	double calculateDSigmaSurSigmaYdEpsilonPB11_WebPlate(void);
	double calculateDSigmaSurSigmaYdEpsilonPB11_FlangePlate(void);
	double (HLBModel::* calculateDSigmaSurSigmaYdEpsilonPB11) (void);

	// Initialize value of b_chi1c
	void initializeBChi1c(void);

	// Initialize value of floorF1c
	void initializeFloorF1c_WebPlate(void);
	void initializeFloorF1c_FlangePlate(void);
	void (HLBModel::* initializeFloorF1c) (void);

	//// Initialize value of sigmaYrO
	//void initializeSigmaYrO(void);

	// Computes elastic stiffness matrix 
	double calculateEtaTangentReduce(double epsiPb11);

	// Computes derivative of C elastic matrix moduli with respect to lambda_Pb
	Vector calculateDCdLambdaPB(double etaTangent, double dPhiCompdXiVector11);

	// Computes the derivative of etaTangent with respect to epsiPb11
	double calculateDEtaTangentdEpsiPb11(void);

	// Computes the values of constant c1c needed for buckling prior to yielding
	//void calculateC1c(double yieldStress, double alphaTot11);
	void calculateC1c(double yieldStressTot, Vector alphaTot, double epsiPb11);

	// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
	void setTensileEllipsoidYieldSurf(double yieldStressTot, Vector alphaTot, double targetStress4PLRecov);

	// Returns the current value of chi1t
	double calculateChi1t(double yieldStressTot, double alphaTot11, double epsiPb11);

	// Computes function f1t for tensile ellipsoid yield surface evolution
	double calculateF1t(double yieldStressTot, double alphaTot11, double epsiPb11);

	// Computes parameter tBezier for Bezier curve
	double calculateTBezier(double epsiPb11);

	// Computes the two ratios for backstress update during plastic recovery stage
	void calculateRatioAlphaBackstress();

	// Return mapping for plastic recovery stage
	int returnMappingPlRecovStage(Vector strain_nPlus1);

	// Sets the consistent tangent modulus for plastic recovery stage
	void calculateConsistentTangentModulusPlRecovStage(Vector strain_nPlus1, double consistParam_plRecov, double yieldStressTot, Vector relativeStressNPlus1, Vector backstressTot);

	// Return mapping for the UVC recovery stage
	int returnMappingUVCRecovStage(Vector strain_nPlus1, Vector alphaTot);

	// Sets the consistent tangent modulus for UVC recovery stage
	void calculateConsistentTangentModulusUVCRecov(Vector strain_nPlus1, double consistParam_plastic, double fBar, Vector relativeStressNPlus1);

	// Initialize value of reference energy capacity Erc and sigmaC=sigmaC
	void initializeErc();

	// Compute capping stress with cyclic degradation rule
	void computeSigmaCDegradation();

	// Compute alphaTot_n during plastic recovery stage
	Vector computeBackstressTotPlRecovStage(double epsiPb11);

	// Compute yieldStressTot_n during plastic recovery stage
	double computeYieldStressTotPlRecovStage(double epsiPb11);

	// Compute derivative dAlpha11TotDEpsiPb11 during plastic recovery stage
	double computeDAlpha11TotDEpsiPb11PlRecovStage();

	// Compute derivative dSigmaYieldTotDEpsiPb11 during plastic recovery stage
	double computeDSigmaYieldTotDEpsiPb11PlRecovStage();

	// Compute reduction in c1c linear evolution
	void computeReduceC1cLinearEvol();

	// Returns the component wise multiplication of two length 3 vectors
	Vector vecMult3(const Vector& v1, const Vector& v2);

	// Returns the inverse of a 3x3 matrix
	Matrix matinv3(const Matrix& m);

	/* ------------------------------------------------------------------------ */
	/* Members                                                                  */
	/* ------------------------------------------------------------------------ */

private:
	// Parameters
	const unsigned int N_HARDENING_PARAMS = 7;
	const unsigned int N_SOFTENING_PARAMS = 3;
	const unsigned int N_PARAM_PER_BACK = 2;
	const double RETURN_MAP_TOL = 1.0e-8;
	const double SMALL_NUMBER = 1.0e-6;
	//const unsigned int MAXIMUM_ITERATIONS_TIMEINTEGRATION = 1000;
	const unsigned int MAXIMUM_ITERATIONS_TIMEINTEGRATION = 10000;
	const unsigned int MAXIMUM_ITERATIONS_RETURNMAPPING = 500;
	const unsigned int N_DIRECT = 1;
	const unsigned int N_DIMS = 3;

	// Material properties, set by the constructor
	double elasticModulus;
	double shearModulus;
	double bulkModulus;
	double poissonRatio;
	double initialYield;
	double qInf;
	double bIso;
	double dInf;
	double aIso;
	Matrix stiffnessInitial;
	Matrix elasticMatrix;
	std::vector<double> cK;
	std::vector<double> gammaK;
	unsigned int nBackstresses;

	// Plate properties (for buckling stage), set by the constructor
	double bPlateWidth;
	double tPlateThickness;
	double sigmaC0Stress;

	// Regularization properties (for buckling stage), set by the constructor
	double alphaRegularization;

	// Plate type
	std::string plateType;

	//Steel material
	std::string steelMaterial;

	// Plate stress properties (fixed for now, could be set by the constructor)
	//const double alpha_chi1c = 1. / 3.;
	double alpha_chi1c;
	const double sigmaDMStress = 10; // in MPa
	//const double sigmaDMStress = 1.45; // in ksi
	double b_chi1c;
	double floorF1c;

	// Internal variables
	Vector strainConverged;
	Vector strainTrial;
	Vector strainPlasticConverged;
	Vector strainPlasticTrial;
	Vector strainPostBucklingConverged;
	Vector strainPostBucklingTrial;
	double strainPEqConverged;  // Equivalent plastic strain
	double strainPEqTrial;
	double strainPBEqConverged;  // Equivalent post buckling strain
	double strainPBEqTrial;
	Matrix strainIncrementDecomposition;
	Matrix strainDecomposition;

	Vector stressConverged;
	Vector stressTrial;
	std::vector<Vector> alphaPKConverged;
	std::vector<Vector> alphaPKTrial;
	std::vector<Vector> alphaPBKConverged;
	std::vector<Vector> alphaPBKTrial;
	Matrix stiffnessConverged;
	Matrix stiffnessTrial;
	double sumEjConverged; //Total energy dissipated
	double sumEjTrial;
	double c1cConverged;
	double c1cTrial;

	int elasticLoading;
	int plasticLoading;
	int postBucklingLoading;
	int PlRecoveryLoading;
	int UVCRecoveryLoading;
	/*double c1c = 0.;*/

	double b_1tConverged;
	double sigmaPrBezierConverged;
	double sigmaYrBezierConverged;
	double epsilonPB11UnloadConverged;
	Vector backstressAfterCompressionConverged;
	double epsilonPB11MinConverged;
	double alphaPrBezierConverged;
	double alphaYrBezierConverged;
	double kPrBezierConverged;
	double kYrBezierConverged;
	double rAlphaBackstress1Converged;
	double rAlphaBackstress2Converged;
	double c1cUnloadConverged;
	double ErcConverged;
	double sigmaCConverged;
	double yieldStressPBConverged;
	double sigmaYieldAfterCompressionConverged;
	double backstress11TotAfterFullPLRecovConverged;
	double sigmaYieldTotAfterFullPLRecovConverged;

	double b_1tTrial;
	double sigmaPrBezierTrial;
	double sigmaYrBezierTrial;
	double epsilonPB11UnloadTrial;
	Vector backstressAfterCompressionTrial;
	double epsilonPB11MinTrial;
	double alphaPrBezierTrial;
	double alphaYrBezierTrial;
	double kPrBezierTrial;
	double kYrBezierTrial;
	double rAlphaBackstress1Trial;
	double rAlphaBackstress2Trial;
	double c1cUnloadTrial;
	double ErcTrial;
	double sigmaCTrial;
	double yieldStressPBTrial;
	double sigmaYieldAfterCompressionTrial;
	double backstress11TotAfterFullPLRecovTrial;
	double sigmaYieldTotAfterFullPLRecovTrial;

	// Variables for intermediate state
	Vector strainIntermed;
	Vector strainPlasticIntermed;
	Vector strainPostBucklingIntermed;
	double strainPEqIntermed;
	double strainPBEqIntermed;
	Vector stressIntermed;
	std::vector<Vector> alphaPKIntermed;
	std::vector<Vector> alphaPBKIntermed;
	Matrix stiffnessIntermed;
	double sumEjIntermed;
	double c1cIntermed;
	double b_1tIntermed;
	double sigmaPrBezierIntermed;
	double sigmaYrBezierIntermed;
	double epsilonPB11UnloadIntermed;
	Vector backstressAfterCompressionIntermed;
	double epsilonPB11MinIntermed;
	double alphaPrBezierIntermed;
	double alphaYrBezierIntermed;
	double kPrBezierIntermed;
	double kYrBezierIntermed;
	double rAlphaBackstress1Intermed;
	double rAlphaBackstress2Intermed;
	double c1cUnloadIntermed;
	double ErcIntermed;
	double sigmaCIntermed;
	double yieldStressPBIntermed;
	double sigmaYieldAfterCompressionIntermed;
	double backstress11TotAfterFullPLRecovIntermed;
	double sigmaYieldTotAfterFullPLRecovIntermed;

	// Projection matrices and their eigendecomposition
	Vector pVect;
	Matrix ppMat;
	Matrix PMat;
	Matrix qMat;
	Matrix qMatT;  // transpose
	Vector lambdaC;
	Vector lambdaP;
	Vector lambdapp;

	// Parameters for regression formulas
	double beta1RegressionEuSurEl;
	double beta2RegressionEuSurEl;
	double beta3RegressionEuSurEl;
	double beta1RegressionSigmaPrBezier;
	double beta2RegressionSigmaPrBezier;
	double beta3RegressionSigmaPrBezier;
	double beta1RegressionSigmaYrBezier;
	double beta2RegressionSigmaYrBezier;
	double beta3RegressionSigmaYrBezier;
	double beta1RegressionKPrBezier;
	double beta2RegressionKPrBezier;
	double beta3RegressionKPrBezier;
	double beta1RegressionKYrBezier;
	double beta2RegressionKYrBezier;
	double beta3RegressionKYrBezier;
	double beta1RegressionAlphaPrBezier;
	double beta2RegressionAlphaPrBezier;
	double beta3RegressionAlphaPrBezier;
	double beta1RegressionAlphaYrBezier;
	double beta2RegressionAlphaYrBezier;
	double beta3RegressionAlphaYrBezier;
	double beta1RegressionErc;
	double beta2RegressionErc;




};

/* ------------------------------------------------------------------------ */

#endif //CPP_HLBModel_H