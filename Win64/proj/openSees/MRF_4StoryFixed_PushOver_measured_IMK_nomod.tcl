wipe;
wipe all;

model BasicBuilder -ndm 2 -ndf 3;

geomTransf PDelta 1;

set Source "0_Source";
source $Source/DisplayModel2D.tcl;
source $Source/DisplayPlane.tcl;
source $Source/DynamicAnalysis.tcl;

file mkdir MRF_4StoryFixed_PushOver_measured_IMK_nomod_result;
global Result;
set Result "MRF_4StoryFixed_PushOver_measured_IMK_nomod_result";

set E 205.00;

set Nstory 4;
set NBay 2;
set BayWidth12 5000.0;
set BayWidth23 5000.0;
set HStory12 3450.0;
set HStory23 3500.0;
set HStory34 3500.0;
set HStory45 3525.0;

set Axis1 0.00;
set Axis2 5000.00;
set Axis3 10000.00;

set Floor1 0.00;
set Floor2 3450.00;
set Floor3 6950.00;
set Floor4 10450.00;
set Floor5 13975.00;

set n_fac 10.0;
set H_offset 50.0;

# Column at STORY-1 and AXIS-1 (Bottom);
set            d_Col12_1_b 300.00;#Depth
set           bf_Col12_1_b 300.00;#Flange width
set           tw_Col12_1_b 9.00;#Web thickness
set           tf_Col12_1_b 9.00;#Flange thickness
set            r_Col12_1_b 0.00;#Radius at the k-area
set            A_Col12_1_b 10270.00;#Cross-sectional area
set           Ix_Col12_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_1_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_1_b 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_1_b 272486.17;#Yield moment based on AISC
set  Theta_y_mem_Col12_1_b 0.00503;#Yield chord rotation 
set        a_mem_Col12_1_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_1_b 313359.10;#Capping moment
set  Theta_p_mem_Col12_1_b 0.02281;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_1_b 0.20161;#Post-capping plastic chord rotation
set     Mres_mem_Col12_1_b 68121.54;#Residual moment
set      Res_mem_Col12_1_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_1_b 0.03312;#Post-yielding stiffness ratio
set          K_s_Col12_1_b 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_1_b 272486.17;#Yield moment of the spring
set      Alpha_s_Col12_1_b 0.00310;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_1_b 0.02212;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_1_b 0.20687;#Post-capping plastic rotation of the spring
set        Res_s_Col12_1_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_1_b 0.24886;#Ultimate rotation of the spring
set       Lcanti_Col12_1_b 1625.00;#Effective canti-lever length
set           Lb_Col12_1_b 3250.00;#Unbraced length
set           Pg_Col12_1_b 280.75;#Gravity load sustained by this column
set           Py_Col12_1_b 3389.10;#Axial yield strength
set        Pg_Py_Col12_1_b 0.08284;#Axial load ratio due to gravity load
set     Lambda_s_Col12_1_b 0.36478;#
set     Lambda_c_Col12_1_b 0.32830;#
set     Lambda_k_Col12_1_b 0.32830;#

# Column at STORY-1 and AXIS-1 (Top);
set            d_Col12_1_t 300.00;#Depth
set           bf_Col12_1_t 300.00;#Flange width
set           tw_Col12_1_t 9.00;#Web thickness
set           tf_Col12_1_t 9.00;#Flange thickness
set            r_Col12_1_t 0.00;#Radius at the k-area
set            A_Col12_1_t 10270.00;#Cross-sectional area
set           Ix_Col12_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_1_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_1_t 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_1_t 272486.17;#Yield moment based on AISC
set  Theta_y_mem_Col12_1_t 0.00503;#Yield chord rotation 
set        a_mem_Col12_1_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_1_t 313359.10;#Capping moment
set  Theta_p_mem_Col12_1_t 0.02281;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_1_t 0.20161;#Post-capping plastic chord rotation
set     Mres_mem_Col12_1_t 68121.54;#Residual moment
set      Res_mem_Col12_1_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_1_t 0.03312;#Post-yielding stiffness ratio
set          K_s_Col12_1_t 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_1_t 272486.17;#Yield moment of the spring
set      Alpha_s_Col12_1_t 0.00310;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_1_t 0.02212;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_1_t 0.20687;#Post-capping plastic rotation of the spring
set        Res_s_Col12_1_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_1_t 0.24886;#Ultimate rotation of the spring
set       Lcanti_Col12_1_t 1625.00;#Effective canti-lever length
set           Lb_Col12_1_t 3250.00;#Unbraced length
set           Pg_Col12_1_t 280.75;#Gravity load sustained by this column
set           Py_Col12_1_t 3389.10;#Axial yield strength
set        Pg_Py_Col12_1_t 0.08284;#Axial load ratio due to gravity load
set     Lambda_s_Col12_1_t 0.36478;#
set     Lambda_c_Col12_1_t 0.32830;#
set     Lambda_k_Col12_1_t 0.32830;#


# Column at STORY-1 and AXIS-2 (Bottom);
set            d_Col12_2_b 300.00;#Depth
set           bf_Col12_2_b 300.00;#Flange width
set           tw_Col12_2_b 9.00;#Web thickness
set           tf_Col12_2_b 9.00;#Flange thickness
set            r_Col12_2_b 0.00;#Radius at the k-area
set            A_Col12_2_b 10270.00;#Cross-sectional area
set           Ix_Col12_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_2_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_2_b 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_2_b 260057.81;#Yield moment based on AISC
set  Theta_y_mem_Col12_2_b 0.00481;#Yield chord rotation 
set        a_mem_Col12_2_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_2_b 299066.48;#Capping moment
set  Theta_p_mem_Col12_2_b 0.02096;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_2_b 0.14472;#Post-capping plastic chord rotation
set     Mres_mem_Col12_2_b 65014.45;#Residual moment
set      Res_mem_Col12_2_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_2_b 0.03439;#Post-yielding stiffness ratio
set          K_s_Col12_2_b 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_2_b 260057.81;#Yield moment of the spring
set      Alpha_s_Col12_2_b 0.00323;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_2_b 0.02030;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_2_b 0.14974;#Post-capping plastic rotation of the spring
set        Res_s_Col12_2_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_2_b 0.24891;#Ultimate rotation of the spring
set       Lcanti_Col12_2_b 1625.00;#Effective canti-lever length
set           Lb_Col12_2_b 3250.00;#Unbraced length
set           Pg_Col12_2_b 561.50;#Gravity load sustained by this column
set           Py_Col12_2_b 3389.10;#Axial yield strength
set        Pg_Py_Col12_2_b 0.16568;#Axial load ratio due to gravity load
set     Lambda_s_Col12_2_b 0.25638;#
set     Lambda_c_Col12_2_b 0.23074;#
set     Lambda_k_Col12_2_b 0.23074;#

# Column at STORY-1 and AXIS-2 (Top);
set            d_Col12_2_t 300.00;#Depth
set           bf_Col12_2_t 300.00;#Flange width
set           tw_Col12_2_t 9.00;#Web thickness
set           tf_Col12_2_t 9.00;#Flange thickness
set            r_Col12_2_t 0.00;#Radius at the k-area
set            A_Col12_2_t 10270.00;#Cross-sectional area
set           Ix_Col12_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_2_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_2_t 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_2_t 260057.81;#Yield moment based on AISC
set  Theta_y_mem_Col12_2_t 0.00481;#Yield chord rotation 
set        a_mem_Col12_2_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_2_t 299066.48;#Capping moment
set  Theta_p_mem_Col12_2_t 0.02096;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_2_t 0.14472;#Post-capping plastic chord rotation
set     Mres_mem_Col12_2_t 65014.45;#Residual moment
set      Res_mem_Col12_2_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_2_t 0.03439;#Post-yielding stiffness ratio
set          K_s_Col12_2_t 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_2_t 260057.81;#Yield moment of the spring
set      Alpha_s_Col12_2_t 0.00323;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_2_t 0.02030;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_2_t 0.14974;#Post-capping plastic rotation of the spring
set        Res_s_Col12_2_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_2_t 0.24891;#Ultimate rotation of the spring
set       Lcanti_Col12_2_t 1625.00;#Effective canti-lever length
set           Lb_Col12_2_t 3250.00;#Unbraced length
set           Pg_Col12_2_t 561.50;#Gravity load sustained by this column
set           Py_Col12_2_t 3389.10;#Axial yield strength
set        Pg_Py_Col12_2_t 0.16568;#Axial load ratio due to gravity load
set     Lambda_s_Col12_2_t 0.25638;#
set     Lambda_c_Col12_2_t 0.23074;#
set     Lambda_k_Col12_2_t 0.23074;#


# Column at STORY-1 and AXIS-3 (Bottom);
set            d_Col12_3_b 300.00;#Depth
set           bf_Col12_3_b 300.00;#Flange width
set           tw_Col12_3_b 9.00;#Web thickness
set           tf_Col12_3_b 9.00;#Flange thickness
set            r_Col12_3_b 0.00;#Radius at the k-area
set            A_Col12_3_b 10270.00;#Cross-sectional area
set           Ix_Col12_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_3_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_3_b 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_3_b 272486.17;#Yield moment based on AISC
set  Theta_y_mem_Col12_3_b 0.00503;#Yield chord rotation 
set        a_mem_Col12_3_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_3_b 313359.10;#Capping moment
set  Theta_p_mem_Col12_3_b 0.02281;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_3_b 0.20161;#Post-capping plastic chord rotation
set     Mres_mem_Col12_3_b 68121.54;#Residual moment
set      Res_mem_Col12_3_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_3_b 0.03312;#Post-yielding stiffness ratio
set          K_s_Col12_3_b 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_3_b 272486.17;#Yield moment of the spring
set      Alpha_s_Col12_3_b 0.00310;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_3_b 0.02212;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_3_b 0.20687;#Post-capping plastic rotation of the spring
set        Res_s_Col12_3_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_3_b 0.24886;#Ultimate rotation of the spring
set       Lcanti_Col12_3_b 1625.00;#Effective canti-lever length
set           Lb_Col12_3_b 3250.00;#Unbraced length
set           Pg_Col12_3_b 280.75;#Gravity load sustained by this column
set           Py_Col12_3_b 3389.10;#Axial yield strength
set        Pg_Py_Col12_3_b 0.08284;#Axial load ratio due to gravity load
set     Lambda_s_Col12_3_b 0.36478;#
set     Lambda_c_Col12_3_b 0.32830;#
set     Lambda_k_Col12_3_b 0.32830;#

# Column at STORY-1 and AXIS-3 (Top);
set            d_Col12_3_t 300.00;#Depth
set           bf_Col12_3_t 300.00;#Flange width
set           tw_Col12_3_t 9.00;#Web thickness
set           tf_Col12_3_t 9.00;#Flange thickness
set            r_Col12_3_t 0.00;#Radius at the k-area
set            A_Col12_3_t 10270.00;#Cross-sectional area
set           Ix_Col12_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col12_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col12_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col12_3_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col12_3_t 54120000.00;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col12_3_t 272486.17;#Yield moment based on AISC
set  Theta_y_mem_Col12_3_t 0.00503;#Yield chord rotation 
set        a_mem_Col12_3_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col12_3_t 313359.10;#Capping moment
set  Theta_p_mem_Col12_3_t 0.02281;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col12_3_t 0.20161;#Post-capping plastic chord rotation
set     Mres_mem_Col12_3_t 68121.54;#Residual moment
set      Res_mem_Col12_3_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col12_3_t 0.03312;#Post-yielding stiffness ratio
set          K_s_Col12_3_t 595320000.00;#Initial stiffness of the spring
set         My_s_Col12_3_t 272486.17;#Yield moment of the spring
set      Alpha_s_Col12_3_t 0.00310;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col12_3_t 0.02212;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col12_3_t 0.20687;#Post-capping plastic rotation of the spring
set        Res_s_Col12_3_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col12_3_t 0.24886;#Ultimate rotation of the spring
set       Lcanti_Col12_3_t 1625.00;#Effective canti-lever length
set           Lb_Col12_3_t 3250.00;#Unbraced length
set           Pg_Col12_3_t 280.75;#Gravity load sustained by this column
set           Py_Col12_3_t 3389.10;#Axial yield strength
set        Pg_Py_Col12_3_t 0.08284;#Axial load ratio due to gravity load
set     Lambda_s_Col12_3_t 0.36478;#
set     Lambda_c_Col12_3_t 0.32830;#
set     Lambda_k_Col12_3_t 0.32830;#


# Column at STORY-2 and AXIS-1 (Bottom);
set            d_Col23_1_b 300.00;#Depth
set           bf_Col23_1_b 300.00;#Flange width
set           tw_Col23_1_b 9.00;#Web thickness
set           tf_Col23_1_b 9.00;#Flange thickness
set            r_Col23_1_b 0.00;#Radius at the k-area
set            A_Col23_1_b 10270.00;#Cross-sectional area
set           Ix_Col23_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_1_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_1_b 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_1_b 277156.35;#Yield moment based on AISC
set  Theta_y_mem_Col23_1_b 0.00489;#Yield chord rotation 
set        a_mem_Col23_1_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_1_b 318729.81;#Capping moment
set  Theta_p_mem_Col23_1_b 0.02300;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_1_b 0.21571;#Post-capping plastic chord rotation
set     Mres_mem_Col23_1_b 69289.09;#Residual moment
set      Res_mem_Col23_1_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_1_b 0.03187;#Post-yielding stiffness ratio
set          K_s_Col23_1_b 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_1_b 277156.35;#Yield moment of the spring
set      Alpha_s_Col23_1_b 0.00298;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_1_b 0.02234;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_1_b 0.22082;#Post-capping plastic rotation of the spring
set        Res_s_Col23_1_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_1_b 0.24889;#Ultimate rotation of the spring
set       Lcanti_Col23_1_b 1551.00;#Effective canti-lever length
set           Lb_Col23_1_b 3102.00;#Unbraced length
set           Pg_Col23_1_b 215.19;#Gravity load sustained by this column
set           Py_Col23_1_b 3409.64;#Axial yield strength
set        Pg_Py_Col23_1_b 0.06311;#Axial load ratio due to gravity load
set     Lambda_s_Col23_1_b 0.39471;#
set     Lambda_c_Col23_1_b 0.35524;#
set     Lambda_k_Col23_1_b 0.35524;#

# Column at STORY-2 and AXIS-1 (Top);
set            d_Col23_1_t 300.00;#Depth
set           bf_Col23_1_t 300.00;#Flange width
set           tw_Col23_1_t 9.00;#Web thickness
set           tf_Col23_1_t 9.00;#Flange thickness
set            r_Col23_1_t 0.00;#Radius at the k-area
set            A_Col23_1_t 10270.00;#Cross-sectional area
set           Ix_Col23_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_1_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_1_t 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_1_t 277156.35;#Yield moment based on AISC
set  Theta_y_mem_Col23_1_t 0.00489;#Yield chord rotation 
set        a_mem_Col23_1_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_1_t 318729.81;#Capping moment
set  Theta_p_mem_Col23_1_t 0.02300;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_1_t 0.21571;#Post-capping plastic chord rotation
set     Mres_mem_Col23_1_t 69289.09;#Residual moment
set      Res_mem_Col23_1_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_1_t 0.03187;#Post-yielding stiffness ratio
set          K_s_Col23_1_t 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_1_t 277156.35;#Yield moment of the spring
set      Alpha_s_Col23_1_t 0.00298;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_1_t 0.02234;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_1_t 0.22082;#Post-capping plastic rotation of the spring
set        Res_s_Col23_1_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_1_t 0.24889;#Ultimate rotation of the spring
set       Lcanti_Col23_1_t 1551.00;#Effective canti-lever length
set           Lb_Col23_1_t 3102.00;#Unbraced length
set           Pg_Col23_1_t 215.19;#Gravity load sustained by this column
set           Py_Col23_1_t 3409.64;#Axial yield strength
set        Pg_Py_Col23_1_t 0.06311;#Axial load ratio due to gravity load
set     Lambda_s_Col23_1_t 0.39471;#
set     Lambda_c_Col23_1_t 0.35524;#
set     Lambda_k_Col23_1_t 0.35524;#


# Column at STORY-2 and AXIS-2 (Bottom);
set            d_Col23_2_b 300.00;#Depth
set           bf_Col23_2_b 300.00;#Flange width
set           tw_Col23_2_b 9.00;#Web thickness
set           tf_Col23_2_b 9.00;#Flange thickness
set            r_Col23_2_b 0.00;#Radius at the k-area
set            A_Col23_2_b 10270.00;#Cross-sectional area
set           Ix_Col23_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_2_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_2_b 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_2_b 267671.42;#Yield moment based on AISC
set  Theta_y_mem_Col23_2_b 0.00472;#Yield chord rotation 
set        a_mem_Col23_2_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_2_b 307822.13;#Capping moment
set  Theta_p_mem_Col23_2_b 0.02163;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_2_b 0.16925;#Post-capping plastic chord rotation
set     Mres_mem_Col23_2_b 66917.85;#Residual moment
set      Res_mem_Col23_2_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_2_b 0.03274;#Post-yielding stiffness ratio
set          K_s_Col23_2_b 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_2_b 267671.42;#Yield moment of the spring
set      Alpha_s_Col23_2_b 0.00307;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_2_b 0.02098;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_2_b 0.17419;#Post-capping plastic rotation of the spring
set        Res_s_Col23_2_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_2_b 0.24893;#Ultimate rotation of the spring
set       Lcanti_Col23_2_b 1551.00;#Effective canti-lever length
set           Lb_Col23_2_b 3102.00;#Unbraced length
set           Pg_Col23_2_b 430.38;#Gravity load sustained by this column
set           Py_Col23_2_b 3409.64;#Axial yield strength
set        Pg_Py_Col23_2_b 0.12622;#Axial load ratio due to gravity load
set     Lambda_s_Col23_2_b 0.30495;#
set     Lambda_c_Col23_2_b 0.27445;#
set     Lambda_k_Col23_2_b 0.27445;#

