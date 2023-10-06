/* ****************************************************************** **
**    OpenSees - Open System for Earthquake Engineering Simulation    **
**          Pacific Earthquake Engineering Research Center            **
**                                                                    **
**                                                                    **
** (C) Copyright 1999, The Regents of the University of California    **
** All Rights Reserved.                                               **
**                                                                    **
** Commercial use of this program without express permission of the   **
** University of California, Berkeley, is strictly prohibited.  See   **
** file 'COPYRIGHT'  in main directory for information on usage and   **
** redistribution,  and for a DISCLAIMER OF ALL WARRANTIES.           **
**                                                                    **
** Developed by:                                                      **
**   Frank McKenna (fmckenna@ce.berkeley.edu)                         **
**   Gregory L. Fenves (fenves@ce.berkeley.edu)                       **
**   Filip C. Filippou (filippou@ce.berkeley.edu)                     **
**                                                                    **
** ****************************************************************** */

//-----------------------------------------------------------------------
// Date: 2023-05-11
// Description: CFSTsteel
// Developed and implemented by:
//   Shiye Wang (shiyewang@tongji.edu.cn,
//               shiye.wang@epfl.ch      )
//-----------------------------------------------------------------------


#ifndef CFSTsteel_h
#define CFSTsteel_h

#include <UniaxialMaterial.h>
#include <vector>
#include <OPS_Globals.h>
#include <elementAPI.h>

class CFSTsteel : public UniaxialMaterial
{
public:
    CFSTsteel(int tag,
        double E0, double Fy, double qInf, double b,
        double b2, double siglb, double a, double sigr, double b3,
        double Lambda_y, double Lambda_lb, double Lambda_a, double Lambda_yneg, double Lambda_re,
        double C_y, double C_lb, double C_a, double C_yneg, double C_re,
        std::vector<double> cK, std::vector<double> gammaK);

    CFSTsteel(void);
    virtual ~CFSTsteel();

public:
    const char* getClassType(void) const { return "CFSTsteel"; };
    int setTrialStrain(double strain, double strainRate = 0.0);
    double getStrain(void);
    double getStress(void);
    double getTangent(void);
    double getInitialTangent(void);
    int commitState(void);
    int revertToLastCommit(void);
    int revertToStart(void);
    UniaxialMaterial* getCopy(void);
    int sendSelf(int commitTag, Channel& theChannel);
    int recvSelf(int commitTag, Channel& theChannel,
        FEM_ObjectBroker& theBroker);
    void Print(OPS_Stream& s, int flag = 0);

    double function1(double x);
    double function2(double x);
    double function3(double x);
    double function4(double x);
    double function5(double x);
    double function6(double x);
    double Newtoniteration1(double x);
    double Newtoniteration2(double x);
    double Newtoniteration3(double x);

private:
    void returnMapping(double strain_inc);
    void calculateStiffness();
    template <typename T> int sgn(T val);



private:
    ////////////////////Local buckling Parameters//////////////////
    double Fy;
    double E0;
    double b2;
    double siglb;      //siglb是负值
    double a;
    double sigr;
    double b3;
    double Lambda_y;
    double Lambda_lb;
    double Lambda_a;
    double Lambda_yneg;
    double Lambda_re;
    double C_y;
    double C_lb;
    double C_a;
    double C_yneg;
    double C_re;

