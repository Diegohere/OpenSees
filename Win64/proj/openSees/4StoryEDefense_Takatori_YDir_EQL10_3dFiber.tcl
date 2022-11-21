wipe;
wipe all;

model BasicBuilder -ndm 3 -ndf 6;

geomTransf Corotational 1 0 0 -1;
set ColTransfTag 1 

set Source "0_Source";
source $Source/DisplayModel2D.tcl;
source $Source/DisplayPlane.tcl;
source $Source/DynamicAnalysis_V02.tcl;

file mkdir 4StoryEDefense_Takatori_YDir_EQL10_3dFiber_result;
global Result;
set Result "4StoryEDefense_Takatori_YDir_EQL10_3dFiber_result";

set E 205000.00;
set G 78846.15;

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
set            J_Col12_1_b 221779539.00;#Torsion constant

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
set            J_Col12_1_t 221779539.00;#Torsion constant


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
set            J_Col12_2_b 221779539.00;#Torsion constant

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
set            J_Col12_2_t 221779539.00;#Torsion constant


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
set            J_Col12_3_b 221779539.00;#Torsion constant

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
set            J_Col12_3_t 221779539.00;#Torsion constant


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
set            J_Col23_1_b 221779539.00;#Torsion constant

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
set            J_Col23_1_t 221779539.00;#Torsion constant


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
set            J_Col23_2_b 221779539.00;#Torsion constant

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
set            J_Col23_2_t 221779539.00;#Torsion constant


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
set            J_Col23_3_b 221779539.00;#Torsion constant

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
set            J_Col23_3_t 221779539.00;#Torsion constant


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
set            J_Col34_1_b 221779539.00;#Torsion constant

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
set            J_Col34_1_t 221779539.00;#Torsion constant


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
set            J_Col34_2_b 221779539.00;#Torsion constant

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
set            J_Col34_2_t 221779539.00;#Torsion constant


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
set            J_Col34_3_b 221779539.00;#Torsion constant

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
set            J_Col34_3_t 221779539.00;#Torsion constant


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
set            J_Col45_1_b 221779539.00;#Torsion constant

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
set            J_Col45_1_t 221779539.00;#Torsion constant


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
set            J_Col45_2_b 221779539.00;#Torsion constant

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
set            J_Col45_2_t 221779539.00;#Torsion constant


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
set            J_Col45_3_b 221779539.00;#Torsion constant

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
set            J_Col45_3_t 221779539.00;#Torsion constant


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
set             J_Beam12_2 356762.67;#Torsion constant
set   K_mem_canti_Beam12_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam12_2 0.00767;#Yield chord rotation 
set         a_mem_Beam12_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam12_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam12_2 0.40;#Residual moment
set      Mres_mem_Beam12_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam12_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam12_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam12_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_2 81705086178.13;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_2 706549887.08;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_2 0.00865;#Composite Yield chord rotation 
set         a_mem_BeamComp12_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_2 918514853.21;#Composite Capping moment
set   Theta_p_mem_BeamComp12_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_2 211964966.12535;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_2 0.03837;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_2 898755947959.40;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_2 706549887.08;#Composite Yield moment of the spring
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
set             J_Beam23_2 356762.67;#Torsion constant
set   K_mem_canti_Beam23_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam23_2 0.00767;#Yield chord rotation 
set         a_mem_Beam23_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam23_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam23_2 0.40;#Residual moment
set      Mres_mem_Beam23_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam23_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam23_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam23_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_2 81705086178.13;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_2 706549887.08;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_2 0.00865;#Composite Yield chord rotation 
set         a_mem_BeamComp23_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_2 918514853.21;#Composite Capping moment
set   Theta_p_mem_BeamComp23_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_2 211964966.12535;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_2 0.03837;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_2 898755947959.40;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_2 706549887.08;#Composite Yield moment of the spring
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
set             J_Beam12_3 219340.00;#Torsion constant
set   K_mem_canti_Beam12_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam12_3 0.00737;#Yield chord rotation 
set         a_mem_Beam12_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam12_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam12_3 0.40;#Residual moment
set      Mres_mem_Beam12_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam12_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam12_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam12_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_3 71040322061.61;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_3 598462909.44;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_3 0.00842;#Composite Yield chord rotation 
set         a_mem_BeamComp12_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_3 778001782.27;#Composite Capping moment
set   Theta_p_mem_BeamComp12_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_3 179538872.83090;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_3 0.03929;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_3 781443542677.67;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_3 598462909.44;#Composite Yield moment of the spring
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
set             J_Beam23_3 219340.00;#Torsion constant
set   K_mem_canti_Beam23_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam23_3 0.00737;#Yield chord rotation 
set         a_mem_Beam23_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam23_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam23_3 0.40;#Residual moment
set      Mres_mem_Beam23_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam23_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam23_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam23_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_3 71040322061.61;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_3 598462909.44;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_3 0.00842;#Composite Yield chord rotation 
set         a_mem_BeamComp23_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_3 778001782.27;#Composite Capping moment
set   Theta_p_mem_BeamComp23_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_3 179538872.83090;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_3 0.03929;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_3 781443542677.67;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_3 598462909.44;#Composite Yield moment of the spring
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
set             J_Beam12_4 192784.67;#Torsion constant
set   K_mem_canti_Beam12_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam12_4 0.00813;#Yield chord rotation 
set         a_mem_Beam12_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam12_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam12_4 0.40;#Residual moment
set      Mres_mem_Beam12_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam12_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam12_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam12_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_4 50698073632.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_4 484325811.76;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_4 0.00955;#Composite Yield chord rotation 
set         a_mem_BeamComp12_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_4 629623555.29;#Composite Capping moment
set   Theta_p_mem_BeamComp12_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_4 145297743.52869;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_4 0.03621;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_4 557678809956.72;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_4 484325811.76;#Composite Yield moment of the spring
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
set             J_Beam23_4 192784.67;#Torsion constant
set   K_mem_canti_Beam23_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam23_4 0.00813;#Yield chord rotation 
set         a_mem_Beam23_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam23_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam23_4 0.40;#Residual moment
set      Mres_mem_Beam23_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam23_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam23_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam23_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_4 50698073632.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_4 484325811.76;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_4 0.00955;#Composite Yield chord rotation 
set         a_mem_BeamComp23_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_4 629623555.29;#Composite Capping moment
set   Theta_p_mem_BeamComp23_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_4 145297743.52869;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_4 0.03621;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_4 557678809956.72;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_4 484325811.76;#Composite Yield moment of the spring
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
set             J_Beam12_5 108180.00;#Torsion constant
set   K_mem_canti_Beam12_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam12_5 0.00904;#Yield chord rotation 
set         a_mem_Beam12_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam12_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam12_5 0.40;#Residual moment
set      Mres_mem_Beam12_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam12_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam12_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam12_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp12_5 43175532830.51;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp12_5 452025027.16;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp12_5 0.01047;#Composite Yield chord rotation 
set         a_mem_BeamComp12_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp12_5 587632535.31;#Composite Capping moment
set   Theta_p_mem_BeamComp12_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp12_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp12_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp12_5 135607508.14829;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp12_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp12_5 0.04358;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp12_5 474930861135.66;#Composite Initial stiffness of the spring
set          My_s_BeamComp12_5 452025027.16;#Composite Yield moment of the spring
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
set             J_Beam23_5 108180.00;#Torsion constant
set   K_mem_canti_Beam23_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam23_5 0.00904;#Yield chord rotation 
set         a_mem_Beam23_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam23_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam23_5 0.40;#Residual moment
set      Mres_mem_Beam23_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam23_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam23_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam23_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp23_5 43175532830.51;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp23_5 452025027.16;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp23_5 0.01047;#Composite Yield chord rotation 
set         a_mem_BeamComp23_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp23_5 587632535.31;#Composite Capping moment
set   Theta_p_mem_BeamComp23_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp23_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp23_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp23_5 135607508.14829;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp23_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp23_5 0.04358;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp23_5 474930861135.66;#Composite Initial stiffness of the spring
set          My_s_BeamComp23_5 452025027.16;#Composite Yield moment of the spring
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
set         M1_Panel2_1 305539424.18;#Yield moment of the panel
set         M4_Panel2_1 381752628.87;#Ultimate moment of the panel
set         M6_Panel2_1 404067305.91;#3rd moment of the panel
set         M1C_Panel2_1 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel2_1 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel2_1 541366661.80;#Composite 3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-2;
set             KfKe2_2 0.00161;#Kf/Ke
set    Gamma_1_Panel2_2 0.00227;#Yield distorsion angle
set    Gamma_4_Panel2_2 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel2_2 0.01362;#3rd distorsion angle
set         M1_Panel2_2 305539424.18;#Yield moment of the panel
set         M4_Panel2_2 381752628.87;#Ultimate moment of the panel
set         M6_Panel2_2 404067305.91;#3rd moment of the panel
set         M1C_Panel2_2 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel2_2 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel2_2 541366661.80;#Composite 3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-3;
set             KfKe2_3 0.00161;#Kf/Ke
set    Gamma_1_Panel2_3 0.00227;#Yield distorsion angle
set    Gamma_4_Panel2_3 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel2_3 0.01362;#3rd distorsion angle
set         M1_Panel2_3 305539424.18;#Yield moment of the panel
set         M4_Panel2_3 381752628.87;#Ultimate moment of the panel
set         M6_Panel2_3 404067305.91;#3rd moment of the panel
set         M1C_Panel2_3 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel2_3 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel2_3 541366661.80;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-1;
set             KfKe3_1 0.00164;#Kf/Ke
set    Gamma_1_Panel3_1 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_1 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_1 0.01366;#3rd distorsion angle
set         M1_Panel3_1 305802593.37;#Yield moment of the panel
set         M4_Panel3_1 382081442.50;#Ultimate moment of the panel
set         M6_Panel3_1 404415339.77;#3rd moment of the panel
set         M1C_Panel3_1 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel3_1 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel3_1 541496383.51;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-2;
set             KfKe3_2 0.00164;#Kf/Ke
set    Gamma_1_Panel3_2 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_2 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_2 0.01366;#3rd distorsion angle
set         M1_Panel3_2 305802593.37;#Yield moment of the panel
set         M4_Panel3_2 382081442.50;#Ultimate moment of the panel
set         M6_Panel3_2 404415339.77;#3rd moment of the panel
set         M1C_Panel3_2 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel3_2 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel3_2 541496383.51;#Composite 3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-3;
set             KfKe3_3 0.00164;#Kf/Ke
set    Gamma_1_Panel3_3 0.00228;#Yield distorsion angle
set    Gamma_4_Panel3_3 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel3_3 0.01366;#3rd distorsion angle
set         M1_Panel3_3 305802593.37;#Yield moment of the panel
set         M4_Panel3_3 382081442.50;#Ultimate moment of the panel
set         M6_Panel3_3 404415339.77;#3rd moment of the panel
set         M1C_Panel3_3 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel3_3 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel3_3 541496383.51;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-1;
set             KfKe4_1 0.00202;#Kf/Ke
set    Gamma_1_Panel4_1 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_1 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_1 0.01320;#3rd distorsion angle
set         M1_Panel4_1 269265140.65;#Yield moment of the panel
set         M4_Panel4_1 336430153.27;#Ultimate moment of the panel
set         M6_Panel4_1 356095584.89;#3rd moment of the panel
set         M1C_Panel4_1 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel4_1 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel4_1 493176628.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-2;
set             KfKe4_2 0.00202;#Kf/Ke
set    Gamma_1_Panel4_2 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_2 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_2 0.01320;#3rd distorsion angle
set         M1_Panel4_2 269265140.65;#Yield moment of the panel
set         M4_Panel4_2 336430153.27;#Ultimate moment of the panel
set         M6_Panel4_2 356095584.89;#3rd moment of the panel
set         M1C_Panel4_2 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel4_2 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel4_2 493176628.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-3;
set             KfKe4_3 0.00202;#Kf/Ke
set    Gamma_1_Panel4_3 0.00220;#Yield distorsion angle
set    Gamma_4_Panel4_3 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel4_3 0.01320;#3rd distorsion angle
set         M1_Panel4_3 269265140.65;#Yield moment of the panel
set         M4_Panel4_3 336430153.27;#Ultimate moment of the panel
set         M6_Panel4_3 356095584.89;#3rd moment of the panel
set         M1C_Panel4_3 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel4_3 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel4_3 493176628.63;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-1;
set             KfKe5_1 0.00206;#Kf/Ke
set    Gamma_1_Panel5_1 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_1 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_1 0.01316;#3rd distorsion angle
set         M1_Panel5_1 267676555.75;#Yield moment of the panel
set         M4_Panel5_1 334445314.60;#Ultimate moment of the panel
set         M6_Panel5_1 353994725.98;#3rd moment of the panel
set         M1C_Panel5_1 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel5_1 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel5_1 490025340.27;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-2;
set             KfKe5_2 0.00206;#Kf/Ke
set    Gamma_1_Panel5_2 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_2 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_2 0.01316;#3rd distorsion angle
set         M1_Panel5_2 267676555.75;#Yield moment of the panel
set         M4_Panel5_2 334445314.60;#Ultimate moment of the panel
set         M6_Panel5_2 353994725.98;#3rd moment of the panel
set         M1C_Panel5_2 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel5_2 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel5_2 490025340.27;#Composite 3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-3;
set             KfKe5_3 0.00206;#Kf/Ke
set    Gamma_1_Panel5_3 0.00219;#Yield distorsion angle
set    Gamma_4_Panel5_3 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel5_3 0.01316;#3rd distorsion angle
set         M1_Panel5_3 267676555.75;#Yield moment of the panel
set         M4_Panel5_3 334445314.60;#Ultimate moment of the panel
set         M6_Panel5_3 353994725.98;#3rd moment of the panel
set         M1C_Panel5_3 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel5_3 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel5_3 490025340.27;#Composite 3rd moment of the panel

