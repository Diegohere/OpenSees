//-----------------------------------------------------------------------
// Date: 2023-04-29
// Description: CFSTsteel is used to construct a uniaxial steel material, which is intended to be used 
//              in concrte filled steel tube (CFST) and double skin composite wall (DSCW) as the steel 
//              material. It could consider the deterioration (local buckling and dutile fracture) of 
//              the steel in steel-concrete components under cyclic loads.          
//-----------------------------------------------------------------------
#include <math.h>
#include <cmath>
#include <iostream>
#include <stdlib.h>
#include <CFSTsteel.h>
#include <float.h>
#include <Channel.h>
#include <Information.h>
#include <Parameter.h>
#include <elementAPI.h>
#include <OPS_Globals.h>


void* OPS_CFSTsteel(void)
{
	UniaxialMaterial* theMaterial = 0;

	const int N_TAGS = 1;
	const int N_VC_PROPERTIES = 4;
	const int N_LOCALBUCKLING_PROPERTIES = 5;
	const int N_ENERGY_PROPERTIES = 5;
	const int N_DETERIORATION_PROPERTIES = 5;
	const int N_PARAM_PER_BACK = 2;
	const int MAX_BACKSTRESSES = 8;
	const int BACKSTRESS_SPACE = MAX_BACKSTRESSES * N_PARAM_PER_BACK;

	std::string inputInstructions = "Invalid args, want:\n"
		"uniaxialMaterial CFSTuniaxial "
		"tag? E? fy? QInf? b? DInf? a? "
		"N? C1? gamma1? <C2? gamma2? C3? gamma3? ... C8? gamma8?>\n";

	// Containers for the inputs
	int nInputsToRead;
	int nBackstresses[1];  // for N
	int materialTag[1];    // for the tag
	double vcProps[4];     // holds E, fy, QInf, b
	double lbProps[5];     // holds b2, siglb, a, sigr, b3 
	double enProps[5];     // holds Lambda_y, Lambda_lb, Lambda_a, Lambda_yneg, Lambda_re
	double deProps[5];     // holds C_y, C_lb, C_a, C_yneg, C_re
	double backstressProps[BACKSTRESS_SPACE];  // holds C's and gamma's
	std::vector<double> cK;
	std::vector<double> gammaK;

	// Get the material tag
	nInputsToRead = N_TAGS;
	if (OPS_GetIntInput(&nInputsToRead, materialTag) != 0) {
		opserr << "WARNING invalid uniaxialMaterial CFSTsteeluniaxial tag" << endln;
		return 0;
	}

	// Get E0, fy, qInf, b
	nInputsToRead = N_VC_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, vcProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}

	// Get b2, siglb, a, sigr, Er
	nInputsToRead = N_LOCALBUCKLING_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, lbProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}

	// Get Lambda_y, Lambda_lb, Lambda_a, Lambda_yneg
	nInputsToRead = N_ENERGY_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, enProps) != 0) {
		opserr << inputInstructions.c_str() << endln;
		return 0;
	}

	// Get C_y, C_lb, C_a, C_yneg
	nInputsToRead = N_DETERIORATION_PROPERTIES;
	if (OPS_GetDoubleInput(&nInputsToRead, deProps) != 0) {
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
	for (int i = 0; i < nBackstresses[0]; ++i) {
		cK.push_back(backstressProps[2 * i]);
		gammaK.push_back(backstressProps[1 + 2 * i]);
	}

	// Parsing was successful, Allocate the material
	theMaterial = new CFSTsteel(materialTag[0],
		vcProps[0], vcProps[1], vcProps[2], vcProps[3],
		lbProps[0], lbProps[1], lbProps[2], lbProps[3], lbProps[4],
		enProps[0], enProps[1], enProps[2], enProps[3], enProps[4],
		deProps[0], deProps[1], deProps[2], deProps[3], deProps[4],
		cK, gammaK);

	return theMaterial;
}

//第一个构造函数
CFSTsteel::CFSTsteel(int tag,
	double E0, double Fy, double qInf, double b,
	double b2, double siglb, double a, double sigr, double b3,
	double Lambda_y, double Lambda_lb, double Lambda_a, double Lambda_yneg, double Lambda_re,
	double C_y, double C_lb, double C_a, double C_yneg, double C_re,
	std::vector<double> cK, std::vector<double> gammaK)
	: UniaxialMaterial(tag, MAT_TAG_CFSTsteel),
	E0(E0), Fy(Fy), qInf(qInf), b(b),
	b2(b2), siglb(siglb), a(a), sigr(sigr), b3(b3),
	Lambda_y(Lambda_y), Lambda_lb(Lambda_lb), Lambda_a(Lambda_a), Lambda_yneg(Lambda_yneg), Lambda_re(Lambda_re),
	C_y(C_y), C_lb(C_lb), C_a(C_a), C_yneg(C_yneg), C_re(C_re),
	cK(cK), gammaK(gammaK),
	strainConverged(0.), strainTrial(0.), strainPEqConverged(0.), strainPEqTrial(0.), stressConverged(0.), stressTrial(0.),
	stiffnessInitial(E0), stiffnessConverged(E0), stiffnessTrial(E0), flowDirection(0.), plasticLoading(false)
{
	nBackstresses = cK.size();
	for (int i = 0; i < nBackstresses; ++i) {
		alphaKTrial.push_back(0.);
		alphaKConverged.push_back(0.);
	}
	this->revertToStart();
}



//第二个构造函数，将所有的成员变量初始化为零
CFSTsteel::CFSTsteel() :
	UniaxialMaterial(0, MAT_TAG_CFSTsteel)
{
	this->revertToStart();
}

//析构函数，不需要进行任何补充定义
CFSTsteel::~CFSTsteel(void)
{
	// Does nothing
}

double
CFSTsteel::getInitialTangent(void)
{
	return E0;
}