# Column at STORY-2 and AXIS-2 (Top);
set            d_Col23_2_t 300.00;#Depth
set           bf_Col23_2_t 300.00;#Flange width
set           tw_Col23_2_t 9.00;#Web thickness
set           tf_Col23_2_t 9.00;#Flange thickness
set            r_Col23_2_t 0.00;#Radius at the k-area
set            A_Col23_2_t 10270.00;#Cross-sectional area
set           Ix_Col23_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_2_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_2_t 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_2_t 267671.42;#Yield moment based on AISC
set  Theta_y_mem_Col23_2_t 0.00472;#Yield chord rotation 
set        a_mem_Col23_2_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_2_t 307822.13;#Capping moment
set  Theta_p_mem_Col23_2_t 0.02163;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_2_t 0.16925;#Post-capping plastic chord rotation
set     Mres_mem_Col23_2_t 66917.85;#Residual moment
set      Res_mem_Col23_2_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_2_t 0.03274;#Post-yielding stiffness ratio
set          K_s_Col23_2_t 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_2_t 267671.42;#Yield moment of the spring
set      Alpha_s_Col23_2_t 0.00307;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_2_t 0.02098;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_2_t 0.17419;#Post-capping plastic rotation of the spring
set        Res_s_Col23_2_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_2_t 0.24893;#Ultimate rotation of the spring
set       Lcanti_Col23_2_t 1551.00;#Effective canti-lever length
set           Lb_Col23_2_t 3102.00;#Unbraced length
set           Pg_Col23_2_t 430.38;#Gravity load sustained by this column
set           Py_Col23_2_t 3409.64;#Axial yield strength
set        Pg_Py_Col23_2_t 0.12622;#Axial load ratio due to gravity load
set     Lambda_s_Col23_2_t 0.30495;#
set     Lambda_c_Col23_2_t 0.27445;#
set     Lambda_k_Col23_2_t 0.27445;#


# Column at STORY-2 and AXIS-3 (Bottom);
set            d_Col23_3_b 300.00;#Depth
set           bf_Col23_3_b 300.00;#Flange width
set           tw_Col23_3_b 9.00;#Web thickness
set           tf_Col23_3_b 9.00;#Flange thickness
set            r_Col23_3_b 0.00;#Radius at the k-area
set            A_Col23_3_b 10270.00;#Cross-sectional area
set           Ix_Col23_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_3_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_3_b 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_3_b 277156.35;#Yield moment based on AISC
set  Theta_y_mem_Col23_3_b 0.00489;#Yield chord rotation 
set        a_mem_Col23_3_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_3_b 318729.81;#Capping moment
set  Theta_p_mem_Col23_3_b 0.02300;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_3_b 0.21571;#Post-capping plastic chord rotation
set     Mres_mem_Col23_3_b 69289.09;#Residual moment
set      Res_mem_Col23_3_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_3_b 0.03187;#Post-yielding stiffness ratio
set          K_s_Col23_3_b 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_3_b 277156.35;#Yield moment of the spring
set      Alpha_s_Col23_3_b 0.00298;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_3_b 0.02234;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_3_b 0.22082;#Post-capping plastic rotation of the spring
set        Res_s_Col23_3_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_3_b 0.24889;#Ultimate rotation of the spring
set       Lcanti_Col23_3_b 1551.00;#Effective canti-lever length
set           Lb_Col23_3_b 3102.00;#Unbraced length
set           Pg_Col23_3_b 215.19;#Gravity load sustained by this column
set           Py_Col23_3_b 3409.64;#Axial yield strength
set        Pg_Py_Col23_3_b 0.06311;#Axial load ratio due to gravity load
set     Lambda_s_Col23_3_b 0.39471;#
set     Lambda_c_Col23_3_b 0.35524;#
set     Lambda_k_Col23_3_b 0.35524;#

# Column at STORY-2 and AXIS-3 (Top);
set            d_Col23_3_t 300.00;#Depth
set           bf_Col23_3_t 300.00;#Flange width
set           tw_Col23_3_t 9.00;#Web thickness
set           tf_Col23_3_t 9.00;#Flange thickness
set            r_Col23_3_t 0.00;#Radius at the k-area
set            A_Col23_3_t 10270.00;#Cross-sectional area
set           Ix_Col23_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col23_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col23_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col23_3_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col23_3_t 56702127.66;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col23_3_t 277156.35;#Yield moment based on AISC
set  Theta_y_mem_Col23_3_t 0.00489;#Yield chord rotation 
set        a_mem_Col23_3_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col23_3_t 318729.81;#Capping moment
set  Theta_p_mem_Col23_3_t 0.02300;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col23_3_t 0.21571;#Post-capping plastic chord rotation
set     Mres_mem_Col23_3_t 69289.09;#Residual moment
set      Res_mem_Col23_3_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col23_3_t 0.03187;#Post-yielding stiffness ratio
set          K_s_Col23_3_t 623723404.26;#Initial stiffness of the spring
set         My_s_Col23_3_t 277156.35;#Yield moment of the spring
set      Alpha_s_Col23_3_t 0.00298;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col23_3_t 0.02234;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col23_3_t 0.22082;#Post-capping plastic rotation of the spring
set        Res_s_Col23_3_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col23_3_t 0.24889;#Ultimate rotation of the spring
set       Lcanti_Col23_3_t 1551.00;#Effective canti-lever length
set           Lb_Col23_3_t 3102.00;#Unbraced length
set           Pg_Col23_3_t 215.19;#Gravity load sustained by this column
set           Py_Col23_3_t 3409.64;#Axial yield strength
set        Pg_Py_Col23_3_t 0.06311;#Axial load ratio due to gravity load
set     Lambda_s_Col23_3_t 0.39471;#
set     Lambda_c_Col23_3_t 0.35524;#
set     Lambda_k_Col23_3_t 0.35524;#


# Column at STORY-3 and AXIS-1 (Bottom);
set            d_Col34_1_b 300.00;#Depth
set           bf_Col34_1_b 300.00;#Flange width
set           tw_Col34_1_b 9.00;#Web thickness
set           tf_Col34_1_b 9.00;#Flange thickness
set            r_Col34_1_b 0.00;#Radius at the k-area
set            A_Col34_1_b 10270.00;#Cross-sectional area
set           Ix_Col34_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_1_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_1_b 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_1_b 280021.84;#Yield moment based on AISC
set  Theta_y_mem_Col34_1_b 0.00498;#Yield chord rotation 
set        a_mem_Col34_1_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_1_b 322025.12;#Capping moment
set  Theta_p_mem_Col34_1_b 0.02342;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_1_b 0.23133;#Post-capping plastic chord rotation
set     Mres_mem_Col34_1_b 70005.46;#Residual moment
set      Res_mem_Col34_1_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_1_b 0.03189;#Post-yielding stiffness ratio
set          K_s_Col34_1_b 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_1_b 280021.84;#Yield moment of the spring
set      Alpha_s_Col34_1_b 0.00299;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_1_b 0.02274;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_1_b 0.23654;#Post-capping plastic rotation of the spring
set        Res_s_Col34_1_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_1_b 0.24887;#Ultimate rotation of the spring
set       Lcanti_Col34_1_b 1563.50;#Effective canti-lever length
set           Lb_Col34_1_b 3127.00;#Unbraced length
set           Pg_Col34_1_b 150.06;#Gravity load sustained by this column
set           Py_Col34_1_b 3409.64;#Axial yield strength
set        Pg_Py_Col34_1_b 0.04401;#Axial load ratio due to gravity load
set     Lambda_s_Col34_1_b 0.42518;#
set     Lambda_c_Col34_1_b 0.38266;#
set     Lambda_k_Col34_1_b 0.38266;#

# Column at STORY-3 and AXIS-1 (Top);
set            d_Col34_1_t 300.00;#Depth
set           bf_Col34_1_t 300.00;#Flange width
set           tw_Col34_1_t 9.00;#Web thickness
set           tf_Col34_1_t 9.00;#Flange thickness
set            r_Col34_1_t 0.00;#Radius at the k-area
set            A_Col34_1_t 10270.00;#Cross-sectional area
set           Ix_Col34_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_1_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_1_t 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_1_t 280021.84;#Yield moment based on AISC
set  Theta_y_mem_Col34_1_t 0.00498;#Yield chord rotation 
set        a_mem_Col34_1_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_1_t 322025.12;#Capping moment
set  Theta_p_mem_Col34_1_t 0.02342;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_1_t 0.23133;#Post-capping plastic chord rotation
set     Mres_mem_Col34_1_t 70005.46;#Residual moment
set      Res_mem_Col34_1_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_1_t 0.03189;#Post-yielding stiffness ratio
set          K_s_Col34_1_t 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_1_t 280021.84;#Yield moment of the spring
set      Alpha_s_Col34_1_t 0.00299;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_1_t 0.02274;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_1_t 0.23654;#Post-capping plastic rotation of the spring
set        Res_s_Col34_1_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_1_t 0.24887;#Ultimate rotation of the spring
set       Lcanti_Col34_1_t 1563.50;#Effective canti-lever length
set           Lb_Col34_1_t 3127.00;#Unbraced length
set           Pg_Col34_1_t 150.06;#Gravity load sustained by this column
set           Py_Col34_1_t 3409.64;#Axial yield strength
set        Pg_Py_Col34_1_t 0.04401;#Axial load ratio due to gravity load
set     Lambda_s_Col34_1_t 0.42518;#
set     Lambda_c_Col34_1_t 0.38266;#
set     Lambda_k_Col34_1_t 0.38266;#


# Column at STORY-3 and AXIS-2 (Bottom);
set            d_Col34_2_b 300.00;#Depth
set           bf_Col34_2_b 300.00;#Flange width
set           tw_Col34_2_b 9.00;#Web thickness
set           tf_Col34_2_b 9.00;#Flange thickness
set            r_Col34_2_b 0.00;#Radius at the k-area
set            A_Col34_2_b 10270.00;#Cross-sectional area
set           Ix_Col34_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_2_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_2_b 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_2_b 273402.39;#Yield moment based on AISC
set  Theta_y_mem_Col34_2_b 0.00486;#Yield chord rotation 
set        a_mem_Col34_2_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_2_b 314412.75;#Capping moment
set  Theta_p_mem_Col34_2_b 0.02246;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_2_b 0.19638;#Post-capping plastic chord rotation
set     Mres_mem_Col34_2_b 68350.60;#Residual moment
set      Res_mem_Col34_2_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_2_b 0.03246;#Post-yielding stiffness ratio
set          K_s_Col34_2_b 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_2_b 273402.39;#Yield moment of the spring
set      Alpha_s_Col34_2_b 0.00304;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_2_b 0.02180;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_2_b 0.20146;#Post-capping plastic rotation of the spring
set        Res_s_Col34_2_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_2_b 0.24890;#Ultimate rotation of the spring
set       Lcanti_Col34_2_b 1563.50;#Effective canti-lever length
set           Lb_Col34_2_b 3127.00;#Unbraced length
set           Pg_Col34_2_b 300.13;#Gravity load sustained by this column
set           Py_Col34_2_b 3409.64;#Axial yield strength
set        Pg_Py_Col34_2_b 0.08802;#Axial load ratio due to gravity load
set     Lambda_s_Col34_2_b 0.35720;#
set     Lambda_c_Col34_2_b 0.32148;#
set     Lambda_k_Col34_2_b 0.32148;#

# Column at STORY-3 and AXIS-2 (Top);
set            d_Col34_2_t 300.00;#Depth
set           bf_Col34_2_t 300.00;#Flange width
set           tw_Col34_2_t 9.00;#Web thickness
set           tf_Col34_2_t 9.00;#Flange thickness
set            r_Col34_2_t 0.00;#Radius at the k-area
set            A_Col34_2_t 10270.00;#Cross-sectional area
set           Ix_Col34_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_2_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_2_t 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_2_t 273402.39;#Yield moment based on AISC
set  Theta_y_mem_Col34_2_t 0.00486;#Yield chord rotation 
set        a_mem_Col34_2_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_2_t 314412.75;#Capping moment
set  Theta_p_mem_Col34_2_t 0.02246;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_2_t 0.19638;#Post-capping plastic chord rotation
set     Mres_mem_Col34_2_t 68350.60;#Residual moment
set      Res_mem_Col34_2_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_2_t 0.03246;#Post-yielding stiffness ratio
set          K_s_Col34_2_t 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_2_t 273402.39;#Yield moment of the spring
set      Alpha_s_Col34_2_t 0.00304;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_2_t 0.02180;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_2_t 0.20146;#Post-capping plastic rotation of the spring
set        Res_s_Col34_2_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_2_t 0.24890;#Ultimate rotation of the spring
set       Lcanti_Col34_2_t 1563.50;#Effective canti-lever length
set           Lb_Col34_2_t 3127.00;#Unbraced length
set           Pg_Col34_2_t 300.13;#Gravity load sustained by this column
set           Py_Col34_2_t 3409.64;#Axial yield strength
set        Pg_Py_Col34_2_t 0.08802;#Axial load ratio due to gravity load
set     Lambda_s_Col34_2_t 0.35720;#
set     Lambda_c_Col34_2_t 0.32148;#
set     Lambda_k_Col34_2_t 0.32148;#


# Column at STORY-3 and AXIS-3 (Bottom);
set            d_Col34_3_b 300.00;#Depth
set           bf_Col34_3_b 300.00;#Flange width
set           tw_Col34_3_b 9.00;#Web thickness
set           tf_Col34_3_b 9.00;#Flange thickness
set            r_Col34_3_b 0.00;#Radius at the k-area
set            A_Col34_3_b 10270.00;#Cross-sectional area
set           Ix_Col34_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_3_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_3_b 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_3_b 280021.84;#Yield moment based on AISC
set  Theta_y_mem_Col34_3_b 0.00498;#Yield chord rotation 
set        a_mem_Col34_3_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_3_b 322025.12;#Capping moment
set  Theta_p_mem_Col34_3_b 0.02342;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_3_b 0.23133;#Post-capping plastic chord rotation
set     Mres_mem_Col34_3_b 70005.46;#Residual moment
set      Res_mem_Col34_3_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_3_b 0.03189;#Post-yielding stiffness ratio
set          K_s_Col34_3_b 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_3_b 280021.84;#Yield moment of the spring
set      Alpha_s_Col34_3_b 0.00299;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_3_b 0.02274;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_3_b 0.23654;#Post-capping plastic rotation of the spring
set        Res_s_Col34_3_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_3_b 0.24887;#Ultimate rotation of the spring
set       Lcanti_Col34_3_b 1563.50;#Effective canti-lever length
set           Lb_Col34_3_b 3127.00;#Unbraced length
set           Pg_Col34_3_b 150.06;#Gravity load sustained by this column
set           Py_Col34_3_b 3409.64;#Axial yield strength
set        Pg_Py_Col34_3_b 0.04401;#Axial load ratio due to gravity load
set     Lambda_s_Col34_3_b 0.42518;#
set     Lambda_c_Col34_3_b 0.38266;#
set     Lambda_k_Col34_3_b 0.38266;#

# Column at STORY-3 and AXIS-3 (Top);
set            d_Col34_3_t 300.00;#Depth
set           bf_Col34_3_t 300.00;#Flange width
set           tw_Col34_3_t 9.00;#Web thickness
set           tf_Col34_3_t 9.00;#Flange thickness
set            r_Col34_3_t 0.00;#Radius at the k-area
set            A_Col34_3_t 10270.00;#Cross-sectional area
set           Ix_Col34_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col34_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col34_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col34_3_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col34_3_t 56248800.77;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col34_3_t 280021.84;#Yield moment based on AISC
set  Theta_y_mem_Col34_3_t 0.00498;#Yield chord rotation 
set        a_mem_Col34_3_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col34_3_t 322025.12;#Capping moment
set  Theta_p_mem_Col34_3_t 0.02342;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col34_3_t 0.23133;#Post-capping plastic chord rotation
set     Mres_mem_Col34_3_t 70005.46;#Residual moment
set      Res_mem_Col34_3_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col34_3_t 0.03189;#Post-yielding stiffness ratio
set          K_s_Col34_3_t 618736808.44;#Initial stiffness of the spring
set         My_s_Col34_3_t 280021.84;#Yield moment of the spring
set      Alpha_s_Col34_3_t 0.00299;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col34_3_t 0.02274;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col34_3_t 0.23654;#Post-capping plastic rotation of the spring
set        Res_s_Col34_3_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col34_3_t 0.24887;#Ultimate rotation of the spring
set       Lcanti_Col34_3_t 1563.50;#Effective canti-lever length
set           Lb_Col34_3_t 3127.00;#Unbraced length
set           Pg_Col34_3_t 150.06;#Gravity load sustained by this column
set           Py_Col34_3_t 3409.64;#Axial yield strength
set        Pg_Py_Col34_3_t 0.04401;#Axial load ratio due to gravity load
set     Lambda_s_Col34_3_t 0.42518;#
set     Lambda_c_Col34_3_t 0.38266;#
set     Lambda_k_Col34_3_t 0.38266;#


