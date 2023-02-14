// 
// Created by Diego Heredia on 10.12.2021
// Version 14.02.2023
//

#ifndef CPP_LocalBucklingFlangePlate_H
#define CPP_LocalBucklingFlangePlate_H

#include <vector>
#include "NDMaterial.h"
#include <OPS_Globals.h>
#include <elementAPI.h>
#include "Matrix.h"
#include "Vector.h"

/* ------------------------------------------------------------------------ */

class LocalBucklingFlangePlate : public NDMaterial
{

	/* ------------------------------------------------------------------------ */
	/* Constructors/Destructors                                                 */
	/* ------------------------------------------------------------------------ */

public:
	// Constructor, called by clients
	LocalBucklingFlangePlate(int tag, double E, double poissonRatio, double sy0,
		double qInf, double b, double dInf, double a,
		std::vector<double> cK, std::vector<double> gammaK,
		double bPlate, double tPlate, double sigmaC0, double alphaReg);

	// Constructor, parallel processing
	LocalBucklingFlangePlate(void);

	// Destructor
	~LocalBucklingFlangePlate();

	/* ------------------------------------------------------------------------ */
	/* Methods                                                                  */
	/* ------------------------------------------------------------------------ */

public:
	// Returns the class type
	const char* getClassType(void) const { return "LocalBucklingFlangePlate"; };

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

	// Returns the yield stress (accounting for isotropic hardening)
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

private:
	// Determines the trial stress for the given strain increment and which return mapping could be needed
	int timeIntegration();

	// Return mapping for hardening stage
	int returnMappingHardening(Vector strain_nPlus1, Vector alphaTot, Vector eta_trial, int switchUVCRecovUVCPoint);

	// Return mapping for softening stage
	int returnMappingSoftening(Vector strain_nPlus1, Vector relativeStressTrial, Vector backstressTot);

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
	double calculateYieldStress(void);

	// Returns the isotropic hardening modulus
	double calculateIsotropicModulus(void);

	// Returns the current eK value
	double calculateEk(unsigned int i);

	// Returns the current value of chi1c
	double calculateChi1c(void);

	// Returns the current value of the ratio sigmaSurSigmaY
	double calculateSigmaSurSigmaY(void);

	// Returns the current value of the derivative dSigmaSurSigmaYdEpsilonPBeq
	double calculateDSigmaSurSigmaYdEpsilonPB11(void);

	// Initialize value of b_chi1c
	void initializeBChi1c(void);

	// Reverts to before the capping point
	int revertToBeforeCapping(bool cappingPoint);

	//// Initialize value of sigmaYrO
	//void initializeSigmaYrO(void);

	// Computes elastic stiffness matrix 
	double calculateEtaTangentReduce(void);

	// Computes derivative of C elastic matrix moduli with respect to lambda_Pb
	Vector calculateDCdLambdaPB(double etaTangent, double dPhiCompdXiVector11);

	// Computes the derivative of etaTangent with respect to epsiPb11
	double calculateDEtaTangentdEpsiPb11(void);

	// Computes the values of constant c1c needed for buckling prior to yielding
	//void calculateC1c(double yieldStress, double alphaTot11);
	void calculateC1c(double yieldStress, Vector alphaTot);

	// Set tensile ellipsoid yield surface properties for end of elastic recovery stage
	void setTensileEllipsoidYieldSurf(double yieldStress, Vector alphaTot);

	// Returns the current value of chi1t
	double calculateChi1t(double yieldStress, double alphaTot11);

	// Computes function f1t for tensile ellipsoid yield surface evolution
	double calculateF1t(double yieldStress, double alphaTot11);

	// Computes parameter tBezier for Bezier curve
	double calculateTBezier(void);

	// Computes the two ratios for backstress update during plastic recovery stage
	void calculateRatioAlphaBackstress(double yieldstress);

	// Reverts to before the switch between Pl Recov and UVC stage
	int revertToBeforeSwitchPlRecovUVC(bool switchPlRecovUVCPoint);

	// Return mapping for plastic recovery stage
	int returnMappingPlRecovStage(Vector strain_nPlus1);

	// Sets the consistent tangent modulus for plastic recovery stage
	void calculateConsistentTangentModulusPlRecovStage(Vector strain_nPlus1, double consistParam_plRecov, double yieldStress, Vector relativeStressNPlus1, Vector backstressTot);