int CFSTsteel::setTrialStrain(double trialStrain, double strainRate)
{
	//all variables to the last commit
	this->revertToLastCommit();
	eps = trialStrain;
	double deps = eps - eps_1;
	double strainIncrement = eps - strainConverged;

	// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	// %%%%%%%% INITIALIZE CURRENT BACKBONE VALUES AS PREVIOUS %%%%%%%%%%%%
	// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	double Eb_pos_j = Eb_pos_j_1;
	double sigy_project_pos_j = sigy_project_pos_j_1;
	double siglb_project_j = siglb_project_j_1;
	double Eb_neg_j = Eb_neg_j_1;
	double sigy_project_neg_j = sigy_project_neg_j_1;
	double epslb_j = epslb_j_1;
	double siglb_j = siglb_j_1;
	double a_j = a_j_1;
	double sigr_j = sigr_j_1;
	double E_r_j = E_r_j_1;

	//%%%%%%%%%%%%%%%%%%%%%%%%%%%  CORE CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	 // Find the direction of the current increment "Di": 1:if Ri is moving right    and -1: if Ri is moving left
	if (eps >= eps_1) {
		Di = 1;
	}
	else {
		Di = -1;
	}

	//  Check if previous point was a reversal point
	if (Di_1 / Di < 0) {
		Reversal_Flag = 1;
		epsreversal_2 = epsreversal_1;
		sigreversal_2 = sigreversal_1;
		epsreversal_1 = epsreversal;
		sigreversal_1 = sigreversal;
		epsreversal = eps_1;
		sigreversal = sig_1;
	}

	//  Calculate Backbone parameters at current excursion based on Energy Dissipated in the previous Excursion
	if (Excursion_Flag == 1.0) {
		if (eps - eps_1 >= 0.0) {
			//  Update sigy_project_pos,Eb_pos_j
			beta_y_j = pow((Energy_Excrsn / (Ref_Energy_y - Energy_total)), C_y);
			Eb_pos_j = Eb_pos_j_1 * (1.0 - beta_y_j);
		}
		else {
			//  Update sigy_project_pos,Eb_pos_j
			beta_lb_j = pow((Energy_Excrsn / (Ref_Energy_lb - Energy_total)), C_lb);
			beta_a_j = pow((Energy_Excrsn / (Ref_Energy_a - Energy_total)), C_a);
			beta_yneg_j = pow((Energy_Excrsn / (Ref_Energy_yneg - Energy_total)), C_yneg);
			beta_re_j = pow((Energy_Excrsn / (Ref_Energy_re - Energy_total)), C_re);
			sigy_project_neg_j = sigy_project_neg_j_1 * (1.0 - beta_yneg_j);
			Eb_neg_j = Eb_neg_j_1 * (1.0 - beta_yneg_j);
			siglb_project_j = siglb_project_j_1 * (1.0 - beta_lb_j);
			sigr_j = sigr_j_1 * (1.0 - beta_lb_j);
			a_j = a_j_1 * (1.0 - beta_a_j);
			E_r_j = E_r_j_1 * (1.0 - beta_re_j);
		}
	}
	else {
		if (eps - eps_1 >= 0.0) {
			beta_y_j = beta_y_j_1;
			Eb_pos_j = Eb_pos_j_1;
		}
		else {
			beta_lb_j = beta_lb_j_1;
			beta_a_j = beta_a_j_1;
			beta_yneg_j = beta_yneg_j_1;
			a_j = a_j_1;
			sigy_project_neg_j = sigy_project_neg_j_1;
			Eb_neg_j = Eb_neg_j_1;
			siglb_project_j = siglb_project_j_1;
			sigr_j = sigr_j_1;
			E_r_j = E_r_j_1;
		}
	}

	if (((fabs(sig) >= Fy) || (fabs(eps) > fabs(epsy_neg))) && (Yield_Flag == 0.0)) {
		Yield_Flag = 1.0;
	}

	if (((eps_max_Flag == 1.0) && (deps < 0.0) && (Yield_Flag == 1.0)) || ((Buckling_flag == 0.0) && (Di_1 / Di < 0.0) && (deps < 0.0) && (lbstage == 2.0))) {
		epsdiatance = epsreversal - sigreversal / E0;
	}


	/////////////////////////////////////////  Modify code  /////////////////////////////////////////////

	if (kon == 0 || kon == 10) {
		if (fabs(deps) < 10.0 * DBL_EPSILON)
		{
			e = E0;
			kon = 10;
			return 0;
		}
		else
		{
			if (deps < 0.0)
			{
				kon = 2; //kon = 2表示第一次往负向加载
			}
			else {
				kon = 1; //kon = 1表示第一次往正向加载
			}
		}
	}

	if ((kon == 1) && (deps > 0.0)) {     //第一次往正向加载
		kon = 1;
		returnMapping(strainIncrement);
		calculateStiffness();
		sig = stressTrial;
		e = stiffnessTrial;
	}

	if ((kon == 2) && (deps > 0.0) && (Yield_Flag == 0.0)) {
		returnMapping(strainIncrement);
		calculateStiffness();
		if (eps < 0.0) {
			kon = 2;
			sig = sig_1 + deps * E0;
			e = E0;
		}
		else {
			kon = 1;
			sig = stressTrial;
			e = stiffnessTrial;
		}
	}

	if ((kon == 1 || kon == 2) && (deps < 0.0) && (Yield_Flag == 0.0)) {
		returnMapping(strainIncrement);
		calculateStiffness();
		if (eps > 0.0) {
			kon = 1;
			sig = stressTrial;
			e = stiffnessTrial;
		}
		else {
			kon = 2;
			sig = sig_1 + deps * E0;
			e = E0;
		}
	}

	//负向加载(-)
	if ((kon == 2 || kon == 1 || kon == 5) && (deps < 0.0) && (Yield_Flag == 1.0)) {
		kon = 2;
		returnMapping(strainIncrement);
		calculateStiffness();
		sig_Trial = sig_1 + deps * E0;
		epsy_neg = sigy_project_neg_j / (E0 - Eb_neg_j);
		double sig_eps_y = sigr_j + siglb_project_j * exp(a_j * (epsy_neg));
		if (sig_eps_y <= (E0 * epsy_neg)) {
			double JD_1 = sigy_project_neg_j / (E0 - Eb_neg_j);
			double JD_2 = Newtoniteration1(0.0);
			//double epsdiatance = epsreversal - sigreversal / E0;
			if (((JD_1 + epsdiatance) < eps) && (eps <= epsreversal)) {
				lbstage = 1.0;
				sig = E0 * (eps - epsreversal) + sigreversal;
				e = E0;
			}
			if (((JD_2 + epsdiatance) < eps) && (eps <= (JD_1 + epsdiatance))) {
				lbstage = 1.0;
				sig = Eb_neg_j * (eps - epsdiatance) + sigy_project_neg_j;
				e = Eb_neg_j;
			}
			if (((JD_2 + epsdiatance + 0.6 * (JD_2 - JD_1)) < eps) && (eps <= (JD_2 + epsdiatance))) {
				lbstage = 1.0;
				sig = sigr_j + siglb_project_j * exp(a_j * (eps - epsdiatance));
				e = (a_j)*siglb_project_j * exp(a_j * (eps - epsdiatance));
			}
			if (eps <= (JD_2 + epsdiatance + 0.6 * (JD_2 - JD_1))) {
				lbstage = 2.0;
				sig = sigr_j + siglb_project_j * exp(a_j * (eps - epsdiatance));
				e = (a_j)*siglb_project_j * exp(a_j * (eps - epsdiatance));
			}
			curve_epslb = JD_2 + epsdiatance;
			siglb_j = Eb_neg_j * JD_2 + sigy_project_neg_j;
			epslb_j = JD_2 + epsdiatance;
		}
		else {
			double JD_1 = Newtoniteration2(0.0);
			//double epsdiatance = epsreversal - sigreversal / E0;
			if (((JD_1 + epsdiatance) < eps) && (eps <= epsreversal)) {
				lbstage = 1.0;
				sig = E0 * (eps - epsreversal) + sigreversal;
				e = E0;
			}
			if ((1.6 * JD_1 + epsdiatance) < eps <= (JD_1 + epsdiatance)) {
				lbstage = 1.0;
				sig = sigr_j + siglb_project_j * exp(a_j * (eps - epsdiatance));
				e = (a_j)*siglb_project_j * exp(a_j * (eps - epsdiatance));
			}
			if (eps <= (1.6 * JD_1 + epsdiatance)) {
				lbstage = 2.0;
				sig = sigr_j + siglb_project_j * exp(a_j * (eps - epsdiatance));
				e = (a_j)*siglb_project_j * exp(a_j * (eps - epsdiatance));
			}
			curve_epslb = JD_1 + epsdiatance;
			siglb_j = sigr_j + siglb_project_j * exp(a_j * JD_1);
			epslb_j = JD_1 + epsdiatance;
		}
		if (sig >= sig_Trial) {
			sig = sig;
			e = e;
		}
		else {
			sig = sig_Trial;
			e = E0;
		}
	}

	//工况5(+)：屈曲恢复后，往负向加载，后往正向加载
	if ((kon == 5 || kon == 2) && (deps > 0.0) && (Yield_Flag == 1.0)) {
		kon = 5;
		returnMapping(strainIncrement);
		calculateStiffness();
		sig_Trial = E_r_j * (eps - epsreversal) + sigreversal;
		double JD_3_eps = Newtoniteration3(0.0);
		//double JD_3_sig = E_r_j * (JD_3_eps - epsreversal) + sigreversal;

		if ((epsreversal <= eps) && (lbstage == 1.0)) {
			if (sig < sig_iso) {
				sig = E_r_j * (eps - epsreversal) + sigreversal;
				e = E_r_j;
			}
			else {
				sig = sig_1 + Eb_neg_j * deps;
				e = Eb_neg_j;
			}
		}
		if ((Minus_Flag == 0.0) && (lbstage == 2.0)) {
			if ((epsreversal <= eps) && (eps < JD_3_eps)) {
				sig = E_r_j * (eps - epsreversal) + sigreversal;
				e = E_r_j;
			}
			if (JD_3_eps <= eps) {
				sig = sig_1 + deps * (-b3 * a_j * siglb_project_j * exp(a_j * (eps - epsdiatance)));
				e = -b3 * a_j * siglb_project_j * exp(a_j * (eps - epsdiatance));
			}
		}
		if ((Minus_Flag == 1.0) && (lbstage == 2.0)) {
			if ((epsreversal <= eps) && (eps < JD_3_eps)) {
				sig = E_r_j * (eps - epsreversal) + sigreversal;
				e = E_r_j;
			}
			if (JD_3_eps <= eps) {
				sig = sig_1 + deps * (-b3 * a_j * siglb_project_j * exp(a_j * (eps - epsdiatance)));
				if (sig <= stressTrial) {
					sig = sig;
					e = -b3 * a_j * siglb_project_j * exp(a_j * (eps - epsdiatance));
				}
				else {
					sig = stressTrial;
					e = stiffnessTrial;
				}
			}
		}
		if (fabs(sig) <= fabs(sig_Trial)) {
			sig = sig;
			e = e;
		}
		else {
			sig = sig_Trial;
			e = E0;
		}
	}

	// %%%%%%%%%%%%% Energy Calculation %%%%%%%%%%%%%
	Energy_total = Energy_total + (sig + sig_1) * 0.5 * (eps - eps_1); //  total energy dissipated till current incremental step

	// Energy calculation at each new excursion  如何判断新的Excursion
	if ((sig / sig_1) < 0.0) {
		Energy_Excrsn = Energy_total - Energy_Excrsni_1;	// total energy dissipated in current excursion
		Energy_Excrsni_1 = Energy_total;					// total energy dissipated in previous excursion
		Excursion_Flag = 1;
	}
	else {
		Excursion_Flag = 0.0;
	}

	// Check if the Component inheret Reference Energy is Consumed
	if (Excursion_Flag == 1) {
		if ((Energy_total >= Ref_Energy_y) || (Energy_total >= Ref_Energy_lb) || (Energy_total >= Ref_Energy_a) || (Energy_total >= Ref_Energy_yneg) || (Energy_total >= Ref_Energy_re)) {
			Energy_Flag = 1;
		}
		if ((beta_y_j > 1) || (beta_lb_j > 1) || (beta_a_j > 1) || (beta_yneg_j > 1) || (beta_re_j > 1)) {
			Energy_Flag = 1;
		}
	}

	//判断局部屈曲的程度
	if ((deps < 0) && lbstage == 2.0) {
		Bucklingdegree = eps - curve_epslb;
	}
	if ((deps > 0) && lbstage == 2.0) {
		Bucklingdegree = Bucklingdegree + deps;
	}
	if (Bucklingdegree > 0) {
		Bucklingdegree = 0;
	}
	if (deps > 0) {
		if (Bucklingdegree == 0) {
			Buckling_flag = 0;
		}
		else {
			Buckling_flag = 1;
		}
	}

	//判断受拉段该用唯象还是chaboche
	if ((kon == 5) && (deps > 0)) {
		if (stiffnessTrial != E0) {
			Minus_Flag = 1.0;
		}
		else {
			Minus_Flag = 0.0;
		}
	}

	//防止横穿X轴,设置boundary
	if (kon == 5) {
		double sig_boundaryup = E_r_j * (1.7 * fabs(sigreversal) / E_r_j) + sigreversal;
		if (sig_boundaryup <= 0) {
			Energy_Flag = 1;
		}
	}

	if (Energy_Flag == 1) {
		sig = 5;
	}

	//%%%%%%%%%% Find New Tensile State %%%%%%%%%%%%%
	if (eps_max > eps) {
		eps_max = eps_max;
		eps_max_Flag = 0.0;
	}
	else {
		eps_max = eps;
		eps_max_Flag = 1.0;
	}

	// %%%%%%%%%% Memory Point %%%%%%%%%%%%%
	if (Yield_Flag != 0.0) {
		if ((e != E0) && (e != E_r_j)) {
			kon_re = kon;
			eps_re = eps;
			sig_re = sig;
			e_re = e;
			deps_re = eps - eps_1;
			epsreversal_re = epsreversal;
			sigreversal_re = sigreversal;
			lbstage_re = lbstage;
			Minus_Flag_re = Minus_Flag;
		}
		if ((e == E0) || (e == E_r_j)) {//危机出现
			reloading_Flag = 1.0;
		}
		if (fabs(e / e_1) <= 0.9) {//危机解除，曲线已经脱离弹性段
			reloading_Flag = 0.0;
		}
		if ((reloading_Flag == 1.0) && (deps / deps_re > 0.0) && (kon == 5)) {//返回记忆点
			if (sig > sig_re) {
				kon = kon_re;
				sig = sig_re;
				e = e_re;
				epsreversal = epsreversal_re;
				sigreversal = sigreversal_re;
				lbstage = lbstage_re;
				Minus_Flag = Minus_Flag_re;
			}
		}
	}


	// %%%%%%%%%% PREPARE RETURN VALUES %%%%%%%%%%%%%
	Eb_pos_j_1 = Eb_pos_j;
	sigy_project_pos_j_1 = sigy_project_pos_j;
	Eb_neg_j_1 = Eb_neg_j;
	E_r_j_1 = E_r_j;
	sigy_project_neg_j_1 = sigy_project_neg_j;
	epslb_j_1 = epslb_j;
	siglb_project_j_1 = siglb_project_j;
	siglb_j_1 = siglb_j;
	a_j_1 = a_j;
	eps_2 = eps_1;
	eps_1 = eps;
	sig_2 = sig_1;
	sig_1 = sig;
	e_2 = e_1;
	e_1 = e;
	Di_2 = Di_1;
	Di_1 = Di;
	kon_2 = kon_1;
	kon_1 = kon;
	Minus_Flag_2 = Minus_Flag_1;
	Minus_Flag_1 = Minus_Flag;

	beta_y_j_1 = beta_y_j;
	beta_lb_j_1 = beta_lb_j;
	beta_a_j_1 = beta_a_j;
	beta_yneg_j_1 = beta_yneg_j;
	beta_re_j_1 = beta_re_j;
	Minus_1 = Minus;

	// %%%%%%%%%%%%%%%%%%%%%% END OF MAIN CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
	return 0;
}