# Floor 1 MRF Column Bases;
node 1103 [expr $Axis1] [expr $Floor1] 0.0 ;
fix  1103 1 1 1 1 1 1;

node 1203 [expr $Axis2] [expr $Floor1] 0.0 ;
fix  1203 1 1 1 1 1 1;

node 1303 [expr $Axis3] [expr $Floor1] 0.0 ;
fix  1303 1 1 1 1 1 1;

# Floor 2~ MRF Beam-Column;
# AXIS-1, FLOOR-2;
node 2101  [expr $Axis1                               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom middle ;
node 2105  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom left ;
node 2106  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom left ;
node 2112  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom right ;
node 2111  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom right;
node 2102  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2               ] 0.0 ;# middle left  ;
node 2104  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2               ] 0.0 ;# middle right ;
node 2107  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top left  ;
node 2108  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top left;
node 2109  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top right;
node 2110  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top right;
node 2103  [expr $Axis1                               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top middle;
# Constrains for out of plane movement in 3D;
fix 2101  0 0 1 1 1 0;
fix 2105  0 0 1 1 1 0;
fix 2106  0 0 1 1 1 0;
fix 2112  0 0 1 1 1 0;
fix 2111  0 0 1 1 1 0;
fix 2102  0 0 1 1 1 0;
fix 2104  0 0 1 1 1 0;
fix 2107  0 0 1 1 1 0;
fix 2108  0 0 1 1 1 0;
fix 2109  0 0 1 1 1 0;
fix 2110  0 0 1 1 1 0;
fix 2103  0 0 1 1 1 0;
node 214   [expr $Axis1+$d_Col12_1_t/2.+$H_offset               ] [expr $Floor2               ] 0.0 ;# WUF-Wright;
node 21040   [expr $Axis1+$d_Col12_1_t/2.+$H_offset               ] [expr $Floor2               ] 0.0 ;# middle WUF-Wright;
fix 214   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 21040 0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-1, FLOOR-3;
node 3101  [expr $Axis1                               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom middle ;
node 3105  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom left ;
node 3106  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom left ;
node 3112  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom right ;
node 3111  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom right;
node 3102  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3               ] 0.0 ;# middle left  ;
node 3104  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3               ] 0.0 ;# middle right ;
node 3107  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top left  ;
node 3108  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top left;
node 3109  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top right;
node 3110  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top right;
node 3103  [expr $Axis1                               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top middle;
# Constrains for out of plane movement in 3D;
fix 3101  0 0 1 1 1 0;
fix 3105  0 0 1 1 1 0;
fix 3106  0 0 1 1 1 0;
fix 3112  0 0 1 1 1 0;
fix 3111  0 0 1 1 1 0;
fix 3102  0 0 1 1 1 0;
fix 3104  0 0 1 1 1 0;
fix 3107  0 0 1 1 1 0;
fix 3108  0 0 1 1 1 0;
fix 3109  0 0 1 1 1 0;
fix 3110  0 0 1 1 1 0;
fix 3103  0 0 1 1 1 0;
node 314   [expr $Axis1+$d_Col23_1_t/2.+$H_offset               ] [expr $Floor3               ] 0.0 ;# WUF-Wright;
node 31040   [expr $Axis1+$d_Col23_1_t/2.+$H_offset               ] [expr $Floor3               ] 0.0 ;# middle WUF-Wright;
fix 314   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 31040 0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-1, FLOOR-4;
node 4101  [expr $Axis1                               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom middle ;
node 4105  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom left ;
node 4106  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom left ;
node 4112  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom right ;
node 4111  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom right;
node 4102  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4               ] 0.0 ;# middle left  ;
node 4104  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4               ] 0.0 ;# middle right ;
node 4107  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top left  ;
node 4108  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top left;
node 4109  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top right;
node 4110  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top right;
node 4103  [expr $Axis1                               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top middle;
# Constrains for out of plane movement in 3D;
fix 4101  0 0 1 1 1 0;
fix 4105  0 0 1 1 1 0;
fix 4106  0 0 1 1 1 0;
fix 4112  0 0 1 1 1 0;
fix 4111  0 0 1 1 1 0;
fix 4102  0 0 1 1 1 0;
fix 4104  0 0 1 1 1 0;
fix 4107  0 0 1 1 1 0;
fix 4108  0 0 1 1 1 0;
fix 4109  0 0 1 1 1 0;
fix 4110  0 0 1 1 1 0;
fix 4103  0 0 1 1 1 0;
node 414   [expr $Axis1+$d_Col34_1_t/2.+$H_offset               ] [expr $Floor4               ] 0.0 ;# WUF-Wright;
node 41040   [expr $Axis1+$d_Col34_1_t/2.+$H_offset               ] [expr $Floor4               ] 0.0 ;# middle WUF-Wright;
fix 414   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 41040 0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-1, FLOOR-5;
node 5101  [expr $Axis1                               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom middle ;
node 5105  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom left ;
node 5106  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom left ;
node 5112  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom right ;
node 5111  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom right;
node 5102  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5               ] 0.0 ;# middle left  ;
node 5104  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5               ] 0.0 ;# middle right ;
node 5107  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top left  ;
node 5108  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top left;
node 5109  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top right;
node 5110  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top right;
node 5103  [expr $Axis1                               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top middle;
# Constrains for out of plane movement in 3D;
fix 5101  0 0 1 1 1 0;
fix 5105  0 0 1 1 1 0;
fix 5106  0 0 1 1 1 0;
fix 5112  0 0 1 1 1 0;
fix 5111  0 0 1 1 1 0;
fix 5102  0 0 1 1 1 0;
fix 5104  0 0 1 1 1 0;
fix 5107  0 0 1 1 1 0;
fix 5108  0 0 1 1 1 0;
fix 5109  0 0 1 1 1 0;
fix 5110  0 0 1 1 1 0;
fix 5103  0 0 1 1 1 0;
node 514   [expr $Axis1+$d_Col45_1_t/2.+$H_offset               ] [expr $Floor5               ] 0.0 ;# WUF-Wright;
node 51040   [expr $Axis1+$d_Col45_1_t/2.+$H_offset               ] [expr $Floor5               ] 0.0 ;# middle WUF-Wright;
fix 514   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 51040 0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-2, FLOOR-2;
node 2201  [expr $Axis2                               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom middle  ;
node 2205  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom left    ;
node 2206  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom left    ;
node 2212  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom right   ;
node 2211  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0.0 ;# bottom right   ;
node 2202  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2               ] 0.0 ;# middle left    ;
node 2204  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2               ] 0.0 ;# middle right   ;
node 2207  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top left       ;
node 2208  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top left       ;
node 2209  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top right      ;
node 2210  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top right      ;
node 2203  [expr $Axis2                               ] [expr $Floor2+$d_Beam12_2/2.] 0.0 ;# top middle     ;
fix 2201  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 2205  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2206  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2212  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2211  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2202  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2204  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2207  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2208  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2209  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2210  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2203  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 222   [expr $Axis2-$d_Col12_2_t/2.-$H_offset               ] [expr $Floor2               ] 0.0 ;# WUF-Wleft ;
node 22020   [expr $Axis2-$d_Col12_2_t/2.-$H_offset               ] [expr $Floor2               ] 0.0 ;# middle WUF-Wleft ;
fix 222   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 22020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
node 224   [expr $Axis2+$d_Col12_2_t/2.+$H_offset               ] [expr $Floor2               ] 0.0 ;# WUF-Wright;
node 22040   [expr $Axis2+$d_Col12_2_t/2.+$H_offset               ] [expr $Floor2               ] 0.0 ;# middle WUF-Wright;
fix 224   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 22040   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-2, FLOOR-3;
node 3201  [expr $Axis2                               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom middle  ;
node 3205  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom left    ;
node 3206  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom left    ;
node 3212  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom right   ;
node 3211  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0.0 ;# bottom right   ;
node 3202  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3               ] 0.0 ;# middle left    ;
node 3204  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3               ] 0.0 ;# middle right   ;
node 3207  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top left       ;
node 3208  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top left       ;
node 3209  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top right      ;
node 3210  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top right      ;
node 3203  [expr $Axis2                               ] [expr $Floor3+$d_Beam12_3/2.] 0.0 ;# top middle     ;
fix 3201  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 3205  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3206  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3212  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3211  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3202  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3204  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3207  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3208  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3209  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3210  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3203  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 322   [expr $Axis2-$d_Col23_2_t/2.-$H_offset               ] [expr $Floor3               ] 0.0 ;# WUF-Wleft ;
node 32020   [expr $Axis2-$d_Col23_2_t/2.-$H_offset               ] [expr $Floor3               ] 0.0 ;# middle WUF-Wleft ;
fix 322   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 32020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
node 324   [expr $Axis2+$d_Col23_2_t/2.+$H_offset               ] [expr $Floor3               ] 0.0 ;# WUF-Wright;
node 32040   [expr $Axis2+$d_Col23_2_t/2.+$H_offset               ] [expr $Floor3               ] 0.0 ;# middle WUF-Wright;
fix 324   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 32040   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-2, FLOOR-4;
node 4201  [expr $Axis2                               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom middle  ;
node 4205  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom left    ;
node 4206  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom left    ;
node 4212  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom right   ;
node 4211  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0.0 ;# bottom right   ;
node 4202  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4               ] 0.0 ;# middle left    ;
node 4204  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4               ] 0.0 ;# middle right   ;
node 4207  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top left       ;
node 4208  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top left       ;
node 4209  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top right      ;
node 4210  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top right      ;
node 4203  [expr $Axis2                               ] [expr $Floor4+$d_Beam12_4/2.] 0.0 ;# top middle     ;
fix 4201  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 4205  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4206  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4212  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4211  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4202  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4204  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4207  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4208  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4209  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4210  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4203  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 422   [expr $Axis2-$d_Col34_2_t/2.-$H_offset               ] [expr $Floor4               ] 0.0 ;# WUF-Wleft ;
node 42020   [expr $Axis2-$d_Col34_2_t/2.-$H_offset               ] [expr $Floor4               ] 0.0 ;# middle WUF-Wleft ;
fix 422   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 42020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
node 424   [expr $Axis2+$d_Col34_2_t/2.+$H_offset               ] [expr $Floor4               ] 0.0 ;# WUF-Wright;
node 42040   [expr $Axis2+$d_Col34_2_t/2.+$H_offset               ] [expr $Floor4               ] 0.0 ;# middle WUF-Wright;
fix 424   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 42040   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-2, FLOOR-5;
node 5201  [expr $Axis2                               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom middle  ;
node 5205  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom left    ;
node 5206  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom left    ;
node 5212  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom right   ;
node 5211  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0.0 ;# bottom right   ;
node 5202  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5               ] 0.0 ;# middle left    ;
node 5204  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5               ] 0.0 ;# middle right   ;
node 5207  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top left       ;
node 5208  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top left       ;
node 5209  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top right      ;
node 5210  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top right      ;
node 5203  [expr $Axis2                               ] [expr $Floor5+$d_Beam12_5/2.] 0.0 ;# top middle     ;
fix 5201  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 5205  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5206  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5212  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5211  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5202  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5204  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5207  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5208  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5209  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5210  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5203  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 522   [expr $Axis2-$d_Col45_2_t/2.-$H_offset               ] [expr $Floor5               ] 0.0 ;# WUF-Wleft ;
node 52020   [expr $Axis2-$d_Col45_2_t/2.-$H_offset               ] [expr $Floor5               ] 0.0 ;# middle WUF-Wleft ;
fix 522   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 52020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
node 524   [expr $Axis2+$d_Col45_2_t/2.+$H_offset               ] [expr $Floor5               ] 0.0 ;# WUF-Wright;
node 52040   [expr $Axis2+$d_Col45_2_t/2.+$H_offset               ] [expr $Floor5               ] 0.0 ;# middle WUF-Wright;
fix 524   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 52040   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# AXIS-3, FLOOR-2;
node 2301  [expr $Axis3                               ] [expr $Floor2-$d_Beam23_2/2.] 0.0 ;# bottom middle  ;
node 2305  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.] 0.0 ;# bottom left    ;
node 2306  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.] 0.0 ;# bottom left    ;
node 2312  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.] 0.0 ;# bottom right   ;
node 2311  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.] 0.0 ;# bottom right   ;
node 2302  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2               ] 0.0 ;# middle left    ;
node 2304  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2               ] 0.0 ;# middle right   ;
node 2307  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.] 0.0 ;# top left       ;
node 2308  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.] 0.0 ;# top left       ;
node 2309  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.] 0.0 ;# top right      ;
node 2310  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.] 0.0 ;# top right      ;
node 2303  [expr $Axis3                               ] [expr $Floor2+$d_Beam23_2/2.] 0.0 ;# top middle     ;
fix 2301  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 2305  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2306  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2312  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2311  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2302  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2304  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2307  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2308  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2309  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2310  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2303  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 232   [expr $Axis3-$d_Col12_3_t/2.-$H_offset               ] [expr $Floor2               ] 0.0 ;# WUF-Wleft ;
node 23020   [expr $Axis3-$d_Col12_3_t/2.-$H_offset               ] [expr $Floor2               ] 0.0 ;# middle WUF-Wleft ;
fix 232   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 23020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;