	// Reverts to before the switch between UVC Recov and UVC stage
	int revertToBeforeSwitchUVCRecovUVC(bool switchUVCRecovUVCPoint);

	// Return mapping for the UVC recovery stage
	int returnMappingUVCRecovStage(Vector strain_nPlus1, Vector alphaTot);

	// Sets the consistent tangent modulus for UVC recovery stage
	void calculateConsistentTangentModulusUVCRecov(Vector strain_nPlus1, double consistParam_plastic, double fBar, Vector relativeStressNPlus1);

	// Initialize value of reference energy capacity Erc and sigmaC=sigmaC
	void initializeErc();

	// Compute capping stress with cyclic degradation rule
	void computeSigmaCDegradation();

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
	const double RETURN_MAP_TOL = 1.0e-6;
	const unsigned int MAXIMUM_ITERATIONS_TIMEINTEGRATION = 1000;
	const unsigned int MAXIMUM_ITERATIONS_RETURNMAPPING = 1000;
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

	// Plate stress properties (fixed for now, could be set by the constructor)
	/*const double alpha_chi1c = 1. / 3.;*/
	const double alpha_chi1c = 2. / 3.;
	const double sigmaDMStress = 10; // in MPa
	//const double sigmaDMStress = 1.45; // in ksi
	double b_chi1c;

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

	double b_1tOConverged;
	double b_1tSConverged;
	double sigmaPrBezierOConverged;
	double sigmaPrBezierSConverged;
	double sigmaYrBezierSConverged;
	double sigmaYrBezierOConverged;
	double epsilonPB11UnloadConverged;
	Vector backstressAfterCompressionConverged;
	double epsilonPB11MinConverged;
	double alphaPrBezierConverged;
	double alphaYrBezierConverged;
	double kPrBezierSConverged;
	double kYrBezierSConverged;
	double rAlphaBackstress1Converged;
	double rAlphaBackstress2Converged;
	double c1cUnloadConverged;
	double ErcConverged;
	double sigmaCConverged;

	double b_1tOTrial;
	double b_1tSTrial;
	double sigmaPrBezierOTrial;
	double sigmaPrBezierSTrial;
	double sigmaYrBezierSTrial;
	double sigmaYrBezierOTrial;
	double epsilonPB11UnloadTrial;
	Vector backstressAfterCompressionTrial;
	double epsilonPB11MinTrial;
	double alphaPrBezierTrial;
	double alphaYrBezierTrial;
	double kPrBezierSTrial;
	double kYrBezierSTrial;
	double rAlphaBackstress1Trial;
	double rAlphaBackstress2Trial;
	double c1cUnloadTrial;
	double ErcTrial;
	double sigmaCTrial;


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
	const double beta1RegressionEuSurEl = 2.048;
	const double beta2RegressionEuSurEl = -1.045;
	const double beta3RegressionEuSurEl = -0.258;

	const double beta1RegressionSigmaPrBezierS = 0.0174;
	const double beta2RegressionSigmaPrBezierS = 0.0;
	const double beta3RegressionSigmaPrBezierS = -0.692;
	const double beta1RegressionSigmaYrBezierO = 638.5;
	const double beta2RegressionSigmaYrBezierO = -0.0976;
	const double beta3RegressionSigmaYrBezierO = 0.0839;
	const double beta1RegressionKPrBezierS = -629.5;
	const double beta2RegressionKPrBezierS = -0.948;
	const double beta3RegressionKPrBezierS = -0.342;
	const double beta1RegressionKYrBezierS = -0.211;
	const double beta2RegressionKYrBezierS = 1.1148;
	const double beta3RegressionKYrBezierS = -0.5578;
	const double beta1RegressionAlphaPrBezier = -0.0076;
	const double beta2RegressionAlphaPrBezier = 0.455;
	const double beta3RegressionAlphaPrBezier = 0.654;
	const double beta1RegressionAlphaYrBezier = 5.45;
	const double beta2RegressionAlphaYrBezier = -0.761;
	const double beta3RegressionAlphaYrBezier = 1.27;
	const double beta1RegressionErc = 8.1152e3;
	const double beta2RegressionErc = -1.0211;

};

/* ------------------------------------------------------------------------ */

#endif //CPP_LocalBucklingFlangePlate_H