// %%%%%%%%%%%%%%%%%%%%%% Newtoniteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%
double CFSTsteel::function1(double x1)
{
	return ((sigr_j_1 + siglb_project_j_1 * exp(a_j_1 * x1)) - (Eb_neg_j_1 * x1 + sigy_project_neg_j_1));
}
double CFSTsteel::function2(double x2)
{
	return (a_j_1 * siglb_project_j_1 * exp(a_j_1 * x2) - Eb_neg_j_1);
}
double CFSTsteel::function3(double x3)
{
	return ((sigr_j_1 + siglb_project_j_1 * exp(a_j_1 * x3)) - E0 * x3);
}
double CFSTsteel::function4(double x4)
{
	return (a_j_1 * siglb_project_j_1 * exp(a_j_1 * x4) - E0);
}
double CFSTsteel::function5(double x5)
{
	return (-0.7 * (sigr_j_1 + siglb_project_j_1 * exp(a_j_1 * (x5 - epsdiatance))) - (E_r_j_1 * (x5 - epsreversal) + sigreversal));
}
double CFSTsteel::function6(double x6)
{
	return (-0.7 * (a_j_1)*siglb_project_j_1 * exp(a_j_1 * (x6 - epsdiatance)) - E_r_j_1);
}

double CFSTsteel::Newtoniteration1(double x0)
{
	double fx = function1(x0);
	double fdx = function2(x0);
	double h = x0 - (fx / fdx);
	int i = 0;
	while (abs(h - x0) > 10.0e-6)
	{
		x0 = h;
		i++;
		h = x0 - (function1(x0) / function2(x0));
		if (i > 1000)
		{
			break;
		}
	}
	return h;
}
double CFSTsteel::Newtoniteration2(double x0)
{
	double fx = function3(x0);
	double fdx = function4(x0);
	double h = x0 - (fx / fdx);
	int i = 0;
	while (abs(h - x0) > 10.0e-6)
	{
		x0 = h;
		i++;
		h = x0 - (function3(x0) / function4(x0));
		if (i > 1000)
		{
			break;
		}
	}
	return h;
}
double CFSTsteel::Newtoniteration3(double x0)
{
	double fx = function5(x0);
	double fdx = function6(x0);
	double h = x0 - (fx / fdx);
	int i = 0;
	while (abs(h - x0) > 10.0e-6)
	{
		x0 = h;
		i++;
		h = x0 - (function5(x0) / function6(x0));
		if (i > 1000)
		{
			break;
		}
	}
	return h;
}

void CFSTsteel::returnMapping(double strainIncrement) {
	// Initialize all the variables
	bool converged = true;
	int iterationNumber = 0;
	double sigmaY1 = 0.;
	double dit = 0.;
	double plasticStrainIncrement = 0.;
	double aux = 0.;
	double alpha = 0.;
	double sy = 0.;
	double stressRadius = 0.;
	double phi = 0.;
	double ePEq = strainPEqConverged;

	// Yield criteria
	for (int i = 0; i < nBackstresses; ++i) {
		alpha += alphaKConverged[i];
	}
	sigmaY1 = qInf * (1. - exp(-b * ePEq));
	sy = Fy + sigmaY1;
	stressTrial = stressConverged + E0 * strainIncrement;
	stressRadius = stressTrial - alpha;
	phi = pow(stressRadius, 2) - pow(sy, 2);

	// Determine if have elastic or plastic loading
	if (phi > RETURN_MAP_TOL) {
		converged = false;
	}
	while ((!converged) && (iterationNumber < MAXIMUM_ITERATIONS)) {
		iterationNumber++;

		aux = E0;
		for (int i = 0; i < nBackstresses; ++i) {
			aux = aux + sgn<double>(stressRadius) * cK[i] - gammaK[i] * alphaKTrial[i];
		}

		// Calculate the plastic strain from the strain increment
		dit = 2. * stressRadius * aux +
			2. * sy * qInf * b * exp(-b * ePEq);
		plasticStrainIncrement = phi / dit;

		// Prevent Newton step from overshooting
		if (abs(plasticStrainIncrement) > abs(stressTrial / E0)) {
			plasticStrainIncrement = sgn<double>(plasticStrainIncrement) * 0.95 * abs(stressTrial / E0);
		}

		// Update the variables
		ePEq = ePEq + abs(plasticStrainIncrement);
		stressTrial = stressTrial - E0 * plasticStrainIncrement;
		sigmaY1 = qInf * (1. - exp(-b * ePEq));
		sy = Fy + sigmaY1;
		sig_iso = sy;

		alpha = 0.;
		for (int i = 0; i < nBackstresses; ++i) {
			alphaKTrial[i] = sgn<double>(stressRadius) * cK[i] / gammaK[i] -
				(sgn<double>(stressRadius) * cK[i] / gammaK[i] - alphaKConverged[i]) * exp(-gammaK[i] * (ePEq - strainPEqConverged));
			alpha += alphaKTrial[i];
		}

		// Check convergence
		stressRadius = stressTrial - alpha;
		phi = pow(stressRadius, 2) - pow(sy, 2);
		if (abs(phi) < RETURN_MAP_TOL) {
			converged = true;
		}
	}

	// Warn the user if the algorithm did not converge
	if (iterationNumber == MAXIMUM_ITERATIONS - 1) {
		opserr << "WARNING: return mapping in VCuniaxial does not converge!" << endln;
		opserr << "\tStrain increment = " << strainIncrement << endln;
		opserr << "\tExiting with phi = " << phi << " > " << RETURN_MAP_TOL << endln;
	}

	// Condition for plastic loading is whether or not iterations were performed
	if (iterationNumber == 0) {
		plasticLoading = false;
	}
	else {
		plasticLoading = true;
	}

	flowDirection = sgn<double>(stressRadius);
	strainPEqTrial = ePEq;
	return;
}