# Column at STORY-4 and AXIS-1 (Bottom);
set            d_Col45_1_b 300.00;#Depth
set           bf_Col45_1_b 300.00;#Flange width
set           tw_Col45_1_b 9.00;#Web thickness
set           tf_Col45_1_b 9.00;#Flange thickness
set            r_Col45_1_b 0.00;#Radius at the k-area
set            A_Col45_1_b 10270.00;#Cross-sectional area
set           Ix_Col45_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_1_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_1_b 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_1_b 282888.79;#Yield moment based on AISC
set  Theta_y_mem_Col45_1_b 0.00511;#Yield chord rotation 
set        a_mem_Col45_1_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_1_b 325322.11;#Capping moment
set  Theta_p_mem_Col45_1_b 0.02383;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_1_b 0.24773;#Post-capping plastic chord rotation
set     Mres_mem_Col45_1_b 70722.20;#Residual moment
set      Res_mem_Col45_1_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_1_b 0.03216;#Post-yielding stiffness ratio
set          K_s_Col45_1_b 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_1_b 282888.79;#Yield moment of the spring
set      Alpha_s_Col45_1_b 0.00301;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_1_b 0.02313;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_1_b 0.25308;#Post-capping plastic rotation of the spring
set        Res_s_Col45_1_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_1_b 0.24884;#Ultimate rotation of the spring
set       Lcanti_Col45_1_b 1588.50;#Effective canti-lever length
set           Lb_Col45_1_b 3177.00;#Unbraced length
set           Pg_Col45_1_b 84.94;#Gravity load sustained by this column
set           Py_Col45_1_b 3409.64;#Axial yield strength
set        Pg_Py_Col45_1_b 0.02491;#Axial load ratio due to gravity load
set     Lambda_s_Col45_1_b 0.45731;#
set     Lambda_c_Col45_1_b 0.41158;#
set     Lambda_k_Col45_1_b 0.41158;#

# Column at STORY-4 and AXIS-1 (Top);
set            d_Col45_1_t 300.00;#Depth
set           bf_Col45_1_t 300.00;#Flange width
set           tw_Col45_1_t 9.00;#Web thickness
set           tf_Col45_1_t 9.00;#Flange thickness
set            r_Col45_1_t 0.00;#Radius at the k-area
set            A_Col45_1_t 10270.00;#Cross-sectional area
set           Ix_Col45_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_1_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_1_t 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_1_t 282888.79;#Yield moment based on AISC
set  Theta_y_mem_Col45_1_t 0.00511;#Yield chord rotation 
set        a_mem_Col45_1_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_1_t 325322.11;#Capping moment
set  Theta_p_mem_Col45_1_t 0.02383;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_1_t 0.24773;#Post-capping plastic chord rotation
set     Mres_mem_Col45_1_t 70722.20;#Residual moment
set      Res_mem_Col45_1_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_1_t 0.03216;#Post-yielding stiffness ratio
set          K_s_Col45_1_t 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_1_t 282888.79;#Yield moment of the spring
set      Alpha_s_Col45_1_t 0.00301;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_1_t 0.02313;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_1_t 0.25308;#Post-capping plastic rotation of the spring
set        Res_s_Col45_1_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_1_t 0.24884;#Ultimate rotation of the spring
set       Lcanti_Col45_1_t 1588.50;#Effective canti-lever length
set           Lb_Col45_1_t 3177.00;#Unbraced length
set           Pg_Col45_1_t 84.94;#Gravity load sustained by this column
set           Py_Col45_1_t 3409.64;#Axial yield strength
set        Pg_Py_Col45_1_t 0.02491;#Axial load ratio due to gravity load
set     Lambda_s_Col45_1_t 0.45731;#
set     Lambda_c_Col45_1_t 0.41158;#
set     Lambda_k_Col45_1_t 0.41158;#


# Column at STORY-4 and AXIS-2 (Bottom);
set            d_Col45_2_b 300.00;#Depth
set           bf_Col45_2_b 300.00;#Flange width
set           tw_Col45_2_b 9.00;#Web thickness
set           tf_Col45_2_b 9.00;#Flange thickness
set            r_Col45_2_b 0.00;#Radius at the k-area
set            A_Col45_2_b 10270.00;#Cross-sectional area
set           Ix_Col45_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_2_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_2_b 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_2_b 279136.29;#Yield moment based on AISC
set  Theta_y_mem_Col45_2_b 0.00504;#Yield chord rotation 
set        a_mem_Col45_2_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_2_b 321006.73;#Capping moment
set  Theta_p_mem_Col45_2_b 0.02329;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_2_b 0.22642;#Post-capping plastic chord rotation
set     Mres_mem_Col45_2_b 69784.07;#Residual moment
set      Res_mem_Col45_2_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_2_b 0.03247;#Post-yielding stiffness ratio
set          K_s_Col45_2_b 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_2_b 279136.29;#Yield moment of the spring
set      Alpha_s_Col45_2_b 0.00304;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_2_b 0.02260;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_2_b 0.23170;#Post-capping plastic rotation of the spring
set        Res_s_Col45_2_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_2_b 0.24885;#Ultimate rotation of the spring
set       Lcanti_Col45_2_b 1588.50;#Effective canti-lever length
set           Lb_Col45_2_b 3177.00;#Unbraced length
set           Pg_Col45_2_b 169.87;#Gravity load sustained by this column
set           Py_Col45_2_b 3409.64;#Axial yield strength
set        Pg_Py_Col45_2_b 0.04982;#Axial load ratio due to gravity load
set     Lambda_s_Col45_2_b 0.41559;#
set     Lambda_c_Col45_2_b 0.37403;#
set     Lambda_k_Col45_2_b 0.37403;#

# Column at STORY-4 and AXIS-2 (Top);
set            d_Col45_2_t 300.00;#Depth
set           bf_Col45_2_t 300.00;#Flange width
set           tw_Col45_2_t 9.00;#Web thickness
set           tf_Col45_2_t 9.00;#Flange thickness
set            r_Col45_2_t 0.00;#Radius at the k-area
set            A_Col45_2_t 10270.00;#Cross-sectional area
set           Ix_Col45_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_2_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_2_t 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_2_t 279136.29;#Yield moment based on AISC
set  Theta_y_mem_Col45_2_t 0.00504;#Yield chord rotation 
set        a_mem_Col45_2_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_2_t 321006.73;#Capping moment
set  Theta_p_mem_Col45_2_t 0.02329;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_2_t 0.22642;#Post-capping plastic chord rotation
set     Mres_mem_Col45_2_t 69784.07;#Residual moment
set      Res_mem_Col45_2_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_2_t 0.03247;#Post-yielding stiffness ratio
set          K_s_Col45_2_t 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_2_t 279136.29;#Yield moment of the spring
set      Alpha_s_Col45_2_t 0.00304;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_2_t 0.02260;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_2_t 0.23170;#Post-capping plastic rotation of the spring
set        Res_s_Col45_2_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_2_t 0.24885;#Ultimate rotation of the spring
set       Lcanti_Col45_2_t 1588.50;#Effective canti-lever length
set           Lb_Col45_2_t 3177.00;#Unbraced length
set           Pg_Col45_2_t 169.87;#Gravity load sustained by this column
set           Py_Col45_2_t 3409.64;#Axial yield strength
set        Pg_Py_Col45_2_t 0.04982;#Axial load ratio due to gravity load
set     Lambda_s_Col45_2_t 0.41559;#
set     Lambda_c_Col45_2_t 0.37403;#
set     Lambda_k_Col45_2_t 0.37403;#


# Column at STORY-4 and AXIS-3 (Bottom);
set            d_Col45_3_b 300.00;#Depth
set           bf_Col45_3_b 300.00;#Flange width
set           tw_Col45_3_b 9.00;#Web thickness
set           tf_Col45_3_b 9.00;#Flange thickness
set            r_Col45_3_b 0.00;#Radius at the k-area
set            A_Col45_3_b 10270.00;#Cross-sectional area
set           Ix_Col45_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_3_b 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_3_b 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_3_b 282888.79;#Yield moment based on AISC
set  Theta_y_mem_Col45_3_b 0.00511;#Yield chord rotation 
set        a_mem_Col45_3_b 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_3_b 325322.11;#Capping moment
set  Theta_p_mem_Col45_3_b 0.02383;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_3_b 0.24773;#Post-capping plastic chord rotation
set     Mres_mem_Col45_3_b 70722.20;#Residual moment
set      Res_mem_Col45_3_b 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_3_b 0.03216;#Post-yielding stiffness ratio
set          K_s_Col45_3_b 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_3_b 282888.79;#Yield moment of the spring
set      Alpha_s_Col45_3_b 0.00301;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_3_b 0.02313;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_3_b 0.25308;#Post-capping plastic rotation of the spring
set        Res_s_Col45_3_b 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_3_b 0.24884;#Ultimate rotation of the spring
set       Lcanti_Col45_3_b 1588.50;#Effective canti-lever length
set           Lb_Col45_3_b 3177.00;#Unbraced length
set           Pg_Col45_3_b 84.94;#Gravity load sustained by this column
set           Py_Col45_3_b 3409.64;#Axial yield strength
set        Pg_Py_Col45_3_b 0.02491;#Axial load ratio due to gravity load
set     Lambda_s_Col45_3_b 0.45731;#
set     Lambda_c_Col45_3_b 0.41158;#
set     Lambda_k_Col45_3_b 0.41158;#

# Column at STORY-4 and AXIS-3 (Top);
set            d_Col45_3_t 300.00;#Depth
set           bf_Col45_3_t 300.00;#Flange width
set           tw_Col45_3_t 9.00;#Web thickness
set           tf_Col45_3_t 9.00;#Flange thickness
set            r_Col45_3_t 0.00;#Radius at the k-area
set            A_Col45_3_t 10270.00;#Cross-sectional area
set           Ix_Col45_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col45_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col45_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col45_3_t 118.00;#Radius of gyration about weak axis
set  K_mem_canti_Col45_3_t 55363550.52;#Cantilever stiffness (Mbase-chord rotation)
set      My_star_Col45_3_t 282888.79;#Yield moment based on AISC
set  Theta_y_mem_Col45_3_t 0.00511;#Yield chord rotation 
set        a_mem_Col45_3_t 1.15000;#Cappin moment/Yield moment
set       Mc_mem_Col45_3_t 325322.11;#Capping moment
set  Theta_p_mem_Col45_3_t 0.02383;#Pre-capping plastic chord rotation
set Theta_pc_mem_Col45_3_t 0.24773;#Post-capping plastic chord rotation
set     Mres_mem_Col45_3_t 70722.20;#Residual moment
set      Res_mem_Col45_3_t 0.25000;#Residual moment / Yield moment
set    Alpha_mem_Col45_3_t 0.03216;#Post-yielding stiffness ratio
set          K_s_Col45_3_t 608999055.71;#Initial stiffness of the spring
set         My_s_Col45_3_t 282888.79;#Yield moment of the spring
set      Alpha_s_Col45_3_t 0.00301;#Post-yielding stiffness ratio of the spring
set    Theta_p_s_Col45_3_t 0.02313;#Pre-capping plastic rotation of the spring
set   Theta_pc_s_Col45_3_t 0.25308;#Post-capping plastic rotation of the spring
set        Res_s_Col45_3_t 0.25000;#Residual moment/Yield moment of the spring
set  Theta_ult_s_Col45_3_t 0.24884;#Ultimate rotation of the spring
set       Lcanti_Col45_3_t 1588.50;#Effective canti-lever length
set           Lb_Col45_3_t 3177.00;#Unbraced length
set           Pg_Col45_3_t 84.94;#Gravity load sustained by this column
set           Py_Col45_3_t 3409.64;#Axial yield strength
set        Pg_Py_Col45_3_t 0.02491;#Axial load ratio due to gravity load
set     Lambda_s_Col45_3_t 0.45731;#
set     Lambda_c_Col45_3_t 0.41158;#
set     Lambda_k_Col45_3_t 0.41158;#


# Beam at SPAN-1 and FLOOR-2;
set             d_Beam12_2 400.00;#Depth
set            bf_Beam12_2 200.00;#Flange width
set            tw_Beam12_2 8.00;#Web thickness
set            tf_Beam12_2 13.00;#Flange thickness
set             r_Beam12_2 13.00;#Radius at the k-area
set             A_Beam12_2 8337.07;#Cross-sectional area
set            Ix_Beam12_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam12_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam12_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam12_2 45.63;#Radius of gyration about weak axis
set   K_mem_canti_Beam12_2 61386240.55;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_2 470719.45;#Yield moment based on AISC
set   Theta_y_mem_Beam12_2 0.00767;#Yield chord rotation 
set         a_mem_Beam12_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_2 517791.39;#Capping moment
set   Theta_p_mem_Beam12_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam12_2 0.40;#Residual moment
set      Mres_mem_Beam12_2 188287.77804;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam12_2 675248646.10;#Initial stiffness of the spring
set          My_s_Beam12_2 470719.45;#Yield moment of the spring
set       Alpha_s_Beam12_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_2 81705086.18;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_2 706549.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_2 0.00865;#Composite Yield chord rotation 
set         a_mem_BeamComp12_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_2 918514.85;#Composite Capping moment
set   Theta_p_mem_BeamComp12_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_2 211964.96613;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_2 0.03837;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_2 898755947.96;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_2 706549.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp12_2 0.00361;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp12_2 0.06526;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp12_2 0.22604;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp12_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp12_2 0.19564;#Composite Ultimate rotation of the spring
set        Lcanti_Beam12_2 2350.00;#Effective canti-lever length
set            Lb_Beam12_2 1566.67;#Unbraced length
set        Lambda_Beam12_2 0.96638;#

# Beam at SPAN-2 and FLOOR-2;
set             d_Beam23_2 400.00;#Depth
set            bf_Beam23_2 200.00;#Flange width
set            tw_Beam23_2 8.00;#Web thickness
set            tf_Beam23_2 13.00;#Flange thickness
set             r_Beam23_2 13.00;#Radius at the k-area
set             A_Beam23_2 8337.07;#Cross-sectional area
set            Ix_Beam23_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam23_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam23_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam23_2 45.63;#Radius of gyration about weak axis
set   K_mem_canti_Beam23_2 61386240.55;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_2 470719.45;#Yield moment based on AISC
set   Theta_y_mem_Beam23_2 0.00767;#Yield chord rotation 
set         a_mem_Beam23_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_2 517791.39;#Capping moment
set   Theta_p_mem_Beam23_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam23_2 0.40;#Residual moment
set      Mres_mem_Beam23_2 188287.77804;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam23_2 675248646.10;#Initial stiffness of the spring
set          My_s_Beam23_2 470719.45;#Yield moment of the spring
set       Alpha_s_Beam23_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_2 81705086.18;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_2 706549.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_2 0.00865;#Composite Yield chord rotation 
set         a_mem_BeamComp23_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_2 918514.85;#Composite Capping moment
set   Theta_p_mem_BeamComp23_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_2 211964.96613;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_2 0.03837;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_2 898755947.96;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_2 706549.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp23_2 0.00361;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp23_2 0.06526;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp23_2 0.22604;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp23_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp23_2 0.19564;#Composite Ultimate rotation of the spring
set        Lcanti_Beam23_2 2350.00;#Effective canti-lever length
set            Lb_Beam23_2 1566.67;#Unbraced length
set        Lambda_Beam23_2 0.96638;#

# Beam at SPAN-1 and FLOOR-3;
set             d_Beam12_3 396.00;#Depth
set            bf_Beam12_3 199.00;#Flange width
set            tw_Beam12_3 7.00;#Web thickness
set            tf_Beam12_3 11.00;#Flange thickness
set             r_Beam12_3 13.00;#Radius at the k-area
set             A_Beam12_3 7141.07;#Cross-sectional area
set            Ix_Beam12_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam12_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam12_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam12_3 45.01;#Radius of gyration about weak axis
set   K_mem_canti_Beam12_3 51740948.33;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_3 381186.57;#Yield moment based on AISC
set   Theta_y_mem_Beam12_3 0.00737;#Yield chord rotation 
set         a_mem_Beam12_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_3 419305.22;#Capping moment
set   Theta_p_mem_Beam12_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam12_3 0.40;#Residual moment
set      Mres_mem_Beam12_3 152474.62661;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam12_3 569150431.67;#Initial stiffness of the spring
set          My_s_Beam12_3 381186.57;#Yield moment of the spring
set       Alpha_s_Beam12_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_3 71040322.06;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_3 598462.91;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_3 0.00842;#Composite Yield chord rotation 
set         a_mem_BeamComp12_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_3 778001.78;#Composite Capping moment
set   Theta_p_mem_BeamComp12_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_3 179538.87283;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_3 0.03929;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_3 781443542.68;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_3 598462.91;#Composite Yield moment of the spring
set       Alpha_s_BeamComp12_3 0.00370;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp12_3 0.06203;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp12_3 0.19854;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp12_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp12_3 0.19676;#Composite Ultimate rotation of the spring
set        Lcanti_Beam12_3 2350.00;#Effective canti-lever length
set            Lb_Beam12_3 1566.67;#Unbraced length
set        Lambda_Beam12_3 0.74633;#

# Beam at SPAN-2 and FLOOR-3;
set             d_Beam23_3 396.00;#Depth
set            bf_Beam23_3 199.00;#Flange width
set            tw_Beam23_3 7.00;#Web thickness
set            tf_Beam23_3 11.00;#Flange thickness
set             r_Beam23_3 13.00;#Radius at the k-area
set             A_Beam23_3 7141.07;#Cross-sectional area
set            Ix_Beam23_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam23_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam23_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam23_3 45.01;#Radius of gyration about weak axis
set   K_mem_canti_Beam23_3 51740948.33;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_3 381186.57;#Yield moment based on AISC
set   Theta_y_mem_Beam23_3 0.00737;#Yield chord rotation 
set         a_mem_Beam23_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_3 419305.22;#Capping moment
set   Theta_p_mem_Beam23_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam23_3 0.40;#Residual moment
set      Mres_mem_Beam23_3 152474.62661;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam23_3 569150431.67;#Initial stiffness of the spring
set          My_s_Beam23_3 381186.57;#Yield moment of the spring
set       Alpha_s_Beam23_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_3 71040322.06;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_3 598462.91;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_3 0.00842;#Composite Yield chord rotation 
set         a_mem_BeamComp23_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_3 778001.78;#Composite Capping moment
set   Theta_p_mem_BeamComp23_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_3 179538.87283;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_3 0.03929;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_3 781443542.68;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_3 598462.91;#Composite Yield moment of the spring
set       Alpha_s_BeamComp23_3 0.00370;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp23_3 0.06203;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp23_3 0.19854;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp23_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp23_3 0.19676;#Composite Ultimate rotation of the spring
set        Lcanti_Beam23_3 2350.00;#Effective canti-lever length
set            Lb_Beam23_3 1566.67;#Unbraced length
set        Lambda_Beam23_3 0.74633;#