# AXIS-3, FLOOR-3;
node 3301  [expr $Axis3                               ] [expr $Floor3-$d_Beam23_3/2.] 0.0 ;# bottom middle  ;
node 3305  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.] 0.0 ;# bottom left    ;
node 3306  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.] 0.0 ;# bottom left    ;
node 3312  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.] 0.0 ;# bottom right   ;
node 3311  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.] 0.0 ;# bottom right   ;
node 3302  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3               ] 0.0 ;# middle left    ;
node 3304  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3               ] 0.0 ;# middle right   ;
node 3307  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.] 0.0 ;# top left       ;
node 3308  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.] 0.0 ;# top left       ;
node 3309  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.] 0.0 ;# top right      ;
node 3310  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.] 0.0 ;# top right      ;
node 3303  [expr $Axis3                               ] [expr $Floor3+$d_Beam23_3/2.] 0.0 ;# top middle     ;
fix 3301  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 3305  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3306  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3312  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3311  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3302  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3304  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3307  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3308  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3309  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3310  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3303  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 332   [expr $Axis3-$d_Col23_3_t/2.-$H_offset               ] [expr $Floor3               ] 0.0 ;# WUF-Wleft ;
node 33020   [expr $Axis3-$d_Col23_3_t/2.-$H_offset               ] [expr $Floor3               ] 0.0 ;# middle WUF-Wleft ;
fix 332   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 33020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;