void CFSTsteel::calculateStiffness() {
	if (!plasticLoading) {
		stiffnessTrial = E0;
	}
	else {
		double sigmaY1 = qInf * (1. - exp(-b * strainPEqTrial));
		double plasticModulus = 0.;

		plasticModulus = b * (qInf - sigmaY1);
		for (int i = 0; i < nBackstresses; ++i) {
			plasticModulus += gammaK[i] *
				(cK[i] / gammaK[i] - flowDirection * alphaKTrial[i]);
		}
		stiffnessTrial = (E0 * plasticModulus) /
			(E0 + plasticModulus);
	}
	return;
}

double CFSTsteel::getStrain(void)
{
	return eps;
}

double CFSTsteel::getStress(void)
{
	return sig;
}

double CFSTsteel::getTangent(void)
{
	//return e;

	double alphaElastic = 0.05;
	return alphaElastic * E0 + (1. - alphaElastic) * e;
}

int CFSTsteel::commitState(void)
{
	cEb_pos_j_1 = Eb_pos_j_1;
	csigy_project_pos_j_1 = sigy_project_pos_j_1;
	cEb_neg_j_1 = Eb_neg_j_1;
	cE_r_j_1 = E_r_j_1;
	csigy_project_neg_j_1 = sigy_project_neg_j_1;
	cepslb_j_1 = epslb_j_1;
	csiglb_j_1 = siglb_j_1;
	ca_j_1 = a_j_1;
	csigr_j_1 = sigr_j_1;
	cslope_lb_j_1 = slope_lb_j_1;
	cslope_r_j_1 = slope_r_j_1;
	csiglb_project_j_1 = siglb_project_j_1;
	csigr_project_j_1 = sigr_project_j_1;
	cDi = Di;
	cDi_1 = Di_1;
	cDi_2 = Di_2;
	cepsreversal = epsreversal;
	csigreversal = sigreversal;
	cepsreversal_1 = epsreversal_1;
	csigreversal_1 = sigreversal_1;
	cepsreversal_2 = epsreversal_2;
	csigreversal_2 = sigreversal_2;
	csig = sig;
	csig_1 = sig_1;
	csig_2 = sig_2;
	ceps = eps;
	ceps_1 = eps_1;
	ceps_2 = eps_2;
	ckon = kon;
	ckon_1 = kon_1;
	ckon_2 = kon_2;
	clbstage = lbstage;
	cbeta_y_j_1 = beta_y_j_1;
	cbeta_lb_j_1 = beta_lb_j_1;
	cbeta_a_j_1 = beta_a_j_1;
	cbeta_yneg_j_1 = beta_yneg_j_1;
	cbeta_re_j_1 = beta_re_j_1;
	ccurve_epslb = curve_epslb;
	ccurve_epsr = curve_epsr;
	cbeta_y_j = beta_y_j;
	cbeta_lb_j = beta_lb_j;
	cbeta_a_j = beta_a_j;
	cbeta_yneg_j = beta_yneg_j;
	cbeta_re_j = beta_re_j;

	cExcursion_Flag = Excursion_Flag;
	cReversal_Flag = Reversal_Flag;
	cEnergy_Excrsni_1 = Energy_Excrsni_1;
	cEnergy_Flag = Energy_Flag;
	cYield_Flag = Yield_Flag;
	cBucklingdegree = Bucklingdegree;
	cBuckling_flag = Buckling_flag;
	cStiffness_neg_Flag = Stiffness_neg_Flag;
	cEnergy_Excrsn = Energy_Excrsn;
	cEnergy_total = Energy_total;
	ce = e;
	ce_1 = e_1;
	ce_2 = e_2;

	ceps_inflection = eps_inflection;
	csig_inflection = sig_inflection;
	ce_inflection = e_inflection;
	cepsdiatance = epsdiatance;

	cMinus = Minus;
	cMinus_1 = Minus_1;
	cMinus_Flag = Minus_Flag;
	cMinus_Flag_1 = Minus_Flag_1;
	cMinus_Flag_2 = Minus_Flag_2;
	cStiffness_neg = Stiffness_neg;
	csig_iso = sig_iso;
	csig_lb_re = sig_lb_re;

	ckon_re = kon_re;
	ceps_re = eps_re;
	csig_re = sig_re;
	ce_re = e_re;
	cdeps_re = deps_re;
	cepsreversal_re = epsreversal_re;
	csigreversal_re = sigreversal_re;
	creloading_Flag = reloading_Flag;

	csig_Trial = sig_Trial;
	ceps_max = eps_max;
	ceps_max_Flag = eps_max_Flag;
	clbstage_re = lbstage_re;
	cMinus_Flag_re = Minus_Flag_re;

	strainConverged = eps;
	strainPEqConverged = strainPEqTrial;
	stressConverged = stressTrial;
	alphaKConverged = alphaKTrial;
	stiffnessConverged = stiffnessTrial;

	return 0;
}

int CFSTsteel::revertToLastCommit(void)
{
	Eb_pos_j_1 = cEb_pos_j_1;
	sigy_project_pos_j_1 = csigy_project_pos_j_1;
	Eb_neg_j_1 = cEb_neg_j_1;
	E_r_j_1 = cE_r_j_1;
	sigy_project_neg_j_1 = csigy_project_neg_j_1;
	epslb_j_1 = cepslb_j_1;
	siglb_j_1 = csiglb_j_1;
	a_j_1 = ca_j_1;
	sigr_j_1 = csigr_j_1;
	slope_lb_j_1 = cslope_lb_j_1;
	slope_r_j_1 = cslope_r_j_1;
	siglb_project_j_1 = csiglb_project_j_1;
	sigr_project_j_1 = csigr_project_j_1;
	Di = cDi;
	Di_1 = cDi_1;
	Di_2 = cDi_2;
	epsreversal = cepsreversal;
	sigreversal = csigreversal;
	epsreversal_1 = cepsreversal_1;
	sigreversal_1 = csigreversal_1;
	epsreversal_2 = cepsreversal_2;
	sigreversal_2 = csigreversal_2;
	sig = csig;
	sig_1 = csig_1;
	sig_2 = csig_2;
	eps = ceps;
	eps_1 = ceps_1;
	eps_2 = ceps_2;
	kon = ckon;
	kon_1 = ckon_1;
	kon_2 = ckon_2;
	lbstage = clbstage;
	beta_y_j_1 = cbeta_y_j_1;
	beta_lb_j_1 = cbeta_lb_j_1;
	beta_a_j_1 = cbeta_a_j_1;
	beta_yneg_j_1 = cbeta_yneg_j_1;
	beta_re_j_1 = cbeta_re_j_1;
	beta_y_j = cbeta_y_j;
	beta_lb_j = cbeta_lb_j;
	beta_a_j = cbeta_a_j;
	beta_yneg_j = cbeta_yneg_j;
	beta_re_j = cbeta_re_j;
	curve_epslb = ccurve_epslb;
	sig_iso = csig_iso;
	sig_lb_re = csig_lb_re;

	Excursion_Flag = cExcursion_Flag;
	Reversal_Flag = cReversal_Flag;
	Energy_Excrsni_1 = cEnergy_Excrsni_1;
	Energy_Flag = cEnergy_Flag;
	Yield_Flag = cYield_Flag;
	Buckling_flag = cBuckling_flag;
	Stiffness_neg_Flag = cStiffness_neg_Flag;
	Bucklingdegree = cBucklingdegree;

	eps_inflection = ceps_inflection;
	sig_inflection = csig_inflection;
	e_inflection = ce_inflection;
	epsdiatance = cepsdiatance;

	Minus = cMinus;
	Minus_1 = cMinus_1;
	Minus_Flag = cMinus_Flag;
	Minus_Flag_1 = cMinus_Flag_1;
	Minus_Flag_2 = cMinus_Flag_2;
	Stiffness_neg = cStiffness_neg;

	kon_re = ckon_re;
	eps_re = ceps_re;
	sig_re = csig_re;
	e_re = ce_re;
	deps_re = cdeps_re;
	epsreversal_re = cepsreversal_re;
	sigreversal_re = csigreversal_re;
	reloading_Flag = creloading_Flag;

	sig_Trial = csig_Trial;
	eps_max = ceps_max;
	eps_max_Flag = ceps_max_Flag;
	Minus_Flag_re = cMinus_Flag_re;
	lbstage_re = clbstage_re;

	Energy_Excrsn = cEnergy_Excrsn;
	Energy_total = cEnergy_total;

	e = ce;
	e_1 = ce_1;
	e_2 = ce_2;

	eps = strainConverged;
	strainPEqTrial = strainPEqConverged;
	stressTrial = stressConverged;
	alphaKTrial = alphaKConverged;
	stiffnessTrial = stiffnessConverged;

	return 0;
}