# Beam at SPAN-1 and FLOOR-4;
set             d_Beam12_4 350.00;#Depth
set            bf_Beam12_4 175.00;#Flange width
set            tw_Beam12_4 7.00;#Web thickness
set            tf_Beam12_4 11.00;#Flange thickness
set             r_Beam12_4 13.00;#Radius at the k-area
set             A_Beam12_4 6291.07;#Cross-sectional area
set            Ix_Beam12_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam12_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam12_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam12_4 39.55;#Radius of gyration about weak axis
set   K_mem_canti_Beam12_4 35329668.04;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_4 287092.95;#Yield moment based on AISC
set   Theta_y_mem_Beam12_4 0.00813;#Yield chord rotation 
set         a_mem_Beam12_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_4 315802.25;#Capping moment
set   Theta_p_mem_Beam12_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam12_4 0.40;#Residual moment
set      Mres_mem_Beam12_4 114837.18121;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam12_4 388626348.40;#Initial stiffness of the spring
set          My_s_Beam12_4 287092.95;#Yield moment of the spring
set       Alpha_s_Beam12_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_4 50698073.63;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_4 484325.81;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_4 0.00955;#Composite Yield chord rotation 
set         a_mem_BeamComp12_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_4 629623.56;#Composite Capping moment
set   Theta_p_mem_BeamComp12_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_4 145297.74353;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_4 0.03621;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_4 557678809.96;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_4 484325.81;#Composite Yield moment of the spring
set       Alpha_s_BeamComp12_4 0.00340;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp12_4 0.07655;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp12_4 0.25574;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp12_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp12_4 0.19385;#Composite Ultimate rotation of the spring
set        Lcanti_Beam12_4 2350.00;#Effective canti-lever length
set            Lb_Beam12_4 1566.67;#Unbraced length
set        Lambda_Beam12_4 0.98456;#

# Beam at SPAN-2 and FLOOR-4;
set             d_Beam23_4 350.00;#Depth
set            bf_Beam23_4 175.00;#Flange width
set            tw_Beam23_4 7.00;#Web thickness
set            tf_Beam23_4 11.00;#Flange thickness
set             r_Beam23_4 13.00;#Radius at the k-area
set             A_Beam23_4 6291.07;#Cross-sectional area
set            Ix_Beam23_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam23_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam23_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam23_4 39.55;#Radius of gyration about weak axis
set   K_mem_canti_Beam23_4 35329668.04;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_4 287092.95;#Yield moment based on AISC
set   Theta_y_mem_Beam23_4 0.00813;#Yield chord rotation 
set         a_mem_Beam23_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_4 315802.25;#Capping moment
set   Theta_p_mem_Beam23_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam23_4 0.40;#Residual moment
set      Mres_mem_Beam23_4 114837.18121;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam23_4 388626348.40;#Initial stiffness of the spring
set          My_s_Beam23_4 287092.95;#Yield moment of the spring
set       Alpha_s_Beam23_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_4 50698073.63;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_4 484325.81;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_4 0.00955;#Composite Yield chord rotation 
set         a_mem_BeamComp23_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_4 629623.56;#Composite Capping moment
set   Theta_p_mem_BeamComp23_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_4 145297.74353;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_4 0.03621;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_4 557678809.96;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_4 484325.81;#Composite Yield moment of the spring
set       Alpha_s_BeamComp23_4 0.00340;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp23_4 0.07655;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp23_4 0.25574;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp23_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp23_4 0.19385;#Composite Ultimate rotation of the spring
set        Lcanti_Beam23_4 2350.00;#Effective canti-lever length
set            Lb_Beam23_4 1566.67;#Unbraced length
set        Lambda_Beam23_4 0.98456;#

# Beam at SPAN-1 and FLOOR-5;
set             d_Beam12_5 346.00;#Depth
set            bf_Beam12_5 174.00;#Flange width
set            tw_Beam12_5 6.00;#Web thickness
set            tf_Beam12_5 9.00;#Flange thickness
set             r_Beam12_5 13.00;#Radius at the k-area
set             A_Beam12_5 5245.07;#Cross-sectional area
set            Ix_Beam12_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam12_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam12_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam12_5 38.84;#Radius of gyration about weak axis
set   K_mem_canti_Beam12_5 28879955.07;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_5 260984.43;#Yield moment based on AISC
set   Theta_y_mem_Beam12_5 0.00904;#Yield chord rotation 
set         a_mem_Beam12_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_5 287082.87;#Capping moment
set   Theta_p_mem_Beam12_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam12_5 0.40;#Residual moment
set      Mres_mem_Beam12_5 104393.77071;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam12_5 317679505.78;#Initial stiffness of the spring
set          My_s_Beam12_5 260984.43;#Yield moment of the spring
set       Alpha_s_Beam12_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_5 43175532.83;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_5 452025.03;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_5 0.01047;#Composite Yield chord rotation 
set         a_mem_BeamComp12_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_5 587632.54;#Composite Capping moment
set   Theta_p_mem_BeamComp12_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_5 135607.50815;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_5 0.04358;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_5 474930861.14;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_5 452025.03;#Composite Yield moment of the spring
set       Alpha_s_BeamComp12_5 0.00413;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp12_5 0.06921;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp12_5 0.17962;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp12_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp12_5 0.19632;#Composite Ultimate rotation of the spring
set        Lcanti_Beam12_5 2350.00;#Effective canti-lever length
set            Lb_Beam12_5 1566.67;#Unbraced length
set        Lambda_Beam12_5 0.68846;#

# Beam at SPAN-2 and FLOOR-5;
set             d_Beam23_5 346.00;#Depth
set            bf_Beam23_5 174.00;#Flange width
set            tw_Beam23_5 6.00;#Web thickness
set            tf_Beam23_5 9.00;#Flange thickness
set             r_Beam23_5 13.00;#Radius at the k-area
set             A_Beam23_5 5245.07;#Cross-sectional area
set            Ix_Beam23_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam23_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam23_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam23_5 38.84;#Radius of gyration about weak axis
set   K_mem_canti_Beam23_5 28879955.07;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_5 260984.43;#Yield moment based on AISC
set   Theta_y_mem_Beam23_5 0.00904;#Yield chord rotation 
set         a_mem_Beam23_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_5 287082.87;#Capping moment
set   Theta_p_mem_Beam23_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam23_5 0.40;#Residual moment
set      Mres_mem_Beam23_5 104393.77071;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam23_5 317679505.78;#Initial stiffness of the spring
set          My_s_Beam23_5 260984.43;#Yield moment of the spring
set       Alpha_s_Beam23_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_5 43175532.83;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_5 452025.03;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_5 0.01047;#Composite Yield chord rotation 
set         a_mem_BeamComp23_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_5 587632.54;#Composite Capping moment
set   Theta_p_mem_BeamComp23_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_5 135607.50815;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_5 0.04358;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_5 474930861.14;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_5 452025.03;#Composite Yield moment of the spring
set       Alpha_s_BeamComp23_5 0.00413;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp23_5 0.06921;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp23_5 0.17962;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp23_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp23_5 0.19632;#Composite Ultimate rotation of the spring
set        Lcanti_Beam23_5 2350.00;#Effective canti-lever length
set            Lb_Beam23_5 1566.67;#Unbraced length
set        Lambda_Beam23_5 0.68846;#

# Panel zone at FLOOR-2 and AXIS-1;
set             KfKe2_1 0.00161;#Kf/Ke
set    Gamma_1_Panel2_1 0.00227;#Yield distorsion angle
set    Gamma_4_Panel2_1 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel2_1 0.01362;#3rd distorsion angle
set         M1_Panel2_1 305539.42;#Yield moment of the panel
set         M4_Panel2_1 381752.63;#Ultimate moment of the panel
set         M6_Panel2_1 404067.31;#3rd moment of the panel
set         M1C_Panel2_1 409359.67;#Composite Yield moment of the panel
set         M4C_Panel2_1 511469.61;#Composite Ultimate moment of the panel
set         M6C_Panel2_1 541366.66;#Composite 3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-2;
set             KfKe2_2 0.00161;#Kf/Ke
set    Gamma_1_Panel2_2 0.00227;#Yield distorsion angle
set    Gamma_4_Panel2_2 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel2_2 0.01362;#3rd distorsion angle
set         M1_Panel2_2 305539.42;#Yield moment of the panel
set         M4_Panel2_2 381752.63;#Ultimate moment of the panel
set         M6_Panel2_2 404067.31;#3rd moment of the panel
set         M1C_Panel2_2 409359.67;#Composite Yield moment of the panel
set         M4C_Panel2_2 511469.61;#Composite Ultimate moment of the panel
set         M6C_Panel2_2 541366.66;#Composite 3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-3;
set             KfKe2_3 0.00161;#Kf/Ke
set    Gamma_1_Panel2_3 0.00227;#Yield distorsion angle
set    Gamma_4_Panel2_3 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel2_3 0.01362;#3rd distorsion angle
set         M1_Panel2_3 305539.42;#Yield moment of the panel
set         M4_Panel2_3 381752.63;#Ultimate moment of the panel
set         M6_Panel2_3 404067.31;#3rd moment of the panel
set         M1C_Panel2_3 409359.67;#Composite Yield moment of the panel
set         M4C_Panel2_3 511469.61;#Composite Ultimate moment of the panel
set         M6C_Panel2_3 541366.66;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-1;
set             KfKe3_1 0.00164;#Kf/Ke
set    Gamma_1_Panel3_1 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_1 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_1 0.01366;#3rd distorsion angle
set         M1_Panel3_1 305802.59;#Yield moment of the panel
set         M4_Panel3_1 382081.44;#Ultimate moment of the panel
set         M6_Panel3_1 404415.34;#3rd moment of the panel
set         M1C_Panel3_1 409457.76;#Composite Yield moment of the panel
set         M4C_Panel3_1 511592.17;#Composite Ultimate moment of the panel
set         M6C_Panel3_1 541496.38;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-2;
set             KfKe3_2 0.00164;#Kf/Ke
set    Gamma_1_Panel3_2 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_2 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_2 0.01366;#3rd distorsion angle
set         M1_Panel3_2 305802.59;#Yield moment of the panel
set         M4_Panel3_2 382081.44;#Ultimate moment of the panel
set         M6_Panel3_2 404415.34;#3rd moment of the panel
set         M1C_Panel3_2 409457.76;#Composite Yield moment of the panel
set         M4C_Panel3_2 511592.17;#Composite Ultimate moment of the panel
set         M6C_Panel3_2 541496.38;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-3;
set             KfKe3_3 0.00164;#Kf/Ke
set    Gamma_1_Panel3_3 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_3 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_3 0.01366;#3rd distorsion angle
set         M1_Panel3_3 305802.59;#Yield moment of the panel
set         M4_Panel3_3 382081.44;#Ultimate moment of the panel
set         M6_Panel3_3 404415.34;#3rd moment of the panel
set         M1C_Panel3_3 409457.76;#Composite Yield moment of the panel
set         M4C_Panel3_3 511592.17;#Composite Ultimate moment of the panel
set         M6C_Panel3_3 541496.38;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-1;
set             KfKe4_1 0.00202;#Kf/Ke
set    Gamma_1_Panel4_1 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_1 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_1 0.01320;#3rd distorsion angle
set         M1_Panel4_1 269265.14;#Yield moment of the panel
set         M4_Panel4_1 336430.15;#Ultimate moment of the panel
set         M6_Panel4_1 356095.58;#3rd moment of the panel
set         M1C_Panel4_1 372920.31;#Composite Yield moment of the panel
set         M4C_Panel4_1 465940.88;#Composite Ultimate moment of the panel
set         M6C_Panel4_1 493176.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-2;
set             KfKe4_2 0.00202;#Kf/Ke
set    Gamma_1_Panel4_2 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_2 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_2 0.01320;#3rd distorsion angle
set         M1_Panel4_2 269265.14;#Yield moment of the panel
set         M4_Panel4_2 336430.15;#Ultimate moment of the panel
set         M6_Panel4_2 356095.58;#3rd moment of the panel
set         M1C_Panel4_2 372920.31;#Composite Yield moment of the panel
set         M4C_Panel4_2 465940.88;#Composite Ultimate moment of the panel
set         M6C_Panel4_2 493176.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-3;
set             KfKe4_3 0.00202;#Kf/Ke
set    Gamma_1_Panel4_3 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_3 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_3 0.01320;#3rd distorsion angle
set         M1_Panel4_3 269265.14;#Yield moment of the panel
set         M4_Panel4_3 336430.15;#Ultimate moment of the panel
set         M6_Panel4_3 356095.58;#3rd moment of the panel
set         M1C_Panel4_3 372920.31;#Composite Yield moment of the panel
set         M4C_Panel4_3 465940.88;#Composite Ultimate moment of the panel
set         M6C_Panel4_3 493176.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-1;
set             KfKe5_1 0.00206;#Kf/Ke
set    Gamma_1_Panel5_1 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_1 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_1 0.01316;#3rd distorsion angle
set         M1_Panel5_1 267676.56;#Yield moment of the panel
set         M4_Panel5_1 334445.31;#Ultimate moment of the panel
set         M6_Panel5_1 353994.73;#3rd moment of the panel
set         M1C_Panel5_1 370537.43;#Composite Yield moment of the panel
set         M4C_Panel5_1 462963.62;#Composite Ultimate moment of the panel
set         M6C_Panel5_1 490025.34;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-2;
set             KfKe5_2 0.00206;#Kf/Ke
set    Gamma_1_Panel5_2 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_2 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_2 0.01316;#3rd distorsion angle
set         M1_Panel5_2 267676.56;#Yield moment of the panel
set         M4_Panel5_2 334445.31;#Ultimate moment of the panel
set         M6_Panel5_2 353994.73;#3rd moment of the panel
set         M1C_Panel5_2 370537.43;#Composite Yield moment of the panel
set         M4C_Panel5_2 462963.62;#Composite Ultimate moment of the panel
set         M6C_Panel5_2 490025.34;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-3;
set             KfKe5_3 0.00206;#Kf/Ke
set    Gamma_1_Panel5_3 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_3 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_3 0.01316;#3rd distorsion angle
set         M1_Panel5_3 267676.56;#Yield moment of the panel
set         M4_Panel5_3 334445.31;#Ultimate moment of the panel
set         M6_Panel5_3 353994.73;#3rd moment of the panel
set         M1C_Panel5_3 370537.43;#Composite Yield moment of the panel
set         M4C_Panel5_3 462963.62;#Composite Ultimate moment of the panel
set         M6C_Panel5_3 490025.34;#Composite 3rd moment of the panel

# Floor 1 MRF Column Bases;
node 1103 [expr $Axis1] [expr $Floor1];
node 113  [expr $Axis1] [expr $Floor1];
fix  1103 1 1 1;

node 1203 [expr $Axis2] [expr $Floor1];
node 123  [expr $Axis2] [expr $Floor1];
fix  1203 1 1 1;

node 1303 [expr $Axis3] [expr $Floor1];
node 133  [expr $Axis3] [expr $Floor1];
fix  1303 1 1 1;

# Floor 2~ MRF Beam-Column;
# AXIS-1, FLOOR-2;
node 211   [expr $Axis1                               ] [expr $Floor2-$d_Beam12_2/2.];# bottom middle  ;
node 2101  [expr $Axis1                               ] [expr $Floor2-$d_Beam12_2/2.];# bottom middle  ;
node 2105  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom left    ;
node 2106  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom left    ;
node 2112  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom right   ;
node 2111  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom right   ;
node 2102  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2               ];# middle left    ;
node 2104  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2               ];# middle right   ;
node 2107  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top left       ;
node 2108  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top left       ;
node 2109  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top right      ;
node 2110  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top right      ;
node 2103  [expr $Axis1                               ] [expr $Floor2+$d_Beam12_2/2.];# top middle     ;
node 213   [expr $Axis1                               ] [expr $Floor2+$d_Beam12_2/2.];# top middle     ;
node 214   [expr $Axis1+$d_Col12_1_t/2.+$H_offset               ] [expr $Floor2               ];# WUF-Wright;
node 21040   [expr $Axis1+$d_Col12_1_t/2.+$H_offset               ] [expr $Floor2               ];# middle WUF-Wright;

# AXIS-1, FLOOR-3;
node 311   [expr $Axis1                               ] [expr $Floor3-$d_Beam12_3/2.];# bottom middle  ;
node 3101  [expr $Axis1                               ] [expr $Floor3-$d_Beam12_3/2.];# bottom middle  ;
node 3105  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom left    ;
node 3106  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom left    ;
node 3112  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom right   ;
node 3111  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom right   ;
node 3102  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3               ];# middle left    ;
node 3104  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3               ];# middle right   ;
node 3107  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top left       ;
node 3108  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top left       ;
node 3109  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top right      ;
node 3110  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top right      ;
node 3103  [expr $Axis1                               ] [expr $Floor3+$d_Beam12_3/2.];# top middle     ;
node 313   [expr $Axis1                               ] [expr $Floor3+$d_Beam12_3/2.];# top middle     ;
node 314   [expr $Axis1+$d_Col23_1_t/2.+$H_offset               ] [expr $Floor3               ];# WUF-Wright;
node 31040   [expr $Axis1+$d_Col23_1_t/2.+$H_offset               ] [expr $Floor3               ];# middle WUF-Wright;