# AXIS-3, FLOOR-4;
node 4301  [expr $Axis3                               ] [expr $Floor4-$d_Beam23_4/2.] 0.0 ;# bottom middle  ;
node 4305  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.] 0.0 ;# bottom left    ;
node 4306  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.] 0.0 ;# bottom left    ;
node 4312  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.] 0.0 ;# bottom right   ;
node 4311  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.] 0.0 ;# bottom right   ;
node 4302  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4               ] 0.0 ;# middle left    ;
node 4304  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4               ] 0.0 ;# middle right   ;
node 4307  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.] 0.0 ;# top left       ;
node 4308  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.] 0.0 ;# top left       ;
node 4309  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.] 0.0 ;# top right      ;
node 4310  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.] 0.0 ;# top right      ;
node 4303  [expr $Axis3                               ] [expr $Floor4+$d_Beam23_4/2.] 0.0 ;# top middle     ;
fix 4301  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 4305  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4306  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4312  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4311  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4302  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4304  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4307  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4308  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4309  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4310  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4303  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 432   [expr $Axis3-$d_Col34_3_t/2.-$H_offset               ] [expr $Floor4               ] 0.0 ;# WUF-Wleft ;
node 43020   [expr $Axis3-$d_Col34_3_t/2.-$H_offset               ] [expr $Floor4               ] 0.0 ;# middle WUF-Wleft ;
fix 432   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 43020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;

# AXIS-3, FLOOR-5;
node 5301  [expr $Axis3                               ] [expr $Floor5-$d_Beam23_5/2.] 0.0 ;# bottom middle  ;
node 5305  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.] 0.0 ;# bottom left    ;
node 5306  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.] 0.0 ;# bottom left    ;
node 5312  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.] 0.0 ;# bottom right   ;
node 5311  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.] 0.0 ;# bottom right   ;
node 5302  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5               ] 0.0 ;# middle left    ;
node 5304  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5               ] 0.0 ;# middle right   ;
node 5307  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.] 0.0 ;# top left       ;
node 5308  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.] 0.0 ;# top left       ;
node 5309  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.] 0.0 ;# top right      ;
node 5310  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.] 0.0 ;# top right      ;
node 5303  [expr $Axis3                               ] [expr $Floor5+$d_Beam23_5/2.] 0.0 ;# top middle     ;
fix 5301  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 5305  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5306  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5312  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5311  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5302  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5304  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5307  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5308  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5309  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5310  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5303  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 532   [expr $Axis3-$d_Col45_3_t/2.-$H_offset               ] [expr $Floor5               ] 0.0 ;# WUF-Wleft ;
node 53020   [expr $Axis3-$d_Col45_3_t/2.-$H_offset               ] [expr $Floor5               ] 0.0 ;# middle WUF-Wleft ;
fix 532   0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;
fix 53020 0 0 1 1 1 0;# Constrains for out of plane movement in 3D ;


uniaxialMaterial Elastic 555 [expr 10009999.*$E];
uniaxialMaterial Elastic 556 [expr 10009999.*$E*1000.];
uniaxialMaterial Elastic 666 [expr 0.0001];
set A_pz_rigid 10547290000.0000;
set I_pz_rigid 31220642685.9510;

# FloorAxis = 21;
# Panel Rigid Link;
element elasticBeamColumn 1002101 2105 2101 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002108 2101 2112 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002107 2111 2104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002106 2104 2110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002105 2109 2103 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002104 2103 2108 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002103 2107 2102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002102 2106 2102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 2105 2106 1 2;
equalDOF 2112 2111 1 2;
equalDOF 2110 2109 1 2;
equalDOF 2107 2108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002100 $M1C_Panel2_1 $Gamma_1_Panel2_1 $M4C_Panel2_1 $Gamma_4_Panel2_1 $M6C_Panel2_1 $Gamma_6_Panel2_1 -$M1_Panel2_1 -$Gamma_1_Panel2_1 -$M4_Panel2_1 -$Gamma_4_Panel2_1 -$M6_Panel2_1 -$Gamma_6_Panel2_1 0.25 0.75 0 0 0;
element zeroLength          1002100  2109 2110 -mat 1002100 -dir 6;
# Panel to hinge;
# Right side;
element elasticBeamColumn  5002104 21040 2104 $A_Beam12_2 $E $G [expr 1.3310*$J_Beam12_2] [expr 1.3310*$Iy_Beam12_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam12_2] 1;

# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 21400 $K_s_Beam12_2 $Alpha_s_Beam12_2 $Alpha_s_BeamComp12_2 $My_s_Beam12_2 -$My_s_BeamComp12_2  $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 1. 1. 1. 1.  $Theta_p_s_Beam12_2  $Theta_p_s_BeamComp12_2  $Theta_pc_s_Beam12_2  $Theta_pc_s_BeamComp12_2  $Res_s_Beam12_2  $Res_s_BeamComp12_2  $Theta_ult_s_Beam12_2  $Theta_ult_s_BeamComp12_2  1. 1.15;
element     zeroLength 21400 214 21040 -mat 21400 -dir 6;
equalDOF                     214 21040 1 2;

# FloorAxis = 31;
# Panel Rigid Link;
element elasticBeamColumn 1003101 3105 3101 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003108 3101 3112 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003107 3111 3104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003106 3104 3110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003105 3109 3103 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003104 3103 3108 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003103 3107 3102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003102 3106 3102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 3105 3106 1 2;
equalDOF 3112 3111 1 2;
equalDOF 3110 3109 1 2;
equalDOF 3107 3108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003100 $M1C_Panel3_1 $Gamma_1_Panel3_1 $M4C_Panel3_1 $Gamma_4_Panel3_1 $M6C_Panel3_1 $Gamma_6_Panel3_1 -$M1_Panel3_1 -$Gamma_1_Panel3_1 -$M4_Panel3_1 -$Gamma_4_Panel3_1 -$M6_Panel3_1 -$Gamma_6_Panel3_1 0.25 0.75 0 0 0;
element zeroLength          1003100  3109 3110 -mat 1003100 -dir 6;
# Panel to hinge;
# Right side;
element elasticBeamColumn  5003104 31040 3104 $A_Beam12_3 $E $G [expr 1.3730*$J_Beam12_3] [expr 1.3730*$Iy_Beam12_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam12_3] 1;

# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 31400 $K_s_Beam12_3 $Alpha_s_Beam12_3 $Alpha_s_BeamComp12_3 $My_s_Beam12_3 -$My_s_BeamComp12_3  $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 1. 1. 1. 1.  $Theta_p_s_Beam12_3  $Theta_p_s_BeamComp12_3  $Theta_pc_s_Beam12_3  $Theta_pc_s_BeamComp12_3  $Res_s_Beam12_3  $Res_s_BeamComp12_3  $Theta_ult_s_Beam12_3  $Theta_ult_s_BeamComp12_3  1. 1.15;
element     zeroLength 31400 314 31040 -mat 31400 -dir 6;
equalDOF                     314 31040 1 2;

# FloorAxis = 41;
# Panel Rigid Link;
element elasticBeamColumn 1004101 4105 4101 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004108 4101 4112 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004107 4111 4104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004106 4104 4110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004105 4109 4103 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004104 4103 4108 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004103 4107 4102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004102 4106 4102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 4105 4106 1 2;
equalDOF 4112 4111 1 2;
equalDOF 4110 4109 1 2;
equalDOF 4107 4108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004100 $M1C_Panel4_1 $Gamma_1_Panel4_1 $M4C_Panel4_1 $Gamma_4_Panel4_1 $M6C_Panel4_1 $Gamma_6_Panel4_1 -$M1_Panel4_1 -$Gamma_1_Panel4_1 -$M4_Panel4_1 -$Gamma_4_Panel4_1 -$M6_Panel4_1 -$Gamma_6_Panel4_1 0.25 0.75 0 0 0;
element zeroLength          1004100  4109 4110 -mat 1004100 -dir 6;
# Panel to hinge;
# Right side;
element elasticBeamColumn  5004104 41040 4104 $A_Beam12_4 $E $G [expr 1.4350*$J_Beam12_4] [expr 1.4350*$Iy_Beam12_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam12_4] 1;

# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 41400 $K_s_Beam12_4 $Alpha_s_Beam12_4 $Alpha_s_BeamComp12_4 $My_s_Beam12_4 -$My_s_BeamComp12_4  $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 1. 1. 1. 1.  $Theta_p_s_Beam12_4  $Theta_p_s_BeamComp12_4  $Theta_pc_s_Beam12_4  $Theta_pc_s_BeamComp12_4  $Res_s_Beam12_4  $Res_s_BeamComp12_4  $Theta_ult_s_Beam12_4  $Theta_ult_s_BeamComp12_4  1. 1.15;
element     zeroLength 41400 414 41040 -mat 41400 -dir 6;
equalDOF                     414 41040 1 2;

# FloorAxis = 51;
# Panel Rigid Link;
element elasticBeamColumn 1005101 5105 5101 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005108 5101 5112 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005107 5111 5104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005106 5104 5110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005105 5109 5103 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005104 5103 5108 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005103 5107 5102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005102 5106 5102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 5105 5106 1 2;
equalDOF 5112 5111 1 2;
equalDOF 5110 5109 1 2;
equalDOF 5107 5108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005100 $M1C_Panel5_1 $Gamma_1_Panel5_1 $M4C_Panel5_1 $Gamma_4_Panel5_1 $M6C_Panel5_1 $Gamma_6_Panel5_1 -$M1_Panel5_1 -$Gamma_1_Panel5_1 -$M4_Panel5_1 -$Gamma_4_Panel5_1 -$M6_Panel5_1 -$Gamma_6_Panel5_1 0.25 0.75 0 0 0;
element zeroLength          1005100  5109 5110 -mat 1005100 -dir 6;
# Panel to hinge;
# Right side;
element elasticBeamColumn  5005104 51040 5104 $A_Beam12_5 $E $G [expr 1.4950*$J_Beam12_5] [expr 1.4950*$Iy_Beam12_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam12_5] 1;

# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 51400 $K_s_Beam12_5 $Alpha_s_Beam12_5 $Alpha_s_BeamComp12_5 $My_s_Beam12_5 -$My_s_BeamComp12_5  $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 1. 1. 1. 1.  $Theta_p_s_Beam12_5  $Theta_p_s_BeamComp12_5  $Theta_pc_s_Beam12_5  $Theta_pc_s_BeamComp12_5  $Res_s_Beam12_5  $Res_s_BeamComp12_5  $Theta_ult_s_Beam12_5  $Theta_ult_s_BeamComp12_5  1. 1.15;
element     zeroLength 51400 514 51040 -mat 51400 -dir 6;
equalDOF                     514 51040 1 2;

# FloorAxis = 22;
# Panel Rigid Link;
element elasticBeamColumn 1002201 2205 2201 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002208 2201 2212 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002207 2211 2204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002206 2204 2210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002205 2209 2203 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002204 2203 2208 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002203 2207 2202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002202 2206 2202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 2205 2206 1 2;
equalDOF 2212 2211 1 2;
equalDOF 2210 2209 1 2;
equalDOF 2207 2208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002200 $M1C_Panel2_2 $Gamma_1_Panel2_2 $M4C_Panel2_2 $Gamma_4_Panel2_2 $M6C_Panel2_2 $Gamma_6_Panel2_2 -$M1C_Panel2_2 -$Gamma_1_Panel2_2 -$M4C_Panel2_2 -$Gamma_4_Panel2_2 -$M6C_Panel2_2 -$Gamma_6_Panel2_2 0.25 0.75 0 0 0;
element zeroLength          1002200  2209 2210 -mat 1002200 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5002202 22020 2202 $A_Beam12_2 $E $G [expr 1.3310*$J_Beam12_2] [expr 1.3310*$Iy_Beam12_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam12_2] 1;
# Right side;
element elasticBeamColumn  5002204 22040 2204 $A_Beam23_2 $E $G [expr 1.3310*$J_Beam23_2] [expr 1.3310*$Iy_Beam23_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam23_2] 1;

# IMK Hinges;
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
element elasticBeamColumn 1003201 3205 3201 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003208 3201 3212 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003207 3211 3204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003206 3204 3210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003205 3209 3203 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003204 3203 3208 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003203 3207 3202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003202 3206 3202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 3205 3206 1 2;
equalDOF 3212 3211 1 2;
equalDOF 3210 3209 1 2;
equalDOF 3207 3208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003200 $M1C_Panel3_2 $Gamma_1_Panel3_2 $M4C_Panel3_2 $Gamma_4_Panel3_2 $M6C_Panel3_2 $Gamma_6_Panel3_2 -$M1C_Panel3_2 -$Gamma_1_Panel3_2 -$M4C_Panel3_2 -$Gamma_4_Panel3_2 -$M6C_Panel3_2 -$Gamma_6_Panel3_2 0.25 0.75 0 0 0;
element zeroLength          1003200  3209 3210 -mat 1003200 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5003202 32020 3202 $A_Beam12_3 $E $G [expr 1.3730*$J_Beam12_3] [expr 1.3730*$Iy_Beam12_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam12_3] 1;
# Right side;
element elasticBeamColumn  5003204 32040 3204 $A_Beam23_3 $E $G [expr 1.3730*$J_Beam23_3] [expr 1.3730*$Iy_Beam23_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam23_3] 1;

# IMK Hinges;
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
element elasticBeamColumn 1004201 4205 4201 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004208 4201 4212 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004207 4211 4204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004206 4204 4210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004205 4209 4203 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004204 4203 4208 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004203 4207 4202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004202 4206 4202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 4205 4206 1 2;
equalDOF 4212 4211 1 2;
equalDOF 4210 4209 1 2;
equalDOF 4207 4208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004200 $M1C_Panel4_2 $Gamma_1_Panel4_2 $M4C_Panel4_2 $Gamma_4_Panel4_2 $M6C_Panel4_2 $Gamma_6_Panel4_2 -$M1C_Panel4_2 -$Gamma_1_Panel4_2 -$M4C_Panel4_2 -$Gamma_4_Panel4_2 -$M6C_Panel4_2 -$Gamma_6_Panel4_2 0.25 0.75 0 0 0;
element zeroLength          1004200  4209 4210 -mat 1004200 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5004202 42020 4202 $A_Beam12_4 $E $G [expr 1.4350*$J_Beam12_4] [expr 1.4350*$Iy_Beam12_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam12_4] 1;
# Right side;
element elasticBeamColumn  5004204 42040 4204 $A_Beam23_4 $E $G [expr 1.4350*$J_Beam23_4] [expr 1.4350*$Iy_Beam23_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam23_4] 1;