int CFSTsteel::revertToStart(void)
{
	// 正向屈服点
	Eb_pos = b * E0;
	epsy_pos = Fy / E0;
	sigy_project_pos = Fy - Eb_pos * epsy_pos;

	// 负向屈服点
	Eb_neg = b2 * E0;
	epsy_neg = -Fy / E0;
	sigy_project_neg = -Fy - Eb_neg * epsy_neg; // 因为epsy_neg是负值

	epslb = (siglb - sigy_project_neg) / Eb_neg;
	siglb_project = (siglb - sigr) / exp(a * (epslb));

	// 判断epslb出现在弹性段还是强化段
	if (fabs(siglb) <= fabs(Fy)) {
		epslb = siglb / E0;
	}
	else {
		epslb = epsy_neg + (siglb + Fy) / Eb_neg;
	}

	Ref_Energy_y = Lambda_y * Fy;
	Ref_Energy_lb = Lambda_lb * Fy;
	Ref_Energy_a = Lambda_a * Fy;
	Ref_Energy_yneg = Lambda_yneg * Fy;
	Ref_Energy_re = Lambda_re * Fy;
	////////////////////////////////////////////////////////////////////////////
	Eb_pos_j_1 = Eb_pos;
	sigy_project_pos_j_1 = sigy_project_pos;
	Eb_neg_j_1 = Eb_neg;
	E_r_j_1 = E0;
	sigy_project_neg_j_1 = sigy_project_neg;
	epslb_j_1 = epslb;
	siglb_j_1 = siglb;
	a_j_1 = a;
	sigr_j_1 = sigr;
	slope_lb_j_1 = slope_lb;
	slope_r_j_1 = slope_r;
	siglb_project_j_1 = siglb_project;
	sigr_project_j_1 = sigr_project;

	//initially I zero everything
	cEb_pos_j_1 = Eb_pos;
	csigy_project_pos_j_1 = sigy_project_pos;
	cEb_neg_j_1 = Eb_neg;
	cE_r_j_1 = E0;
	csigy_project_neg_j_1 = sigy_project_neg;
	cepslb_j_1 = epslb;
	csiglb_j_1 = siglb;
	ca_j_1 = a;
	csigr_j_1 = sigr;
	cslope_lb_j_1 = slope_lb;
	cslope_r_j_1 = slope_r;
	csiglb_project_j_1 = siglb_project;
	csigr_project_j_1 = sigr_project;

	Di = 0;
	cDi = 0;
	Di_1 = 0;
	cDi_1 = 0;
	Di_2 = 0;
	cDi_2 = 0;
	epsreversal = cepsreversal = 0;
	sigreversal = csigreversal = 0;
	epsreversal_1 = cepsreversal_1 = 0;
	sigreversal_1 = csigreversal_1 = 0;
	epsreversal_2 = cepsreversal_2 = 0;
	sigreversal_2 = csigreversal_2 = 0;
	sig = 0;
	csig = 0;
	sig_1 = 0;
	csig_1 = 0;
	sig_2 = 0;
	csig_2 = 0;
	eps = 0;
	ceps = 0;
	eps_1 = 0;
	ceps_1 = 0;
	eps_2 = 0;
	ceps_2 = 0;
	kon = ckon = 0;
	kon_1 = ckon_1 = 0;
	kon_2 = ckon_2 = 0;
	lbstage = clbstage = 0;
	beta_y_j_1 = cbeta_y_j_1 = 0;
	beta_lb_j_1 = cbeta_lb_j_1 = 0;
	beta_a_j_1 = cbeta_a_j_1 = 0;
	beta_yneg_j_1 = cbeta_yneg_j_1 = 0;
	beta_re_j_1 = cbeta_re_j_1 = 0;
	beta_y_j = cbeta_y_j = 0;
	beta_lb_j = cbeta_lb_j = 0;
	beta_a_j = cbeta_a_j = 0;
	beta_yneg_j = cbeta_yneg_j = 0;
	beta_re_j = cbeta_re_j = 0;
	curve_epslb = ccurve_epslb = 0;

	Excursion_Flag = cExcursion_Flag = 0;
	Reversal_Flag = cReversal_Flag = 0;
	Energy_Excrsni_1 = cEnergy_Excrsni_1 = 0;
	Energy_Flag = cEnergy_Flag = 0;
	Yield_Flag = cYield_Flag = 0;
	Bucklingdegree = cBucklingdegree = 0;
	Buckling_flag = cBuckling_flag = 0;
	Stiffness_neg_Flag = cStiffness_neg_Flag = 0;

	eps_inflection = ceps_inflection = 0;
	sig_inflection = csig_inflection = 0;
	e_inflection = ce_inflection = 0;
	epsdiatance = cepsdiatance = 0;

	Minus = cMinus = 0;
	Minus_1 = cMinus_1 = 0;
	Minus_Flag = cMinus_Flag = 0;
	Minus_Flag_1 = cMinus_Flag_1 = 0;
	Minus_Flag_2 = cMinus_Flag_2 = 0;
	Stiffness_neg = cStiffness_neg = 0;
	sig_iso = csig_iso = 0;
	sig_lb_re = csig_lb_re = 0;

	kon_re = ckon_re = 0;
	eps_re = ceps_re = 0;
	sig_re = csig_re = 0;
	e_re = ce_re = 0;
	deps_re = cdeps_re = 0;
	epsreversal_re = cepsreversal_re = 0;
	sigreversal_re = csigreversal_re = 0;
	reloading_Flag = creloading_Flag = 0;
	sig_Trial = csig_Trial = 0;
	eps_max = ceps_max = 0;
	eps_max_Flag = ceps_max_Flag = 0;

	sig_Trial = csig_Trial = 0;
	eps_max = ceps_max = 0;
	eps_max_Flag = ceps_max_Flag = 0;
	lbstage_re = clbstage_re = 0;
	Minus_Flag_re = cMinus_Flag_re;


	Energy_Excrsn = cEnergy_Excrsn = 0;
	Energy_total = cEnergy_total = 0;

	//e = E0; //非常重要，刚度如果不给初值，会影响结果
	e = ce = E0;
	e_1 = ce_1 = E0;
	e_2 = ce_2 = E0;

	strainConverged = 0.;
	strainPEqConverged = 0.;
	stressConverged = 0.;
	stiffnessConverged = 0.;
	for (int i = 0; i < nBackstresses; ++i) {
		alphaKConverged[i] = 0.;
		alphaKTrial[i] = 0.;
	}

	return 0;
}