# AXIS-1, FLOOR-4;
node 411   [expr $Axis1                               ] [expr $Floor4-$d_Beam12_4/2.];# bottom middle  ;
node 4101  [expr $Axis1                               ] [expr $Floor4-$d_Beam12_4/2.];# bottom middle  ;
node 4105  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom left    ;
node 4106  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom left    ;
node 4112  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom right   ;
node 4111  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom right   ;
node 4102  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4               ];# middle left    ;
node 4104  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4               ];# middle right   ;
node 4107  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top left       ;
node 4108  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top left       ;
node 4109  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top right      ;
node 4110  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top right      ;
node 4103  [expr $Axis1                               ] [expr $Floor4+$d_Beam12_4/2.];# top middle     ;
node 413   [expr $Axis1                               ] [expr $Floor4+$d_Beam12_4/2.];# top middle     ;
node 414   [expr $Axis1+$d_Col34_1_t/2.+$H_offset               ] [expr $Floor4               ];# WUF-Wright;
node 41040   [expr $Axis1+$d_Col34_1_t/2.+$H_offset               ] [expr $Floor4               ];# middle WUF-Wright;

# AXIS-1, FLOOR-5;
node 511   [expr $Axis1                               ] [expr $Floor5-$d_Beam12_5/2.];# bottom middle  ;
node 5101  [expr $Axis1                               ] [expr $Floor5-$d_Beam12_5/2.];# bottom middle  ;
node 5105  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom left    ;
node 5106  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom left    ;
node 5112  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom right   ;
node 5111  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom right   ;
node 5102  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5               ];# middle left    ;
node 5104  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5               ];# middle right   ;
node 5107  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top left       ;
node 5108  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top left       ;
node 5109  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top right      ;
node 5110  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top right      ;
node 5103  [expr $Axis1                               ] [expr $Floor5+$d_Beam12_5/2.];# top middle     ;
node 514   [expr $Axis1+$d_Col45_1_t/2.+$H_offset               ] [expr $Floor5               ];# WUF-Wright;
node 51040   [expr $Axis1+$d_Col45_1_t/2.+$H_offset               ] [expr $Floor5               ];# middle WUF-Wright;

# AXIS-2, FLOOR-2;
node 221   [expr $Axis2                               ] [expr $Floor2-$d_Beam12_2/2.];# bottom middle  ;
node 2201  [expr $Axis2                               ] [expr $Floor2-$d_Beam12_2/2.];# bottom middle  ;
node 2205  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom left    ;
node 2206  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom left    ;
node 2212  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom right   ;
node 2211  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.];# bottom right   ;
node 2202  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2               ];# middle left    ;
node 2204  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2               ];# middle right   ;
node 2207  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top left       ;
node 2208  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top left       ;
node 2209  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top right      ;
node 2210  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.];# top right      ;
node 2203  [expr $Axis2                               ] [expr $Floor2+$d_Beam12_2/2.];# top middle     ;
node 223   [expr $Axis2                               ] [expr $Floor2+$d_Beam12_2/2.];# top middle     ;
node 222   [expr $Axis2-$d_Col12_2_t/2.-$H_offset               ] [expr $Floor2               ];# WUF-Wleft ;
node 22020   [expr $Axis2-$d_Col12_2_t/2.-$H_offset               ] [expr $Floor2               ];# middle WUF-Wleft ;
node 224   [expr $Axis2+$d_Col12_2_t/2.+$H_offset               ] [expr $Floor2               ];# WUF-Wright;
node 22040   [expr $Axis2+$d_Col12_2_t/2.+$H_offset               ] [expr $Floor2               ];# middle WUF-Wright;

# AXIS-2, FLOOR-3;
node 321   [expr $Axis2                               ] [expr $Floor3-$d_Beam12_3/2.];# bottom middle  ;
node 3201  [expr $Axis2                               ] [expr $Floor3-$d_Beam12_3/2.];# bottom middle  ;
node 3205  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom left    ;
node 3206  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom left    ;
node 3212  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom right   ;
node 3211  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.];# bottom right   ;
node 3202  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3               ];# middle left    ;
node 3204  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3               ];# middle right   ;
node 3207  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top left       ;
node 3208  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top left       ;
node 3209  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top right      ;
node 3210  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.];# top right      ;
node 3203  [expr $Axis2                               ] [expr $Floor3+$d_Beam12_3/2.];# top middle     ;
node 323   [expr $Axis2                               ] [expr $Floor3+$d_Beam12_3/2.];# top middle     ;
node 322   [expr $Axis2-$d_Col23_2_t/2.-$H_offset               ] [expr $Floor3               ];# WUF-Wleft ;
node 32020   [expr $Axis2-$d_Col23_2_t/2.-$H_offset               ] [expr $Floor3               ];# middle WUF-Wleft ;
node 324   [expr $Axis2+$d_Col23_2_t/2.+$H_offset               ] [expr $Floor3               ];# WUF-Wright;
node 32040   [expr $Axis2+$d_Col23_2_t/2.+$H_offset               ] [expr $Floor3               ];# middle WUF-Wright;

# AXIS-2, FLOOR-4;
node 421   [expr $Axis2                               ] [expr $Floor4-$d_Beam12_4/2.];# bottom middle  ;
node 4201  [expr $Axis2                               ] [expr $Floor4-$d_Beam12_4/2.];# bottom middle  ;
node 4205  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom left    ;
node 4206  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom left    ;
node 4212  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom right   ;
node 4211  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.];# bottom right   ;
node 4202  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4               ];# middle left    ;
node 4204  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4               ];# middle right   ;
node 4207  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top left       ;
node 4208  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top left       ;
node 4209  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top right      ;
node 4210  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.];# top right      ;
node 4203  [expr $Axis2                               ] [expr $Floor4+$d_Beam12_4/2.];# top middle     ;
node 423   [expr $Axis2                               ] [expr $Floor4+$d_Beam12_4/2.];# top middle     ;
node 422   [expr $Axis2-$d_Col34_2_t/2.-$H_offset               ] [expr $Floor4               ];# WUF-Wleft ;
node 42020   [expr $Axis2-$d_Col34_2_t/2.-$H_offset               ] [expr $Floor4               ];# middle WUF-Wleft ;
node 424   [expr $Axis2+$d_Col34_2_t/2.+$H_offset               ] [expr $Floor4               ];# WUF-Wright;
node 42040   [expr $Axis2+$d_Col34_2_t/2.+$H_offset               ] [expr $Floor4               ];# middle WUF-Wright;

# AXIS-2, FLOOR-5;
node 521   [expr $Axis2                               ] [expr $Floor5-$d_Beam12_5/2.];# bottom middle  ;
node 5201  [expr $Axis2                               ] [expr $Floor5-$d_Beam12_5/2.];# bottom middle  ;
node 5205  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom left    ;
node 5206  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom left    ;
node 5212  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom right   ;
node 5211  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.];# bottom right   ;
node 5202  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5               ];# middle left    ;
node 5204  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5               ];# middle right   ;
node 5207  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top left       ;
node 5208  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top left       ;
node 5209  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top right      ;
node 5210  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.];# top right      ;
node 5203  [expr $Axis2                               ] [expr $Floor5+$d_Beam12_5/2.];# top middle     ;
node 522   [expr $Axis2-$d_Col45_2_t/2.-$H_offset               ] [expr $Floor5               ];# WUF-Wleft ;
node 52020   [expr $Axis2-$d_Col45_2_t/2.-$H_offset               ] [expr $Floor5               ];# middle WUF-Wleft ;
node 524   [expr $Axis2+$d_Col45_2_t/2.+$H_offset               ] [expr $Floor5               ];# WUF-Wright;
node 52040   [expr $Axis2+$d_Col45_2_t/2.+$H_offset               ] [expr $Floor5               ];# middle WUF-Wright;

# AXIS-3, FLOOR-2;
node 231   [expr $Axis3                               ] [expr $Floor2-$d_Beam23_2/2.];# bottom middle  ;
node 2301  [expr $Axis3                               ] [expr $Floor2-$d_Beam23_2/2.];# bottom middle  ;
node 2305  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.];# bottom left    ;
node 2306  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.];# bottom left    ;
node 2312  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.];# bottom right   ;
node 2311  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.];# bottom right   ;
node 2302  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2               ];# middle left    ;
node 2304  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2               ];# middle right   ;
node 2307  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.];# top left       ;
node 2308  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.];# top left       ;
node 2309  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.];# top right      ;
node 2310  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.];# top right      ;
node 2303  [expr $Axis3                               ] [expr $Floor2+$d_Beam23_2/2.];# top middle     ;
node 233   [expr $Axis3                               ] [expr $Floor2+$d_Beam23_2/2.];# top middle     ;
node 232   [expr $Axis3-$d_Col12_3_t/2.-$H_offset               ] [expr $Floor2               ];# WUF-Wleft ;
node 23020   [expr $Axis3-$d_Col12_3_t/2.-$H_offset               ] [expr $Floor2               ];# middle WUF-Wleft ;

# AXIS-3, FLOOR-3;
node 331   [expr $Axis3                               ] [expr $Floor3-$d_Beam23_3/2.];# bottom middle  ;
node 3301  [expr $Axis3                               ] [expr $Floor3-$d_Beam23_3/2.];# bottom middle  ;
node 3305  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.];# bottom left    ;
node 3306  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.];# bottom left    ;
node 3312  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.];# bottom right   ;
node 3311  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.];# bottom right   ;
node 3302  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3               ];# middle left    ;
node 3304  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3               ];# middle right   ;
node 3307  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.];# top left       ;
node 3308  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.];# top left       ;
node 3309  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.];# top right      ;
node 3310  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.];# top right      ;
node 3303  [expr $Axis3                               ] [expr $Floor3+$d_Beam23_3/2.];# top middle     ;
node 333   [expr $Axis3                               ] [expr $Floor3+$d_Beam23_3/2.];# top middle     ;
node 332   [expr $Axis3-$d_Col23_3_t/2.-$H_offset               ] [expr $Floor3               ];# WUF-Wleft ;
node 33020   [expr $Axis3-$d_Col23_3_t/2.-$H_offset               ] [expr $Floor3               ];# middle WUF-Wleft ;

# AXIS-3, FLOOR-4;
node 431   [expr $Axis3                               ] [expr $Floor4-$d_Beam23_4/2.];# bottom middle  ;
node 4301  [expr $Axis3                               ] [expr $Floor4-$d_Beam23_4/2.];# bottom middle  ;
node 4305  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.];# bottom left    ;
node 4306  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.];# bottom left    ;
node 4312  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.];# bottom right   ;
node 4311  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.];# bottom right   ;
node 4302  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4               ];# middle left    ;
node 4304  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4               ];# middle right   ;
node 4307  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.];# top left       ;
node 4308  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.];# top left       ;
node 4309  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.];# top right      ;
node 4310  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.];# top right      ;
node 4303  [expr $Axis3                               ] [expr $Floor4+$d_Beam23_4/2.];# top middle     ;
node 433   [expr $Axis3                               ] [expr $Floor4+$d_Beam23_4/2.];# top middle     ;
node 432   [expr $Axis3-$d_Col34_3_t/2.-$H_offset               ] [expr $Floor4               ];# WUF-Wleft ;
node 43020   [expr $Axis3-$d_Col34_3_t/2.-$H_offset               ] [expr $Floor4               ];# middle WUF-Wleft ;

# AXIS-3, FLOOR-5;
node 531   [expr $Axis3                               ] [expr $Floor5-$d_Beam23_5/2.];# bottom middle  ;
node 5301  [expr $Axis3                               ] [expr $Floor5-$d_Beam23_5/2.];# bottom middle  ;
node 5305  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.];# bottom left    ;
node 5306  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.];# bottom left    ;
node 5312  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.];# bottom right   ;
node 5311  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.];# bottom right   ;
node 5302  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5               ];# middle left    ;
node 5304  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5               ];# middle right   ;
node 5307  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.];# top left       ;
node 5308  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.];# top left       ;
node 5309  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.];# top right      ;
node 5310  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.];# top right      ;
node 5303  [expr $Axis3                               ] [expr $Floor5+$d_Beam23_5/2.];# top middle     ;
node 532   [expr $Axis3-$d_Col45_3_t/2.-$H_offset               ] [expr $Floor5               ];# WUF-Wleft ;
node 53020   [expr $Axis3-$d_Col45_3_t/2.-$H_offset               ] [expr $Floor5               ];# middle WUF-Wleft ;


set K44_two 2.0625;
set K11_two 3.9375;
set K33_two 3.9375;
set K44_one 1.9355;
set K11_one 3.9375;
set K33_one 3.8710;

uniaxialMaterial Elastic 555 [expr 10009999.*$E];
uniaxialMaterial Elastic 556 [expr 10009999.*$E*1000.];
uniaxialMaterial Elastic 666 [expr 0.0001];
set A_pz_rigid 10547290000.0000;
set I_pz_rigid 31220642685.9510;

# FloorAxis = 21;
# Panel Rigid Link;
element elasticBeamColumn 1002101 2105 2101 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002108 2101 2112 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002107 2111 2104 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002106 2104 2110 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002105 2109 2103 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002104 2103 2108 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002103 2107 2102 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002102 2106 2102 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 2105 2106 1 2;
equalDOF 2112 2111 1 2;
equalDOF 2110 2109 1 2;
equalDOF 2107 2108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002100 $M1C_Panel2_1 $Gamma_1_Panel2_1 $M4C_Panel2_1 $Gamma_4_Panel2_1 $M6C_Panel2_1 $Gamma_6_Panel2_1 -$M1_Panel2_1 -$Gamma_1_Panel2_1 -$M4_Panel2_1 -$Gamma_4_Panel2_1 -$M6_Panel2_1 -$Gamma_6_Panel2_1 0.25 0.75 0 0 0;
element zeroLength          1002100  2109 2110 -mat 1002100 -dir 6;
# Panel to hinge;
# Right side;
element ModElasticBeam2d  5002104 21040 2104 $A_Beam12_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam12_2] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 21100 $K_s_Col12_1_t $Alpha_s_Col12_1_t $Alpha_s_Col12_1_t $My_s_Col12_1_t -$My_s_Col12_1_t  $Lambda_s_Col12_1_t $Lambda_c_Col12_1_t $Lambda_s_Col12_1_t $Lambda_k_Col12_1_t 1. 1. 1. 1.  $Theta_p_s_Col12_1_t  $Theta_p_s_Col12_1_t  $Theta_pc_s_Col12_1_t  $Theta_pc_s_Col12_1_t  $Res_s_Col12_1_t  $Res_s_Col12_1_t  $Theta_ult_s_Col12_1_t  $Theta_ult_s_Col12_1_t  1. 1.;
element     zeroLength 21100 211 2101 -mat 21100 -dir 6;
equalDOF                     211 2101 1 2;
# Top Column;
uniaxialMaterial Bilin 21300 $K_s_Col23_1_b $Alpha_s_Col23_1_b $Alpha_s_Col23_1_b $My_s_Col23_1_b -$My_s_Col23_1_b  $Lambda_s_Col23_1_b $Lambda_c_Col23_1_b $Lambda_s_Col23_1_b $Lambda_k_Col23_1_b 1. 1. 1. 1.  $Theta_p_s_Col23_1_b  $Theta_p_s_Col23_1_b  $Theta_pc_s_Col23_1_b  $Theta_pc_s_Col23_1_b $Res_s_Col23_1_b  $Res_s_Col23_1_b  $Theta_ult_s_Col23_1_b  $Theta_ult_s_Col23_1_b  1. 1.;
element     zeroLength 21300 213 2103 -mat 21300 -dir 6;
equalDOF                     213 2103 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 21400 $K_s_Beam12_2 $Alpha_s_Beam12_2 $Alpha_s_BeamComp12_2 $My_s_Beam12_2 -$My_s_BeamComp12_2  $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 1. 1. 1. 1.  $Theta_p_s_Beam12_2  $Theta_p_s_BeamComp12_2  $Theta_pc_s_Beam12_2  $Theta_pc_s_BeamComp12_2  $Res_s_Beam12_2  $Res_s_BeamComp12_2  $Theta_ult_s_Beam12_2  $Theta_ult_s_BeamComp12_2  1. 1.15;
element     zeroLength 21400 214 21040 -mat 21400 -dir 6;
equalDOF                     214 21040 1 2;

# FloorAxis = 31;
# Panel Rigid Link;
element elasticBeamColumn 1003101 3105 3101 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003108 3101 3112 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003107 3111 3104 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003106 3104 3110 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003105 3109 3103 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003104 3103 3108 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003103 3107 3102 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003102 3106 3102 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 3105 3106 1 2;
equalDOF 3112 3111 1 2;
equalDOF 3110 3109 1 2;
equalDOF 3107 3108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003100 $M1C_Panel3_1 $Gamma_1_Panel3_1 $M4C_Panel3_1 $Gamma_4_Panel3_1 $M6C_Panel3_1 $Gamma_6_Panel3_1 -$M1_Panel3_1 -$Gamma_1_Panel3_1 -$M4_Panel3_1 -$Gamma_4_Panel3_1 -$M6_Panel3_1 -$Gamma_6_Panel3_1 0.25 0.75 0 0 0;
element zeroLength          1003100  3109 3110 -mat 1003100 -dir 6;
# Panel to hinge;
# Right side;
element ModElasticBeam2d  5003104 31040 3104 $A_Beam12_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam12_3] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 31100 $K_s_Col23_1_t $Alpha_s_Col23_1_t $Alpha_s_Col23_1_t $My_s_Col23_1_t -$My_s_Col23_1_t  $Lambda_s_Col23_1_t $Lambda_c_Col23_1_t $Lambda_s_Col23_1_t $Lambda_k_Col23_1_t 1. 1. 1. 1.  $Theta_p_s_Col23_1_t  $Theta_p_s_Col23_1_t  $Theta_pc_s_Col23_1_t  $Theta_pc_s_Col23_1_t  $Res_s_Col23_1_t  $Res_s_Col23_1_t  $Theta_ult_s_Col23_1_t  $Theta_ult_s_Col23_1_t  1. 1.;
element     zeroLength 31100 311 3101 -mat 31100 -dir 6;
equalDOF                     311 3101 1 2;
# Top Column;
uniaxialMaterial Bilin 31300 $K_s_Col34_1_b $Alpha_s_Col34_1_b $Alpha_s_Col34_1_b $My_s_Col34_1_b -$My_s_Col34_1_b  $Lambda_s_Col34_1_b $Lambda_c_Col34_1_b $Lambda_s_Col34_1_b $Lambda_k_Col34_1_b 1. 1. 1. 1.  $Theta_p_s_Col34_1_b  $Theta_p_s_Col34_1_b  $Theta_pc_s_Col34_1_b  $Theta_pc_s_Col34_1_b $Res_s_Col34_1_b  $Res_s_Col34_1_b  $Theta_ult_s_Col34_1_b  $Theta_ult_s_Col34_1_b  1. 1.;
element     zeroLength 31300 313 3103 -mat 31300 -dir 6;
equalDOF                     313 3103 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 31400 $K_s_Beam12_3 $Alpha_s_Beam12_3 $Alpha_s_BeamComp12_3 $My_s_Beam12_3 -$My_s_BeamComp12_3  $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 1. 1. 1. 1.  $Theta_p_s_Beam12_3  $Theta_p_s_BeamComp12_3  $Theta_pc_s_Beam12_3  $Theta_pc_s_BeamComp12_3  $Res_s_Beam12_3  $Res_s_BeamComp12_3  $Theta_ult_s_Beam12_3  $Theta_ult_s_BeamComp12_3  1. 1.15;
element     zeroLength 31400 314 31040 -mat 31400 -dir 6;
equalDOF                     314 31040 1 2;