# IMK Hinges;
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
element elasticBeamColumn 1005201 5205 5201 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005208 5201 5212 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005207 5211 5204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005206 5204 5210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005205 5209 5203 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005204 5203 5208 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005203 5207 5202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005202 5206 5202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 5205 5206 1 2;
equalDOF 5212 5211 1 2;
equalDOF 5210 5209 1 2;
equalDOF 5207 5208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005200 $M1C_Panel5_2 $Gamma_1_Panel5_2 $M4C_Panel5_2 $Gamma_4_Panel5_2 $M6C_Panel5_2 $Gamma_6_Panel5_2 -$M1C_Panel5_2 -$Gamma_1_Panel5_2 -$M4C_Panel5_2 -$Gamma_4_Panel5_2 -$M6C_Panel5_2 -$Gamma_6_Panel5_2 0.25 0.75 0 0 0;
element zeroLength          1005200  5209 5210 -mat 1005200 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5005202 52020 5202 $A_Beam12_5 $E $G [expr 1.4950*$J_Beam12_5] [expr 1.4950*$Iy_Beam12_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam12_5] 1;
# Right side;
element elasticBeamColumn  5005204 52040 5204 $A_Beam23_5 $E $G [expr 1.4950*$J_Beam23_5] [expr 1.4950*$Iy_Beam23_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam23_5] 1;

# IMK Hinges;
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
element elasticBeamColumn 1002301 2305 2301 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002308 2301 2312 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002307 2311 2304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002306 2304 2310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002305 2309 2303 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002304 2303 2308 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002303 2307 2302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1002302 2306 2302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 2305 2306 1 2;
equalDOF 2312 2311 1 2;
equalDOF 2310 2309 1 2;
equalDOF 2307 2308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002300 $M1_Panel2_3 $Gamma_1_Panel2_3 $M4_Panel2_3 $Gamma_4_Panel2_3 $M6_Panel2_3 $Gamma_6_Panel2_3 -$M1C_Panel2_3 -$Gamma_1_Panel2_3 -$M4C_Panel2_3 -$Gamma_4_Panel2_3 -$M6C_Panel2_3 -$Gamma_6_Panel2_3 0.25 0.75 0 0 0;
element zeroLength          1002300  2309 2310 -mat 1002300 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5002302 23020 2302 $A_Beam23_2 $E $G [expr 1.3310*$J_Beam23_2] [expr 1.3310*$Iy_Beam23_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam23_2] 1;

# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 23200 $K_s_Beam23_2 $Alpha_s_BeamComp23_2 $Alpha_s_Beam23_2 $My_s_BeamComp23_2 -$My_s_Beam23_2  $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 1. 1. 1. 1.  $Theta_p_s_BeamComp23_2  $Theta_p_s_Beam23_2  $Theta_pc_s_BeamComp23_2  $Theta_pc_s_Beam23_2  $Res_s_BeamComp23_2  $Res_s_Beam23_2  $Theta_ult_s_BeamComp23_2  $Theta_ult_s_Beam23_2  1.15 1.;
element     zeroLength 23200 232 23020 -mat 23200 -dir 6;
equalDOF                     232 23020 1 2;

# FloorAxis = 33;
# Panel Rigid Link;
element elasticBeamColumn 1003301 3305 3301 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003308 3301 3312 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003307 3311 3304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003306 3304 3310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003305 3309 3303 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003304 3303 3308 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003303 3307 3302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1003302 3306 3302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 3305 3306 1 2;
equalDOF 3312 3311 1 2;
equalDOF 3310 3309 1 2;
equalDOF 3307 3308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003300 $M1_Panel3_3 $Gamma_1_Panel3_3 $M4_Panel3_3 $Gamma_4_Panel3_3 $M6_Panel3_3 $Gamma_6_Panel3_3 -$M1C_Panel3_3 -$Gamma_1_Panel3_3 -$M4C_Panel3_3 -$Gamma_4_Panel3_3 -$M6C_Panel3_3 -$Gamma_6_Panel3_3 0.25 0.75 0 0 0;
element zeroLength          1003300  3309 3310 -mat 1003300 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5003302 33020 3302 $A_Beam23_3 $E $G [expr 1.3730*$J_Beam23_3] [expr 1.3730*$Iy_Beam23_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam23_3] 1;

# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 33200 $K_s_Beam23_3 $Alpha_s_BeamComp23_3 $Alpha_s_Beam23_3 $My_s_BeamComp23_3 -$My_s_Beam23_3  $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 1. 1. 1. 1.  $Theta_p_s_BeamComp23_3  $Theta_p_s_Beam23_3  $Theta_pc_s_BeamComp23_3  $Theta_pc_s_Beam23_3  $Res_s_BeamComp23_3  $Res_s_Beam23_3  $Theta_ult_s_BeamComp23_3  $Theta_ult_s_Beam23_3  1.15 1.;
element     zeroLength 33200 332 33020 -mat 33200 -dir 6;
equalDOF                     332 33020 1 2;

# FloorAxis = 43;
# Panel Rigid Link;
element elasticBeamColumn 1004301 4305 4301 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004308 4301 4312 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004307 4311 4304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004306 4304 4310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004305 4309 4303 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004304 4303 4308 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004303 4307 4302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1004302 4306 4302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 4305 4306 1 2;
equalDOF 4312 4311 1 2;
equalDOF 4310 4309 1 2;
equalDOF 4307 4308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004300 $M1_Panel4_3 $Gamma_1_Panel4_3 $M4_Panel4_3 $Gamma_4_Panel4_3 $M6_Panel4_3 $Gamma_6_Panel4_3 -$M1C_Panel4_3 -$Gamma_1_Panel4_3 -$M4C_Panel4_3 -$Gamma_4_Panel4_3 -$M6C_Panel4_3 -$Gamma_6_Panel4_3 0.25 0.75 0 0 0;
element zeroLength          1004300  4309 4310 -mat 1004300 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5004302 43020 4302 $A_Beam23_4 $E $G [expr 1.4350*$J_Beam23_4] [expr 1.4350*$Iy_Beam23_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam23_4] 1;

# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 43200 $K_s_Beam23_4 $Alpha_s_BeamComp23_4 $Alpha_s_Beam23_4 $My_s_BeamComp23_4 -$My_s_Beam23_4  $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 1. 1. 1. 1.  $Theta_p_s_BeamComp23_4  $Theta_p_s_Beam23_4  $Theta_pc_s_BeamComp23_4  $Theta_pc_s_Beam23_4  $Res_s_BeamComp23_4  $Res_s_Beam23_4  $Theta_ult_s_BeamComp23_4  $Theta_ult_s_Beam23_4  1.15 1.;
element     zeroLength 43200 432 43020 -mat 43200 -dir 6;
equalDOF                     432 43020 1 2;

# FloorAxis = 53;
# Panel Rigid Link;
element elasticBeamColumn 1005301 5305 5301 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005308 5301 5312 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005307 5311 5304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005306 5304 5310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005305 5309 5303 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005304 5303 5308 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005303 5307 5302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
element elasticBeamColumn 1005302 5306 5302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid 1;
equalDOF 5305 5306 1 2;
equalDOF 5312 5311 1 2;
equalDOF 5310 5309 1 2;
equalDOF 5307 5308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005300 $M1_Panel5_3 $Gamma_1_Panel5_3 $M4_Panel5_3 $Gamma_4_Panel5_3 $M6_Panel5_3 $Gamma_6_Panel5_3 -$M1C_Panel5_3 -$Gamma_1_Panel5_3 -$M4C_Panel5_3 -$Gamma_4_Panel5_3 -$M6C_Panel5_3 -$Gamma_6_Panel5_3 0.25 0.75 0 0 0;
element zeroLength          1005300  5309 5310 -mat 1005300 -dir 6;
# Panel to hinge;
# Left side;
element elasticBeamColumn  5005302 53020 5302 $A_Beam23_5 $E $G [expr 1.4950*$J_Beam23_5] [expr 1.4950*$Iy_Beam23_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam23_5] 1;

# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 53200 $K_s_Beam23_5 $Alpha_s_BeamComp23_5 $Alpha_s_Beam23_5 $My_s_BeamComp23_5 -$My_s_Beam23_5  $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 1. 1. 1. 1.  $Theta_p_s_BeamComp23_5  $Theta_p_s_Beam23_5  $Theta_pc_s_BeamComp23_5  $Theta_pc_s_Beam23_5  $Res_s_BeamComp23_5  $Res_s_Beam23_5  $Theta_ult_s_BeamComp23_5  $Theta_ult_s_Beam23_5  1.15 1.;
element     zeroLength 53200 532 53020 -mat 53200 -dir 6;
equalDOF                     532 53020 1 2;

# Gradient Element for Columns;

nDMaterial LocalBucklingWebPlate 1 205000.0 0.3 412.21 0.09 0.09 103.30 212.83 2 20750.59 225.26 1245.04 2.09 246.00 9.00 373.6463 1.0; 