UniaxialMaterial*
CFSTsteel::getCopy(void) {
	CFSTsteel* theCopy = new CFSTsteel(this->getTag(),
		E0, Fy, qInf, b,
		b2, siglb, a, sigr, b3,
		Lambda_y, Lambda_lb, Lambda_a, Lambda_yneg, Lambda_re,
		C_y, C_lb, C_a, C_yneg, C_re,
		cK, gammaK);

	theCopy->Eb_pos = Eb_pos;
	theCopy->epsy_pos = epsy_pos;
	theCopy->sigy_project_pos = sigy_project_pos;
	theCopy->epslb = epslb;
	theCopy->slope_lb = slope_lb;
	theCopy->slope_r = slope_r;
	theCopy->siglb_project = siglb_project;
	theCopy->sigr_project = sigr_project;
	theCopy->Eb_pos_j_1 = Eb_pos_j_1;
	theCopy->sigy_project_pos_j_1 = sigy_project_pos_j_1;
	theCopy->Eb_neg_j_1 = Eb_neg_j_1;
	theCopy->E_r_j_1 = E_r_j_1;
	theCopy->sigy_project_neg_j_1 = sigy_project_neg_j_1;
	theCopy->epslb_j_1 = epslb_j_1;
	theCopy->siglb_j_1 = siglb_j_1;
	theCopy->a_j_1 = a_j_1;
	theCopy->sigr_j_1 = sigr_j_1;
	theCopy->slope_lb_j_1 = slope_lb_j_1;
	theCopy->slope_r_j_1 = slope_r_j_1;
	theCopy->siglb_project_j_1 = siglb_project_j_1;
	theCopy->sigr_project_j_1 = sigr_project_j_1;
	theCopy->Di = Di;
	theCopy->Di_1 = Di_1;
	theCopy->Di_2 = Di_2;
	theCopy->epsreversal = epsreversal;
	theCopy->sigreversal = sigreversal;
	theCopy->epsreversal_1 = epsreversal_1;
	theCopy->sigreversal_1 = sigreversal_1;
	theCopy->epsreversal_2 = epsreversal_2;
	theCopy->sigreversal_2 = sigreversal_2;
	theCopy->sig = sig;
	theCopy->sig_1 = sig_1;
	theCopy->sig_2 = sig_2;
	theCopy->eps = eps;
	theCopy->eps_1 = eps_1;
	theCopy->eps_2 = eps_2;
	theCopy->kon = kon;
	theCopy->kon_1 = kon_1;
	theCopy->kon_2 = kon_2;
	theCopy->lbstage = lbstage;
	theCopy->beta_y_j_1 = beta_y_j_1;
	theCopy->beta_lb_j_1 = beta_lb_j_1;
	theCopy->beta_a_j_1 = beta_a_j_1;
	theCopy->beta_yneg_j_1 = beta_yneg_j_1;
	theCopy->beta_re_j_1 = beta_re_j_1;
	theCopy->curve_epslb = curve_epslb;
	theCopy->curve_epsr = curve_epsr;
	theCopy->beta_y_j = beta_y_j;
	theCopy->cbeta_y_j = cbeta_y_j;
	theCopy->Excursion_Flag = Excursion_Flag;
	theCopy->Reversal_Flag = Reversal_Flag;
	theCopy->Energy_Excrsni_1 = Energy_Excrsni_1;
	theCopy->Energy_Flag = Energy_Flag;
	theCopy->Energy_Excrsn = Energy_Excrsn;
	theCopy->Energy_total = Energy_total;
	theCopy->Ref_Energy_y = Ref_Energy_y;
	theCopy->Ref_Energy_lb = Ref_Energy_lb;
	theCopy->Ref_Energy_a = Ref_Energy_a;
	theCopy->Ref_Energy_yneg = Ref_Energy_yneg;
	theCopy->Ref_Energy_re = Ref_Energy_re;
	theCopy->e = e;
	theCopy->e_1 = e_1;
	theCopy->e_2 = e_2;
	theCopy->Eb_neg = Eb_neg;
	theCopy->epsy_neg = epsy_neg;
	theCopy->sigy_project_neg = sigy_project_neg;
	theCopy->cEb_pos_j_1 = cEb_pos_j_1;
	theCopy->csigy_project_pos_j_1 = csigy_project_pos_j_1;
	theCopy->cEb_neg_j_1 = cEb_neg_j_1;
	theCopy->cE_r_j_1 = cE_r_j_1;
	theCopy->csigy_project_neg_j_1 = csigy_project_neg_j_1;
	theCopy->cepslb_j_1 = cepslb_j_1;
	theCopy->csiglb_j_1 = csiglb_j_1;
	theCopy->ca_j_1 = ca_j_1;
	theCopy->csigr_j_1 = csigr_j_1;
	theCopy->cslope_lb_j_1 = cslope_lb_j_1;
	theCopy->cslope_r_j_1 = cslope_r_j_1;
	theCopy->csiglb_project_j_1 = csiglb_project_j_1;
	theCopy->csigr_project_j_1 = csigr_project_j_1;
	theCopy->cDi = cDi;
	theCopy->cDi_1 = cDi_1;
	theCopy->cDi_2 = cDi_2;
	theCopy->cepsreversal = cepsreversal;
	theCopy->csigreversal = csigreversal;
	theCopy->cepsreversal_1 = cepsreversal_1;
	theCopy->csigreversal_1 = csigreversal_1;
	theCopy->cepsreversal_2 = cepsreversal_2;
	theCopy->csigreversal_2 = csigreversal_2;
	theCopy->csig = csig;
	theCopy->csig_1 = csig_1;
	theCopy->csig_2 = csig_2;
	theCopy->ceps = ceps;
	theCopy->ceps_1 = ceps_1;
	theCopy->ceps_2 = ceps_2;
	theCopy->ckon = ckon;
	theCopy->ckon_1 = ckon_1;
	theCopy->ckon_2 = ckon_2;
	theCopy->clbstage = clbstage;
	theCopy->cbeta_y_j_1 = cbeta_y_j_1;
	theCopy->cbeta_lb_j_1 = cbeta_lb_j_1;
	theCopy->cbeta_a_j_1 = cbeta_a_j_1;
	theCopy->cbeta_yneg_j_1 = cbeta_yneg_j_1;
	theCopy->cbeta_re_j_1 = cbeta_re_j_1;
	theCopy->ccurve_epslb = ccurve_epslb;
	theCopy->ccurve_epsr = ccurve_epsr;
	theCopy->beta_lb_j = beta_lb_j;
	theCopy->cbeta_lb_j = cbeta_lb_j;
	theCopy->cExcursion_Flag = cExcursion_Flag;
	theCopy->cReversal_Flag = cReversal_Flag;
	theCopy->cEnergy_Excrsni_1 = cEnergy_Excrsni_1;
	theCopy->cEnergy_Flag = cEnergy_Flag;
	theCopy->cEnergy_Excrsn = cEnergy_Excrsn;
	theCopy->cEnergy_total = cEnergy_total;
	theCopy->ce = ce;
	theCopy->ce_1 = ce_1;
	theCopy->ce_2 = ce_2;
	theCopy->beta_a_j = beta_a_j;
	theCopy->cbeta_a_j = cbeta_a_j;
	theCopy->beta_yneg_j = beta_yneg_j;
	theCopy->cbeta_yneg_j = cbeta_yneg_j;
	theCopy->cbeta_re_j = cbeta_re_j;
	theCopy->Eb_pos = Eb_pos;
	theCopy->epsy_pos = epsy_pos;
	theCopy->sigy_project_pos = sigy_project_pos;
	theCopy->epslb = epslb;
	theCopy->slope_lb = slope_lb;
	theCopy->slope_r = slope_r;
	theCopy->siglb_project = siglb_project;
	theCopy->sigr_project = sigr_project;
	theCopy->Eb_neg = Eb_neg;
	theCopy->epsy_neg = epsy_neg;
	theCopy->sigy_project_neg = sigy_project_neg;
	theCopy->Yield_Flag = Yield_Flag;
	theCopy->cYield_Flag = cYield_Flag;
	theCopy->Bucklingdegree = Bucklingdegree;
	theCopy->cBucklingdegree = cBucklingdegree;
	theCopy->Buckling_flag = Buckling_flag;
	theCopy->cBuckling_flag = cBuckling_flag;
	theCopy->Stiffness_neg_Flag = Stiffness_neg_Flag;
	theCopy->cStiffness_neg_Flag = cStiffness_neg_Flag;
	theCopy->strainConverged = strainConverged;
	theCopy->strainTrial = strainTrial;
	theCopy->strainPEqConverged = strainPEqConverged;
	theCopy->strainPEqTrial = strainPEqTrial;
	theCopy->stressConverged = stressConverged;
	theCopy->stressTrial = stressTrial;
	theCopy->alphaKConverged = alphaKConverged;
	theCopy->alphaKTrial = alphaKTrial;
	theCopy->stiffnessConverged = stiffnessConverged;
	theCopy->stiffnessTrial = stiffnessTrial;
	theCopy->flowDirection = flowDirection;
	theCopy->plasticLoading = plasticLoading;
	theCopy->eps_inflection = eps_inflection;
	theCopy->ceps_inflection = ceps_inflection;
	theCopy->sig_inflection = sig_inflection;
	theCopy->csig_inflection = csig_inflection;
	theCopy->e_inflection = e_inflection;
	theCopy->ce_inflection = ce_inflection;
	theCopy->epsdiatance = epsdiatance;
	theCopy->cepsdiatance = cepsdiatance;
	theCopy->Minus = Minus;
	theCopy->cMinus = cMinus;
	theCopy->Minus_1 = Minus_1;
	theCopy->cMinus_1 = cMinus_1;
	theCopy->Minus_Flag = Minus_Flag;
	theCopy->cMinus_Flag = cMinus_Flag;
	theCopy->Minus_Flag_1 = Minus_Flag_1;
	theCopy->cMinus_Flag_1 = cMinus_Flag_1;
	theCopy->Minus_Flag_2 = Minus_Flag_2;
	theCopy->cMinus_Flag_2 = cMinus_Flag_2;
	theCopy->cStiffness_neg = Stiffness_neg;
	theCopy->csig_iso = sig_iso;
	theCopy->csig_lb_re = sig_lb_re;
	theCopy->kon_re = kon_re;
	theCopy->ckon_re = ckon_re;
	theCopy->eps_re = eps_re;
	theCopy->ceps_re = ceps_re;
	theCopy->sig_re = sig_re;
	theCopy->csig_re = csig_re;
	theCopy->e_re = e_re;
	theCopy->ce_re = ce_re;
	theCopy->deps_re = deps_re;
	theCopy->cdeps_re = cdeps_re;
	theCopy->epsreversal_re = epsreversal_re;
	theCopy->cepsreversal_re = cepsreversal_re;
	theCopy->sigreversal_re = sigreversal_re;
	theCopy->csigreversal_re = csigreversal_re;
	theCopy->reloading_Flag = reloading_Flag;
	theCopy->creloading_Flag = creloading_Flag;
	theCopy->sig_Trial = sig_Trial;
	theCopy->csig_Trial = csig_Trial;
	theCopy->eps_max = eps_max;
	theCopy->ceps_max = ceps_max;
	theCopy->eps_max_Flag = eps_max_Flag;
	theCopy->ceps_max_Flag = ceps_max_Flag;
	theCopy->Minus_Flag_re = Minus_Flag_re;
	theCopy->cMinus_Flag_re = cMinus_Flag_re;
	theCopy->clbstage_re = clbstage_re;
	theCopy->lbstage_re = lbstage_re;


	return theCopy;
}


