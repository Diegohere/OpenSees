// 
// Created by Diego Heredia on 10.12.2021
//

#ifndef CPP_LocalBucklingWebPlate_H
#define CPP_LocalBucklingWebPlate_H

#include <vector>
#include "NDMaterial.h"
#include <OPS_Globals.h>
#include <elementAPI.h>
#include "Matrix.h"
#include "Vector.h"

/* ------------------------------------------------------------------------ */

class LocalBucklingWebPlate : public NDMaterial
{

	/* ------------------------------------------------------------------------ */
	/* Constructors/Destructors                                                 */
	/* ------------------------------------------------------------------------ */

public:
	// Constructor, called by clients
	LocalBucklingWebPlate(int tag, double E, double poissonRatio, double sy0,
		double qInf, double b, double dInf, double a,
		std::vector<double> cK, std::vector<double> gammaK,
		double bPlate, double tPlate, double sigmaC0, double alphaReg);

	// Constructor, parallel processing
	LocalBucklingWebPlate(void);

	// Destructor
	~LocalBucklingWebPlate();

	/* ------------------------------------------------------------------------ */
	/* Methods                                                                  */
	/* ------------------------------------------------------------------------ */

public:
	// Returns the class type
	const char* getClassType(void) const { return "LocalBucklingWebPlate"; };

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
	int returnMappingHardening(Vector strain_nPlus1, Vector alphaTot, Vector eta_trial);

	// Return mapping for softening stage
	int returnMappingSoftening(Vector strain_nPlus1, Vector relativeStressTrial, Vector alphaTot);

	//! Sets the elastoplastic tangent modulus for elastic stage
	void calculateConsistentTangentModulusElastic(double etaTangent);

	// Sets the elastoplastic tangent modulus for hardening stage
	void calculateConsistentTangentModulusHardening(double consistParam, double fBar,
		const Vector& stressRelative);

	// Sets the consistent tangent modulus for softening stage
	void calculateConsistentTangentModulusSoftening(const Vector& strain_nPlus1, const Vector& alphaTot, const Vector& relativeStressNPlus1, const Vector& stressTrial, double consistParam);

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

	// Initialize value of sigmaYrO
	void initializeSigmaYrO(void);

	// Computes elastic stiffness matrix 
	double calculateEtaTangentReduce(void);

	// Computes derivative of C elastic matrix moduli with respect to lambda_Pb
	Vector calculateDCdLambdaPB(double etaTangent, double dPhiCompdXiVector11);

	// Computes the derivative of etaTangent with respect to epsiPb11
	double calculateDEtaTangentdEpsiPb11(void);

	// Computes the values of constant c1c needed for buckling prior to yielding
	void calculateC1c(double yieldStress, double alphaTot11);

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
	const double alpha_chi1c = 1. / 3.;
	const double sigmaDMStress = 10;
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
	int elasticLoading;
	int plasticLoading;
	int postBucklingLoading;
	int PlRecoveryLoading;
	double c1c = 0.;
	double b_1tO = 0.;
	double b_1tS = 0.;
	double sigmaPrBezierO = 0.;
	double sigmaPrBezierS = 0.;
	double sigmaYrBezierS = 1.;
	double sigmaYrBezierO = 0.;
	double epsilonPB11Unload = 0.;
	Vector backstressAfterCompression;
	double epsilonPB11Min = 1000.; // big number so that works for start with tension
	double alphaPrBezier = 0.;
	double alphaYrBezier = 0.;
	double kPrBezierS = 0.;
	double kYrBezierS = 0.;
	double rAlphaBackstress1 = 0.;
	double rAlphaBackstress2 = 0.;


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
	const double beta1RegressionEuSurEl = 2.59;
	const double beta2RegressionEuSurEl = -0.98;
	const double beta3RegressionEuSurEl = -0.37;
	const double beta1RegressionSigmaPrBezierS = 0.015;
	const double beta2RegressionSigmaPrBezierS = -0.302;
	const double beta3RegressionSigmaPrBezierS = -0.986;
	const double beta1RegressionSigmaYrBezierO = 2.0627;
	const double beta2RegressionSigmaYrBezierO = -0.2557;
	const double beta1RegressionKPrBezierS = -689.6;
	const double beta2RegressionKPrBezierS = -0.704;
	const double beta3RegressionKPrBezierS = -0.297;
	const double beta1RegressionKYrBezierS = -0.113;
	const double beta2RegressionKYrBezierS = 1.591;
	const double beta3RegressionKYrBezierS = -0.099;
	const double beta1RegressionAlphaPrBezier = -0.0094;
	const double beta2RegressionAlphaPrBezier = 0.295;
	const double beta3RegressionAlphaPrBezier = 0.638;
	const double beta1RegressionAlphaYrBezier = 5.49;
	const double beta2RegressionAlphaYrBezier = -1.04;
	const double beta3RegressionAlphaYrBezier = 0.817;

};

/* ------------------------------------------------------------------------ */

#endif //CPP_LocalBucklingWebPlate_H