# Fiber section for HSS300x9 columns 
section NDFiber 1 -GJ 17486463651923.08 {; 
patch circ 1 1 1 0.0000 173.9483 18.0000 27.0000 45 135 ; 
patch circ 1 1 1 173.9483 0.0000 18.0000 27.0000 315 405; 
patch circ 1 1 1 0.0000 -173.9483 18.0000 27.0000 225 315; 
patch circ 1 1 1 -173.9483 0.0000 18.0000 27.0000 135 225; 

patch quad 1 1 6 186.6762 12.7279 193.0402 19.0919 19.0919 193.0402 12.7279 186.6762; 
patch quad 1 1 6 -19.0919 -193.0402 -12.7279 -186.6762 -186.6762 -12.7279 -193.0402 -19.0919; 

patch quad 1 6 1 19.0919 -193.0402 193.0402 -19.0919 186.6762 -12.7279 12.7279 -186.6762; 
patch quad 1 6 1 -186.6762 12.7279 -12.7279 186.6762 -19.0919 193.0402 -193.0402 19.0919; 
} 

# Story 1, Axis 1 Column;
element gradientForceBeamColumn 11032101 1103 2101 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 2, Axis 1 Column;
element gradientForceBeamColumn 21033101 2103 3101 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 3, Axis 1 Column;
element gradientForceBeamColumn 31034101 3103 4101 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 4, Axis 1 Column;
element gradientForceBeamColumn 41035101 4103 5101 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 1, Axis 2 Column;
element gradientForceBeamColumn 12032201 1203 2201 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 2, Axis 2 Column;
element gradientForceBeamColumn 22033201 2203 3201 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 3, Axis 2 Column;
element gradientForceBeamColumn 32034201 3203 4201 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 4, Axis 2 Column;
element gradientForceBeamColumn 42035201 4203 5201 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 1, Axis 3 Column;
element gradientForceBeamColumn 13032301 1303 2301 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 2, Axis 3 Column;
element gradientForceBeamColumn 23033301 2303 3301 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 3, Axis 3 Column;
element gradientForceBeamColumn 33034301 3303 4301 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 
# Story 4, Axis 3 Column;
element gradientForceBeamColumn 43035301 4303 5301 $ColTransfTag Simpson 1 12  10 0.00000100 600.00 

# Beam-column element for Beams;
# Span 1 Floor 2 Beam;
element elasticBeamColumn  214222 214 222 $A_Beam12_2 $E $G [expr 1.3310*$J_Beam12_2] [expr 1.3310*$Iy_Beam12_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam12_2] 1;
# Span 1 Floor 3 Beam;
element elasticBeamColumn  314322 314 322 $A_Beam12_3 $E $G [expr 1.3730*$J_Beam12_3] [expr 1.3730*$Iy_Beam12_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam12_3] 1;
# Span 1 Floor 4 Beam;
element elasticBeamColumn  414422 414 422 $A_Beam12_4 $E $G [expr 1.4350*$J_Beam12_4] [expr 1.4350*$Iy_Beam12_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam12_4] 1;
# Span 1 Floor 5 Beam;
element elasticBeamColumn  514522 514 522 $A_Beam12_5 $E $G [expr 1.4950*$J_Beam12_5] [expr 1.4950*$Iy_Beam12_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam12_5] 1;
# Span 2 Floor 2 Beam;
element elasticBeamColumn  224232 224 232 $A_Beam23_2 $E $G [expr 1.3310*$J_Beam23_2] [expr 1.3310*$Iy_Beam23_2] [expr ($n_fac+1)/$n_fac*1.3310*$Ix_Beam23_2] 1;
# Span 2 Floor 3 Beam;
element elasticBeamColumn  324332 324 332 $A_Beam23_3 $E $G [expr 1.3730*$J_Beam23_3] [expr 1.3730*$Iy_Beam23_3] [expr ($n_fac+1)/$n_fac*1.3730*$Ix_Beam23_3] 1;
# Span 2 Floor 4 Beam;
element elasticBeamColumn  424432 424 432 $A_Beam23_4 $E $G [expr 1.4350*$J_Beam23_4] [expr 1.4350*$Iy_Beam23_4] [expr ($n_fac+1)/$n_fac*1.4350*$Ix_Beam23_4] 1;
# Span 2 Floor 5 Beam;
element elasticBeamColumn  524532 524 532 $A_Beam23_5 $E $G [expr 1.4950*$J_Beam23_5] [expr 1.4950*$Iy_Beam23_5] [expr ($n_fac+1)/$n_fac*1.4950*$Ix_Beam23_5] 1;

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
mass 2104 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 2202 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 2204 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 2302 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 3104 6.63875000 1.e-10 6.63875000 1.e-10 1.e-10 1.e-10; #ton
mass 3202 6.63875000 1.e-10 6.63875000 1.e-10 1.e-10 1.e-10; #ton
mass 3204 6.63875000 1.e-10 6.63875000 1.e-10 1.e-10 1.e-10; #ton
mass 3302 6.63875000 1.e-10 6.63875000 1.e-10 1.e-10 1.e-10; #ton
mass 4104 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 4202 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 4204 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 4302 6.68325000 1.e-10 6.68325000 1.e-10 1.e-10 1.e-10; #ton
mass 5104 8.65825000 1.e-10 8.65825000 1.e-10 1.e-10 1.e-10; #ton
mass 5202 8.65825000 1.e-10 8.65825000 1.e-10 1.e-10 1.e-10; #ton
mass 5204 8.65825000 1.e-10 8.65825000 1.e-10 1.e-10 1.e-10; #ton
mass 5302 8.65825000 1.e-10 8.65825000 1.e-10 1.e-10 1.e-10; #ton

# Create recorders;
# Floor Lateral Displacment;
recorder Node -file $Result/3dFiber_lc20D_EQL10_DispAxis1.txt  -time  -node 1103  2102  3102  4102  5102  -dof 1 disp;#Left middle of panel zone
# Reaction Forces;
recorder Node -file $Result/3dFiber_lc20D_EQL10_ReactionX.txt -time  -node 1103  1203  1303  -dof 1 reaction;
# Reaction Forces;
recorder Node -file $Result/3dFiber_lc20D_EQL10_ReactionY.txt -time  -node 1103  1203  1303  -dof 2 reaction;

# Fiber stress-strain in columns;
# Story 1, Axis 1 Column;
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos7BIP.txt -ele 11032101 section 1 fiber 212.1320 0.0000 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos7BIP.txt -ele 11032101 section 1 fiber 212.1320 0.0000 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerNeg7BIP.txt -ele 11032101 section 1 fiber -212.1320 0.0000 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerNeg7BIP.txt -ele 11032101 section 1 fiber -212.1320 0.0000 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayer0BIP.txt -ele 11032101 section 1 fiber 0.0000 212.1320 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayer0BIP.txt -ele 11032101 section 1 fiber 0.0000 212.1320 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos1BIP.txt -ele 11032101 section 1 fiber 30.4056 175.3625 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos1BIP.txt -ele 11032101 section 1 fiber 30.4056 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg1BIP.txt -ele 11032101 section 1 fiber -30.4056 175.3625 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg1BIP.txt -ele 11032101 section 1 fiber -30.4056 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos2BIP.txt -ele 11032101 section 1 fiber 59.3970 146.3711 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos2BIP.txt -ele 11032101 section 1 fiber 59.3970 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg2BIP.txt -ele 11032101 section 1 fiber -59.3970 146.3711 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg2BIP.txt -ele 11032101 section 1 fiber -59.3970 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos3BIP.txt -ele 11032101 section 1 fiber 88.3883 117.3797 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos3BIP.txt -ele 11032101 section 1 fiber 88.3883 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg3BIP.txt -ele 11032101 section 1 fiber -88.3883 117.3797 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg3BIP.txt -ele 11032101 section 1 fiber -88.3883 117.3797 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos4BIP.txt -ele 11032101 section 1 fiber 117.3797 88.3883 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos4BIP.txt -ele 11032101 section 1 fiber 117.3797 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg4BIP.txt -ele 11032101 section 1 fiber -117.3797 88.3883 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg4BIP.txt -ele 11032101 section 1 fiber -117.3797 88.3883 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos5BIP.txt -ele 11032101 section 1 fiber 146.3711 59.3970 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos5BIP.txt -ele 11032101 section 1 fiber 146.3711 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg5BIP.txt -ele 11032101 section 1 fiber -146.3711 59.3970 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg5BIP.txt -ele 11032101 section 1 fiber -146.3711 59.3970 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_stressFiberLayerPos6BIP.txt -ele 11032101 section 1 fiber 175.3625 30.4056 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_11032101_strainFiberLayerPos6BIP.txt -ele 11032101 section 1 fiber 175.3625 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_stressFiberLayerNeg6BIP.txt -ele 11032101 section 1 fiber -175.3625 30.4056 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_11032101_strainFiberLayerNeg6BIP.txt -ele 11032101 section 1 fiber -175.3625 30.4056 strain; 