# FloorAxis = 41;
# Panel Rigid Link;
element elasticBeamColumn 1004101 4105 4101 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004108 4101 4112 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004107 4111 4104 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004106 4104 4110 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004105 4109 4103 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004104 4103 4108 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004103 4107 4102 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004102 4106 4102 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 4105 4106 1 2;
equalDOF 4112 4111 1 2;
equalDOF 4110 4109 1 2;
equalDOF 4107 4108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004100 $M1C_Panel4_1 $Gamma_1_Panel4_1 $M4C_Panel4_1 $Gamma_4_Panel4_1 $M6C_Panel4_1 $Gamma_6_Panel4_1 -$M1_Panel4_1 -$Gamma_1_Panel4_1 -$M4_Panel4_1 -$Gamma_4_Panel4_1 -$M6_Panel4_1 -$Gamma_6_Panel4_1 0.25 0.75 0 0 0;
element zeroLength          1004100  4109 4110 -mat 1004100 -dir 6;
# Panel to hinge;
# Right side;
element ModElasticBeam2d  5004104 41040 4104 $A_Beam12_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam12_4] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 41100 $K_s_Col34_1_t $Alpha_s_Col34_1_t $Alpha_s_Col34_1_t $My_s_Col34_1_t -$My_s_Col34_1_t  $Lambda_s_Col34_1_t $Lambda_c_Col34_1_t $Lambda_s_Col34_1_t $Lambda_k_Col34_1_t 1. 1. 1. 1.  $Theta_p_s_Col34_1_t  $Theta_p_s_Col34_1_t  $Theta_pc_s_Col34_1_t  $Theta_pc_s_Col34_1_t  $Res_s_Col34_1_t  $Res_s_Col34_1_t  $Theta_ult_s_Col34_1_t  $Theta_ult_s_Col34_1_t  1. 1.;
element     zeroLength 41100 411 4101 -mat 41100 -dir 6;
equalDOF                     411 4101 1 2;
# Top Column;
uniaxialMaterial Bilin 41300 $K_s_Col45_1_b $Alpha_s_Col45_1_b $Alpha_s_Col45_1_b $My_s_Col45_1_b -$My_s_Col45_1_b  $Lambda_s_Col45_1_b $Lambda_c_Col45_1_b $Lambda_s_Col45_1_b $Lambda_k_Col45_1_b 1. 1. 1. 1.  $Theta_p_s_Col45_1_b  $Theta_p_s_Col45_1_b  $Theta_pc_s_Col45_1_b  $Theta_pc_s_Col45_1_b $Res_s_Col45_1_b  $Res_s_Col45_1_b  $Theta_ult_s_Col45_1_b  $Theta_ult_s_Col45_1_b  1. 1.;
element     zeroLength 41300 413 4103 -mat 41300 -dir 6;
equalDOF                     413 4103 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 41400 $K_s_Beam12_4 $Alpha_s_Beam12_4 $Alpha_s_BeamComp12_4 $My_s_Beam12_4 -$My_s_BeamComp12_4  $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 1. 1. 1. 1.  $Theta_p_s_Beam12_4  $Theta_p_s_BeamComp12_4  $Theta_pc_s_Beam12_4  $Theta_pc_s_BeamComp12_4  $Res_s_Beam12_4  $Res_s_BeamComp12_4  $Theta_ult_s_Beam12_4  $Theta_ult_s_BeamComp12_4  1. 1.15;
element     zeroLength 41400 414 41040 -mat 41400 -dir 6;
equalDOF                     414 41040 1 2;

# FloorAxis = 51;
# Panel Rigid Link;
element elasticBeamColumn 1005101 5105 5101 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005108 5101 5112 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005107 5111 5104 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005106 5104 5110 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005105 5109 5103 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005104 5103 5108 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005103 5107 5102 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005102 5106 5102 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 5105 5106 1 2;
equalDOF 5112 5111 1 2;
equalDOF 5110 5109 1 2;
equalDOF 5107 5108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005100 $M1C_Panel5_1 $Gamma_1_Panel5_1 $M4C_Panel5_1 $Gamma_4_Panel5_1 $M6C_Panel5_1 $Gamma_6_Panel5_1 -$M1_Panel5_1 -$Gamma_1_Panel5_1 -$M4_Panel5_1 -$Gamma_4_Panel5_1 -$M6_Panel5_1 -$Gamma_6_Panel5_1 0.25 0.75 0 0 0;
element zeroLength          1005100  5109 5110 -mat 1005100 -dir 6;
# Panel to hinge;
# Right side;
element ModElasticBeam2d  5005104 51040 5104 $A_Beam12_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam12_5] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 51100 $K_s_Col45_1_t $Alpha_s_Col45_1_t $Alpha_s_Col45_1_t $My_s_Col45_1_t -$My_s_Col45_1_t  $Lambda_s_Col45_1_t $Lambda_c_Col45_1_t $Lambda_s_Col45_1_t $Lambda_k_Col45_1_t 1. 1. 1. 1.  $Theta_p_s_Col45_1_t  $Theta_p_s_Col45_1_t  $Theta_pc_s_Col45_1_t  $Theta_pc_s_Col45_1_t  $Res_s_Col45_1_t  $Res_s_Col45_1_t  $Theta_ult_s_Col45_1_t  $Theta_ult_s_Col45_1_t  1. 1.;
element     zeroLength 51100 511 5101 -mat 51100 -dir 6;
equalDOF                     511 5101 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 51400 $K_s_Beam12_5 $Alpha_s_Beam12_5 $Alpha_s_BeamComp12_5 $My_s_Beam12_5 -$My_s_BeamComp12_5  $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 1. 1. 1. 1.  $Theta_p_s_Beam12_5  $Theta_p_s_BeamComp12_5  $Theta_pc_s_Beam12_5  $Theta_pc_s_BeamComp12_5  $Res_s_Beam12_5  $Res_s_BeamComp12_5  $Theta_ult_s_Beam12_5  $Theta_ult_s_BeamComp12_5  1. 1.15;
element     zeroLength 51400 514 51040 -mat 51400 -dir 6;
equalDOF                     514 51040 1 2;

# FloorAxis = 22;
# Panel Rigid Link;
element elasticBeamColumn 1002201 2205 2201 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002208 2201 2212 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002207 2211 2204 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002206 2204 2210 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002205 2209 2203 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002204 2203 2208 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002203 2207 2202 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002202 2206 2202 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 2205 2206 1 2;
equalDOF 2212 2211 1 2;
equalDOF 2210 2209 1 2;
equalDOF 2207 2208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002200 $M1C_Panel2_2 $Gamma_1_Panel2_2 $M4C_Panel2_2 $Gamma_4_Panel2_2 $M6C_Panel2_2 $Gamma_6_Panel2_2 -$M1C_Panel2_2 -$Gamma_1_Panel2_2 -$M4C_Panel2_2 -$Gamma_4_Panel2_2 -$M6C_Panel2_2 -$Gamma_6_Panel2_2 0.25 0.75 0 0 0;
element zeroLength          1002200  2209 2210 -mat 1002200 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5002202 22020 2202 $A_Beam12_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam12_2] $K11_one $K33_one $K44_one 1;
# Right side;
element ModElasticBeam2d  5002204 22040 2204 $A_Beam23_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam23_2] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 22100 $K_s_Col12_2_t $Alpha_s_Col12_2_t $Alpha_s_Col12_2_t $My_s_Col12_2_t -$My_s_Col12_2_t  $Lambda_s_Col12_2_t $Lambda_c_Col12_2_t $Lambda_s_Col12_2_t $Lambda_k_Col12_2_t 1. 1. 1. 1.  $Theta_p_s_Col12_2_t  $Theta_p_s_Col12_2_t  $Theta_pc_s_Col12_2_t  $Theta_pc_s_Col12_2_t  $Res_s_Col12_2_t  $Res_s_Col12_2_t  $Theta_ult_s_Col12_2_t  $Theta_ult_s_Col12_2_t  1. 1.;
element     zeroLength 22100 221 2201 -mat 22100 -dir 6;
equalDOF                     221 2201 1 2;
# Top Column;
uniaxialMaterial Bilin 22300 $K_s_Col23_2_b $Alpha_s_Col23_2_b $Alpha_s_Col23_2_b $My_s_Col23_2_b -$My_s_Col23_2_b  $Lambda_s_Col23_2_b $Lambda_c_Col23_2_b $Lambda_s_Col23_2_b $Lambda_k_Col23_2_b 1. 1. 1. 1.  $Theta_p_s_Col23_2_b  $Theta_p_s_Col23_2_b  $Theta_pc_s_Col23_2_b  $Theta_pc_s_Col23_2_b $Res_s_Col23_2_b  $Res_s_Col23_2_b  $Theta_ult_s_Col23_2_b  $Theta_ult_s_Col23_2_b  1. 1.;
element     zeroLength 22300 223 2203 -mat 22300 -dir 6;
equalDOF                     223 2203 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 22200 $K_s_Beam12_2 $Alpha_s_BeamComp12_2 $Alpha_s_Beam12_2 $My_s_BeamComp12_2 -$My_s_Beam12_2  $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 1. 1. 1. 1.  $Theta_p_s_BeamComp12_2  $Theta_p_s_Beam12_2  $Theta_pc_s_BeamComp12_2  $Theta_pc_s_Beam12_2  $Res_s_BeamComp12_2  $Res_s_Beam12_2  $Theta_ult_s_BeamComp12_2  $Theta_ult_s_Beam12_2  1.15 1.;
element     zeroLength 22200 222 22020 -mat 22200 -dir 6;
equalDOF                     222 22020 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 22400 $K_s_Beam23_2 $Alpha_s_Beam23_2 $Alpha_s_BeamComp23_2 $My_s_Beam23_2 -$My_s_BeamComp23_2  $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 1. 1. 1. 1.  $Theta_p_s_Beam23_2  $Theta_p_s_BeamComp23_2  $Theta_pc_s_Beam23_2  $Theta_pc_s_BeamComp23_2  $Res_s_Beam23_2  $Res_s_BeamComp23_2  $Theta_ult_s_Beam23_2  $Theta_ult_s_BeamComp23_2  1. 1.15;
element     zeroLength 22400 224 22040 -mat 22400 -dir 6;
equalDOF                     224 22040 1 2;

# FloorAxis = 32;
# Panel Rigid Link;
element elasticBeamColumn 1003201 3205 3201 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003208 3201 3212 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003207 3211 3204 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003206 3204 3210 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003205 3209 3203 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003204 3203 3208 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003203 3207 3202 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003202 3206 3202 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 3205 3206 1 2;
equalDOF 3212 3211 1 2;
equalDOF 3210 3209 1 2;
equalDOF 3207 3208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003200 $M1C_Panel3_2 $Gamma_1_Panel3_2 $M4C_Panel3_2 $Gamma_4_Panel3_2 $M6C_Panel3_2 $Gamma_6_Panel3_2 -$M1C_Panel3_2 -$Gamma_1_Panel3_2 -$M4C_Panel3_2 -$Gamma_4_Panel3_2 -$M6C_Panel3_2 -$Gamma_6_Panel3_2 0.25 0.75 0 0 0;
element zeroLength          1003200  3209 3210 -mat 1003200 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5003202 32020 3202 $A_Beam12_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam12_3] $K11_one $K33_one $K44_one 1;
# Right side;
element ModElasticBeam2d  5003204 32040 3204 $A_Beam23_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam23_3] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 32100 $K_s_Col23_2_t $Alpha_s_Col23_2_t $Alpha_s_Col23_2_t $My_s_Col23_2_t -$My_s_Col23_2_t  $Lambda_s_Col23_2_t $Lambda_c_Col23_2_t $Lambda_s_Col23_2_t $Lambda_k_Col23_2_t 1. 1. 1. 1.  $Theta_p_s_Col23_2_t  $Theta_p_s_Col23_2_t  $Theta_pc_s_Col23_2_t  $Theta_pc_s_Col23_2_t  $Res_s_Col23_2_t  $Res_s_Col23_2_t  $Theta_ult_s_Col23_2_t  $Theta_ult_s_Col23_2_t  1. 1.;
element     zeroLength 32100 321 3201 -mat 32100 -dir 6;
equalDOF                     321 3201 1 2;
# Top Column;
uniaxialMaterial Bilin 32300 $K_s_Col34_2_b $Alpha_s_Col34_2_b $Alpha_s_Col34_2_b $My_s_Col34_2_b -$My_s_Col34_2_b  $Lambda_s_Col34_2_b $Lambda_c_Col34_2_b $Lambda_s_Col34_2_b $Lambda_k_Col34_2_b 1. 1. 1. 1.  $Theta_p_s_Col34_2_b  $Theta_p_s_Col34_2_b  $Theta_pc_s_Col34_2_b  $Theta_pc_s_Col34_2_b $Res_s_Col34_2_b  $Res_s_Col34_2_b  $Theta_ult_s_Col34_2_b  $Theta_ult_s_Col34_2_b  1. 1.;
element     zeroLength 32300 323 3203 -mat 32300 -dir 6;
equalDOF                     323 3203 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 32200 $K_s_Beam12_3 $Alpha_s_BeamComp12_3 $Alpha_s_Beam12_3 $My_s_BeamComp12_3 -$My_s_Beam12_3  $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 1. 1. 1. 1.  $Theta_p_s_BeamComp12_3  $Theta_p_s_Beam12_3  $Theta_pc_s_BeamComp12_3  $Theta_pc_s_Beam12_3  $Res_s_BeamComp12_3  $Res_s_Beam12_3  $Theta_ult_s_BeamComp12_3  $Theta_ult_s_Beam12_3  1.15 1.;
element     zeroLength 32200 322 32020 -mat 32200 -dir 6;
equalDOF                     322 32020 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 32400 $K_s_Beam23_3 $Alpha_s_Beam23_3 $Alpha_s_BeamComp23_3 $My_s_Beam23_3 -$My_s_BeamComp23_3  $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 1. 1. 1. 1.  $Theta_p_s_Beam23_3  $Theta_p_s_BeamComp23_3  $Theta_pc_s_Beam23_3  $Theta_pc_s_BeamComp23_3  $Res_s_Beam23_3  $Res_s_BeamComp23_3  $Theta_ult_s_Beam23_3  $Theta_ult_s_BeamComp23_3  1. 1.15;
element     zeroLength 32400 324 32040 -mat 32400 -dir 6;
equalDOF                     324 32040 1 2;