    double Eb_pos, Eb_neg;
    double epsy_pos, epsy_neg;   //epsy_neg是负值
    double sigy_project_pos, sigy_project_neg;
    double epslb;
    double slope_lb;
    double slope_r;
    double siglb_project;
    double sigr_project;
    double Eb_pos_j_1, cEb_pos_j_1;
    double sigy_project_pos_j_1, csigy_project_pos_j_1;
    double Eb_neg_j_1, cEb_neg_j_1;
    double sigy_project_neg_j_1, csigy_project_neg_j_1;
    double epslb_j_1, cepslb_j_1;
    double siglb_j_1, csiglb_j_1;
    double a_j_1, ca_j_1;
    double sigr_j_1, csigr_j_1;
    double slope_lb_j_1, cslope_lb_j_1;
    double slope_r_j_1, cslope_r_j_1;
    double siglb_project_j_1, csiglb_project_j_1;
    double siglb_project_j, csiglb_project_j;
    double sigr_project_j_1, csigr_project_j_1;
    double Di, cDi;
    double Di_1, cDi_1;
    double Di_2, cDi_2;
    double epsreversal, cepsreversal;
    double sigreversal, csigreversal;
    double epsreversal_1, cepsreversal_1;
    double sigreversal_1, csigreversal_1;
    double epsreversal_2, cepsreversal_2;
    double sigreversal_2, csigreversal_2;
    double sig, csig;
    double sig_1, csig_1;
    double sig_2, csig_2;
    double eps, ceps;
    double eps_1, ceps_1;
    double eps_2, ceps_2;
    double kon, ckon;
    double kon_1, ckon_1;
    double kon_2, ckon_2;
    double lbstage, clbstage;
    double beta_y_j_1, cbeta_y_j_1;
    double beta_lb_j_1, cbeta_lb_j_1;
    double beta_a_j_1, cbeta_a_j_1;
    double beta_yneg_j_1, cbeta_yneg_j_1;
    double beta_re_j_1, cbeta_re_j_1;
    double curve_epslb, ccurve_epslb;
    double curve_epsr, ccurve_epsr;
    double beta_y_j, beta_lb_j, beta_a_j, beta_yneg_j, beta_re_j;
    double cbeta_y_j, cbeta_lb_j, cbeta_a_j, cbeta_yneg_j, cbeta_re_j;
    double Excursion_Flag, cExcursion_Flag;
    double Reversal_Flag, cReversal_Flag;
    double Energy_Excrsni_1, cEnergy_Excrsni_1;
    double Energy_Flag, cEnergy_Flag;
    double Energy_Excrsn, cEnergy_Excrsn;
    double Energy_total, cEnergy_total;
    double Ref_Energy_y;
    double Ref_Energy_lb;
    double Ref_Energy_a;
    double Ref_Energy_yneg;
    double Ref_Energy_re;
    double e, ce;
    double e_1, ce_1;
    double e_2, ce_2;
    double Yield_Flag, cYield_Flag;
    double Bucklingdegree, cBucklingdegree;
    double Buckling_flag, cBuckling_flag;
    double Stiffness_neg_Flag, cStiffness_neg_Flag;
    double eps_inflection, ceps_inflection;
    double sig_inflection, csig_inflection;
    double e_inflection, ce_inflection;
    double Minus, cMinus;
    double Minus_1, cMinus_1;
    double Minus_Flag, cMinus_Flag;
    double Minus_Flag_1, cMinus_Flag_1;
    double Minus_Flag_2, cMinus_Flag_2;
    double epsdiatance, cepsdiatance;
    double E_r_j_1, cE_r_j_1;
    double Stiffness_neg, cStiffness_neg;
    double sig_iso, csig_iso;
    double exp_point, cexp_point;
    double sig_lb_re, csig_lb_re;

    double kon_re, ckon_re;
    double eps_re, ceps_re;
    double sig_re, csig_re;
    double e_re, ce_re;
    double deps_re, cdeps_re;
    double epsreversal_re, cepsreversal_re;
    double sigreversal_re, csigreversal_re;
    double reloading_Flag, creloading_Flag;

    double sig_Trial, csig_Trial;
    double eps_max, ceps_max;
    double eps_max_Flag, ceps_max_Flag;
    double lbstage_re, clbstage_re;
    double Minus_Flag_re, cMinus_Flag_re;

    ////////////////////Voce-Chaboche Parameters//////////////////
    // Parameters
    const int N_BASIC_PARAMS = 4;
    const int N_PARAM_PER_BACK = 2;
    const double RETURN_MAP_TOL = 10.0e-10;
    const int MAXIMUM_ITERATIONS = 1000;
    double qInf;
    double b;
    double stiffnessInitial;
    std::vector<double> cK;
    std::vector<double> gammaK;
    int nBackstresses;

    // Internal variables
    double strainConverged;
    double strainTrial;
    double strainPEqConverged;  // Equivalent plastic strain
    double strainPEqTrial;
    double stressConverged;
    double stressTrial;
    std::vector<double> alphaKConverged;
    std::vector<double> alphaKTrial;
    double stiffnessConverged;
    double stiffnessTrial;
    double flowDirection;
    bool plasticLoading;
};


#endif