# Story 1, Axis 2 Column;
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos7BIP.txt -ele 12032201 section 1 fiber 212.1320 0.0000 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos7BIP.txt -ele 12032201 section 1 fiber 212.1320 0.0000 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerNeg7BIP.txt -ele 12032201 section 1 fiber -212.1320 0.0000 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerNeg7BIP.txt -ele 12032201 section 1 fiber -212.1320 0.0000 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayer0BIP.txt -ele 12032201 section 1 fiber 0.0000 212.1320 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayer0BIP.txt -ele 12032201 section 1 fiber 0.0000 212.1320 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos1BIP.txt -ele 12032201 section 1 fiber 30.4056 175.3625 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos1BIP.txt -ele 12032201 section 1 fiber 30.4056 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg1BIP.txt -ele 12032201 section 1 fiber -30.4056 175.3625 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg1BIP.txt -ele 12032201 section 1 fiber -30.4056 175.3625 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos2BIP.txt -ele 12032201 section 1 fiber 59.3970 146.3711 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos2BIP.txt -ele 12032201 section 1 fiber 59.3970 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg2BIP.txt -ele 12032201 section 1 fiber -59.3970 146.3711 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg2BIP.txt -ele 12032201 section 1 fiber -59.3970 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos3BIP.txt -ele 12032201 section 1 fiber 88.3883 117.3797 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos3BIP.txt -ele 12032201 section 1 fiber 88.3883 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg3BIP.txt -ele 12032201 section 1 fiber -88.3883 117.3797 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg3BIP.txt -ele 12032201 section 1 fiber -88.3883 117.3797 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos4BIP.txt -ele 12032201 section 1 fiber 117.3797 88.3883 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos4BIP.txt -ele 12032201 section 1 fiber 117.3797 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg4BIP.txt -ele 12032201 section 1 fiber -117.3797 88.3883 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg4BIP.txt -ele 12032201 section 1 fiber -117.3797 88.3883 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos5BIP.txt -ele 12032201 section 1 fiber 146.3711 59.3970 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos5BIP.txt -ele 12032201 section 1 fiber 146.3711 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg5BIP.txt -ele 12032201 section 1 fiber -146.3711 59.3970 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg5BIP.txt -ele 12032201 section 1 fiber -146.3711 59.3970 strain; 

recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_stressFiberLayerPos6BIP.txt -ele 12032201 section 1 fiber 175.3625 30.4056 stress; 
recorder Element -file $Result/3dFiber_lc20D_EQL10_12032201_strainFiberLayerPos6BIP.txt -ele 12032201 section 1 fiber 175.3625 146.3711 strain; 

recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_stressFiberLayerNeg6BIP.txt -ele 12032201 section 1 fiber -175.3625 30.4056 stress; 
recorder Element -file $Result/3dFiber_lc20D_Takatori_YDir_EQL10_12032201_strainFiberLayerNeg6BIP.txt -ele 12032201 section 1 fiber -175.3625 30.4056 strain; 

# Eigen value analysis;
# Mode Shapes;
file mkdir $Result/modes;
set numModes 4;
recorder Node -file $Result/modes/3dHinge_mode1.txt -node 2102  3102  4102  5102  -dof 1 "eigen 1"
recorder Node -file $Result/modes/3dHinge_mode2.txt -node 2102  3102  4102  5102  -dof 1 "eigen 2"
recorder Node -file $Result/modes/3dHinge_mode3.txt -node 2102  3102  4102  5102  -dof 1 "eigen 3"
recorder Node -file $Result/modes/3dHinge_mode4.txt -node 2102  3102  4102  5102  -dof 1 "eigen 4"
set pi [expr 2.0*asin(1.0)];
set nEigen 4;
set lambdaN [eigen [expr $nEigen]];
set lambdaI [lindex $lambdaN 0];
set lambdaJ [lindex $lambdaN 1];
set lambdaK [lindex $lambdaN 2];
set lambdaL [lindex $lambdaN 3];
DisplayModel2D ModeShape 2000 522  10  512  384  1;
DisplayModel2D ModeShape 2000 1032 10  512  384  2;
DisplayModel2D ModeShape 2000 1532 10  512  384  3;
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
set dAmp      2.8;
DisplayModel2D NodeNumbers $dAmp $xLoc1 $yLoc1  $xPixels $yPixels -wipe;
DisplayPlane "DeformedShape" $dAmp XY 0;

# Assign Loads, Analysis Type And Conversion Procedure;
# GRAVITY LOADS;
pattern Plain 100 Linear {
load 2101 0. [expr -1.0*65562.6825] 0. 0. 0. 0.;
load 2201 0. [expr -1.0*131125.3650] 0. 0. 0. 0.;
load 2301 0. [expr -1.0*65562.6825] 0. 0. 0. 0.;
load 3101 0. [expr -1.0*65126.1375] 0. 0. 0. 0.;
load 3201 0. [expr -1.0*130252.2750] 0. 0. 0. 0.;
load 3301 0. [expr -1.0*65126.1375] 0. 0. 0. 0.;
load 4101 0. [expr -1.0*65126.1375] 0. 0. 0. 0.;
load 4201 0. [expr -1.0*130252.2750] 0. 0. 0. 0.;
load 4301 0. [expr -1.0*65126.1375] 0. 0. 0. 0.;
load 5101 0. [expr -1.0*84937.4325] 0. 0. 0. 0.;
load 5201 0. [expr -1.0*169874.8650] 0. 0. 0. 0.;
load 5301 0. [expr -1.0*84937.4325] 0. 0. 0. 0.;
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


# Nonlinear dynamic analysis 

# Rayleigh Damping
# calculate damping parameters
set zeta 0.03;		# percentage of critical damping
set a0 [expr $zeta*2.0*$w1*$w3/($w1+$w3)];	# mass damping coefficient based on first and third modes
set a1 [expr $zeta*2.0/($w1+$w3)];	# stiffness damping coefficient based on first and third modes
set a1_mod_two [expr $a1*(1.0+10.0000)/10.0000]; # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_mod_one [expr (1.0+1.0/(2*10.0000))*$a1];    # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.

# assign damping to frame columns
region 7 -ele  11032101  21033101  31034101  41035101  12032201  22033201  32034201  42035201  13032301  23033301  33034301  43035301  -rayleigh 0.0 0.0 $a1 0.0;# assign stiffness proportional damping to columns without splices
region 9 -ele  214222  314322  414422  514522  224232  324332  424432  524532  -rayleigh 0.0 0.0 $a1_mod_two 0.0;# assign stiffness proportional damping to beams
region 6 -ele  5002104  5003104  5004104  5005104  5002202  5002204  5003202  5003204  5004202  5004204  5005202  5005204  5002302  5003302  5004302  5005302  -rayleigh 0.0 0.0 $a1_mod_one 0.0;# assign stiffness proportional damping to WUF_W edges
region 5 -node 2104  2202  2204  2302  3104  3202  3204  3302  4104  4202  4204  4302  5104  5202  5204  5302 -rayleigh $a0 0.0 0.0 0.0;# assign mass proportional damping to structure (assign to nodes with mass)

# Define ground motion parameters

set patternID 1;              # Pattern ID
set GMdirection 1;				# ground motion direction (1 = x)
set GMfile "Takatori_YDir_EQL10.txt";      # ground motion filename
set dt 0.0100;					# timestep of input GM file
set Scalefact 1.0000;				# ground motion scaling factor
set TotalNumberOfSteps 1800;	# number of steps in ground motion
set GMtime [expr $dt*$TotalNumberOfSteps + 0.0];	# total time of ground motion + free vibration

# define the acceleration series for the ground motion
# syntax:  "Series -dt $timestep_of_record -filePath $filename_with_acc_history -factor $scale_record_by_this_amount
set g 9810;
set accelSeries "Series -dt $dt -filePath $GMfile -factor [expr $Scalefact*$g]";

# create load pattern: apply acceleration to all fixed nodes with UniformExcitation
# command: pattern UniformExcitation $patternID $GMdir -accel $timeSeriesID 
pattern UniformExcitation $patternID $GMdirection -accel $accelSeries;

puts "Running Dynamic Analysis..."
# define dynamic analysis parameters
set dt_analysis 0.0010;			# timestep of analysis
set FloorNodes [list  1103  2102 3102 4102 5102 ]; 
set FloorElevation [list 0 3450.0 6950.0 10450.0 13975.0 ]; 
set tStart [clock seconds];

# proc DynamicAnalysis {dt  dt_anal_Step   GMtime  numStories numBays DriftLimit FloorNodes  FloorElevation   h1       htyp};
DynamicAnalysis_V02        $dt  $dt_analysis  $GMtime    4       0.15    $FloorNodes     3450.0000      3500.0000;

# output time at end of analysis	
set currentTime [getTime];	# get current analysis time	(after dynamic analysis)
puts "Ground motion time: $currentTime";
set tFinish [clock seconds];
puts "Analysis duration: [expr $tFinish - $tStart] s";
wipe;
wipe all;