# FloorAxis = 42;
# Panel Rigid Link;
element elasticBeamColumn 1004201 4205 4201 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004208 4201 4212 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004207 4211 4204 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004206 4204 4210 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004205 4209 4203 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004204 4203 4208 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004203 4207 4202 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004202 4206 4202 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 4205 4206 1 2;
equalDOF 4212 4211 1 2;
equalDOF 4210 4209 1 2;
equalDOF 4207 4208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004200 $M1C_Panel4_2 $Gamma_1_Panel4_2 $M4C_Panel4_2 $Gamma_4_Panel4_2 $M6C_Panel4_2 $Gamma_6_Panel4_2 -$M1C_Panel4_2 -$Gamma_1_Panel4_2 -$M4C_Panel4_2 -$Gamma_4_Panel4_2 -$M6C_Panel4_2 -$Gamma_6_Panel4_2 0.25 0.75 0 0 0;
element zeroLength          1004200  4209 4210 -mat 1004200 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5004202 42020 4202 $A_Beam12_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam12_4] $K11_one $K33_one $K44_one 1;
# Right side;
element ModElasticBeam2d  5004204 42040 4204 $A_Beam23_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam23_4] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 42100 $K_s_Col34_2_t $Alpha_s_Col34_2_t $Alpha_s_Col34_2_t $My_s_Col34_2_t -$My_s_Col34_2_t  $Lambda_s_Col34_2_t $Lambda_c_Col34_2_t $Lambda_s_Col34_2_t $Lambda_k_Col34_2_t 1. 1. 1. 1.  $Theta_p_s_Col34_2_t  $Theta_p_s_Col34_2_t  $Theta_pc_s_Col34_2_t  $Theta_pc_s_Col34_2_t  $Res_s_Col34_2_t  $Res_s_Col34_2_t  $Theta_ult_s_Col34_2_t  $Theta_ult_s_Col34_2_t  1. 1.;
element     zeroLength 42100 421 4201 -mat 42100 -dir 6;
equalDOF                     421 4201 1 2;
# Top Column;
uniaxialMaterial Bilin 42300 $K_s_Col45_2_b $Alpha_s_Col45_2_b $Alpha_s_Col45_2_b $My_s_Col45_2_b -$My_s_Col45_2_b  $Lambda_s_Col45_2_b $Lambda_c_Col45_2_b $Lambda_s_Col45_2_b $Lambda_k_Col45_2_b 1. 1. 1. 1.  $Theta_p_s_Col45_2_b  $Theta_p_s_Col45_2_b  $Theta_pc_s_Col45_2_b  $Theta_pc_s_Col45_2_b $Res_s_Col45_2_b  $Res_s_Col45_2_b  $Theta_ult_s_Col45_2_b  $Theta_ult_s_Col45_2_b  1. 1.;
element     zeroLength 42300 423 4203 -mat 42300 -dir 6;
equalDOF                     423 4203 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 42200 $K_s_Beam12_4 $Alpha_s_BeamComp12_4 $Alpha_s_Beam12_4 $My_s_BeamComp12_4 -$My_s_Beam12_4  $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 1. 1. 1. 1.  $Theta_p_s_BeamComp12_4  $Theta_p_s_Beam12_4  $Theta_pc_s_BeamComp12_4  $Theta_pc_s_Beam12_4  $Res_s_BeamComp12_4  $Res_s_Beam12_4  $Theta_ult_s_BeamComp12_4  $Theta_ult_s_Beam12_4  1.15 1.;
element     zeroLength 42200 422 42020 -mat 42200 -dir 6;
equalDOF                     422 42020 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 42400 $K_s_Beam23_4 $Alpha_s_Beam23_4 $Alpha_s_BeamComp23_4 $My_s_Beam23_4 -$My_s_BeamComp23_4  $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 1. 1. 1. 1.  $Theta_p_s_Beam23_4  $Theta_p_s_BeamComp23_4  $Theta_pc_s_Beam23_4  $Theta_pc_s_BeamComp23_4  $Res_s_Beam23_4  $Res_s_BeamComp23_4  $Theta_ult_s_Beam23_4  $Theta_ult_s_BeamComp23_4  1. 1.15;
element     zeroLength 42400 424 42040 -mat 42400 -dir 6;
equalDOF                     424 42040 1 2;

# FloorAxis = 52;
# Panel Rigid Link;
element elasticBeamColumn 1005201 5205 5201 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005208 5201 5212 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005207 5211 5204 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005206 5204 5210 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005205 5209 5203 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005204 5203 5208 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005203 5207 5202 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005202 5206 5202 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 5205 5206 1 2;
equalDOF 5212 5211 1 2;
equalDOF 5210 5209 1 2;
equalDOF 5207 5208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005200 $M1C_Panel5_2 $Gamma_1_Panel5_2 $M4C_Panel5_2 $Gamma_4_Panel5_2 $M6C_Panel5_2 $Gamma_6_Panel5_2 -$M1C_Panel5_2 -$Gamma_1_Panel5_2 -$M4C_Panel5_2 -$Gamma_4_Panel5_2 -$M6C_Panel5_2 -$Gamma_6_Panel5_2 0.25 0.75 0 0 0;
element zeroLength          1005200  5209 5210 -mat 1005200 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5005202 52020 5202 $A_Beam12_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam12_5] $K11_one $K33_one $K44_one 1;
# Right side;
element ModElasticBeam2d  5005204 52040 5204 $A_Beam23_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam23_5] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 52100 $K_s_Col45_2_t $Alpha_s_Col45_2_t $Alpha_s_Col45_2_t $My_s_Col45_2_t -$My_s_Col45_2_t  $Lambda_s_Col45_2_t $Lambda_c_Col45_2_t $Lambda_s_Col45_2_t $Lambda_k_Col45_2_t 1. 1. 1. 1.  $Theta_p_s_Col45_2_t  $Theta_p_s_Col45_2_t  $Theta_pc_s_Col45_2_t  $Theta_pc_s_Col45_2_t  $Res_s_Col45_2_t  $Res_s_Col45_2_t  $Theta_ult_s_Col45_2_t  $Theta_ult_s_Col45_2_t  1. 1.;
element     zeroLength 52100 521 5201 -mat 52100 -dir 6;
equalDOF                     521 5201 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 52200 $K_s_Beam12_5 $Alpha_s_BeamComp12_5 $Alpha_s_Beam12_5 $My_s_BeamComp12_5 -$My_s_Beam12_5  $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 1. 1. 1. 1.  $Theta_p_s_BeamComp12_5  $Theta_p_s_Beam12_5  $Theta_pc_s_BeamComp12_5  $Theta_pc_s_Beam12_5  $Res_s_BeamComp12_5  $Res_s_Beam12_5  $Theta_ult_s_BeamComp12_5  $Theta_ult_s_Beam12_5  1.15 1.;
element     zeroLength 52200 522 52020 -mat 52200 -dir 6;
equalDOF                     522 52020 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 52400 $K_s_Beam23_5 $Alpha_s_Beam23_5 $Alpha_s_BeamComp23_5 $My_s_Beam23_5 -$My_s_BeamComp23_5  $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 1. 1. 1. 1.  $Theta_p_s_Beam23_5  $Theta_p_s_BeamComp23_5  $Theta_pc_s_Beam23_5  $Theta_pc_s_BeamComp23_5  $Res_s_Beam23_5  $Res_s_BeamComp23_5  $Theta_ult_s_Beam23_5  $Theta_ult_s_BeamComp23_5  1. 1.15;
element     zeroLength 52400 524 52040 -mat 52400 -dir 6;
equalDOF                     524 52040 1 2;

# FloorAxis = 23;
# Panel Rigid Link;
element elasticBeamColumn 1002301 2305 2301 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002308 2301 2312 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002307 2311 2304 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002306 2304 2310 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002305 2309 2303 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002304 2303 2308 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002303 2307 2302 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1002302 2306 2302 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 2305 2306 1 2;
equalDOF 2312 2311 1 2;
equalDOF 2310 2309 1 2;
equalDOF 2307 2308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002300 $M1_Panel2_3 $Gamma_1_Panel2_3 $M4_Panel2_3 $Gamma_4_Panel2_3 $M6_Panel2_3 $Gamma_6_Panel2_3 -$M1C_Panel2_3 -$Gamma_1_Panel2_3 -$M4C_Panel2_3 -$Gamma_4_Panel2_3 -$M6C_Panel2_3 -$Gamma_6_Panel2_3 0.25 0.75 0 0 0;
element zeroLength          1002300  2309 2310 -mat 1002300 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5002302 23020 2302 $A_Beam23_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam23_2] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 23100 $K_s_Col12_3_t $Alpha_s_Col12_3_t $Alpha_s_Col12_3_t $My_s_Col12_3_t -$My_s_Col12_3_t  $Lambda_s_Col12_3_t $Lambda_c_Col12_3_t $Lambda_s_Col12_3_t $Lambda_k_Col12_3_t 1. 1. 1. 1.  $Theta_p_s_Col12_3_t  $Theta_p_s_Col12_3_t  $Theta_pc_s_Col12_3_t  $Theta_pc_s_Col12_3_t  $Res_s_Col12_3_t  $Res_s_Col12_3_t  $Theta_ult_s_Col12_3_t  $Theta_ult_s_Col12_3_t  1. 1.;
element     zeroLength 23100 231 2301 -mat 23100 -dir 6;
equalDOF                     231 2301 1 2;
# Top Column;
uniaxialMaterial Bilin 23300 $K_s_Col23_3_b $Alpha_s_Col23_3_b $Alpha_s_Col23_3_b $My_s_Col23_3_b -$My_s_Col23_3_b  $Lambda_s_Col23_3_b $Lambda_c_Col23_3_b $Lambda_s_Col23_3_b $Lambda_k_Col23_3_b 1. 1. 1. 1.  $Theta_p_s_Col23_3_b  $Theta_p_s_Col23_3_b  $Theta_pc_s_Col23_3_b  $Theta_pc_s_Col23_3_b $Res_s_Col23_3_b  $Res_s_Col23_3_b  $Theta_ult_s_Col23_3_b  $Theta_ult_s_Col23_3_b  1. 1.;
element     zeroLength 23300 233 2303 -mat 23300 -dir 6;
equalDOF                     233 2303 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 23200 $K_s_Beam23_2 $Alpha_s_BeamComp23_2 $Alpha_s_Beam23_2 $My_s_BeamComp23_2 -$My_s_Beam23_2  $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 1. 1. 1. 1.  $Theta_p_s_BeamComp23_2  $Theta_p_s_Beam23_2  $Theta_pc_s_BeamComp23_2  $Theta_pc_s_Beam23_2  $Res_s_BeamComp23_2  $Res_s_Beam23_2  $Theta_ult_s_BeamComp23_2  $Theta_ult_s_Beam23_2  1.15 1.;
element     zeroLength 23200 232 23020 -mat 23200 -dir 6;
equalDOF                     232 23020 1 2;

# FloorAxis = 33;
# Panel Rigid Link;
element elasticBeamColumn 1003301 3305 3301 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003308 3301 3312 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003307 3311 3304 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003306 3304 3310 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003305 3309 3303 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003304 3303 3308 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003303 3307 3302 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1003302 3306 3302 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 3305 3306 1 2;
equalDOF 3312 3311 1 2;
equalDOF 3310 3309 1 2;
equalDOF 3307 3308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003300 $M1_Panel3_3 $Gamma_1_Panel3_3 $M4_Panel3_3 $Gamma_4_Panel3_3 $M6_Panel3_3 $Gamma_6_Panel3_3 -$M1C_Panel3_3 -$Gamma_1_Panel3_3 -$M4C_Panel3_3 -$Gamma_4_Panel3_3 -$M6C_Panel3_3 -$Gamma_6_Panel3_3 0.25 0.75 0 0 0;
element zeroLength          1003300  3309 3310 -mat 1003300 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5003302 33020 3302 $A_Beam23_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam23_3] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 33100 $K_s_Col23_3_t $Alpha_s_Col23_3_t $Alpha_s_Col23_3_t $My_s_Col23_3_t -$My_s_Col23_3_t  $Lambda_s_Col23_3_t $Lambda_c_Col23_3_t $Lambda_s_Col23_3_t $Lambda_k_Col23_3_t 1. 1. 1. 1.  $Theta_p_s_Col23_3_t  $Theta_p_s_Col23_3_t  $Theta_pc_s_Col23_3_t  $Theta_pc_s_Col23_3_t  $Res_s_Col23_3_t  $Res_s_Col23_3_t  $Theta_ult_s_Col23_3_t  $Theta_ult_s_Col23_3_t  1. 1.;
element     zeroLength 33100 331 3301 -mat 33100 -dir 6;
equalDOF                     331 3301 1 2;
# Top Column;
uniaxialMaterial Bilin 33300 $K_s_Col34_3_b $Alpha_s_Col34_3_b $Alpha_s_Col34_3_b $My_s_Col34_3_b -$My_s_Col34_3_b  $Lambda_s_Col34_3_b $Lambda_c_Col34_3_b $Lambda_s_Col34_3_b $Lambda_k_Col34_3_b 1. 1. 1. 1.  $Theta_p_s_Col34_3_b  $Theta_p_s_Col34_3_b  $Theta_pc_s_Col34_3_b  $Theta_pc_s_Col34_3_b $Res_s_Col34_3_b  $Res_s_Col34_3_b  $Theta_ult_s_Col34_3_b  $Theta_ult_s_Col34_3_b  1. 1.;
element     zeroLength 33300 333 3303 -mat 33300 -dir 6;
equalDOF                     333 3303 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 33200 $K_s_Beam23_3 $Alpha_s_BeamComp23_3 $Alpha_s_Beam23_3 $My_s_BeamComp23_3 -$My_s_Beam23_3  $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 1. 1. 1. 1.  $Theta_p_s_BeamComp23_3  $Theta_p_s_Beam23_3  $Theta_pc_s_BeamComp23_3  $Theta_pc_s_Beam23_3  $Res_s_BeamComp23_3  $Res_s_Beam23_3  $Theta_ult_s_BeamComp23_3  $Theta_ult_s_Beam23_3  1.15 1.;
element     zeroLength 33200 332 33020 -mat 33200 -dir 6;
equalDOF                     332 33020 1 2;

# FloorAxis = 43;
# Panel Rigid Link;
element elasticBeamColumn 1004301 4305 4301 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004308 4301 4312 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004307 4311 4304 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004306 4304 4310 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004305 4309 4303 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004304 4303 4308 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004303 4307 4302 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1004302 4306 4302 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 4305 4306 1 2;
equalDOF 4312 4311 1 2;
equalDOF 4310 4309 1 2;
equalDOF 4307 4308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004300 $M1_Panel4_3 $Gamma_1_Panel4_3 $M4_Panel4_3 $Gamma_4_Panel4_3 $M6_Panel4_3 $Gamma_6_Panel4_3 -$M1C_Panel4_3 -$Gamma_1_Panel4_3 -$M4C_Panel4_3 -$Gamma_4_Panel4_3 -$M6C_Panel4_3 -$Gamma_6_Panel4_3 0.25 0.75 0 0 0;
element zeroLength          1004300  4309 4310 -mat 1004300 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5004302 43020 4302 $A_Beam23_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam23_4] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 43100 $K_s_Col34_3_t $Alpha_s_Col34_3_t $Alpha_s_Col34_3_t $My_s_Col34_3_t -$My_s_Col34_3_t  $Lambda_s_Col34_3_t $Lambda_c_Col34_3_t $Lambda_s_Col34_3_t $Lambda_k_Col34_3_t 1. 1. 1. 1.  $Theta_p_s_Col34_3_t  $Theta_p_s_Col34_3_t  $Theta_pc_s_Col34_3_t  $Theta_pc_s_Col34_3_t  $Res_s_Col34_3_t  $Res_s_Col34_3_t  $Theta_ult_s_Col34_3_t  $Theta_ult_s_Col34_3_t  1. 1.;
element     zeroLength 43100 431 4301 -mat 43100 -dir 6;
equalDOF                     431 4301 1 2;
# Top Column;
uniaxialMaterial Bilin 43300 $K_s_Col45_3_b $Alpha_s_Col45_3_b $Alpha_s_Col45_3_b $My_s_Col45_3_b -$My_s_Col45_3_b  $Lambda_s_Col45_3_b $Lambda_c_Col45_3_b $Lambda_s_Col45_3_b $Lambda_k_Col45_3_b 1. 1. 1. 1.  $Theta_p_s_Col45_3_b  $Theta_p_s_Col45_3_b  $Theta_pc_s_Col45_3_b  $Theta_pc_s_Col45_3_b $Res_s_Col45_3_b  $Res_s_Col45_3_b  $Theta_ult_s_Col45_3_b  $Theta_ult_s_Col45_3_b  1. 1.;
element     zeroLength 43300 433 4303 -mat 43300 -dir 6;
equalDOF                     433 4303 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 43200 $K_s_Beam23_4 $Alpha_s_BeamComp23_4 $Alpha_s_Beam23_4 $My_s_BeamComp23_4 -$My_s_Beam23_4  $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 1. 1. 1. 1.  $Theta_p_s_BeamComp23_4  $Theta_p_s_Beam23_4  $Theta_pc_s_BeamComp23_4  $Theta_pc_s_Beam23_4  $Res_s_BeamComp23_4  $Res_s_Beam23_4  $Theta_ult_s_BeamComp23_4  $Theta_ult_s_Beam23_4  1.15 1.;
element     zeroLength 43200 432 43020 -mat 43200 -dir 6;
equalDOF                     432 43020 1 2;

# FloorAxis = 53;
# Panel Rigid Link;
element elasticBeamColumn 1005301 5305 5301 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005308 5301 5312 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005307 5311 5304 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005306 5304 5310 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005305 5309 5303 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005304 5303 5308 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005303 5307 5302 $A_pz_rigid $E $I_pz_rigid 1;
element elasticBeamColumn 1005302 5306 5302 $A_pz_rigid $E $I_pz_rigid 1;
equalDOF 5305 5306 1 2;
equalDOF 5312 5311 1 2;
equalDOF 5310 5309 1 2;
equalDOF 5307 5308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005300 $M1_Panel5_3 $Gamma_1_Panel5_3 $M4_Panel5_3 $Gamma_4_Panel5_3 $M6_Panel5_3 $Gamma_6_Panel5_3 -$M1C_Panel5_3 -$Gamma_1_Panel5_3 -$M4C_Panel5_3 -$Gamma_4_Panel5_3 -$M6C_Panel5_3 -$Gamma_6_Panel5_3 0.25 0.75 0 0 0;
element zeroLength          1005300  5309 5310 -mat 1005300 -dir 6;
# Panel to hinge;
# Left side;
element ModElasticBeam2d  5005302 53020 5302 $A_Beam23_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam23_5] $K11_one $K33_one $K44_one 1;

# IMK Hinges;
# Bottom Column;
uniaxialMaterial Bilin 53100 $K_s_Col45_3_t $Alpha_s_Col45_3_t $Alpha_s_Col45_3_t $My_s_Col45_3_t -$My_s_Col45_3_t  $Lambda_s_Col45_3_t $Lambda_c_Col45_3_t $Lambda_s_Col45_3_t $Lambda_k_Col45_3_t 1. 1. 1. 1.  $Theta_p_s_Col45_3_t  $Theta_p_s_Col45_3_t  $Theta_pc_s_Col45_3_t  $Theta_pc_s_Col45_3_t  $Res_s_Col45_3_t  $Res_s_Col45_3_t  $Theta_ult_s_Col45_3_t  $Theta_ult_s_Col45_3_t  1. 1.;
element     zeroLength 53100 531 5301 -mat 53100 -dir 6;
equalDOF                     531 5301 1 2;
# Left WUF-W;
uniaxialMaterial Bilin 53200 $K_s_Beam23_5 $Alpha_s_BeamComp23_5 $Alpha_s_Beam23_5 $My_s_BeamComp23_5 -$My_s_Beam23_5  $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 1. 1. 1. 1.  $Theta_p_s_BeamComp23_5  $Theta_p_s_Beam23_5  $Theta_pc_s_BeamComp23_5  $Theta_pc_s_Beam23_5  $Res_s_BeamComp23_5  $Res_s_Beam23_5  $Theta_ult_s_BeamComp23_5  $Theta_ult_s_Beam23_5  1.15 1.;
element     zeroLength 53200 532 53020 -mat 53200 -dir 6;
equalDOF                     532 53020 1 2;