int CFSTsteel::sendSelf(int commitTag, Channel& theChannel)
{
	static Vector data(228);
	data(0) = this->getTag();
	data(1) = E0;
	data(2) = Fy;
	data(3) = b;
	data(4) = b2;
	data(5) = siglb;
	data(6) = a;
	data(7) = sigr;
	data(8) = Lambda_y;
	data(9) = Lambda_lb;
	data(10) = Lambda_a;
	data(11) = Lambda_yneg;
	data(12) = C_y;
	data(13) = C_lb;
	data(14) = C_a;
	data(15) = C_yneg;
	data(16) = Eb_pos;
	data(17) = epsy_pos;
	data(18) = sigy_project_pos;
	data(19) = epslb;
	data(20) = slope_lb;
	data(21) = slope_r;
	data(22) = siglb_project;
	data(23) = sigr_project;
	data(24) = Eb_pos_j_1;
	data(25) = sigy_project_pos_j_1;
	data(26) = Eb_neg_j_1;
	data(27) = sigy_project_neg_j_1;
	data(28) = epslb_j_1;
	data(29) = siglb_j_1;
	data(30) = a_j_1;
	data(31) = sigr_j_1;
	data(32) = slope_lb_j_1;
	data(33) = slope_r_j_1;
	data(34) = siglb_project_j_1;
	data(35) = sigr_project_j_1;
	data(36) = Di;
	data(37) = Di_1;
	data(38) = epsreversal;
	data(39) = sigreversal;
	data(40) = sig;
	data(41) = sig_1;
	data(42) = eps;
	data(43) = eps_1;
	data(44) = kon;
	data(45) = lbstage;
	data(46) = beta_y_j_1;
	data(47) = beta_lb_j_1;
	data(48) = beta_a_j_1;
	data(49) = beta_yneg_j_1;
	data(50) = curve_epslb;
	data(51) = curve_epsr;
	data(52) = beta_y_j;
	data(53) = cbeta_y_j;
	data(54) = Excursion_Flag;
	data(55) = Reversal_Flag;
	data(56) = Energy_Excrsni_1;
	data(57) = Energy_Flag;
	data(58) = Energy_Excrsn;
	data(59) = Energy_total;
	data(60) = Ref_Energy_y;
	data(61) = Ref_Energy_lb;
	data(62) = Ref_Energy_a;
	data(63) = Ref_Energy_yneg;
	data(64) = e;
	data(65) = Eb_neg;
	data(66) = epsy_neg;
	data(67) = sigy_project_neg;
	data(68) = cEb_pos_j_1;
	data(69) = csigy_project_pos_j_1;
	data(70) = cEb_neg_j_1;
	data(71) = csigy_project_neg_j_1;
	data(72) = cepslb_j_1;
	data(73) = csiglb_j_1;
	data(74) = ca_j_1;
	data(75) = csigr_j_1;
	data(76) = cslope_lb_j_1;
	data(77) = cslope_r_j_1;
	data(78) = csiglb_project_j_1;
	data(79) = csigr_project_j_1;
	data(80) = cDi;
	data(81) = cDi_1;
	data(82) = cepsreversal;
	data(83) = csigreversal;
	data(84) = csig;
	data(85) = csig_1;
	data(86) = ceps;
	data(87) = ceps_1;
	data(88) = ckon;
	data(89) = clbstage;
	data(90) = cbeta_y_j_1;
	data(91) = cbeta_lb_j_1;
	data(92) = cbeta_a_j_1;
	data(93) = cbeta_yneg_j_1;
	data(94) = ccurve_epslb;
	data(95) = ccurve_epsr;
	data(96) = beta_lb_j;
	data(97) = cbeta_lb_j;
	data(98) = cExcursion_Flag;
	data(99) = cReversal_Flag;
	data(100) = cEnergy_Excrsni_1;
	data(101) = cEnergy_Flag;
	data(102) = cEnergy_Excrsn;
	data(103) = cEnergy_total;
	data(104) = ce;
	data(105) = beta_a_j;
	data(106) = cbeta_a_j;
	data(107) = beta_yneg_j;
	data(108) = cbeta_yneg_j;
	data(109) = Eb_pos;
	data(110) = epsy_pos;
	data(111) = sigy_project_pos;
	data(112) = epslb;
	data(113) = slope_lb;
	data(114) = slope_r;
	data(115) = siglb_project;
	data(116) = sigr_project;
	data(117) = Eb_neg;
	data(118) = epsy_neg;
	data(119) = sigy_project_neg;
	data(120) = Yield_Flag;
	data(121) = cYield_Flag;

	data(122) = qInf;
	data(123) = stiffnessInitial;
	data(124) = strainConverged;
	data(125) = strainPEqConverged;
	data(126) = stressConverged;
	data(127) = stiffnessConverged;
	data(128) = flowDirection;
	data(129) = plasticLoading;

	data(130) = b3;
	data(131) = Lambda_re;
	data(132) = C_re;
	data(133) = beta_re_j_1;
	data(134) = Ref_Energy_re;
	data(135) = cbeta_re_j_1;
	data(136) = beta_re_j;
	data(137) = cbeta_re_j;

	data(138) = epsreversal_1;
	data(139) = sigreversal_1;
	data(140) = cepsreversal_1;
	data(141) = csigreversal_1;

	data(142) = Bucklingdegree;
	data(143) = cBucklingdegree;
	data(144) = Buckling_flag;
	data(145) = cBuckling_flag;

	data(146) = eps_inflection;
	data(147) = ceps_inflection;
	data(148) = sig_inflection;
	data(149) = csig_inflection;
	data(150) = e_inflection;
	data(151) = ce_inflection;

	data(152) = Minus;
	data(153) = cMinus;
	data(154) = Minus_1;
	data(155) = cMinus_1;
	data(156) = Minus_Flag;
	data(157) = cMinus_Flag;

	data(158) = epsdiatance;
	data(159) = cepsdiatance;

	data(160) = E_r_j_1;
	data(161) = cE_r_j_1;

	data(162) = eps_2;
	data(163) = ceps_2;
	data(164) = sig_2;
	data(165) = csig_2;
	data(166) = kon_1;
	data(167) = ckon_1;
	data(168) = kon_2;
	data(169) = ckon_2;
	data(170) = epsreversal_2;
	data(171) = sigreversal_2;
	data(172) = cepsreversal_2;
	data(173) = csigreversal_2;
	data(174) = Di_2;
	data(175) = cDi_2;
	data(176) = e_1;
	data(177) = ce_1;
	data(178) = e_2;
	data(179) = ce_2;
	data(180) = Minus_Flag_1;
	data(181) = cMinus_Flag_1;
	data(182) = Minus_Flag_2;
	data(183) = cMinus_Flag_2;
	data(184) = Stiffness_neg;
	data(185) = cStiffness_neg;
	data(186) = Stiffness_neg_Flag;
	data(187) = cStiffness_neg_Flag;
	data(188) = sig_iso;
	data(189) = csig_iso;
	data(190) = sig_lb_re;
	data(191) = csig_lb_re;
	data(192) = kon_re;
	data(193) = ckon_re;
	data(194) = eps_re;
	data(195) = ceps_re;
	data(196) = sig_re;
	data(197) = csig_re;
	data(198) = e_re;
	data(199) = ce_re;
	data(200) = deps_re;
	data(201) = cdeps_re;
	data(202) = epsreversal_re;
	data(203) = cepsreversal_re;
	data(204) = sigreversal_re;
	data(205) = csigreversal_re;
	data(206) = reloading_Flag;
	data(207) = creloading_Flag;
	data(208) = sig_Trial;
	data(209) = csig_Trial;
	data(210) = eps_max;
	data(211) = ceps_max;
	data(212) = eps_max_Flag;
	data(213) = ceps_max_Flag;
	data(214) = lbstage_re;
	data(215) = clbstage_re;
	data(216) = Minus_Flag_re;
	data(217) = cMinus_Flag_re;


	// Kinematic hardening related, 12 total spaces required
	int cKStart = 13;  // starts at the 13th space
	int gammaKStart = cKStart + nBackstresses;
	int alpha_k_start = gammaKStart + nBackstresses;
	for (int i = 0; i < nBackstresses; ++i) {
		data(cKStart + i) = cK[i];
		data(gammaKStart + i) = gammaK[i];
		data(alpha_k_start + i) = alphaKConverged[i];
	}

	if (theChannel.sendVector(this->getDbTag(), commitTag, data) < 0) {
		opserr << "CFSTsteel::sendSelf() - failed to sendSelf\n";
		return -1;
	}
	return 0;
}