# Beam-column element;
# Columns;

# Story 1, Axis 1 Column;
element ModElasticBeam2d 113211 113 211 $A_Col12_1_b $E [expr (10.00+1)/10.00*$Ix_Col12_1_b] $K11_two $K33_two $K44_two 1;
# Story 2, Axis 1 Column;
element ModElasticBeam2d 213311 213 311 $A_Col23_1_b $E [expr (10.00+1)/10.00*$Ix_Col23_1_b] $K11_two $K33_two $K44_two 1;
# Story 3, Axis 1 Column;
element ModElasticBeam2d 313411 313 411 $A_Col34_1_b $E [expr (10.00+1)/10.00*$Ix_Col34_1_b] $K11_two $K33_two $K44_two 1;
# Story 4, Axis 1 Column;
element ModElasticBeam2d 413511 413 511 $A_Col45_1_b $E [expr (10.00+1)/10.00*$Ix_Col45_1_b] $K11_two $K33_two $K44_two 1;
# Story 1, Axis 2 Column;
element ModElasticBeam2d 123221 123 221 $A_Col12_2_b $E [expr (10.00+1)/10.00*$Ix_Col12_2_b] $K11_two $K33_two $K44_two 1;
# Story 2, Axis 2 Column;
element ModElasticBeam2d 223321 223 321 $A_Col23_2_b $E [expr (10.00+1)/10.00*$Ix_Col23_2_b] $K11_two $K33_two $K44_two 1;
# Story 3, Axis 2 Column;
element ModElasticBeam2d 323421 323 421 $A_Col34_2_b $E [expr (10.00+1)/10.00*$Ix_Col34_2_b] $K11_two $K33_two $K44_two 1;
# Story 4, Axis 2 Column;
element ModElasticBeam2d 423521 423 521 $A_Col45_2_b $E [expr (10.00+1)/10.00*$Ix_Col45_2_b] $K11_two $K33_two $K44_two 1;
# Story 1, Axis 3 Column;
element ModElasticBeam2d 133231 133 231 $A_Col12_3_b $E [expr (10.00+1)/10.00*$Ix_Col12_3_b] $K11_two $K33_two $K44_two 1;
# Story 2, Axis 3 Column;
element ModElasticBeam2d 233331 233 331 $A_Col23_3_b $E [expr (10.00+1)/10.00*$Ix_Col23_3_b] $K11_two $K33_two $K44_two 1;
# Story 3, Axis 3 Column;
element ModElasticBeam2d 333431 333 431 $A_Col34_3_b $E [expr (10.00+1)/10.00*$Ix_Col34_3_b] $K11_two $K33_two $K44_two 1;
# Story 4, Axis 3 Column;
element ModElasticBeam2d 433531 433 531 $A_Col45_3_b $E [expr (10.00+1)/10.00*$Ix_Col45_3_b] $K11_two $K33_two $K44_two 1;

# Beams;
# Span 1 Floor 2 Beam;
element ModElasticBeam2d 214222 214 222 $A_Beam12_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam12_2] $K11_two $K33_two $K44_two 1;
# Span 1 Floor 3 Beam;
element ModElasticBeam2d 314322 314 322 $A_Beam12_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam12_3] $K11_two $K33_two $K44_two 1;
# Span 1 Floor 4 Beam;
element ModElasticBeam2d 414422 414 422 $A_Beam12_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam12_4] $K11_two $K33_two $K44_two 1;
# Span 1 Floor 5 Beam;
element ModElasticBeam2d 514522 514 522 $A_Beam12_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam12_5] $K11_two $K33_two $K44_two 1;
# Span 2 Floor 2 Beam;
element ModElasticBeam2d 224232 224 232 $A_Beam23_2 $E [expr (10.00+1)/10.00*1.3310*$Ix_Beam23_2] $K11_two $K33_two $K44_two 1;
# Span 2 Floor 3 Beam;
element ModElasticBeam2d 324332 324 332 $A_Beam23_3 $E [expr (10.00+1)/10.00*1.3730*$Ix_Beam23_3] $K11_two $K33_two $K44_two 1;
# Span 2 Floor 4 Beam;
element ModElasticBeam2d 424432 424 432 $A_Beam23_4 $E [expr (10.00+1)/10.00*1.4350*$Ix_Beam23_4] $K11_two $K33_two $K44_two 1;
# Span 2 Floor 5 Beam;
element ModElasticBeam2d 524532 524 532 $A_Beam23_5 $E [expr (10.00+1)/10.00*1.4950*$Ix_Beam23_5] $K11_two $K33_two $K44_two 1;

# Column Base;
# Axis = 1;
uniaxialMaterial Bilin 11300 $K_s_Col12_1_b $Alpha_s_Col12_1_b $Alpha_s_Col12_1_b $My_s_Col12_1_b -$My_s_Col12_1_b $Lambda_s_Col12_1_b $Lambda_c_Col12_1_b $Lambda_s_Col12_1_b $Lambda_k_Col12_1_b 1. 1. 1. 1.  $Theta_p_s_Col12_1_b  $Theta_p_s_Col12_1_b  $Theta_pc_s_Col12_1_b  $Theta_pc_s_Col12_1_b  $Res_s_Col12_1_b  $Res_s_Col12_1_b  $Theta_ult_s_Col12_1_b $Theta_ult_s_Col12_1_b  1. 1.;
element zeroLength 11300 1103 113 -mat 11300 -dir 6;
equalDOF                     1103 113 1 2;

# Axis = 2;
uniaxialMaterial Bilin 12300 $K_s_Col12_2_b $Alpha_s_Col12_2_b $Alpha_s_Col12_2_b $My_s_Col12_2_b -$My_s_Col12_2_b $Lambda_s_Col12_2_b $Lambda_c_Col12_2_b $Lambda_s_Col12_2_b $Lambda_k_Col12_2_b 1. 1. 1. 1.  $Theta_p_s_Col12_2_b  $Theta_p_s_Col12_2_b  $Theta_pc_s_Col12_2_b  $Theta_pc_s_Col12_2_b  $Res_s_Col12_2_b  $Res_s_Col12_2_b  $Theta_ult_s_Col12_2_b $Theta_ult_s_Col12_2_b  1. 1.;
element zeroLength 12300 1203 123 -mat 12300 -dir 6;
equalDOF                     1203 123 1 2;

# Axis = 3;
uniaxialMaterial Bilin 13300 $K_s_Col12_3_b $Alpha_s_Col12_3_b $Alpha_s_Col12_3_b $My_s_Col12_3_b -$My_s_Col12_3_b $Lambda_s_Col12_3_b $Lambda_c_Col12_3_b $Lambda_s_Col12_3_b $Lambda_k_Col12_3_b 1. 1. 1. 1.  $Theta_p_s_Col12_3_b  $Theta_p_s_Col12_3_b  $Theta_pc_s_Col12_3_b  $Theta_pc_s_Col12_3_b  $Res_s_Col12_3_b  $Res_s_Col12_3_b  $Theta_ult_s_Col12_3_b $Theta_ult_s_Col12_3_b  1. 1.;
element zeroLength 13300 1303 133 -mat 13300 -dir 6;
equalDOF                     1303 133 1 2;

# Floor movement / Rigid Diaphram;
equalDOF 2102 2202 1;
equalDOF 2102 2302 1;
equalDOF 3102 3202 1;
equalDOF 3102 3302 1;
equalDOF 4102 4202 1;
equalDOF 4102 4302 1;
equalDOF 5102 5202 1;
equalDOF 5102 5302 1;

# Assign mass;
mass 2104 0.00668325 1.e-10 1.e-10; #kton
mass 2202 0.00668325 1.e-10 1.e-10; #kton
mass 2204 0.00668325 1.e-10 1.e-10; #kton
mass 2302 0.00668325 1.e-10 1.e-10; #kton
mass 3104 0.00663875 1.e-10 1.e-10; #kton
mass 3202 0.00663875 1.e-10 1.e-10; #kton
mass 3204 0.00663875 1.e-10 1.e-10; #kton
mass 3302 0.00663875 1.e-10 1.e-10; #kton
mass 4104 0.00668325 1.e-10 1.e-10; #kton
mass 4202 0.00668325 1.e-10 1.e-10; #kton
mass 4204 0.00668325 1.e-10 1.e-10; #kton
mass 4302 0.00668325 1.e-10 1.e-10; #kton
mass 5104 0.00865825 1.e-10 1.e-10; #kton
mass 5202 0.00865825 1.e-10 1.e-10; #kton
mass 5204 0.00865825 1.e-10 1.e-10; #kton
mass 5302 0.00865825 1.e-10 1.e-10; #kton

# Create recorders;
# Floor Lateral Displacment;
recorder Node -file $Result/DispFloor1Axis1.out  -time  -node 1103  2102  3102  4102  5102  -dof 1 disp;#Left middle of panel zone
# Column Element Forces;
recorder Element -file $Result/Columns_S1.out -time  -ele 113211  123221  133231  143241  153251  163261  globalForce;
recorder Element -file $Result/Columns_S2.out -time  -ele 213311  223321  233331  243341  253351  263361  globalForce;
recorder Element -file $Result/Columns_S3.out -time  -ele 313411  323421  333431  343441  353451  363461  globalForce;
recorder Element -file $Result/Columns_S4.out -time  -ele 413511  423521  433531  443541  453551  463561  globalForce;
# Reaction Forces;
recorder Node -file $Result/ReactionX.out -time  -node 113  123  133  1401  1501  1601  -dof 1 reaction;
# Reaction Forces;
recorder Node -file $Result/ReactionY.out -time  -node 113  123  133  1401  1501  1601  -dof 2 reaction;
# Column Bottom Spring;
recorder Element -file $Result/CBot_F.out -time  -ele  11300  12300  13300  21300  22300  23300  31300  32300  33300  41300  42300  43300  force;
recorder Element -file $Result/CBot_R.out -time  -ele  11300  12300  13300  21300  22300  23300  31300  32300  33300  41300  42300  43300  deformation;
# Column Top Spring;
recorder Element -file $Result/CTop_F.out -time  -ele  21100  22100  23100  31100  32100  33100  41100  42100  43100  51100  52100  53100  force;
recorder Element -file $Result/CTop_R.out -time  -ele  21100  22100  23100  31100  32100  33100  41100  42100  43100  51100  52100  53100  deformation;
# Beam left end Spring;
recorder Element -file $Result/BeamLeft_F.out -time  -ele  21400  31400  41400  51400  22400  32400  42400  52400  force;
recorder Element -file $Result/BeamLeft_R.out -time  -ele  21400  31400  41400  51400  22400  32400  42400  52400  deformation;
# Beam right end Spring;
recorder Element -file $Result/BeamRight_F.out -time  -ele  22200  32200  42200  52200  23200  33200  43200  53200  force;
recorder Element -file $Result/BeamRight_R.out -time  -ele  22200  32200  42200  52200  23200  33200  43200  53200  deformation;
# Panel Spring;
recorder Element -file $Result/Panel_F.out -time  -ele   1002100   1003100   1004100   1005100   1002200   1003200   1004200   1005200   1002300   1003300   1004300   1005300  force;
recorder Element -file $Result/Panel_R.out -time  -ele   1002100   1003100   1004100   1005100   1002200   1003200   1004200   1005200   1002300   1003300   1004300   1005300  deformation;
# Relative Floor Acceleration;
recorder Node -file $Result/AccelFloor1Axis1.out  -time  -node 1103  2104  3104  4104  5104  -dof 1 accel;#At the same point as the mass
#Relative Floor Velocity;
recorder Node -file $Result/VelFloor1Axis1.out  -time  -node 1103  2102  3102  4102  5102  -dof 1 vel;#Left middle of panel zone

# Eigen value analysis;
# Mode Shapes;
file mkdir $Result/modes;
set numModes 4;
recorder Node -file $Result/modes/mode1.out -node 2102  3102  4102  5102  -dof 1 "eigen 1"
recorder Node -file $Result/modes/mode2.out -node 2102  3102  4102  5102  -dof 1 "eigen 2"
recorder Node -file $Result/modes/mode3.out -node 2102  3102  4102  5102  -dof 1 "eigen 3"
recorder Node -file $Result/modes/mode4.out -node 2102  3102  4102  5102  -dof 1 "eigen 4"
set pi [expr 2.0*asin(1.0)];
set nEigen 4;
set lambdaN [eigen [expr $nEigen]];
set lambdaI [lindex $lambdaN 0];
set lambdaJ [lindex $lambdaN 1];
set lambdaK [lindex $lambdaN 2];
set lambdaL [lindex $lambdaN 3];
DisplayModel2D ModeShape 100 522  10  512  384  1;
DisplayModel2D ModeShape 100 1032 10  512  384  2;
DisplayModel2D ModeShape 100 1532 10  512  384  3;
set w1 [expr pow($lambdaI,0.5)];
set w2 [expr pow($lambdaJ,0.5)];
set w3 [expr pow($lambdaK,0.5)];
set w4 [expr pow($lambdaL,0.5)];
set T1 [expr 2.0*$pi/$w1];
set T2 [expr 2.0*$pi/$w2];
set T3 [expr 2.0*$pi/$w3];
set T4 [expr 2.0*$pi/$w4];
puts "";
puts "T1 = [expr {double(round($T1*1000))/1000}] s";
puts "T2 = [expr {double(round($T2*1000))/1000}] s";
puts "T3 = [expr {double(round($T3*1000))/1000}] s";
puts "T4 = [expr {double(round($T4*1000))/1000}] s";
puts "Eigen Analysis Done";

#Store Eigen vector of 1st mode;
set eigenvector2 [nodeEigenvector 2102 1 1];
set eigenvector3 [nodeEigenvector 3102 1 1];
set eigenvector4 [nodeEigenvector 4102 1 1];
set eigenvector5 [nodeEigenvector 5102 1 1];

# Define display;
set xPixels 1200;
set yPixels  800;
set xLoc1     10;
set yLoc1     10;
set dAmp      5;
DisplayModel2D NodeNumbers $dAmp $xLoc1 $yLoc1  $xPixels $yPixels -wipe;
DisplayPlane "DeformedShape" $dAmp XY 0;

# Assign Loads, Analysis Type And Conversion Procedure;
# GRAVITY LOADS;
pattern Plain 100 Linear {
load 211 0. [expr -1.0*65.5627] 0.;
load 221 0. [expr -1.0*131.1254] 0.;
load 231 0. [expr -1.0*65.5627] 0.;
load 311 0. [expr -1.0*65.1261] 0.;
load 321 0. [expr -1.0*130.2523] 0.;
load 331 0. [expr -1.0*65.1261] 0.;
load 411 0. [expr -1.0*65.1261] 0.;
load 421 0. [expr -1.0*130.2523] 0.;
load 431 0. [expr -1.0*65.1261] 0.;
load 511 0. [expr -1.0*84.9374] 0.;
load 521 0. [expr -1.0*169.8749] 0.;
load 531 0. [expr -1.0*84.9374] 0.;
};
# CONVERSION PARAMETERS;
constraints Plain;
numberer RCM;
system BandGeneral;
test NormDispIncr 1.0e-4 500;
algorithm Newton;
integrator LoadControl 0.1;
analysis Static;
analyze 10;
loadConst -time 0.0;
puts "Gravity Done";

# Pushover Analysis;
puts "Running Pushover...";
pattern Plain 1 Linear {
load 2102 $eigenvector2 0.0 0.0;
load 3102 $eigenvector3 0.0 0.0;
load 4102 $eigenvector4 0.0 0.0;
load 5102 $eigenvector5 0.0 0.0;
};


# Displacement Control Parameters;

set CtrlNode 5102;
set CtrlDOF 1;
set Dmax  [expr 0.06*($Floor5)];
set Dincr [expr 0.0001*($Floor5)];

#  analysis commands;

constraints Plain;
numberer RCM;
system SparseSYM;
test NormDispIncr 1.0e-8 5000 0 2;
algorithm KrylovNewton;
integrator DisplacementControl $CtrlNode $CtrlDOF $Dincr;
analysis Static;
set ok 0;
set currentDisp 0.0;

set tStart [clock seconds];

while {$ok == 0 && $currentDisp <= $Dmax}  {
      set ok [analyze 1];
      if {$ok != 0} {
          puts "Different Algorithm";
	     # Change algorithm, Tolerance and smaller displ. step;
          test EnergyIncr 1.0e-5 5000 0 2;
          algorithm KrylovNewton;
          integrator DisplacementControl $CtrlNode $CtrlDOF [expr $Dincr*1];
          set ok [analyze 1];
          # Change them back;
          test NormDispIncr 1.0e-8 5000 0 2;
          algorithm KrylovNewton;
          integrator DisplacementControl $CtrlNode $CtrlDOF  $Dincr;
      };
      if {$ok != 0} {
         set fileID1 [open $Result/ConvergenceState.txt w];   # Create/Open ConvergenceState.txt file (writing permission);
         puts -nonewline $fileID1 1;               # Write value of 1 in case the analysis does not converge;
         close $fileID1;                           # Close ConvergenceState.txt file;
      };
      set currentDisp [nodeDisp $CtrlNode 1];
      puts "Current Roof Drift = [expr {double(round($currentDisp/($Floor5)*10000))/100}] %";

};
puts "Pushover complete";
set tFinish [clock seconds];
puts "Analysis duration: [expr $tFinish - $tStart] s";

wipe;
wipe all;