int CFSTsteel::recvSelf(int commitTag, Channel& theChannel, FEM_ObjectBroker& theBroker)
{
	static Vector data(228);

	if (theChannel.recvVector(this->getDbTag(), commitTag, data) < 0) {
		opserr << "CFSTsteel::recvSelf() - failed to recvSelf\n";
		return -1;
	}

	this->setTag((int)data(0));
	E0 = data(1);
	Fy = data(2);
	b = data(3);
	b2 = data(4);
	siglb = data(5);
	a = data(6);
	sigr = data(7);
	Lambda_y = data(8);
	Lambda_lb = data(9);
	Lambda_a = data(10);
	Lambda_yneg = data(11);
	C_y = data(12);
	C_lb = data(13);
	C_a = data(14);
	C_yneg = data(15);
	Eb_pos = data(16);
	epsy_pos = data(17);
	sigy_project_pos = data(18);
	epslb = data(19);
	slope_lb = data(20);
	slope_r = data(21);
	siglb_project = data(22);
	sigr_project = data(23);
	Eb_pos_j_1 = data(24);
	sigy_project_pos_j_1 = data(25);
	Eb_neg_j_1 = data(26);
	sigy_project_neg_j_1 = data(27);
	epslb_j_1 = data(28);
	siglb_j_1 = data(29);
	a_j_1 = data(30);
	sigr_j_1 = data(31);
	slope_lb_j_1 = data(32);
	slope_r_j_1 = data(33);
	siglb_project_j_1 = data(34);
	sigr_project_j_1 = data(35);
	Di = data(36);
	Di_1 = data(37);
	epsreversal = data(38);
	sigreversal = data(39);
	sig = data(40);
	sig_1 = data(41);
	eps = data(42);
	eps_1 = data(43);
	kon = data(44);
	lbstage = data(45);
	beta_y_j_1 = data(46);
	beta_lb_j_1 = data(47);
	beta_a_j_1 = data(48);
	beta_yneg_j_1 = data(49);
	curve_epslb = data(50);
	curve_epsr = data(51);
	beta_y_j = data(52);
	cbeta_y_j = data(53);
	Excursion_Flag = data(54);
	Reversal_Flag = data(55);
	Energy_Excrsni_1 = data(56);
	Energy_Flag = data(57);
	Energy_Excrsn = data(58);
	Energy_total = data(59);
	Ref_Energy_y = data(60);
	Ref_Energy_lb = data(61);
	Ref_Energy_a = data(62);
	Ref_Energy_yneg = data(63);
	e = data(64);
	Eb_neg = data(65);
	epsy_neg = data(66);
	sigy_project_neg = data(67);
	cEb_pos_j_1 = data(68);
	csigy_project_pos_j_1 = data(69);
	cEb_neg_j_1 = data(70);
	csigy_project_neg_j_1 = data(71);
	cepslb_j_1 = data(72);
	csiglb_j_1 = data(73);
	ca_j_1 = data(74);
	csigr_j_1 = data(75);
	cslope_lb_j_1 = data(76);
	cslope_r_j_1 = data(77);
	csiglb_project_j_1 = data(78);
	csigr_project_j_1 = data(79);
	cDi = data(80);
	cDi_1 = data(81);
	cepsreversal = data(82);
	csigreversal = data(83);
	csig = data(84);
	csig_1 = data(85);
	ceps = data(86);
	ceps_1 = data(87);
	ckon = data(88);
	clbstage = data(89);
	cbeta_y_j_1 = data(90);
	cbeta_lb_j_1 = data(91);
	cbeta_a_j_1 = data(92);
	cbeta_yneg_j_1 = data(93);
	ccurve_epslb = data(94);
	ccurve_epsr = data(95);
	beta_lb_j = data(96);
	cbeta_lb_j = data(97);
	cExcursion_Flag = data(98);
	cReversal_Flag = data(99);
	cEnergy_Excrsni_1 = data(100);
	cEnergy_Flag = data(101);
	cEnergy_Excrsn = data(102);
	cEnergy_total = data(103);
	ce = data(104);
	beta_a_j = data(105);
	cbeta_a_j = data(106);
	beta_yneg_j = data(107);
	cbeta_yneg_j = data(108);
	Eb_pos = data(109);
	epsy_pos = data(110);
	sigy_project_pos = data(111);
	epslb = data(112);
	slope_lb = data(113);
	slope_r = data(114);
	siglb_project = data(115);
	sigr_project = data(116);
	Eb_neg = data(117);
	epsy_neg = data(118);
	sigy_project_neg = data(119);
	Yield_Flag = data(120);
	cYield_Flag = data(121);

	qInf = data(122);
	stiffnessInitial = data(123);
	strainConverged = data(124);
	strainPEqConverged = data(125);
	stressConverged = data(126);
	stiffnessConverged = data(127);
	flowDirection = data(128);
	plasticLoading = bool(data(129));

	b3 = data(130);
	Lambda_re = data(131);
	C_re = data(132);
	beta_re_j_1 = data(133);
	Ref_Energy_re = data(134);
	cbeta_re_j_1 = data(135);
	beta_re_j = data(136);
	cbeta_re_j = data(137);

	epsreversal_1 = data(138);
	sigreversal_1 = data(139);
	cepsreversal_1 = data(140);
	csigreversal_1 = data(141);

	Bucklingdegree = data(142);
	cBucklingdegree = data(143);
	Buckling_flag = data(144);
	cBuckling_flag = data(145);

	eps_inflection = data(146);
	ceps_inflection = data(147);
	sig_inflection = data(148);
	csig_inflection = data(149);
	e_inflection = data(150);
	ce_inflection = data(151);

	Minus = data(152);
	cMinus = data(153);
	Minus_1 = data(154);
	cMinus_1 = data(155);
	Minus_Flag = data(156);
	cMinus_Flag = data(157);
	epsdiatance = data(158);
	cepsdiatance = data(159);

	E_r_j_1 = data(160);
	cE_r_j_1 = data(161);

	eps_2 = data(162);
	ceps_2 = data(163);
	sig_2 = data(164);
	csig_2 = data(165);
	kon_1 = data(166);
	ckon_1 = data(167);
	kon_2 = data(168);
	ckon_1 = data(169);
	epsreversal_2 = data(170);
	sigreversal_2 = data(171);
	cepsreversal_2 = data(172);
	csigreversal_2 = data(173);
	Di_2 = data(174);
	cDi_2 = data(175);
	e_1 = data(176);
	ce_1 = data(177);
	e_2 = data(178);
	ce_2 = data(179);
	Minus_Flag_1 = data(180);
	cMinus_Flag_1 = data(181);
	Minus_Flag_2 = data(182);
	cMinus_Flag_2 = data(183);
	Stiffness_neg = data(184);
	cStiffness_neg = data(185);
	Stiffness_neg_Flag = data(186);
	cStiffness_neg_Flag = data(187);
	sig_iso = data(188);
	csig_iso = data(189);
	sig_lb_re = data(190);
	csig_lb_re = data(191);
	kon_re = data(192);
	ckon_re = data(193);
	eps_re = data(194);
	ceps_re = data(195);
	sig_re = data(196);
	csig_re = data(197);
	e_re = data(198);
	ce_re = data(199);
	deps_re = data(200);
	cdeps_re = data(201);
	epsreversal_re = data(202);
	cepsreversal_re = data(203);
	sigreversal_re = data(204);
	csigreversal_re = data(205);
	reloading_Flag = data(206);
	creloading_Flag = data(207);
	sig_Trial = data(208);
	csig_Trial = data(209);
	eps_max = data(210);
	ceps_max = data(211);
	eps_max_Flag = data(212);
	ceps_max_Flag = data(213);
	lbstage_re = data(214);
	clbstage_re = data(215);
	Minus_Flag_re = data(216);
	cMinus_Flag_re = data(217);

	// Kinematic hardening related, 12 total spaces required
	int cKStart = 13;  // starts at the 13th space
	int gammaKStart = cKStart + nBackstresses;
	int alpha_k_start = gammaKStart + nBackstresses;
	for (int i = 0; i < nBackstresses; ++i) {
		cK[i] = (cKStart + i);
		gammaK[i] = (gammaKStart + i);
		alphaKConverged[i] = (alpha_k_start + i);
	}

	return 0;
}

void CFSTsteel::Print(OPS_Stream& s, int flag)
{
	if (flag == 2) {
		s << "CFSTsteel tag: " << this->getTag() << endln;
		s << "  E0: " << Fy << " ";
		s << "  Fy: " << E0 << " ";
		s << "  qInf: " << qInf << " ";
		s << "   b: " << b << " ";
		s << "   b2: " << b2 << " ";
		s << "  siglb: " << siglb << " ";
		s << "  a: " << a << " ";
		s << " sigr: " << sigr << " ";
		s << " b3: " << b3 << " ";
		s << "  Lambda_y: " << Lambda_y << " ";
		s << "  Lambda_lb: " << Lambda_lb << " ";
		s << "  Lambda_a: " << Lambda_a << " ";
		s << "  Lambda_yneg: " << Lambda_yneg << " ";
		s << "  Lambda_re: " << Lambda_re << " ";
		s << "  C_y: " << C_y << " ";
		s << "  C_lb: " << C_lb << " ";
		s << "  C_a: " << C_a << " ";
		s << "  C_yneg: " << C_yneg << " ";
		s << "  C_re: " << C_re << " ";
		for (int i = 0; i < nBackstresses; ++i) {
			s << "  C" << (i + 1) << ": " << cK[i] << " ";
			s << "gam" << (i + 1) << ": " << gammaK[i] << " ";
		}
	}

	if (flag == 25000) {
		s << "\t\t\t{";
		s << "\"name\": \"" << this->getTag() << "\", ";
		s << "\"type\": \"CFSTsteel\", ";
		s << "\"E0\": " << E0 << ", ";
		s << "\"Fy\": " << Fy << ", ";
		s << "\"qInf\": " << qInf << ", ";
		s << "\"b\": " << b << ", ";
		s << "\"b2\": " << b2 << ", ";
		s << "\"siglb\": " << siglb << ", ";
		s << "\"a\": " << a << ", ";
		s << "\"sigr\": " << sigr << ", ";
		s << "\"b3\": " << b3 << ", ";
		s << "\"Lambda_y\": " << Lambda_y << ", ";
		s << "\"Lambda_lb\": " << Lambda_lb << ", ";
		s << "\"Lambda_a\": " << Lambda_a << ", ";
		s << "\"Lambda_yneg\": " << Lambda_yneg << ", ";
		s << "\"Lambda_re\": " << Lambda_re << ", ";
		s << "\"C_y\": " << C_y << ", ";
		s << "\"C_lb\": " << C_lb << ", ";
		s << "\"C_a\": " << C_a << ", ";
		s << "\"C_yneg\": " << C_yneg << ", ";
		s << "\"C_re\": " << C_re << ", ";
		for (int i = 0; i < nBackstresses; ++i) {
			s << "\"C\": " << cK[i] << ", ";
			s << "\"gam\": " << gammaK[i] << ", ";
		}
	}
}

template <typename T> int CFSTsteel::sgn(T val) {
	return (T(0) < val) - (val < T(0));
}