wipe;
wipe all;

model BasicBuilder -ndm 3 -ndf 6;

set ColTransfTag 1 
set BeamTransfTag 2 
geomTransf Corotational $ColTransfTag 0 0 -1;
geomTransf Linear $BeamTransfTag 0 0 1;

set Source "0_Source";
source $Source/DisplayModel3D.tcl;
source $Source/DisplayPlane.tcl;
source $Source/DynamicAnalysis_V03.tcl;

file mkdir MRF_4Story_3Bay_GMCanoga_SF2.15_localHnIPs_V01_result;
global Result;
set Result "MRF_4Story_3Bay_GMCanoga_SF2.15_localHnIPs_V01_result";

set E 205000.00;
set G 78846.15;

set Nstory 4;
set NBay 3;
set BayWidth12 6100.0;
set BayWidth23 6100.0;
set BayWidth34 6100.0;
set BayWidthLC 3050.0;
set HStory12 4300.0;
set HStory23 4000.0;
set HStory34 4000.0;
set HStory45 4000.0;

set Axis1 0.00;
set Axis2 6100.00;
set Axis3 12200.00;
set Axis4 18300.00;
set Axis5 21350.00;

set Floor1 0.00;
set Floor2 4300.00;
set Floor3 8300.00;
set Floor4 12300.00;
set Floor5 16300.00;

set n_fac 10.0;
set H_offset 0.0;

# Column at STORY-1 and AXIS-1 (Bottom);
set            d_Col12_1_b 622.00;#Depth
set           bf_Col12_1_b 229.00;#Flange width
set           tw_Col12_1_b 14.00;#Web thickness
set           tf_Col12_1_b 24.90;#Flange thickness
set            r_Col12_1_b 12.70;#Radius at the k-area
set            A_Col12_1_b 19553.45;#Cross-sectional area
set           Ix_Col12_1_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col12_1_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col12_1_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col12_1_b 50.56;#Radius of gyration about weak axis
set            J_Col12_1_b 2880278.28;#Torsion constant

# Column at STORY-1 and AXIS-1 (Top);
set            d_Col12_1_t 622.00;#Depth
set           bf_Col12_1_t 229.00;#Flange width
set           tw_Col12_1_t 14.00;#Web thickness
set           tf_Col12_1_t 24.90;#Flange thickness
set            r_Col12_1_t 12.70;#Radius at the k-area
set            A_Col12_1_t 19553.45;#Cross-sectional area
set           Ix_Col12_1_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col12_1_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col12_1_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col12_1_t 50.56;#Radius of gyration about weak axis
set            J_Col12_1_t 2880278.28;#Torsion constant


# Column at STORY-1 and AXIS-2 (Bottom);
set            d_Col12_2_b 627.00;#Depth
set           bf_Col12_2_b 328.00;#Flange width
set           tw_Col12_2_b 16.50;#Web thickness
set           tf_Col12_2_b 27.70;#Flange thickness
set            r_Col12_2_b 12.70;#Radius at the k-area
set            A_Col12_2_b 27741.05;#Cross-sectional area
set           Ix_Col12_2_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col12_2_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col12_2_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col12_2_b 76.69;#Radius of gyration about weak axis
set            J_Col12_2_b 5503426.23;#Torsion constant

# Column at STORY-1 and AXIS-2 (Top);
set            d_Col12_2_t 627.00;#Depth
set           bf_Col12_2_t 328.00;#Flange width
set           tw_Col12_2_t 16.50;#Web thickness
set           tf_Col12_2_t 27.70;#Flange thickness
set            r_Col12_2_t 12.70;#Radius at the k-area
set            A_Col12_2_t 27741.05;#Cross-sectional area
set           Ix_Col12_2_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col12_2_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col12_2_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col12_2_t 76.69;#Radius of gyration about weak axis
set            J_Col12_2_t 5503426.23;#Torsion constant


# Column at STORY-1 and AXIS-3 (Bottom);
set            d_Col12_3_b 627.00;#Depth
set           bf_Col12_3_b 328.00;#Flange width
set           tw_Col12_3_b 16.50;#Web thickness
set           tf_Col12_3_b 27.70;#Flange thickness
set            r_Col12_3_b 12.70;#Radius at the k-area
set            A_Col12_3_b 27741.05;#Cross-sectional area
set           Ix_Col12_3_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col12_3_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col12_3_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col12_3_b 76.69;#Radius of gyration about weak axis
set            J_Col12_3_b 5503426.23;#Torsion constant

# Column at STORY-1 and AXIS-3 (Top);
set            d_Col12_3_t 627.00;#Depth
set           bf_Col12_3_t 328.00;#Flange width
set           tw_Col12_3_t 16.50;#Web thickness
set           tf_Col12_3_t 27.70;#Flange thickness
set            r_Col12_3_t 12.70;#Radius at the k-area
set            A_Col12_3_t 27741.05;#Cross-sectional area
set           Ix_Col12_3_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col12_3_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col12_3_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col12_3_t 76.69;#Radius of gyration about weak axis
set            J_Col12_3_t 5503426.23;#Torsion constant


# Column at STORY-1 and AXIS-4 (Bottom);
set            d_Col12_4_b 622.00;#Depth
set           bf_Col12_4_b 229.00;#Flange width
set           tw_Col12_4_b 14.00;#Web thickness
set           tf_Col12_4_b 24.90;#Flange thickness
set            r_Col12_4_b 12.70;#Radius at the k-area
set            A_Col12_4_b 19553.45;#Cross-sectional area
set           Ix_Col12_4_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col12_4_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col12_4_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col12_4_b 50.56;#Radius of gyration about weak axis
set            J_Col12_4_b 2880278.28;#Torsion constant

# Column at STORY-1 and AXIS-4 (Top);
set            d_Col12_4_t 622.00;#Depth
set           bf_Col12_4_t 229.00;#Flange width
set           tw_Col12_4_t 14.00;#Web thickness
set           tf_Col12_4_t 24.90;#Flange thickness
set            r_Col12_4_t 12.70;#Radius at the k-area
set            A_Col12_4_t 19553.45;#Cross-sectional area
set           Ix_Col12_4_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col12_4_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col12_4_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col12_4_t 50.56;#Radius of gyration about weak axis
set            J_Col12_4_t 2880278.28;#Torsion constant


# Column at STORY-2 and AXIS-1 (Bottom);
set            d_Col23_1_b 622.00;#Depth
set           bf_Col23_1_b 229.00;#Flange width
set           tw_Col23_1_b 14.00;#Web thickness
set           tf_Col23_1_b 24.90;#Flange thickness
set            r_Col23_1_b 12.70;#Radius at the k-area
set            A_Col23_1_b 19553.45;#Cross-sectional area
set           Ix_Col23_1_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col23_1_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col23_1_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col23_1_b 50.56;#Radius of gyration about weak axis
set            J_Col23_1_b 2880278.28;#Torsion constant

# Column at STORY-2 and AXIS-1 (Top);
set            d_Col23_1_t 622.00;#Depth
set           bf_Col23_1_t 229.00;#Flange width
set           tw_Col23_1_t 14.00;#Web thickness
set           tf_Col23_1_t 24.90;#Flange thickness
set            r_Col23_1_t 12.70;#Radius at the k-area
set            A_Col23_1_t 19553.45;#Cross-sectional area
set           Ix_Col23_1_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col23_1_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col23_1_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col23_1_t 50.56;#Radius of gyration about weak axis
set            J_Col23_1_t 2880278.28;#Torsion constant


# Column at STORY-2 and AXIS-2 (Bottom);
set            d_Col23_2_b 627.00;#Depth
set           bf_Col23_2_b 328.00;#Flange width
set           tw_Col23_2_b 16.50;#Web thickness
set           tf_Col23_2_b 27.70;#Flange thickness
set            r_Col23_2_b 12.70;#Radius at the k-area
set            A_Col23_2_b 27741.05;#Cross-sectional area
set           Ix_Col23_2_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col23_2_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col23_2_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col23_2_b 76.69;#Radius of gyration about weak axis
set            J_Col23_2_b 5503426.23;#Torsion constant

# Column at STORY-2 and AXIS-2 (Top);
set            d_Col23_2_t 627.00;#Depth
set           bf_Col23_2_t 328.00;#Flange width
set           tw_Col23_2_t 16.50;#Web thickness
set           tf_Col23_2_t 27.70;#Flange thickness
set            r_Col23_2_t 12.70;#Radius at the k-area
set            A_Col23_2_t 27741.05;#Cross-sectional area
set           Ix_Col23_2_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col23_2_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col23_2_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col23_2_t 76.69;#Radius of gyration about weak axis
set            J_Col23_2_t 5503426.23;#Torsion constant


# Column at STORY-2 and AXIS-3 (Bottom);
set            d_Col23_3_b 627.00;#Depth
set           bf_Col23_3_b 328.00;#Flange width
set           tw_Col23_3_b 16.50;#Web thickness
set           tf_Col23_3_b 27.70;#Flange thickness
set            r_Col23_3_b 12.70;#Radius at the k-area
set            A_Col23_3_b 27741.05;#Cross-sectional area
set           Ix_Col23_3_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col23_3_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col23_3_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col23_3_b 76.69;#Radius of gyration about weak axis
set            J_Col23_3_b 5503426.23;#Torsion constant

# Column at STORY-2 and AXIS-3 (Top);
set            d_Col23_3_t 627.00;#Depth
set           bf_Col23_3_t 328.00;#Flange width
set           tw_Col23_3_t 16.50;#Web thickness
set           tf_Col23_3_t 27.70;#Flange thickness
set            r_Col23_3_t 12.70;#Radius at the k-area
set            A_Col23_3_t 27741.05;#Cross-sectional area
set           Ix_Col23_3_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col23_3_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col23_3_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col23_3_t 76.69;#Radius of gyration about weak axis
set            J_Col23_3_t 5503426.23;#Torsion constant


# Column at STORY-2 and AXIS-4 (Bottom);
set            d_Col23_4_b 622.00;#Depth
set           bf_Col23_4_b 229.00;#Flange width
set           tw_Col23_4_b 14.00;#Web thickness
set           tf_Col23_4_b 24.90;#Flange thickness
set            r_Col23_4_b 12.70;#Radius at the k-area
set            A_Col23_4_b 19553.45;#Cross-sectional area
set           Ix_Col23_4_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col23_4_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col23_4_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col23_4_b 50.56;#Radius of gyration about weak axis
set            J_Col23_4_b 2880278.28;#Torsion constant

# Column at STORY-2 and AXIS-4 (Top);
set            d_Col23_4_t 622.00;#Depth
set           bf_Col23_4_t 229.00;#Flange width
set           tw_Col23_4_t 14.00;#Web thickness
set           tf_Col23_4_t 24.90;#Flange thickness
set            r_Col23_4_t 12.70;#Radius at the k-area
set            A_Col23_4_t 19553.45;#Cross-sectional area
set           Ix_Col23_4_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col23_4_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col23_4_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col23_4_t 50.56;#Radius of gyration about weak axis
set            J_Col23_4_t 2880278.28;#Torsion constant


# Column at STORY-3 and AXIS-1 (Bottom);
set            d_Col34_1_b 622.00;#Depth
set           bf_Col34_1_b 229.00;#Flange width
set           tw_Col34_1_b 14.00;#Web thickness
set           tf_Col34_1_b 24.90;#Flange thickness
set            r_Col34_1_b 12.70;#Radius at the k-area
set            A_Col34_1_b 19553.45;#Cross-sectional area
set           Ix_Col34_1_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col34_1_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col34_1_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col34_1_b 50.56;#Radius of gyration about weak axis
set            J_Col34_1_b 2880278.28;#Torsion constant

# Column at STORY-3 and AXIS-1 (Top);
set            d_Col34_1_t 607.00;#Depth
set           bf_Col34_1_t 228.00;#Flange width
set           tw_Col34_1_t 11.20;#Web thickness
set           tf_Col34_1_t 17.30;#Flange thickness
set            r_Col34_1_t 12.70;#Radius at the k-area
set            A_Col34_1_t 19553.45;#Cross-sectional area
set           Ix_Col34_1_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col34_1_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col34_1_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col34_1_t 50.56;#Radius of gyration about weak axis
set            J_Col34_1_t 2880278.28;#Torsion constant


# Column at STORY-3 and AXIS-2 (Bottom);
set            d_Col34_2_b 627.00;#Depth
set           bf_Col34_2_b 328.00;#Flange width
set           tw_Col34_2_b 16.50;#Web thickness
set           tf_Col34_2_b 27.70;#Flange thickness
set            r_Col34_2_b 12.70;#Radius at the k-area
set            A_Col34_2_b 27741.05;#Cross-sectional area
set           Ix_Col34_2_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col34_2_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col34_2_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col34_2_b 76.69;#Radius of gyration about weak axis
set            J_Col34_2_b 5503426.23;#Torsion constant

# Column at STORY-3 and AXIS-2 (Top);
set            d_Col34_2_t 612.00;#Depth
set           bf_Col34_2_t 229.00;#Flange width
set           tw_Col34_2_t 11.90;#Web thickness
set           tf_Col34_2_t 19.60;#Flange thickness
set            r_Col34_2_t 12.70;#Radius at the k-area
set            A_Col34_2_t 27741.05;#Cross-sectional area
set           Ix_Col34_2_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col34_2_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col34_2_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col34_2_t 76.69;#Radius of gyration about weak axis
set            J_Col34_2_t 5503426.23;#Torsion constant


# Column at STORY-3 and AXIS-3 (Bottom);
set            d_Col34_3_b 627.00;#Depth
set           bf_Col34_3_b 328.00;#Flange width
set           tw_Col34_3_b 16.50;#Web thickness
set           tf_Col34_3_b 27.70;#Flange thickness
set            r_Col34_3_b 12.70;#Radius at the k-area
set            A_Col34_3_b 27741.05;#Cross-sectional area
set           Ix_Col34_3_b 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col34_3_b 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col34_3_b 163141859.16;#Second moment of inertia about weak axis
set           ry_Col34_3_b 76.69;#Radius of gyration about weak axis
set            J_Col34_3_b 5503426.23;#Torsion constant

# Column at STORY-3 and AXIS-3 (Top);
set            d_Col34_3_t 612.00;#Depth
set           bf_Col34_3_t 229.00;#Flange width
set           tw_Col34_3_t 11.90;#Web thickness
set           tf_Col34_3_t 19.60;#Flange thickness
set            r_Col34_3_t 12.70;#Radius at the k-area
set            A_Col34_3_t 27741.05;#Cross-sectional area
set           Ix_Col34_3_t 1900632460.92;#Second moment of inertia about strong axis
set           Zx_Col34_3_t 6831923.81;#Plastic section modulus abotu strong axis
set           Iy_Col34_3_t 163141859.16;#Second moment of inertia about weak axis
set           ry_Col34_3_t 76.69;#Radius of gyration about weak axis
set            J_Col34_3_t 5503426.23;#Torsion constant


# Column at STORY-3 and AXIS-4 (Bottom);
set            d_Col34_4_b 622.00;#Depth
set           bf_Col34_4_b 229.00;#Flange width
set           tw_Col34_4_b 14.00;#Web thickness
set           tf_Col34_4_b 24.90;#Flange thickness
set            r_Col34_4_b 12.70;#Radius at the k-area
set            A_Col34_4_b 19553.45;#Cross-sectional area
set           Ix_Col34_4_b 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col34_4_b 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col34_4_b 49981545.37;#Second moment of inertia about weak axis
set           ry_Col34_4_b 50.56;#Radius of gyration about weak axis
set            J_Col34_4_b 2880278.28;#Torsion constant

# Column at STORY-3 and AXIS-4 (Top);
set            d_Col34_4_t 607.00;#Depth
set           bf_Col34_4_t 228.00;#Flange width
set           tw_Col34_4_t 11.20;#Web thickness
set           tf_Col34_4_t 17.30;#Flange thickness
set            r_Col34_4_t 12.70;#Radius at the k-area
set            A_Col34_4_t 19553.45;#Cross-sectional area
set           Ix_Col34_4_t 1246748531.96;#Second moment of inertia about strong axis
set           Zx_Col34_4_t 4589887.05;#Plastic section modulus abotu strong axis
set           Iy_Col34_4_t 49981545.37;#Second moment of inertia about weak axis
set           ry_Col34_4_t 50.56;#Radius of gyration about weak axis
set            J_Col34_4_t 2880278.28;#Torsion constant


# Column at STORY-4 and AXIS-1 (Bottom);
set            d_Col45_1_b 607.00;#Depth
set           bf_Col45_1_b 228.00;#Flange width
set           tw_Col45_1_b 11.20;#Web thickness
set           tf_Col45_1_b 17.30;#Flange thickness
set            r_Col45_1_b 12.70;#Radius at the k-area
set            A_Col45_1_b 14438.13;#Cross-sectional area
set           Ix_Col45_1_b 872177854.73;#Second moment of inertia about strong axis
set           Zx_Col45_1_b 3282641.66;#Plastic section modulus abotu strong axis
set           Iy_Col45_1_b 34251152.46;#Second moment of inertia about weak axis
set           ry_Col45_1_b 48.71;#Radius of gyration about weak axis
set            J_Col45_1_b 1055073.25;#Torsion constant

# Column at STORY-4 and AXIS-1 (Top);
set            d_Col45_1_t 607.00;#Depth
set           bf_Col45_1_t 228.00;#Flange width
set           tw_Col45_1_t 11.20;#Web thickness
set           tf_Col45_1_t 17.30;#Flange thickness
set            r_Col45_1_t 12.70;#Radius at the k-area
set            A_Col45_1_t 14438.13;#Cross-sectional area
set           Ix_Col45_1_t 872177854.73;#Second moment of inertia about strong axis
set           Zx_Col45_1_t 3282641.66;#Plastic section modulus abotu strong axis
set           Iy_Col45_1_t 34251152.46;#Second moment of inertia about weak axis
set           ry_Col45_1_t 48.71;#Radius of gyration about weak axis
set            J_Col45_1_t 1055073.25;#Torsion constant


# Column at STORY-4 and AXIS-2 (Bottom);
set            d_Col45_2_b 612.00;#Depth
set           bf_Col45_2_b 229.00;#Flange width
set           tw_Col45_2_b 11.90;#Web thickness
set           tf_Col45_2_b 19.60;#Flange thickness
set            r_Col45_2_b 12.70;#Radius at the k-area
set            A_Col45_2_b 15931.57;#Cross-sectional area
set           Ix_Col45_2_b 985363984.02;#Second moment of inertia about strong axis
set           Zx_Col45_2_b 3674284.92;#Plastic section modulus abotu strong axis
set           Iy_Col45_2_b 39320492.78;#Second moment of inertia about weak axis
set           ry_Col45_2_b 49.68;#Radius of gyration about weak axis
set            J_Col45_2_b 1471262.19;#Torsion constant

# Column at STORY-4 and AXIS-2 (Top);
set            d_Col45_2_t 612.00;#Depth
set           bf_Col45_2_t 229.00;#Flange width
set           tw_Col45_2_t 11.90;#Web thickness
set           tf_Col45_2_t 19.60;#Flange thickness
set            r_Col45_2_t 12.70;#Radius at the k-area
set            A_Col45_2_t 15931.57;#Cross-sectional area
set           Ix_Col45_2_t 985363984.02;#Second moment of inertia about strong axis
set           Zx_Col45_2_t 3674284.92;#Plastic section modulus abotu strong axis
set           Iy_Col45_2_t 39320492.78;#Second moment of inertia about weak axis
set           ry_Col45_2_t 49.68;#Radius of gyration about weak axis
set            J_Col45_2_t 1471262.19;#Torsion constant


# Column at STORY-4 and AXIS-3 (Bottom);
set            d_Col45_3_b 612.00;#Depth
set           bf_Col45_3_b 229.00;#Flange width
set           tw_Col45_3_b 11.90;#Web thickness
set           tf_Col45_3_b 19.60;#Flange thickness
set            r_Col45_3_b 12.70;#Radius at the k-area
set            A_Col45_3_b 15931.57;#Cross-sectional area
set           Ix_Col45_3_b 985363984.02;#Second moment of inertia about strong axis
set           Zx_Col45_3_b 3674284.92;#Plastic section modulus abotu strong axis
set           Iy_Col45_3_b 39320492.78;#Second moment of inertia about weak axis
set           ry_Col45_3_b 49.68;#Radius of gyration about weak axis
set            J_Col45_3_b 1471262.19;#Torsion constant

# Column at STORY-4 and AXIS-3 (Top);
set            d_Col45_3_t 612.00;#Depth
set           bf_Col45_3_t 229.00;#Flange width
set           tw_Col45_3_t 11.90;#Web thickness
set           tf_Col45_3_t 19.60;#Flange thickness
set            r_Col45_3_t 12.70;#Radius at the k-area
set            A_Col45_3_t 15931.57;#Cross-sectional area
set           Ix_Col45_3_t 985363984.02;#Second moment of inertia about strong axis
set           Zx_Col45_3_t 3674284.92;#Plastic section modulus abotu strong axis
set           Iy_Col45_3_t 39320492.78;#Second moment of inertia about weak axis
set           ry_Col45_3_t 49.68;#Radius of gyration about weak axis
set            J_Col45_3_t 1471262.19;#Torsion constant


# Column at STORY-4 and AXIS-4 (Bottom);
set            d_Col45_4_b 607.00;#Depth
set           bf_Col45_4_b 228.00;#Flange width
set           tw_Col45_4_b 11.20;#Web thickness
set           tf_Col45_4_b 17.30;#Flange thickness
set            r_Col45_4_b 12.70;#Radius at the k-area
set            A_Col45_4_b 14438.13;#Cross-sectional area
set           Ix_Col45_4_b 872177854.73;#Second moment of inertia about strong axis
set           Zx_Col45_4_b 3282641.66;#Plastic section modulus abotu strong axis
set           Iy_Col45_4_b 34251152.46;#Second moment of inertia about weak axis
set           ry_Col45_4_b 48.71;#Radius of gyration about weak axis
set            J_Col45_4_b 1055073.25;#Torsion constant

# Column at STORY-4 and AXIS-4 (Top);
set            d_Col45_4_t 607.00;#Depth
set           bf_Col45_4_t 228.00;#Flange width
set           tw_Col45_4_t 11.20;#Web thickness
set           tf_Col45_4_t 17.30;#Flange thickness
set            r_Col45_4_t 12.70;#Radius at the k-area
set            A_Col45_4_t 14438.13;#Cross-sectional area
set           Ix_Col45_4_t 872177854.73;#Second moment of inertia about strong axis
set           Zx_Col45_4_t 3282641.66;#Plastic section modulus abotu strong axis
set           Iy_Col45_4_t 34251152.46;#Second moment of inertia about weak axis
set           ry_Col45_4_t 48.71;#Radius of gyration about weak axis
set            J_Col45_4_t 1055073.25;#Torsion constant


# Beam at SPAN-1 and FLOOR-2;
set             d_Beam12_2 607.00;#Depth
set            bf_Beam12_2 228.00;#Flange width
set            tw_Beam12_2 11.20;#Web thickness
set            tf_Beam12_2 17.30;#Flange thickness
set             r_Beam12_2 12.70;#Radius at the k-area
set             A_Beam12_2 14438.13;#Cross-sectional area
set            Ix_Beam12_2 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam12_2 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam12_2 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam12_2 48.71;#Radius of gyration about weak axis
set             J_Beam12_2 1055073.25;#Torsion constant
set   K_mem_canti_Beam12_2 195923433718.12;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_2 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam12_2 0.00636;#Yield chord rotation 
set         a_mem_Beam12_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_2 1370338759.68;#Capping moment
set   Theta_p_mem_Beam12_2 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_2 0.10785;#Post-capping plastic chord rotation
set       Res_mem_Beam12_2 0.40;#Residual moment
set      Mres_mem_Beam12_2 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_2 0.03293;#Post-yielding stiffness ratio
set           K_s_Beam12_2 2155157770899.37;#Initial stiffness of the spring
set          My_s_Beam12_2 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam12_2 0.00309;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_2 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_2 0.11421;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_2 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam12_2 2737.75;#Effective canti-lever length
set            Lb_Beam12_2 5475.50;#Unbraced length
set        Lambda_Beam12_2 0.80987;#

# Beam at SPAN-2 and FLOOR-2;
set             d_Beam23_2 607.00;#Depth
set            bf_Beam23_2 228.00;#Flange width
set            tw_Beam23_2 11.20;#Web thickness
set            tf_Beam23_2 17.30;#Flange thickness
set             r_Beam23_2 12.70;#Radius at the k-area
set             A_Beam23_2 14438.13;#Cross-sectional area
set            Ix_Beam23_2 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam23_2 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam23_2 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam23_2 48.71;#Radius of gyration about weak axis
set             J_Beam23_2 1055073.25;#Torsion constant
set   K_mem_canti_Beam23_2 196012929165.65;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_2 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam23_2 0.00636;#Yield chord rotation 
set         a_mem_Beam23_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_2 1370338759.68;#Capping moment
set   Theta_p_mem_Beam23_2 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_2 0.10785;#Post-capping plastic chord rotation
set       Res_mem_Beam23_2 0.40;#Residual moment
set      Mres_mem_Beam23_2 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_2 0.03291;#Post-yielding stiffness ratio
set           K_s_Beam23_2 2156142220822.13;#Initial stiffness of the spring
set          My_s_Beam23_2 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam23_2 0.00308;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_2 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_2 0.11421;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_2 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam23_2 2736.50;#Effective canti-lever length
set            Lb_Beam23_2 5473.00;#Unbraced length
set        Lambda_Beam23_2 0.80992;#

# Beam at SPAN-3 and FLOOR-2;
set             d_Beam34_2 607.00;#Depth
set            bf_Beam34_2 228.00;#Flange width
set            tw_Beam34_2 11.20;#Web thickness
set            tf_Beam34_2 17.30;#Flange thickness
set             r_Beam34_2 12.70;#Radius at the k-area
set             A_Beam34_2 14438.13;#Cross-sectional area
set            Ix_Beam34_2 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam34_2 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam34_2 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam34_2 48.71;#Radius of gyration about weak axis
set             J_Beam34_2 1055073.25;#Torsion constant
set   K_mem_canti_Beam34_2 195923433718.12;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam34_2 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam34_2 0.00636;#Yield chord rotation 
set         a_mem_Beam34_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam34_2 1370338759.68;#Capping moment
set   Theta_p_mem_Beam34_2 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam34_2 0.10785;#Post-capping plastic chord rotation
set       Res_mem_Beam34_2 0.40;#Residual moment
set      Mres_mem_Beam34_2 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam34_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam34_2 0.03293;#Post-yielding stiffness ratio
set           K_s_Beam34_2 2155157770899.37;#Initial stiffness of the spring
set          My_s_Beam34_2 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam34_2 0.00309;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam34_2 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam34_2 0.11421;#Post-capping plastic rotation of the spring
set         Res_s_Beam34_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam34_2 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam34_2 2737.75;#Effective canti-lever length
set            Lb_Beam34_2 5475.50;#Unbraced length
set        Lambda_Beam34_2 0.80987;#

# Beam at SPAN-1 and FLOOR-3;
set             d_Beam12_3 607.00;#Depth
set            bf_Beam12_3 228.00;#Flange width
set            tw_Beam12_3 11.20;#Web thickness
set            tf_Beam12_3 17.30;#Flange thickness
set             r_Beam12_3 12.70;#Radius at the k-area
set             A_Beam12_3 14438.13;#Cross-sectional area
set            Ix_Beam12_3 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam12_3 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam12_3 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam12_3 48.71;#Radius of gyration about weak axis
set             J_Beam12_3 1055073.25;#Torsion constant
set   K_mem_canti_Beam12_3 195834019956.84;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_3 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam12_3 0.00636;#Yield chord rotation 
set         a_mem_Beam12_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_3 1370338759.68;#Capping moment
set   Theta_p_mem_Beam12_3 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_3 0.10784;#Post-capping plastic chord rotation
set       Res_mem_Beam12_3 0.40;#Residual moment
set      Mres_mem_Beam12_3 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_3 0.03294;#Post-yielding stiffness ratio
set           K_s_Beam12_3 2154174219525.28;#Initial stiffness of the spring
set          My_s_Beam12_3 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam12_3 0.00309;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_3 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_3 0.11420;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_3 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam12_3 2739.00;#Effective canti-lever length
set            Lb_Beam12_3 5478.00;#Unbraced length
set        Lambda_Beam12_3 0.80982;#

# Beam at SPAN-2 and FLOOR-3;
set             d_Beam23_3 607.00;#Depth
set            bf_Beam23_3 228.00;#Flange width
set            tw_Beam23_3 11.20;#Web thickness
set            tf_Beam23_3 17.30;#Flange thickness
set             r_Beam23_3 12.70;#Radius at the k-area
set             A_Beam23_3 14438.13;#Cross-sectional area
set            Ix_Beam23_3 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam23_3 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam23_3 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam23_3 48.71;#Radius of gyration about weak axis
set             J_Beam23_3 1055073.25;#Torsion constant
set   K_mem_canti_Beam23_3 195923433718.12;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_3 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam23_3 0.00636;#Yield chord rotation 
set         a_mem_Beam23_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_3 1370338759.68;#Capping moment
set   Theta_p_mem_Beam23_3 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_3 0.10785;#Post-capping plastic chord rotation
set       Res_mem_Beam23_3 0.40;#Residual moment
set      Mres_mem_Beam23_3 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_3 0.03293;#Post-yielding stiffness ratio
set           K_s_Beam23_3 2155157770899.37;#Initial stiffness of the spring
set          My_s_Beam23_3 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam23_3 0.00309;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_3 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_3 0.11421;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_3 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam23_3 2737.75;#Effective canti-lever length
set            Lb_Beam23_3 5475.50;#Unbraced length
set        Lambda_Beam23_3 0.80987;#

# Beam at SPAN-3 and FLOOR-3;
set             d_Beam34_3 607.00;#Depth
set            bf_Beam34_3 228.00;#Flange width
set            tw_Beam34_3 11.20;#Web thickness
set            tf_Beam34_3 17.30;#Flange thickness
set             r_Beam34_3 12.70;#Radius at the k-area
set             A_Beam34_3 14438.13;#Cross-sectional area
set            Ix_Beam34_3 872177854.73;#Second moment of inertia about strong axis
set            Zx_Beam34_3 3282641.66;#Plastic section modulus abotu strong axis
set            Iy_Beam34_3 34251152.46;#Second moment of inertia about weak axis
set            ry_Beam34_3 48.71;#Radius of gyration about weak axis
set             J_Beam34_3 1055073.25;#Torsion constant
set   K_mem_canti_Beam34_3 196012929165.65;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam34_3 1245762508.80;#Yield moment based on AISC
set   Theta_y_mem_Beam34_3 0.00636;#Yield chord rotation 
set         a_mem_Beam34_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam34_3 1370338759.68;#Capping moment
set   Theta_p_mem_Beam34_3 0.01931;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam34_3 0.10785;#Post-capping plastic chord rotation
set       Res_mem_Beam34_3 0.40;#Residual moment
set      Mres_mem_Beam34_3 498305003.52020;#Residual moment / Yield moment
set Theta_ult_mem_Beam34_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam34_3 0.03291;#Post-yielding stiffness ratio
set           K_s_Beam34_3 2156142220822.13;#Initial stiffness of the spring
set          My_s_Beam34_3 1245762508.80;#Yield moment of the spring
set       Alpha_s_Beam34_3 0.00308;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam34_3 0.01873;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam34_3 0.11421;#Post-capping plastic rotation of the spring
set         Res_s_Beam34_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam34_3 0.19769;#Ultimate rotation of the spring
set        Lcanti_Beam34_3 2736.50;#Effective canti-lever length
set            Lb_Beam34_3 5473.00;#Unbraced length
set        Lambda_Beam34_3 0.80992;#

# Beam at SPAN-1 and FLOOR-4;
set             d_Beam12_4 462.00;#Depth
set            bf_Beam12_4 192.00;#Flange width
set            tw_Beam12_4 10.50;#Web thickness
set            tf_Beam12_4 17.70;#Flange thickness
set             r_Beam12_4 10.30;#Radius at the k-area
set             A_Beam12_4 11367.17;#Cross-sectional area
set            Ix_Beam12_4 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam12_4 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam12_4 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam12_4 42.91;#Radius of gyration about weak axis
set             J_Beam12_4 874404.10;#Torsion constant
set   K_mem_canti_Beam12_4 91559705855.70;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_4 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam12_4 0.00832;#Yield chord rotation 
set         a_mem_Beam12_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_4 837756065.34;#Capping moment
set   Theta_p_mem_Beam12_4 0.03674;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_4 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam12_4 0.40;#Residual moment
set      Mres_mem_Beam12_4 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_4 0.02264;#Post-yielding stiffness ratio
set           K_s_Beam12_4 1007156764412.72;#Initial stiffness of the spring
set          My_s_Beam12_4 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam12_4 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_4 0.03599;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_4 0.20847;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_4 0.19698;#Ultimate rotation of the spring
set        Lcanti_Beam12_4 2737.75;#Effective canti-lever length
set            Lb_Beam12_4 5475.50;#Unbraced length
set        Lambda_Beam12_4 1.36500;#

# Beam at SPAN-2 and FLOOR-4;
set             d_Beam23_4 462.00;#Depth
set            bf_Beam23_4 192.00;#Flange width
set            tw_Beam23_4 10.50;#Web thickness
set            tf_Beam23_4 17.70;#Flange thickness
set             r_Beam23_4 10.30;#Radius at the k-area
set             A_Beam23_4 11367.17;#Cross-sectional area
set            Ix_Beam23_4 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam23_4 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam23_4 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam23_4 42.91;#Radius of gyration about weak axis
set             J_Beam23_4 874404.10;#Torsion constant
set   K_mem_canti_Beam23_4 91517920666.83;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_4 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam23_4 0.00832;#Yield chord rotation 
set         a_mem_Beam23_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_4 837756065.34;#Capping moment
set   Theta_p_mem_Beam23_4 0.03675;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_4 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam23_4 0.40;#Residual moment
set      Mres_mem_Beam23_4 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_4 0.02264;#Post-yielding stiffness ratio
set           K_s_Beam23_4 1006697127335.13;#Initial stiffness of the spring
set          My_s_Beam23_4 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam23_4 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_4 0.03599;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_4 0.20847;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_4 0.19697;#Ultimate rotation of the spring
set        Lcanti_Beam23_4 2739.00;#Effective canti-lever length
set            Lb_Beam23_4 5478.00;#Unbraced length
set        Lambda_Beam23_4 1.36500;#

# Beam at SPAN-3 and FLOOR-4;
set             d_Beam34_4 462.00;#Depth
set            bf_Beam34_4 192.00;#Flange width
set            tw_Beam34_4 10.50;#Web thickness
set            tf_Beam34_4 17.70;#Flange thickness
set             r_Beam34_4 10.30;#Radius at the k-area
set             A_Beam34_4 11367.17;#Cross-sectional area
set            Ix_Beam34_4 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam34_4 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam34_4 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam34_4 42.91;#Radius of gyration about weak axis
set             J_Beam34_4 874404.10;#Torsion constant
set   K_mem_canti_Beam34_4 91559705855.70;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam34_4 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam34_4 0.00832;#Yield chord rotation 
set         a_mem_Beam34_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam34_4 837756065.34;#Capping moment
set   Theta_p_mem_Beam34_4 0.03674;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam34_4 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam34_4 0.40;#Residual moment
set      Mres_mem_Beam34_4 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam34_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam34_4 0.02264;#Post-yielding stiffness ratio
set           K_s_Beam34_4 1007156764412.72;#Initial stiffness of the spring
set          My_s_Beam34_4 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam34_4 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam34_4 0.03599;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam34_4 0.20847;#Post-capping plastic rotation of the spring
set         Res_s_Beam34_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam34_4 0.19698;#Ultimate rotation of the spring
set        Lcanti_Beam34_4 2737.75;#Effective canti-lever length
set            Lb_Beam34_4 5475.50;#Unbraced length
set        Lambda_Beam34_4 1.36500;#

# Beam at SPAN-1 and FLOOR-5;
set             d_Beam12_5 462.00;#Depth
set            bf_Beam12_5 192.00;#Flange width
set            tw_Beam12_5 10.50;#Web thickness
set            tf_Beam12_5 17.70;#Flange thickness
set             r_Beam12_5 10.30;#Radius at the k-area
set             A_Beam12_5 11367.17;#Cross-sectional area
set            Ix_Beam12_5 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam12_5 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam12_5 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam12_5 42.91;#Radius of gyration about weak axis
set             J_Beam12_5 874404.10;#Torsion constant
set   K_mem_canti_Beam12_5 91601529218.51;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam12_5 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam12_5 0.00831;#Yield chord rotation 
set         a_mem_Beam12_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam12_5 837756065.34;#Capping moment
set   Theta_p_mem_Beam12_5 0.03674;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam12_5 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam12_5 0.40;#Residual moment
set      Mres_mem_Beam12_5 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam12_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam12_5 0.02263;#Post-yielding stiffness ratio
set           K_s_Beam12_5 1007616821403.59;#Initial stiffness of the spring
set          My_s_Beam12_5 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam12_5 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam12_5 0.03598;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam12_5 0.20846;#Post-capping plastic rotation of the spring
set         Res_s_Beam12_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam12_5 0.19698;#Ultimate rotation of the spring
set        Lcanti_Beam12_5 2736.50;#Effective canti-lever length
set            Lb_Beam12_5 5473.00;#Unbraced length
set        Lambda_Beam12_5 1.36500;#

# Beam at SPAN-2 and FLOOR-5;
set             d_Beam23_5 462.00;#Depth
set            bf_Beam23_5 192.00;#Flange width
set            tw_Beam23_5 10.50;#Web thickness
set            tf_Beam23_5 17.70;#Flange thickness
set             r_Beam23_5 10.30;#Radius at the k-area
set             A_Beam23_5 11367.17;#Cross-sectional area
set            Ix_Beam23_5 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam23_5 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam23_5 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam23_5 42.91;#Radius of gyration about weak axis
set             J_Beam23_5 874404.10;#Torsion constant
set   K_mem_canti_Beam23_5 91559705855.70;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam23_5 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam23_5 0.00832;#Yield chord rotation 
set         a_mem_Beam23_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam23_5 837756065.34;#Capping moment
set   Theta_p_mem_Beam23_5 0.03674;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam23_5 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam23_5 0.40;#Residual moment
set      Mres_mem_Beam23_5 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam23_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam23_5 0.02264;#Post-yielding stiffness ratio
set           K_s_Beam23_5 1007156764412.72;#Initial stiffness of the spring
set          My_s_Beam23_5 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam23_5 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam23_5 0.03599;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam23_5 0.20847;#Post-capping plastic rotation of the spring
set         Res_s_Beam23_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam23_5 0.19698;#Ultimate rotation of the spring
set        Lcanti_Beam23_5 2737.75;#Effective canti-lever length
set            Lb_Beam23_5 5475.50;#Unbraced length
set        Lambda_Beam23_5 1.36500;#

# Beam at SPAN-3 and FLOOR-5;
set             d_Beam34_5 462.00;#Depth
set            bf_Beam34_5 192.00;#Flange width
set            tw_Beam34_5 10.50;#Web thickness
set            tf_Beam34_5 17.70;#Flange thickness
set             r_Beam34_5 10.30;#Radius at the k-area
set             A_Beam34_5 11367.17;#Cross-sectional area
set            Ix_Beam34_5 407589568.63;#Second moment of inertia about strong axis
set            Zx_Beam34_5 2006841.69;#Plastic section modulus abotu strong axis
set            Iy_Beam34_5 20926115.66;#Second moment of inertia about weak axis
set            ry_Beam34_5 42.91;#Radius of gyration about weak axis
set             J_Beam34_5 874404.10;#Torsion constant
set   K_mem_canti_Beam34_5 91392793621.89;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam34_5 761596423.03;#Yield moment based on AISC
set   Theta_y_mem_Beam34_5 0.00833;#Yield chord rotation 
set         a_mem_Beam34_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam34_5 837756065.34;#Capping moment
set   Theta_p_mem_Beam34_5 0.03677;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam34_5 0.20015;#Post-capping plastic chord rotation
set       Res_mem_Beam34_5 0.40;#Residual moment
set      Mres_mem_Beam34_5 304638569.21399;#Residual moment / Yield moment
set Theta_ult_mem_Beam34_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam34_5 0.02266;#Post-yielding stiffness ratio
set           K_s_Beam34_5 1005320729840.83;#Initial stiffness of the spring
set          My_s_Beam34_5 761596423.03;#Yield moment of the spring
set       Alpha_s_Beam34_5 0.00210;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam34_5 0.03601;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam34_5 0.20848;#Post-capping plastic rotation of the spring
set         Res_s_Beam34_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam34_5 0.19697;#Ultimate rotation of the spring
set        Lcanti_Beam34_5 2742.75;#Effective canti-lever length
set            Lb_Beam34_5 5485.50;#Unbraced length
set        Lambda_Beam34_5 1.36500;#

# Panel zone at FLOOR-2 and AXIS-1;
set             KfKe2_1 0.00452;#Kf/Ke
set    Gamma_1_Panel2_1 0.00248;#Yield distorsion angle
set    Gamma_4_Panel2_1 0.00993;#Ultimate distorsion angle
set    Gamma_6_Panel2_1 0.01490;#3rd distorsion angle
set         M1_Panel2_1 1267900049.84;#Yield moment of the panel
set         M4_Panel2_1 1583751724.27;#Ultimate moment of the panel
set         M6_Panel2_1 1680657172.11;#3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-2;
set             KfKe2_2 0.00456;#Kf/Ke
set    Gamma_1_Panel2_2 0.00252;#Yield distorsion angle
set    Gamma_4_Panel2_2 0.01009;#Ultimate distorsion angle
set    Gamma_6_Panel2_2 0.01513;#3rd distorsion angle
set         M1_Panel2_2 2516353382.55;#Yield moment of the panel
set         M4_Panel2_2 3143577901.84;#Ultimate moment of the panel
set         M6_Panel2_2 3335740889.50;#3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-3;
set             KfKe2_3 0.00456;#Kf/Ke
set    Gamma_1_Panel2_3 0.00252;#Yield distorsion angle
set    Gamma_4_Panel2_3 0.01009;#Ultimate distorsion angle
set    Gamma_6_Panel2_3 0.01513;#3rd distorsion angle
set         M1_Panel2_3 2516353382.55;#Yield moment of the panel
set         M4_Panel2_3 3143577901.84;#Ultimate moment of the panel
set         M6_Panel2_3 3335740889.50;#3rd moment of the panel

# Panel zone at FLOOR-2 and AXIS-4;
set             KfKe2_4 0.00452;#Kf/Ke
set    Gamma_1_Panel2_4 0.00248;#Yield distorsion angle
set    Gamma_4_Panel2_4 0.00993;#Ultimate distorsion angle
set    Gamma_6_Panel2_4 0.01490;#3rd distorsion angle
set         M1_Panel2_4 1267900049.84;#Yield moment of the panel
set         M4_Panel2_4 1583751724.27;#Ultimate moment of the panel
set         M6_Panel2_4 1680657172.11;#3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-1;
set             KfKe3_1 0.00452;#Kf/Ke
set    Gamma_1_Panel3_1 0.00248;#Yield distorsion angle
set    Gamma_4_Panel3_1 0.00993;#Ultimate distorsion angle
set    Gamma_6_Panel3_1 0.01490;#3rd distorsion angle
set         M1_Panel3_1 1267900049.84;#Yield moment of the panel
set         M4_Panel3_1 1583751724.27;#Ultimate moment of the panel
set         M6_Panel3_1 1680657172.11;#3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-2;
set             KfKe3_2 0.00456;#Kf/Ke
set    Gamma_1_Panel3_2 0.00252;#Yield distorsion angle
set    Gamma_4_Panel3_2 0.01009;#Ultimate distorsion angle
set    Gamma_6_Panel3_2 0.01513;#3rd distorsion angle
set         M1_Panel3_2 2516353382.55;#Yield moment of the panel
set         M4_Panel3_2 3143577901.84;#Ultimate moment of the panel
set         M6_Panel3_2 3335740889.50;#3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-3;
set             KfKe3_3 0.00456;#Kf/Ke
set    Gamma_1_Panel3_3 0.00252;#Yield distorsion angle
set    Gamma_4_Panel3_3 0.01009;#Ultimate distorsion angle
set    Gamma_6_Panel3_3 0.01513;#3rd distorsion angle
set         M1_Panel3_3 2516353382.55;#Yield moment of the panel
set         M4_Panel3_3 3143577901.84;#Ultimate moment of the panel
set         M6_Panel3_3 3335740889.50;#3rd moment of the panel

# Panel zone at FLOOR-3 and AXIS-4;
set             KfKe3_4 0.00452;#Kf/Ke
set    Gamma_1_Panel3_4 0.00248;#Yield distorsion angle
set    Gamma_4_Panel3_4 0.00993;#Ultimate distorsion angle
set    Gamma_6_Panel3_4 0.01490;#3rd distorsion angle
set         M1_Panel3_4 1267900049.84;#Yield moment of the panel
set         M4_Panel3_4 1583751724.27;#Ultimate moment of the panel
set         M6_Panel3_4 1680657172.11;#3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-1;
set             KfKe4_1 0.00291;#Kf/Ke
set    Gamma_1_Panel4_1 0.00236;#Yield distorsion angle
set    Gamma_4_Panel4_1 0.00944;#Ultimate distorsion angle
set    Gamma_6_Panel4_1 0.01416;#3rd distorsion angle
set         M1_Panel4_1 812621169.04;#Yield moment of the panel
set         M4_Panel4_1 1015444536.14;#Ultimate moment of the panel
set         M6_Panel4_1 1074977346.70;#3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-2;
set             KfKe4_2 0.00220;#Kf/Ke
set    Gamma_1_Panel4_2 0.00237;#Yield distorsion angle
set    Gamma_4_Panel4_2 0.00948;#Ultimate distorsion angle
set    Gamma_6_Panel4_2 0.01423;#3rd distorsion angle
set         M1_Panel4_2 1581895531.44;#Yield moment of the panel
set         M4_Panel4_2 1976992840.00;#Ultimate moment of the panel
set         M6_Panel4_2 2093281093.36;#3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-3;
set             KfKe4_3 0.00220;#Kf/Ke
set    Gamma_1_Panel4_3 0.00237;#Yield distorsion angle
set    Gamma_4_Panel4_3 0.00948;#Ultimate distorsion angle
set    Gamma_6_Panel4_3 0.01423;#3rd distorsion angle
set         M1_Panel4_3 1581895531.44;#Yield moment of the panel
set         M4_Panel4_3 1976992840.00;#Ultimate moment of the panel
set         M6_Panel4_3 2093281093.36;#3rd moment of the panel

# Panel zone at FLOOR-4 and AXIS-4;
set             KfKe4_4 0.00291;#Kf/Ke
set    Gamma_1_Panel4_4 0.00236;#Yield distorsion angle
set    Gamma_4_Panel4_4 0.00944;#Ultimate distorsion angle
set    Gamma_6_Panel4_4 0.01416;#3rd distorsion angle
set         M1_Panel4_4 812621169.04;#Yield moment of the panel
set         M4_Panel4_4 1015444536.14;#Ultimate moment of the panel
set         M6_Panel4_4 1074977346.70;#3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-1;
set             KfKe5_1 0.00297;#Kf/Ke
set    Gamma_1_Panel5_1 0.00240;#Yield distorsion angle
set    Gamma_4_Panel5_1 0.00962;#Ultimate distorsion angle
set    Gamma_6_Panel5_1 0.01443;#3rd distorsion angle
set         M1_Panel5_1 812621169.04;#Yield moment of the panel
set         M4_Panel5_1 1015444536.14;#Ultimate moment of the panel
set         M6_Panel5_1 1074977346.70;#3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-2;
set             KfKe5_2 0.00228;#Kf/Ke
set    Gamma_1_Panel5_2 0.00247;#Yield distorsion angle
set    Gamma_4_Panel5_2 0.00986;#Ultimate distorsion angle
set    Gamma_6_Panel5_2 0.01479;#3rd distorsion angle
set         M1_Panel5_2 1581895531.44;#Yield moment of the panel
set         M4_Panel5_2 1976992840.00;#Ultimate moment of the panel
set         M6_Panel5_2 2093281093.36;#3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-3;
set             KfKe5_3 0.00228;#Kf/Ke
set    Gamma_1_Panel5_3 0.00247;#Yield distorsion angle
set    Gamma_4_Panel5_3 0.00986;#Ultimate distorsion angle
set    Gamma_6_Panel5_3 0.01479;#3rd distorsion angle
set         M1_Panel5_3 1581895531.44;#Yield moment of the panel
set         M4_Panel5_3 1976992840.00;#Ultimate moment of the panel
set         M6_Panel5_3 2093281093.36;#3rd moment of the panel

# Panel zone at FLOOR-5 and AXIS-4;
set             KfKe5_4 0.00297;#Kf/Ke
set    Gamma_1_Panel5_4 0.00240;#Yield distorsion angle
set    Gamma_4_Panel5_4 0.00962;#Ultimate distorsion angle
set    Gamma_6_Panel5_4 0.01443;#3rd distorsion angle
set         M1_Panel5_4 812621169.04;#Yield moment of the panel
set         M4_Panel5_4 1015444536.14;#Ultimate moment of the panel
set         M6_Panel5_4 1074977346.70;#3rd moment of the panel

# Floor 1 MRF Column Bases;
node 1103 [expr $Axis1] [expr $Floor1] 0 ;
fix  1103 1 1 1 1 1 1;

node 1203 [expr $Axis2] [expr $Floor1] 0 ;
fix  1203 1 1 1 1 1 1;

node 1303 [expr $Axis3] [expr $Floor1] 0 ;
fix  1303 1 1 1 1 1 1;

node 1403 [expr $Axis4] [expr $Floor1] 0 ;
fix  1403 1 1 1 1 1 1;


# Panel zone ;
# AXIS-1, FLOOR-2;
node 2101  [expr $Axis1                                  ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom middle ;
node 2105  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom left ;
node 2106  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom left ;
node 2112  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom right ;
node 2111  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom right;
node 2102  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2                  ]  0;# middle left  ;
node 2104  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2                  ]  0;# middle right ;
node 2107  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top left  ;
node 2108  [expr $Axis1-$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top left;
node 2109  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top right;
node 2110  [expr $Axis1+$d_Col12_1_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top right;
node 2103  [expr $Axis1                                  ] [expr $Floor2+$d_Beam12_2/2.]  0;# top middle;
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
node 214   [expr $Axis1+$d_Col12_1_t/2.+$H_offset               ] [expr $Floor2               ]  0;# WUF-Wright;
fix 214   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;


# AXIS-1, FLOOR-3;
node 3101  [expr $Axis1                                  ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom middle ;
node 3105  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom left ;
node 3106  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom left ;
node 3112  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom right ;
node 3111  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom right;
node 3102  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3                  ]  0;# middle left  ;
node 3104  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3                  ]  0;# middle right ;
node 3107  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top left  ;
node 3108  [expr $Axis1-$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top left;
node 3109  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top right;
node 3110  [expr $Axis1+$d_Col23_1_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top right;
node 3103  [expr $Axis1                                  ] [expr $Floor3+$d_Beam12_3/2.]  0;# top middle;
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
node 314   [expr $Axis1+$d_Col23_1_t/2.+$H_offset               ] [expr $Floor3               ]  0;# WUF-Wright;
fix 314   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;


# AXIS-1, FLOOR-4;
node 4101  [expr $Axis1                                  ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom middle ;
node 4105  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom left ;
node 4106  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom left ;
node 4112  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom right ;
node 4111  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom right;
node 4102  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4                  ]  0;# middle left  ;
node 4104  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4                  ]  0;# middle right ;
node 4107  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top left  ;
node 4108  [expr $Axis1-$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top left;
node 4109  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top right;
node 4110  [expr $Axis1+$d_Col34_1_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top right;
node 4103  [expr $Axis1                                  ] [expr $Floor4+$d_Beam12_4/2.]  0;# top middle;
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
node 414   [expr $Axis1+$d_Col34_1_t/2.+$H_offset               ] [expr $Floor4               ]  0;# WUF-Wright;
fix 414   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;


# AXIS-1, FLOOR-5;
node 5101  [expr $Axis1                                  ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom middle ;
node 5105  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom left ;
node 5106  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom left ;
node 5112  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom right ;
node 5111  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom right;
node 5102  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5                  ]  0;# middle left  ;
node 5104  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5                  ]  0;# middle right ;
node 5107  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top left  ;
node 5108  [expr $Axis1-$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top left;
node 5109  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top right;
node 5110  [expr $Axis1+$d_Col45_1_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top right;
node 5103  [expr $Axis1                                  ] [expr $Floor5+$d_Beam12_5/2.]  0;# top middle;
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
node 514   [expr $Axis1+$d_Col45_1_t/2.+$H_offset               ] [expr $Floor5               ]  0;# WUF-Wright;
fix 514   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;


#AXIS-2, FLOOR-2;
node 2201  [expr $Axis2                               ] [expr $Floor2-$d_Beam12_2/2.] 0;# bottom middle  ;
node 2205  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom left    ;
node 2206  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom left    ;
node 2212  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.] 0;# bottom right   ;
node 2211  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2-$d_Beam12_2/2.]  0;# bottom right   ;
node 2202  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2               ]  0;# middle left    ;
node 2204  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2               ] 0;# middle right   ;
node 2207  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.] 0;# top left       ;
node 2208  [expr $Axis2-$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top left       ;
node 2209  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top right      ;
node 2210  [expr $Axis2+$d_Col12_2_t/2.               ] [expr $Floor2+$d_Beam12_2/2.]  0;# top right      ;
node 2203  [expr $Axis2                               ] [expr $Floor2+$d_Beam12_2/2.] 0;# top middle     ;
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
node 222   [expr $Axis2-$d_Col12_2_t/2.-$H_offset               ] [expr $Floor2               ]  0;# WUF-Wleft ;
fix 222   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 224   [expr $Axis2+$d_Col12_2_t/2.+$H_offset               ] [expr $Floor2               ] 0;# WUF-Wright;
fix 224   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-2, FLOOR-3;
node 3201  [expr $Axis2                               ] [expr $Floor3-$d_Beam12_3/2.] 0;# bottom middle  ;
node 3205  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom left    ;
node 3206  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom left    ;
node 3212  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.] 0;# bottom right   ;
node 3211  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3-$d_Beam12_3/2.]  0;# bottom right   ;
node 3202  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3               ]  0;# middle left    ;
node 3204  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3               ] 0;# middle right   ;
node 3207  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.] 0;# top left       ;
node 3208  [expr $Axis2-$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top left       ;
node 3209  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top right      ;
node 3210  [expr $Axis2+$d_Col23_2_t/2.               ] [expr $Floor3+$d_Beam12_3/2.]  0;# top right      ;
node 3203  [expr $Axis2                               ] [expr $Floor3+$d_Beam12_3/2.] 0;# top middle     ;
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
node 322   [expr $Axis2-$d_Col23_2_t/2.-$H_offset               ] [expr $Floor3               ]  0;# WUF-Wleft ;
fix 322   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 324   [expr $Axis2+$d_Col23_2_t/2.+$H_offset               ] [expr $Floor3               ] 0;# WUF-Wright;
fix 324   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-2, FLOOR-4;
node 4201  [expr $Axis2                               ] [expr $Floor4-$d_Beam12_4/2.] 0;# bottom middle  ;
node 4205  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom left    ;
node 4206  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom left    ;
node 4212  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.] 0;# bottom right   ;
node 4211  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4-$d_Beam12_4/2.]  0;# bottom right   ;
node 4202  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4               ]  0;# middle left    ;
node 4204  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4               ] 0;# middle right   ;
node 4207  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.] 0;# top left       ;
node 4208  [expr $Axis2-$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top left       ;
node 4209  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top right      ;
node 4210  [expr $Axis2+$d_Col34_2_t/2.               ] [expr $Floor4+$d_Beam12_4/2.]  0;# top right      ;
node 4203  [expr $Axis2                               ] [expr $Floor4+$d_Beam12_4/2.] 0;# top middle     ;
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
node 422   [expr $Axis2-$d_Col34_2_t/2.-$H_offset               ] [expr $Floor4               ]  0;# WUF-Wleft ;
fix 422   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 424   [expr $Axis2+$d_Col34_2_t/2.+$H_offset               ] [expr $Floor4               ] 0;# WUF-Wright;
fix 424   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-2, FLOOR-5;
node 5201  [expr $Axis2                               ] [expr $Floor5-$d_Beam12_5/2.] 0;# bottom middle  ;
node 5205  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom left    ;
node 5206  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom left    ;
node 5212  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.] 0;# bottom right   ;
node 5211  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5-$d_Beam12_5/2.]  0;# bottom right   ;
node 5202  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5               ]  0;# middle left    ;
node 5204  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5               ] 0;# middle right   ;
node 5207  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.] 0;# top left       ;
node 5208  [expr $Axis2-$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top left       ;
node 5209  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top right      ;
node 5210  [expr $Axis2+$d_Col45_2_t/2.               ] [expr $Floor5+$d_Beam12_5/2.]  0;# top right      ;
node 5203  [expr $Axis2                               ] [expr $Floor5+$d_Beam12_5/2.] 0;# top middle     ;
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
node 522   [expr $Axis2-$d_Col45_2_t/2.-$H_offset               ] [expr $Floor5               ]  0;# WUF-Wleft ;
fix 522   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 524   [expr $Axis2+$d_Col45_2_t/2.+$H_offset               ] [expr $Floor5               ] 0;# WUF-Wright;
fix 524   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-3, FLOOR-2;
node 2301  [expr $Axis3                               ] [expr $Floor2-$d_Beam23_2/2.] 0;# bottom middle  ;
node 2305  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.]  0;# bottom left    ;
node 2306  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.]  0;# bottom left    ;
node 2312  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.] 0;# bottom right   ;
node 2311  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2-$d_Beam23_2/2.]  0;# bottom right   ;
node 2302  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2               ]  0;# middle left    ;
node 2304  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2               ] 0;# middle right   ;
node 2307  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.] 0;# top left       ;
node 2308  [expr $Axis3-$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.]  0;# top left       ;
node 2309  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.]  0;# top right      ;
node 2310  [expr $Axis3+$d_Col12_3_t/2.               ] [expr $Floor2+$d_Beam23_2/2.]  0;# top right      ;
node 2303  [expr $Axis3                               ] [expr $Floor2+$d_Beam23_2/2.] 0;# top middle     ;
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
node 232   [expr $Axis3-$d_Col12_3_t/2.-$H_offset               ] [expr $Floor2               ]  0;# WUF-Wleft ;
fix 232   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 234   [expr $Axis3+$d_Col12_3_t/2.+$H_offset               ] [expr $Floor2               ] 0;# WUF-Wright;
fix 234   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-3, FLOOR-3;
node 3301  [expr $Axis3                               ] [expr $Floor3-$d_Beam23_3/2.] 0;# bottom middle  ;
node 3305  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.]  0;# bottom left    ;
node 3306  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.]  0;# bottom left    ;
node 3312  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.] 0;# bottom right   ;
node 3311  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3-$d_Beam23_3/2.]  0;# bottom right   ;
node 3302  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3               ]  0;# middle left    ;
node 3304  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3               ] 0;# middle right   ;
node 3307  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.] 0;# top left       ;
node 3308  [expr $Axis3-$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.]  0;# top left       ;
node 3309  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.]  0;# top right      ;
node 3310  [expr $Axis3+$d_Col23_3_t/2.               ] [expr $Floor3+$d_Beam23_3/2.]  0;# top right      ;
node 3303  [expr $Axis3                               ] [expr $Floor3+$d_Beam23_3/2.] 0;# top middle     ;
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
node 332   [expr $Axis3-$d_Col23_3_t/2.-$H_offset               ] [expr $Floor3               ]  0;# WUF-Wleft ;
fix 332   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 334   [expr $Axis3+$d_Col23_3_t/2.+$H_offset               ] [expr $Floor3               ] 0;# WUF-Wright;
fix 334   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-3, FLOOR-4;
node 4301  [expr $Axis3                               ] [expr $Floor4-$d_Beam23_4/2.] 0;# bottom middle  ;
node 4305  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.]  0;# bottom left    ;
node 4306  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.]  0;# bottom left    ;
node 4312  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.] 0;# bottom right   ;
node 4311  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4-$d_Beam23_4/2.]  0;# bottom right   ;
node 4302  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4               ]  0;# middle left    ;
node 4304  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4               ] 0;# middle right   ;
node 4307  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.] 0;# top left       ;
node 4308  [expr $Axis3-$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.]  0;# top left       ;
node 4309  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.]  0;# top right      ;
node 4310  [expr $Axis3+$d_Col34_3_t/2.               ] [expr $Floor4+$d_Beam23_4/2.]  0;# top right      ;
node 4303  [expr $Axis3                               ] [expr $Floor4+$d_Beam23_4/2.] 0;# top middle     ;
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
node 432   [expr $Axis3-$d_Col34_3_t/2.-$H_offset               ] [expr $Floor4               ]  0;# WUF-Wleft ;
fix 432   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 434   [expr $Axis3+$d_Col34_3_t/2.+$H_offset               ] [expr $Floor4               ] 0;# WUF-Wright;
fix 434   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-3, FLOOR-5;
node 5301  [expr $Axis3                               ] [expr $Floor5-$d_Beam23_5/2.] 0;# bottom middle  ;
node 5305  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.]  0;# bottom left    ;
node 5306  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.]  0;# bottom left    ;
node 5312  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.] 0;# bottom right   ;
node 5311  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5-$d_Beam23_5/2.]  0;# bottom right   ;
node 5302  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5               ]  0;# middle left    ;
node 5304  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5               ] 0;# middle right   ;
node 5307  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.] 0;# top left       ;
node 5308  [expr $Axis3-$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.]  0;# top left       ;
node 5309  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.]  0;# top right      ;
node 5310  [expr $Axis3+$d_Col45_3_t/2.               ] [expr $Floor5+$d_Beam23_5/2.]  0;# top right      ;
node 5303  [expr $Axis3                               ] [expr $Floor5+$d_Beam23_5/2.] 0;# top middle     ;
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
node 532   [expr $Axis3-$d_Col45_3_t/2.-$H_offset               ] [expr $Floor5               ]  0;# WUF-Wleft ;
fix 532   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;
node 534   [expr $Axis3+$d_Col45_3_t/2.+$H_offset               ] [expr $Floor5               ] 0;# WUF-Wright;
fix 534   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

#AXIS-4, FLOOR-2;
node 2401  [expr $Axis4                               ] [expr $Floor2-$d_Beam34_2/2.] 0;# bottom middle  ;
node 2405  [expr $Axis4-$d_Col12_4_t/2.               ] [expr $Floor2-$d_Beam34_2/2.]  0;# bottom left    ;
node 2406  [expr $Axis4-$d_Col12_4_t/2.               ] [expr $Floor2-$d_Beam34_2/2.]  0;# bottom left    ;
node 2412  [expr $Axis4+$d_Col12_4_t/2.               ] [expr $Floor2-$d_Beam34_2/2.] 0;# bottom right   ;
node 2411  [expr $Axis4+$d_Col12_4_t/2.               ] [expr $Floor2-$d_Beam34_2/2.]  0;# bottom right   ;
node 2402  [expr $Axis4-$d_Col12_4_t/2.               ] [expr $Floor2               ]  0;# middle left    ;
node 2404  [expr $Axis4+$d_Col12_4_t/2.               ] [expr $Floor2               ] 0;# middle right   ;
node 2407  [expr $Axis4-$d_Col12_4_t/2.               ] [expr $Floor2+$d_Beam34_2/2.] 0;# top left       ;
node 2408  [expr $Axis4-$d_Col12_4_t/2.               ] [expr $Floor2+$d_Beam34_2/2.]  0;# top left       ;
node 2409  [expr $Axis4+$d_Col12_4_t/2.               ] [expr $Floor2+$d_Beam34_2/2.]  0;# top right      ;
node 2410  [expr $Axis4+$d_Col12_4_t/2.               ] [expr $Floor2+$d_Beam34_2/2.]  0;# top right      ;
node 2403  [expr $Axis4                               ] [expr $Floor2+$d_Beam34_2/2.] 0;# top middle     ;
fix 2401  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 2405  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2406  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2412  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2411  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2402  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 2404  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 2407  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2408  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 2409  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2410  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 2403  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 242   [expr $Axis4-$d_Col12_4_t/2.-$H_offset               ] [expr $Floor2               ]  0;# WUF-Wleft ;
fix 242   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;

#AXIS-4, FLOOR-3;
node 3401  [expr $Axis4                               ] [expr $Floor3-$d_Beam34_3/2.] 0;# bottom middle  ;
node 3405  [expr $Axis4-$d_Col23_4_t/2.               ] [expr $Floor3-$d_Beam34_3/2.]  0;# bottom left    ;
node 3406  [expr $Axis4-$d_Col23_4_t/2.               ] [expr $Floor3-$d_Beam34_3/2.]  0;# bottom left    ;
node 3412  [expr $Axis4+$d_Col23_4_t/2.               ] [expr $Floor3-$d_Beam34_3/2.] 0;# bottom right   ;
node 3411  [expr $Axis4+$d_Col23_4_t/2.               ] [expr $Floor3-$d_Beam34_3/2.]  0;# bottom right   ;
node 3402  [expr $Axis4-$d_Col23_4_t/2.               ] [expr $Floor3               ]  0;# middle left    ;
node 3404  [expr $Axis4+$d_Col23_4_t/2.               ] [expr $Floor3               ] 0;# middle right   ;
node 3407  [expr $Axis4-$d_Col23_4_t/2.               ] [expr $Floor3+$d_Beam34_3/2.] 0;# top left       ;
node 3408  [expr $Axis4-$d_Col23_4_t/2.               ] [expr $Floor3+$d_Beam34_3/2.]  0;# top left       ;
node 3409  [expr $Axis4+$d_Col23_4_t/2.               ] [expr $Floor3+$d_Beam34_3/2.]  0;# top right      ;
node 3410  [expr $Axis4+$d_Col23_4_t/2.               ] [expr $Floor3+$d_Beam34_3/2.]  0;# top right      ;
node 3403  [expr $Axis4                               ] [expr $Floor3+$d_Beam34_3/2.] 0;# top middle     ;
fix 3401  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 3405  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3406  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3412  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3411  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3402  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 3404  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 3407  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3408  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 3409  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3410  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 3403  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 342   [expr $Axis4-$d_Col23_4_t/2.-$H_offset               ] [expr $Floor3               ]  0;# WUF-Wleft ;
fix 342   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;

#AXIS-4, FLOOR-4;
node 4401  [expr $Axis4                               ] [expr $Floor4-$d_Beam34_4/2.] 0;# bottom middle  ;
node 4405  [expr $Axis4-$d_Col34_4_t/2.               ] [expr $Floor4-$d_Beam34_4/2.]  0;# bottom left    ;
node 4406  [expr $Axis4-$d_Col34_4_t/2.               ] [expr $Floor4-$d_Beam34_4/2.]  0;# bottom left    ;
node 4412  [expr $Axis4+$d_Col34_4_t/2.               ] [expr $Floor4-$d_Beam34_4/2.] 0;# bottom right   ;
node 4411  [expr $Axis4+$d_Col34_4_t/2.               ] [expr $Floor4-$d_Beam34_4/2.]  0;# bottom right   ;
node 4402  [expr $Axis4-$d_Col34_4_t/2.               ] [expr $Floor4               ]  0;# middle left    ;
node 4404  [expr $Axis4+$d_Col34_4_t/2.               ] [expr $Floor4               ] 0;# middle right   ;
node 4407  [expr $Axis4-$d_Col34_4_t/2.               ] [expr $Floor4+$d_Beam34_4/2.] 0;# top left       ;
node 4408  [expr $Axis4-$d_Col34_4_t/2.               ] [expr $Floor4+$d_Beam34_4/2.]  0;# top left       ;
node 4409  [expr $Axis4+$d_Col34_4_t/2.               ] [expr $Floor4+$d_Beam34_4/2.]  0;# top right      ;
node 4410  [expr $Axis4+$d_Col34_4_t/2.               ] [expr $Floor4+$d_Beam34_4/2.]  0;# top right      ;
node 4403  [expr $Axis4                               ] [expr $Floor4+$d_Beam34_4/2.] 0;# top middle     ;
fix 4401  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 4405  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4406  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4412  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4411  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4402  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 4404  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 4407  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4408  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 4409  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4410  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 4403  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 442   [expr $Axis4-$d_Col34_4_t/2.-$H_offset               ] [expr $Floor4               ]  0;# WUF-Wleft ;
fix 442   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;

#AXIS-4, FLOOR-5;
node 5401  [expr $Axis4                               ] [expr $Floor5-$d_Beam34_5/2.] 0;# bottom middle  ;
node 5405  [expr $Axis4-$d_Col45_4_t/2.               ] [expr $Floor5-$d_Beam34_5/2.]  0;# bottom left    ;
node 5406  [expr $Axis4-$d_Col45_4_t/2.               ] [expr $Floor5-$d_Beam34_5/2.]  0;# bottom left    ;
node 5412  [expr $Axis4+$d_Col45_4_t/2.               ] [expr $Floor5-$d_Beam34_5/2.] 0;# bottom right   ;
node 5411  [expr $Axis4+$d_Col45_4_t/2.               ] [expr $Floor5-$d_Beam34_5/2.]  0;# bottom right   ;
node 5402  [expr $Axis4-$d_Col45_4_t/2.               ] [expr $Floor5               ]  0;# middle left    ;
node 5404  [expr $Axis4+$d_Col45_4_t/2.               ] [expr $Floor5               ] 0;# middle right   ;
node 5407  [expr $Axis4-$d_Col45_4_t/2.               ] [expr $Floor5+$d_Beam34_5/2.] 0;# top left       ;
node 5408  [expr $Axis4-$d_Col45_4_t/2.               ] [expr $Floor5+$d_Beam34_5/2.]  0;# top left       ;
node 5409  [expr $Axis4+$d_Col45_4_t/2.               ] [expr $Floor5+$d_Beam34_5/2.]  0;# top right      ;
node 5410  [expr $Axis4+$d_Col45_4_t/2.               ] [expr $Floor5+$d_Beam34_5/2.]  0;# top right      ;
node 5403  [expr $Axis4                               ] [expr $Floor5+$d_Beam34_5/2.] 0;# top middle     ;
fix 5401  0 0 1 1 1 0;# Constrains for out of plane movement in 3D  ;
fix 5405  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5406  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5412  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5411  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5402  0 0 1 1 1 0;# Constrains for out of plane movement in 3D    ;
fix 5404  0 0 1 1 1 0;# Constrains for out of plane movement in 3D   ;
fix 5407  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5408  0 0 1 1 1 0;# Constrains for out of plane movement in 3D       ;
fix 5409  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5410  0 0 1 1 1 0;# Constrains for out of plane movement in 3D      ;
fix 5403  0 0 1 1 1 0;# Constrains for out of plane movement in 3D     ;
node 542   [expr $Axis4-$d_Col45_4_t/2.-$H_offset               ] [expr $Floor5               ]  0;# WUF-Wleft ;
fix 542   0 0 1 1 1 0;# Constrains for out of plane movement in 3Dt ;


set K44_two 2.0625;
set K11_two 3.9375;
set K33_two 3.9375;
set K44_one 1.9355;
set K11_one 3.9375;
set K33_one 3.8710;

uniaxialMaterial Elastic 555 [expr 10009999.*$E];
uniaxialMaterial Elastic 556 [expr 10009999.*$E*1000.];
uniaxialMaterial Elastic 666 [expr 0.0001];
set A_pz_rigid 2774105.1336;
set I_pz_rigid 190063246091.5970;
set J_pz_flexible 0.00000001;

# FloorAxis = 21;
# Panel Rigid Link;
element elasticBeamColumn 1002101 2105 2101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002108 2101 2112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002107 2111 2104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002106 2104 2110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002105 2109 2103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002104 2103 2108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002103 2107 2102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002102 2106 2102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 2105 2106 1 2;
equalDOF 2112 2111 1 2;
equalDOF 2110 2109 1 2;
equalDOF 2107 2108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002100 $M1_Panel2_1 $Gamma_1_Panel2_1 $M4_Panel2_1 $Gamma_4_Panel2_1 $M6_Panel2_1 $Gamma_6_Panel2_1 -$M1_Panel2_1 -$Gamma_1_Panel2_1 -$M4_Panel2_1 -$Gamma_4_Panel2_1 -$M6_Panel2_1 -$Gamma_6_Panel2_1 0.25 0.75 0 0 0;
element zeroLength          1002100  2109 2110 -mat 1002100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 21400 $K_s_Beam12_2 $Alpha_s_Beam12_2 $Alpha_s_Beam12_2 $My_s_Beam12_2 -$My_s_Beam12_2  $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 1. 1. 1. 1.  $Theta_p_s_Beam12_2  $Theta_p_s_Beam12_2  $Theta_pc_s_Beam12_2  $Theta_pc_s_Beam12_2  $Res_s_Beam12_2  $Res_s_Beam12_2  $Theta_ult_s_Beam12_2  $Theta_ult_s_Beam12_2  1. 1.;
element     zeroLength 21400 214 2104 -mat 21400 -dir 6;
equalDOF                     214 2104 1 2;

# FloorAxis = 31;
# Panel Rigid Link;
element elasticBeamColumn 1003101 3105 3101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003108 3101 3112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003107 3111 3104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003106 3104 3110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003105 3109 3103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003104 3103 3108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003103 3107 3102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003102 3106 3102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 3105 3106 1 2;
equalDOF 3112 3111 1 2;
equalDOF 3110 3109 1 2;
equalDOF 3107 3108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003100 $M1_Panel3_1 $Gamma_1_Panel3_1 $M4_Panel3_1 $Gamma_4_Panel3_1 $M6_Panel3_1 $Gamma_6_Panel3_1 -$M1_Panel3_1 -$Gamma_1_Panel3_1 -$M4_Panel3_1 -$Gamma_4_Panel3_1 -$M6_Panel3_1 -$Gamma_6_Panel3_1 0.25 0.75 0 0 0;
element zeroLength          1003100  3109 3110 -mat 1003100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 31400 $K_s_Beam12_3 $Alpha_s_Beam12_3 $Alpha_s_Beam12_3 $My_s_Beam12_3 -$My_s_Beam12_3  $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 1. 1. 1. 1.  $Theta_p_s_Beam12_3  $Theta_p_s_Beam12_3  $Theta_pc_s_Beam12_3  $Theta_pc_s_Beam12_3  $Res_s_Beam12_3  $Res_s_Beam12_3  $Theta_ult_s_Beam12_3  $Theta_ult_s_Beam12_3  1. 1.;
element     zeroLength 31400 314 3104 -mat 31400 -dir 6;
equalDOF                     314 3104 1 2;

# FloorAxis = 41;
# Panel Rigid Link;
element elasticBeamColumn 1004101 4105 4101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004108 4101 4112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004107 4111 4104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004106 4104 4110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004105 4109 4103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004104 4103 4108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004103 4107 4102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004102 4106 4102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 4105 4106 1 2;
equalDOF 4112 4111 1 2;
equalDOF 4110 4109 1 2;
equalDOF 4107 4108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004100 $M1_Panel4_1 $Gamma_1_Panel4_1 $M4_Panel4_1 $Gamma_4_Panel4_1 $M6_Panel4_1 $Gamma_6_Panel4_1 -$M1_Panel4_1 -$Gamma_1_Panel4_1 -$M4_Panel4_1 -$Gamma_4_Panel4_1 -$M6_Panel4_1 -$Gamma_6_Panel4_1 0.25 0.75 0 0 0;
element zeroLength          1004100  4109 4110 -mat 1004100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 41400 $K_s_Beam12_4 $Alpha_s_Beam12_4 $Alpha_s_Beam12_4 $My_s_Beam12_4 -$My_s_Beam12_4  $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 1. 1. 1. 1.  $Theta_p_s_Beam12_4  $Theta_p_s_Beam12_4  $Theta_pc_s_Beam12_4  $Theta_pc_s_Beam12_4  $Res_s_Beam12_4  $Res_s_Beam12_4  $Theta_ult_s_Beam12_4  $Theta_ult_s_Beam12_4  1. 1.;
element     zeroLength 41400 414 4104 -mat 41400 -dir 6;
equalDOF                     414 4104 1 2;

# FloorAxis = 51;
# Panel Rigid Link;
element elasticBeamColumn 1005101 5105 5101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005108 5101 5112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005107 5111 5104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005106 5104 5110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005105 5109 5103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005104 5103 5108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005103 5107 5102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005102 5106 5102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 5105 5106 1 2;
equalDOF 5112 5111 1 2;
equalDOF 5110 5109 1 2;
equalDOF 5107 5108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005100 $M1_Panel5_1 $Gamma_1_Panel5_1 $M4_Panel5_1 $Gamma_4_Panel5_1 $M6_Panel5_1 $Gamma_6_Panel5_1 -$M1_Panel5_1 -$Gamma_1_Panel5_1 -$M4_Panel5_1 -$Gamma_4_Panel5_1 -$M6_Panel5_1 -$Gamma_6_Panel5_1 0.25 0.75 0 0 0;
element zeroLength          1005100  5109 5110 -mat 1005100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 51400 $K_s_Beam12_5 $Alpha_s_Beam12_5 $Alpha_s_Beam12_5 $My_s_Beam12_5 -$My_s_Beam12_5  $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 1. 1. 1. 1.  $Theta_p_s_Beam12_5  $Theta_p_s_Beam12_5  $Theta_pc_s_Beam12_5  $Theta_pc_s_Beam12_5  $Res_s_Beam12_5  $Res_s_Beam12_5  $Theta_ult_s_Beam12_5  $Theta_ult_s_Beam12_5  1. 1.;
element     zeroLength 51400 514 5104 -mat 51400 -dir 6;
equalDOF                     514 5104 1 2;

# FloorAxis = 22;
# Panel Rigid Link;
element elasticBeamColumn 1002201 2205 2201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002208 2201 2212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002207 2211 2204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002206 2204 2210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002205 2209 2203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002204 2203 2208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002203 2207 2202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002202 2206 2202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 2205 2206 1 2;
equalDOF 2212 2211 1 2;
equalDOF 2210 2209 1 2;
equalDOF 2207 2208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002200 $M1_Panel2_2 $Gamma_1_Panel2_2 $M4_Panel2_2 $Gamma_4_Panel2_2 $M6_Panel2_2 $Gamma_6_Panel2_2 -$M1_Panel2_2 -$Gamma_1_Panel2_2 -$M4_Panel2_2 -$Gamma_4_Panel2_2 -$M6_Panel2_2 -$Gamma_6_Panel2_2 0.25 0.75 0 0 0;
element zeroLength          1002200  2209 2210 -mat 1002200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 22200 $K_s_Beam12_2 $Alpha_s_Beam12_2 $Alpha_s_Beam12_2 $My_s_Beam12_2 -$My_s_Beam12_2  $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 $Lambda_Beam12_2 1. 1. 1. 1.  $Theta_p_s_Beam12_2  $Theta_p_s_Beam12_2  $Theta_pc_s_Beam12_2  $Theta_pc_s_Beam12_2  $Res_s_Beam12_2  $Res_s_Beam12_2  $Theta_ult_s_Beam12_2  $Theta_ult_s_Beam12_2  1. 1.;
element     zeroLength 22200 222 2202 -mat 22200 -dir 6;
equalDOF                     222 2202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 22400 $K_s_Beam23_2 $Alpha_s_Beam23_2 $Alpha_s_Beam23_2 $My_s_Beam23_2 -$My_s_Beam23_2  $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 1. 1. 1. 1.  $Theta_p_s_Beam23_2  $Theta_p_s_Beam23_2  $Theta_pc_s_Beam23_2  $Theta_pc_s_Beam23_2  $Res_s_Beam23_2  $Res_s_Beam23_2  $Theta_ult_s_Beam23_2  $Theta_ult_s_Beam23_2  1. 1.;
element     zeroLength 22400 224 2204 -mat 22400 -dir 6;
equalDOF                     224 2204 1 2;

# FloorAxis = 32;
# Panel Rigid Link;
element elasticBeamColumn 1003201 3205 3201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003208 3201 3212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003207 3211 3204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003206 3204 3210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003205 3209 3203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003204 3203 3208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003203 3207 3202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003202 3206 3202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 3205 3206 1 2;
equalDOF 3212 3211 1 2;
equalDOF 3210 3209 1 2;
equalDOF 3207 3208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003200 $M1_Panel3_2 $Gamma_1_Panel3_2 $M4_Panel3_2 $Gamma_4_Panel3_2 $M6_Panel3_2 $Gamma_6_Panel3_2 -$M1_Panel3_2 -$Gamma_1_Panel3_2 -$M4_Panel3_2 -$Gamma_4_Panel3_2 -$M6_Panel3_2 -$Gamma_6_Panel3_2 0.25 0.75 0 0 0;
element zeroLength          1003200  3209 3210 -mat 1003200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 32200 $K_s_Beam12_3 $Alpha_s_Beam12_3 $Alpha_s_Beam12_3 $My_s_Beam12_3 -$My_s_Beam12_3  $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 $Lambda_Beam12_3 1. 1. 1. 1.  $Theta_p_s_Beam12_3  $Theta_p_s_Beam12_3  $Theta_pc_s_Beam12_3  $Theta_pc_s_Beam12_3  $Res_s_Beam12_3  $Res_s_Beam12_3  $Theta_ult_s_Beam12_3  $Theta_ult_s_Beam12_3  1. 1.;
element     zeroLength 32200 322 3202 -mat 32200 -dir 6;
equalDOF                     322 3202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 32400 $K_s_Beam23_3 $Alpha_s_Beam23_3 $Alpha_s_Beam23_3 $My_s_Beam23_3 -$My_s_Beam23_3  $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 1. 1. 1. 1.  $Theta_p_s_Beam23_3  $Theta_p_s_Beam23_3  $Theta_pc_s_Beam23_3  $Theta_pc_s_Beam23_3  $Res_s_Beam23_3  $Res_s_Beam23_3  $Theta_ult_s_Beam23_3  $Theta_ult_s_Beam23_3  1. 1.;
element     zeroLength 32400 324 3204 -mat 32400 -dir 6;
equalDOF                     324 3204 1 2;

# FloorAxis = 42;
# Panel Rigid Link;
element elasticBeamColumn 1004201 4205 4201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004208 4201 4212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004207 4211 4204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004206 4204 4210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004205 4209 4203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004204 4203 4208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004203 4207 4202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004202 4206 4202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 4205 4206 1 2;
equalDOF 4212 4211 1 2;
equalDOF 4210 4209 1 2;
equalDOF 4207 4208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004200 $M1_Panel4_2 $Gamma_1_Panel4_2 $M4_Panel4_2 $Gamma_4_Panel4_2 $M6_Panel4_2 $Gamma_6_Panel4_2 -$M1_Panel4_2 -$Gamma_1_Panel4_2 -$M4_Panel4_2 -$Gamma_4_Panel4_2 -$M6_Panel4_2 -$Gamma_6_Panel4_2 0.25 0.75 0 0 0;
element zeroLength          1004200  4209 4210 -mat 1004200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 42200 $K_s_Beam12_4 $Alpha_s_Beam12_4 $Alpha_s_Beam12_4 $My_s_Beam12_4 -$My_s_Beam12_4  $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 $Lambda_Beam12_4 1. 1. 1. 1.  $Theta_p_s_Beam12_4  $Theta_p_s_Beam12_4  $Theta_pc_s_Beam12_4  $Theta_pc_s_Beam12_4  $Res_s_Beam12_4  $Res_s_Beam12_4  $Theta_ult_s_Beam12_4  $Theta_ult_s_Beam12_4  1. 1.;
element     zeroLength 42200 422 4202 -mat 42200 -dir 6;
equalDOF                     422 4202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 42400 $K_s_Beam23_4 $Alpha_s_Beam23_4 $Alpha_s_Beam23_4 $My_s_Beam23_4 -$My_s_Beam23_4  $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 1. 1. 1. 1.  $Theta_p_s_Beam23_4  $Theta_p_s_Beam23_4  $Theta_pc_s_Beam23_4  $Theta_pc_s_Beam23_4  $Res_s_Beam23_4  $Res_s_Beam23_4  $Theta_ult_s_Beam23_4  $Theta_ult_s_Beam23_4  1. 1.;
element     zeroLength 42400 424 4204 -mat 42400 -dir 6;
equalDOF                     424 4204 1 2;

# FloorAxis = 52;
# Panel Rigid Link;
element elasticBeamColumn 1005201 5205 5201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005208 5201 5212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005207 5211 5204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005206 5204 5210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005205 5209 5203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005204 5203 5208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005203 5207 5202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005202 5206 5202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 5205 5206 1 2;
equalDOF 5212 5211 1 2;
equalDOF 5210 5209 1 2;
equalDOF 5207 5208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005200 $M1_Panel5_2 $Gamma_1_Panel5_2 $M4_Panel5_2 $Gamma_4_Panel5_2 $M6_Panel5_2 $Gamma_6_Panel5_2 -$M1_Panel5_2 -$Gamma_1_Panel5_2 -$M4_Panel5_2 -$Gamma_4_Panel5_2 -$M6_Panel5_2 -$Gamma_6_Panel5_2 0.25 0.75 0 0 0;
element zeroLength          1005200  5209 5210 -mat 1005200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 52200 $K_s_Beam12_5 $Alpha_s_Beam12_5 $Alpha_s_Beam12_5 $My_s_Beam12_5 -$My_s_Beam12_5  $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 $Lambda_Beam12_5 1. 1. 1. 1.  $Theta_p_s_Beam12_5  $Theta_p_s_Beam12_5  $Theta_pc_s_Beam12_5  $Theta_pc_s_Beam12_5  $Res_s_Beam12_5  $Res_s_Beam12_5  $Theta_ult_s_Beam12_5  $Theta_ult_s_Beam12_5  1. 1.;
element     zeroLength 52200 522 5202 -mat 52200 -dir 6;
equalDOF                     522 5202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 52400 $K_s_Beam23_5 $Alpha_s_Beam23_5 $Alpha_s_Beam23_5 $My_s_Beam23_5 -$My_s_Beam23_5  $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 1. 1. 1. 1.  $Theta_p_s_Beam23_5  $Theta_p_s_Beam23_5  $Theta_pc_s_Beam23_5  $Theta_pc_s_Beam23_5  $Res_s_Beam23_5  $Res_s_Beam23_5  $Theta_ult_s_Beam23_5  $Theta_ult_s_Beam23_5  1. 1.;
element     zeroLength 52400 524 5204 -mat 52400 -dir 6;
equalDOF                     524 5204 1 2;

# FloorAxis = 23;
# Panel Rigid Link;
element elasticBeamColumn 1002301 2305 2301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002308 2301 2312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002307 2311 2304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002306 2304 2310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002305 2309 2303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002304 2303 2308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002303 2307 2302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002302 2306 2302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 2305 2306 1 2;
equalDOF 2312 2311 1 2;
equalDOF 2310 2309 1 2;
equalDOF 2307 2308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002300 $M1_Panel2_3 $Gamma_1_Panel2_3 $M4_Panel2_3 $Gamma_4_Panel2_3 $M6_Panel2_3 $Gamma_6_Panel2_3 -$M1_Panel2_3 -$Gamma_1_Panel2_3 -$M4_Panel2_3 -$Gamma_4_Panel2_3 -$M6_Panel2_3 -$Gamma_6_Panel2_3 0.25 0.75 0 0 0;
element zeroLength          1002300  2309 2310 -mat 1002300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 23200 $K_s_Beam23_2 $Alpha_s_Beam23_2 $Alpha_s_Beam23_2 $My_s_Beam23_2 -$My_s_Beam23_2  $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 $Lambda_Beam23_2 1. 1. 1. 1.  $Theta_p_s_Beam23_2  $Theta_p_s_Beam23_2  $Theta_pc_s_Beam23_2  $Theta_pc_s_Beam23_2  $Res_s_Beam23_2  $Res_s_Beam23_2  $Theta_ult_s_Beam23_2  $Theta_ult_s_Beam23_2  1. 1.;
element     zeroLength 23200 232 2302 -mat 23200 -dir 6;
equalDOF                     232 2302 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 23400 $K_s_Beam34_2 $Alpha_s_Beam34_2 $Alpha_s_Beam34_2 $My_s_Beam34_2 -$My_s_Beam34_2  $Lambda_Beam34_2 $Lambda_Beam34_2 $Lambda_Beam34_2 $Lambda_Beam34_2 1. 1. 1. 1.  $Theta_p_s_Beam34_2  $Theta_p_s_Beam34_2  $Theta_pc_s_Beam34_2  $Theta_pc_s_Beam34_2  $Res_s_Beam34_2  $Res_s_Beam34_2  $Theta_ult_s_Beam34_2  $Theta_ult_s_Beam34_2  1. 1.;
element     zeroLength 23400 234 2304 -mat 23400 -dir 6;
equalDOF                     234 2304 1 2;

# FloorAxis = 33;
# Panel Rigid Link;
element elasticBeamColumn 1003301 3305 3301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003308 3301 3312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003307 3311 3304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003306 3304 3310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003305 3309 3303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003304 3303 3308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003303 3307 3302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003302 3306 3302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 3305 3306 1 2;
equalDOF 3312 3311 1 2;
equalDOF 3310 3309 1 2;
equalDOF 3307 3308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003300 $M1_Panel3_3 $Gamma_1_Panel3_3 $M4_Panel3_3 $Gamma_4_Panel3_3 $M6_Panel3_3 $Gamma_6_Panel3_3 -$M1_Panel3_3 -$Gamma_1_Panel3_3 -$M4_Panel3_3 -$Gamma_4_Panel3_3 -$M6_Panel3_3 -$Gamma_6_Panel3_3 0.25 0.75 0 0 0;
element zeroLength          1003300  3309 3310 -mat 1003300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 33200 $K_s_Beam23_3 $Alpha_s_Beam23_3 $Alpha_s_Beam23_3 $My_s_Beam23_3 -$My_s_Beam23_3  $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 $Lambda_Beam23_3 1. 1. 1. 1.  $Theta_p_s_Beam23_3  $Theta_p_s_Beam23_3  $Theta_pc_s_Beam23_3  $Theta_pc_s_Beam23_3  $Res_s_Beam23_3  $Res_s_Beam23_3  $Theta_ult_s_Beam23_3  $Theta_ult_s_Beam23_3  1. 1.;
element     zeroLength 33200 332 3302 -mat 33200 -dir 6;
equalDOF                     332 3302 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 33400 $K_s_Beam34_3 $Alpha_s_Beam34_3 $Alpha_s_Beam34_3 $My_s_Beam34_3 -$My_s_Beam34_3  $Lambda_Beam34_3 $Lambda_Beam34_3 $Lambda_Beam34_3 $Lambda_Beam34_3 1. 1. 1. 1.  $Theta_p_s_Beam34_3  $Theta_p_s_Beam34_3  $Theta_pc_s_Beam34_3  $Theta_pc_s_Beam34_3  $Res_s_Beam34_3  $Res_s_Beam34_3  $Theta_ult_s_Beam34_3  $Theta_ult_s_Beam34_3  1. 1.;
element     zeroLength 33400 334 3304 -mat 33400 -dir 6;
equalDOF                     334 3304 1 2;

# FloorAxis = 43;
# Panel Rigid Link;
element elasticBeamColumn 1004301 4305 4301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004308 4301 4312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004307 4311 4304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004306 4304 4310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004305 4309 4303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004304 4303 4308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004303 4307 4302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004302 4306 4302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 4305 4306 1 2;
equalDOF 4312 4311 1 2;
equalDOF 4310 4309 1 2;
equalDOF 4307 4308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004300 $M1_Panel4_3 $Gamma_1_Panel4_3 $M4_Panel4_3 $Gamma_4_Panel4_3 $M6_Panel4_3 $Gamma_6_Panel4_3 -$M1_Panel4_3 -$Gamma_1_Panel4_3 -$M4_Panel4_3 -$Gamma_4_Panel4_3 -$M6_Panel4_3 -$Gamma_6_Panel4_3 0.25 0.75 0 0 0;
element zeroLength          1004300  4309 4310 -mat 1004300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 43200 $K_s_Beam23_4 $Alpha_s_Beam23_4 $Alpha_s_Beam23_4 $My_s_Beam23_4 -$My_s_Beam23_4  $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 $Lambda_Beam23_4 1. 1. 1. 1.  $Theta_p_s_Beam23_4  $Theta_p_s_Beam23_4  $Theta_pc_s_Beam23_4  $Theta_pc_s_Beam23_4  $Res_s_Beam23_4  $Res_s_Beam23_4  $Theta_ult_s_Beam23_4  $Theta_ult_s_Beam23_4  1. 1.;
element     zeroLength 43200 432 4302 -mat 43200 -dir 6;
equalDOF                     432 4302 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 43400 $K_s_Beam34_4 $Alpha_s_Beam34_4 $Alpha_s_Beam34_4 $My_s_Beam34_4 -$My_s_Beam34_4  $Lambda_Beam34_4 $Lambda_Beam34_4 $Lambda_Beam34_4 $Lambda_Beam34_4 1. 1. 1. 1.  $Theta_p_s_Beam34_4  $Theta_p_s_Beam34_4  $Theta_pc_s_Beam34_4  $Theta_pc_s_Beam34_4  $Res_s_Beam34_4  $Res_s_Beam34_4  $Theta_ult_s_Beam34_4  $Theta_ult_s_Beam34_4  1. 1.;
element     zeroLength 43400 434 4304 -mat 43400 -dir 6;
equalDOF                     434 4304 1 2;

# FloorAxis = 53;
# Panel Rigid Link;
element elasticBeamColumn 1005301 5305 5301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005308 5301 5312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005307 5311 5304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005306 5304 5310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005305 5309 5303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005304 5303 5308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005303 5307 5302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005302 5306 5302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 5305 5306 1 2;
equalDOF 5312 5311 1 2;
equalDOF 5310 5309 1 2;
equalDOF 5307 5308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005300 $M1_Panel5_3 $Gamma_1_Panel5_3 $M4_Panel5_3 $Gamma_4_Panel5_3 $M6_Panel5_3 $Gamma_6_Panel5_3 -$M1_Panel5_3 -$Gamma_1_Panel5_3 -$M4_Panel5_3 -$Gamma_4_Panel5_3 -$M6_Panel5_3 -$Gamma_6_Panel5_3 0.25 0.75 0 0 0;
element zeroLength          1005300  5309 5310 -mat 1005300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 53200 $K_s_Beam23_5 $Alpha_s_Beam23_5 $Alpha_s_Beam23_5 $My_s_Beam23_5 -$My_s_Beam23_5  $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 $Lambda_Beam23_5 1. 1. 1. 1.  $Theta_p_s_Beam23_5  $Theta_p_s_Beam23_5  $Theta_pc_s_Beam23_5  $Theta_pc_s_Beam23_5  $Res_s_Beam23_5  $Res_s_Beam23_5  $Theta_ult_s_Beam23_5  $Theta_ult_s_Beam23_5  1. 1.;
element     zeroLength 53200 532 5302 -mat 53200 -dir 6;
equalDOF                     532 5302 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 53400 $K_s_Beam34_5 $Alpha_s_Beam34_5 $Alpha_s_Beam34_5 $My_s_Beam34_5 -$My_s_Beam34_5  $Lambda_Beam34_5 $Lambda_Beam34_5 $Lambda_Beam34_5 $Lambda_Beam34_5 1. 1. 1. 1.  $Theta_p_s_Beam34_5  $Theta_p_s_Beam34_5  $Theta_pc_s_Beam34_5  $Theta_pc_s_Beam34_5  $Res_s_Beam34_5  $Res_s_Beam34_5  $Theta_ult_s_Beam34_5  $Theta_ult_s_Beam34_5  1. 1.;
element     zeroLength 53400 534 5304 -mat 53400 -dir 6;
equalDOF                     534 5304 1 2;

# FloorAxis = 24;
# Panel Rigid Link;
element elasticBeamColumn 1002401 2405 2401 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002408 2401 2412 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002407 2411 2404 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002406 2404 2410 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002405 2409 2403 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002404 2403 2408 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002403 2407 2402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1002402 2406 2402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 2405 2406 1 2;
equalDOF 2412 2411 1 2;
equalDOF 2410 2409 1 2;
equalDOF 2407 2408 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1002400 $M1_Panel2_4 $Gamma_1_Panel2_4 $M4_Panel2_4 $Gamma_4_Panel2_4 $M6_Panel2_4 $Gamma_6_Panel2_4 -$M1_Panel2_4 -$Gamma_1_Panel2_4 -$M4_Panel2_4 -$Gamma_4_Panel2_4 -$M6_Panel2_4 -$Gamma_6_Panel2_4 0.25 0.75 0 0 0;
element zeroLength          1002400  2409 2410 -mat 1002400 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 24200 $K_s_Beam34_2 $Alpha_s_Beam34_2 $Alpha_s_Beam34_2 $My_s_Beam34_2 -$My_s_Beam34_2  $Lambda_Beam34_2 $Lambda_Beam34_2 $Lambda_Beam34_2 $Lambda_Beam34_2 1. 1. 1. 1.  $Theta_p_s_Beam34_2  $Theta_p_s_Beam34_2  $Theta_pc_s_Beam34_2  $Theta_pc_s_Beam34_2  $Res_s_Beam34_2  $Res_s_Beam34_2  $Theta_ult_s_Beam34_2  $Theta_ult_s_Beam34_2  1. 1.;
element     zeroLength 24200 242 2402 -mat 24200 -dir 6;
equalDOF                     242 2402 1 2;

# FloorAxis = 34;
# Panel Rigid Link;
element elasticBeamColumn 1003401 3405 3401 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003408 3401 3412 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003407 3411 3404 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003406 3404 3410 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003405 3409 3403 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003404 3403 3408 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003403 3407 3402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1003402 3406 3402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 3405 3406 1 2;
equalDOF 3412 3411 1 2;
equalDOF 3410 3409 1 2;
equalDOF 3407 3408 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1003400 $M1_Panel3_4 $Gamma_1_Panel3_4 $M4_Panel3_4 $Gamma_4_Panel3_4 $M6_Panel3_4 $Gamma_6_Panel3_4 -$M1_Panel3_4 -$Gamma_1_Panel3_4 -$M4_Panel3_4 -$Gamma_4_Panel3_4 -$M6_Panel3_4 -$Gamma_6_Panel3_4 0.25 0.75 0 0 0;
element zeroLength          1003400  3409 3410 -mat 1003400 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 34200 $K_s_Beam34_3 $Alpha_s_Beam34_3 $Alpha_s_Beam34_3 $My_s_Beam34_3 -$My_s_Beam34_3  $Lambda_Beam34_3 $Lambda_Beam34_3 $Lambda_Beam34_3 $Lambda_Beam34_3 1. 1. 1. 1.  $Theta_p_s_Beam34_3  $Theta_p_s_Beam34_3  $Theta_pc_s_Beam34_3  $Theta_pc_s_Beam34_3  $Res_s_Beam34_3  $Res_s_Beam34_3  $Theta_ult_s_Beam34_3  $Theta_ult_s_Beam34_3  1. 1.;
element     zeroLength 34200 342 3402 -mat 34200 -dir 6;
equalDOF                     342 3402 1 2;

# FloorAxis = 44;
# Panel Rigid Link;
element elasticBeamColumn 1004401 4405 4401 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004408 4401 4412 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004407 4411 4404 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004406 4404 4410 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004405 4409 4403 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004404 4403 4408 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004403 4407 4402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1004402 4406 4402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 4405 4406 1 2;
equalDOF 4412 4411 1 2;
equalDOF 4410 4409 1 2;
equalDOF 4407 4408 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1004400 $M1_Panel4_4 $Gamma_1_Panel4_4 $M4_Panel4_4 $Gamma_4_Panel4_4 $M6_Panel4_4 $Gamma_6_Panel4_4 -$M1_Panel4_4 -$Gamma_1_Panel4_4 -$M4_Panel4_4 -$Gamma_4_Panel4_4 -$M6_Panel4_4 -$Gamma_6_Panel4_4 0.25 0.75 0 0 0;
element zeroLength          1004400  4409 4410 -mat 1004400 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 44200 $K_s_Beam34_4 $Alpha_s_Beam34_4 $Alpha_s_Beam34_4 $My_s_Beam34_4 -$My_s_Beam34_4  $Lambda_Beam34_4 $Lambda_Beam34_4 $Lambda_Beam34_4 $Lambda_Beam34_4 1. 1. 1. 1.  $Theta_p_s_Beam34_4  $Theta_p_s_Beam34_4  $Theta_pc_s_Beam34_4  $Theta_pc_s_Beam34_4  $Res_s_Beam34_4  $Res_s_Beam34_4  $Theta_ult_s_Beam34_4  $Theta_ult_s_Beam34_4  1. 1.;
element     zeroLength 44200 442 4402 -mat 44200 -dir 6;
equalDOF                     442 4402 1 2;

# FloorAxis = 54;
# Panel Rigid Link;
element elasticBeamColumn 1005401 5405 5401 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005408 5401 5412 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005407 5411 5404 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005406 5404 5410 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005405 5409 5403 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005404 5403 5408 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005403 5407 5402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
element elasticBeamColumn 1005402 5406 5402 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamTransfTag;
equalDOF 5405 5406 1 2;
equalDOF 5412 5411 1 2;
equalDOF 5410 5409 1 2;
equalDOF 5407 5408 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 1005400 $M1_Panel5_4 $Gamma_1_Panel5_4 $M4_Panel5_4 $Gamma_4_Panel5_4 $M6_Panel5_4 $Gamma_6_Panel5_4 -$M1_Panel5_4 -$Gamma_1_Panel5_4 -$M4_Panel5_4 -$Gamma_4_Panel5_4 -$M6_Panel5_4 -$Gamma_6_Panel5_4 0.25 0.75 0 0 0;
element zeroLength          1005400  5409 5410 -mat 1005400 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 54200 $K_s_Beam34_5 $Alpha_s_Beam34_5 $Alpha_s_Beam34_5 $My_s_Beam34_5 -$My_s_Beam34_5  $Lambda_Beam34_5 $Lambda_Beam34_5 $Lambda_Beam34_5 $Lambda_Beam34_5 1. 1. 1. 1.  $Theta_p_s_Beam34_5  $Theta_p_s_Beam34_5  $Theta_pc_s_Beam34_5  $Theta_pc_s_Beam34_5  $Res_s_Beam34_5  $Res_s_Beam34_5  $Theta_ult_s_Beam34_5  $Theta_ult_s_Beam34_5  1. 1.;
element     zeroLength 54200 542 5402 -mat 54200 -dir 6;
equalDOF                     542 5402 1 2;

# Columns;

# Story-1, Axis-1 Column without splice;
nDMaterial HLBModel 01011032101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 02011032101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 11032101 -GJ 227098864437.18 {; 
patch rect 02011032101 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 01011032101 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 02011032101 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 11032101 1103 2101 $ColTransfTag Simpson 11032101 15  20 0.00000001 0.00 

# Story-2, Axis-1 Column without splice;
nDMaterial HLBModel 01021033101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 02021033101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 21033101 -GJ 227098864437.18 {; 
patch rect 02021033101 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 01021033101 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 02021033101 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 21033101 2103 3101 $ColTransfTag Simpson 21033101 13  20 0.00000001 0.00 

# Story-3, Axis-1 Column with splice;
# Node in middle of story;
node 31031  [expr $Axis1] [expr $Floor3 + ($Floor4-$Floor3-$d_Beam12_4/2-$d_Beam12_3/2)/2] 0;
#Element for bottom part of column;
nDMaterial HLBModel 010310331031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 020310331031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 310331031 -GJ 227098864437.18 {; 
patch rect 020310331031 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 010310331031 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 020310331031 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 310331031 3103 31031 $ColTransfTag Simpson 310331031 7  20 0.00000001 0.00 
#Element for top part of column;
nDMaterial HLBModel 010310314101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.00 11.20 353.8946 1.0 web A992Gr50; 
nDMaterial HLBModel 020310314101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.00 17.30 475.2412 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 310314101 -GJ 227098864437.18 {; 
patch rect 020310314101 1 4 -303.5000 -114.0000 -286.2000 114.0000; 
patch rect 010310314101 10 1 -286.2000 -5.6000 286.2000 5.6000; 
patch rect 020310314101 1 4 286.2000 -114.0000 303.5000 114.0000; 
} 
element testNonlocalElementDH 310314101 31031 4101 $ColTransfTag Simpson 310314101 7  20 0.00000001 0.00 

# Story-4, Axis-1 Column without splice;
nDMaterial HLBModel 01041035101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.00 11.20 353.8946 1.0 web A992Gr50; 
nDMaterial HLBModel 02041035101 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.00 17.30 475.2412 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 41035101 -GJ 83188467504.62 {; 
patch rect 02041035101 1 4 -303.5000 -114.0000 -286.2000 114.0000; 
patch rect 01041035101 10 1 -286.2000 -5.6000 286.2000 5.6000; 
patch rect 02041035101 1 4 286.2000 -114.0000 303.5000 114.0000; 
} 
element testNonlocalElementDH 41035101 4103 5101 $ColTransfTag Simpson 41035101 13  20 0.00000001 0.00 

# Story-1, Axis-2 Column without splice;
nDMaterial HLBModel 01012032201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 02012032201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 12032201 -GJ 433923991421.79 {; 
patch rect 02012032201 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 01012032201 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 02012032201 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 12032201 1203 2201 $ColTransfTag Simpson 12032201 15  20 0.00000001 0.00 

# Story-2, Axis-2 Column without splice;
nDMaterial HLBModel 01022033201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 02022033201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 22033201 -GJ 433923991421.79 {; 
patch rect 02022033201 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 01022033201 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 02022033201 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 22033201 2203 3201 $ColTransfTag Simpson 22033201 13  20 0.00000001 0.00 

# Story-3, Axis-2 Column with splice;
# Node in middle of story;
node 32031  [expr $Axis2] [expr $Floor3 + ($Floor4-$Floor3-$d_Beam12_4/2-$d_Beam12_3/2)/2] 0;
#Element for bottom part of column;
nDMaterial HLBModel 010320332031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 020320332031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 320332031 -GJ 433923991421.79 {; 
patch rect 020320332031 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 010320332031 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 020320332031 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 320332031 3203 32031 $ColTransfTag Simpson 320332031 7  20 0.00000001 0.00 
#Element for top part of column;
nDMaterial HLBModel 010320314201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.40 11.90 364.3473 1.0 web A992Gr50; 
nDMaterial HLBModel 020320314201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 19.60 516.7488 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 320314201 -GJ 433923991421.79 {; 
patch rect 020320314201 1 4 -306.0000 -114.5000 -286.4000 114.5000; 
patch rect 010320314201 10 1 -286.4000 -5.9500 286.4000 5.9500; 
patch rect 020320314201 1 4 286.4000 -114.5000 306.0000 114.5000; 
} 
element testNonlocalElementDH 320314201 32031 4201 $ColTransfTag Simpson 320314201 7  20 0.00000001 0.00 

# Story-4, Axis-2 Column without splice;
nDMaterial HLBModel 01042035201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.40 11.90 364.3473 1.0 web A992Gr50; 
nDMaterial HLBModel 02042035201 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 19.60 516.7488 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 42035201 -GJ 116003364802.05 {; 
patch rect 02042035201 1 4 -306.0000 -114.5000 -286.4000 114.5000; 
patch rect 01042035201 10 1 -286.4000 -5.9500 286.4000 5.9500; 
patch rect 02042035201 1 4 286.4000 -114.5000 306.0000 114.5000; 
} 
element testNonlocalElementDH 42035201 4203 5201 $ColTransfTag Simpson 42035201 13  20 0.00000001 0.00 

# Story-1, Axis-3 Column without splice;
nDMaterial HLBModel 01013032301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 02013032301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 13032301 -GJ 433923991421.79 {; 
patch rect 02013032301 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 01013032301 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 02013032301 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 13032301 1303 2301 $ColTransfTag Simpson 13032301 15  20 0.00000001 0.00 

# Story-2, Axis-3 Column without splice;
nDMaterial HLBModel 01023033301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 02023033301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 23033301 -GJ 433923991421.79 {; 
patch rect 02023033301 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 01023033301 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 02023033301 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 23033301 2303 3301 $ColTransfTag Simpson 23033301 13  20 0.00000001 0.00 

# Story-3, Axis-3 Column with splice;
# Node in middle of story;
node 33031  [expr $Axis3] [expr $Floor3 + ($Floor4-$Floor3-$d_Beam23_4/2-$d_Beam23_3/2)/2] 0;
#Element for bottom part of column;
nDMaterial HLBModel 010330333031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.20 16.50 427.5236 1.0 web A992Gr50; 
nDMaterial HLBModel 020330333031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 164.00 27.70 511.9613 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 330333031 -GJ 433923991421.79 {; 
patch rect 020330333031 1 4 -313.5000 -164.0000 -285.8000 164.0000; 
patch rect 010330333031 10 1 -285.8000 -8.2500 285.8000 8.2500; 
patch rect 020330333031 1 4 285.8000 -164.0000 313.5000 164.0000; 
} 
element testNonlocalElementDH 330333031 3303 33031 $ColTransfTag Simpson 330333031 7  20 0.00000001 0.00 
#Element for top part of column;
nDMaterial HLBModel 010330314301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.40 11.90 364.3473 1.0 web A992Gr50; 
nDMaterial HLBModel 020330314301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 19.60 516.7488 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 330314301 -GJ 433923991421.79 {; 
patch rect 020330314301 1 4 -306.0000 -114.5000 -286.4000 114.5000; 
patch rect 010330314301 10 1 -286.4000 -5.9500 286.4000 5.9500; 
patch rect 020330314301 1 4 286.4000 -114.5000 306.0000 114.5000; 
} 
element testNonlocalElementDH 330314301 33031 4301 $ColTransfTag Simpson 330314301 7  20 0.00000001 0.00 

# Story-4, Axis-3 Column without splice;
nDMaterial HLBModel 01043035301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.40 11.90 364.3473 1.0 web A992Gr50; 
nDMaterial HLBModel 02043035301 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 19.60 516.7488 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 43035301 -GJ 116003364802.05 {; 
patch rect 02043035301 1 4 -306.0000 -114.5000 -286.4000 114.5000; 
patch rect 01043035301 10 1 -286.4000 -5.9500 286.4000 5.9500; 
patch rect 02043035301 1 4 286.4000 -114.5000 306.0000 114.5000; 
} 
element testNonlocalElementDH 43035301 4303 5301 $ColTransfTag Simpson 43035301 13  20 0.00000001 0.00 

# Story-1, Axis-4 Column without splice;
nDMaterial HLBModel 01014032401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 02014032401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 14032401 -GJ 227098864437.18 {; 
patch rect 02014032401 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 01014032401 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 02014032401 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 14032401 1403 2401 $ColTransfTag Simpson 14032401 15  20 0.00000001 0.00 

# Story-2, Axis-4 Column without splice;
nDMaterial HLBModel 01024033401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 02024033401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 24033401 -GJ 227098864437.18 {; 
patch rect 02024033401 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 01024033401 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 02024033401 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 24033401 2403 3401 $ColTransfTag Simpson 24033401 13  20 0.00000001 0.00 

# Story-3, Axis-4 Column with splice;
# Node in middle of story;
node 34031  [expr $Axis4] [expr $Floor3 + ($Floor4-$Floor3-$d_Beam34_4/2-$d_Beam34_3/2)/2] 0;
#Element for bottom part of column;
nDMaterial HLBModel 010340334031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 546.80 14.00 394.5022 1.0 web A992Gr50; 
nDMaterial HLBModel 020340334031 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.50 24.90 610.2965 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 340334031 -GJ 227098864437.18 {; 
patch rect 020340334031 1 4 -311.0000 -114.5000 -286.1000 114.5000; 
patch rect 010340334031 10 1 -286.1000 -7.0000 286.1000 7.0000; 
patch rect 020340334031 1 4 286.1000 -114.5000 311.0000 114.5000; 
} 
element testNonlocalElementDH 340334031 3403 34031 $ColTransfTag Simpson 340334031 7  20 0.00000001 0.00 
#Element for top part of column;
nDMaterial HLBModel 010340314401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.00 11.20 353.8946 1.0 web A992Gr50; 
nDMaterial HLBModel 020340314401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.00 17.30 475.2412 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 340314401 -GJ 227098864437.18 {; 
patch rect 020340314401 1 4 -303.5000 -114.0000 -286.2000 114.0000; 
patch rect 010340314401 10 1 -286.2000 -5.6000 286.2000 5.6000; 
patch rect 020340314401 1 4 286.2000 -114.0000 303.5000 114.0000; 
} 
element testNonlocalElementDH 340314401 34031 4401 $ColTransfTag Simpson 340314401 7  20 0.00000001 0.00 

# Story-4, Axis-4 Column without splice;
nDMaterial HLBModel 01044035401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 547.00 11.20 353.8946 1.0 web A992Gr50; 
nDMaterial HLBModel 02044035401 205000.0 0.3 373.72 141.47 15.20 135.95 211.16 2 25621.00 235.12 942.18 3.16 114.00 17.30 475.2412 1.0 flange A992Gr50; 
section NDFiberTestNonlocal 44035401 -GJ 83188467504.62 {; 
patch rect 02044035401 1 4 -303.5000 -114.0000 -286.2000 114.0000; 
patch rect 01044035401 10 1 -286.2000 -5.6000 286.2000 5.6000; 
patch rect 02044035401 1 4 286.2000 -114.0000 303.5000 114.0000; 
} 
element testNonlocalElementDH 44035401 4403 5401 $ColTransfTag Simpson 44035401 13  20 0.00000001 0.00 


# Beam-column element for Beams;
# Span-1 Floor-2 Beam;
element elasticBeamColumn  214222 214 222 $A_Beam12_2 $E $G [expr 1.0000*$J_Beam12_2] [expr 1.0000*$Iy_Beam12_2] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam12_2] $BeamTransfTag;
# Span-1 Floor-3 Beam;
element elasticBeamColumn  314322 314 322 $A_Beam12_3 $E $G [expr 1.0000*$J_Beam12_3] [expr 1.0000*$Iy_Beam12_3] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam12_3] $BeamTransfTag;
# Span-1 Floor-4 Beam;
element elasticBeamColumn  414422 414 422 $A_Beam12_4 $E $G [expr 1.0000*$J_Beam12_4] [expr 1.0000*$Iy_Beam12_4] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam12_4] $BeamTransfTag;
# Span-1 Floor-5 Beam;
element elasticBeamColumn  514522 514 522 $A_Beam12_5 $E $G [expr 1.0000*$J_Beam12_5] [expr 1.0000*$Iy_Beam12_5] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam12_5] $BeamTransfTag;
# Span-2 Floor-2 Beam;
element elasticBeamColumn  224232 224 232 $A_Beam23_2 $E $G [expr 1.0000*$J_Beam23_2] [expr 1.0000*$Iy_Beam23_2] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam23_2] $BeamTransfTag;
# Span-2 Floor-3 Beam;
element elasticBeamColumn  324332 324 332 $A_Beam23_3 $E $G [expr 1.0000*$J_Beam23_3] [expr 1.0000*$Iy_Beam23_3] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam23_3] $BeamTransfTag;
# Span-2 Floor-4 Beam;
element elasticBeamColumn  424432 424 432 $A_Beam23_4 $E $G [expr 1.0000*$J_Beam23_4] [expr 1.0000*$Iy_Beam23_4] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam23_4] $BeamTransfTag;
# Span-2 Floor-5 Beam;
element elasticBeamColumn  524532 524 532 $A_Beam23_5 $E $G [expr 1.0000*$J_Beam23_5] [expr 1.0000*$Iy_Beam23_5] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam23_5] $BeamTransfTag;
# Span-3 Floor-2 Beam;
element elasticBeamColumn  234242 234 242 $A_Beam34_2 $E $G [expr 1.0000*$J_Beam34_2] [expr 1.0000*$Iy_Beam34_2] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam34_2] $BeamTransfTag;
# Span-3 Floor-3 Beam;
element elasticBeamColumn  334342 334 342 $A_Beam34_3 $E $G [expr 1.0000*$J_Beam34_3] [expr 1.0000*$Iy_Beam34_3] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam34_3] $BeamTransfTag;
# Span-3 Floor-4 Beam;
element elasticBeamColumn  434442 434 442 $A_Beam34_4 $E $G [expr 1.0000*$J_Beam34_4] [expr 1.0000*$Iy_Beam34_4] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam34_4] $BeamTransfTag;
# Span-3 Floor-5 Beam;
element elasticBeamColumn  534542 534 542 $A_Beam34_5 $E $G [expr 1.0000*$J_Beam34_5] [expr 1.0000*$Iy_Beam34_5] [expr ($n_fac+1)/$n_fac*1.0000*$Ix_Beam34_5] $BeamTransfTag;

# Leaning Column beam-column properties;
set A_leaningCol 2774105.1336;
set I_leaningCol 190063246091.5970;

# Leaning Column nodes;
node 1503 [expr $Axis5] [expr $Floor1] 0 ;
fix  1503 1 1 1 1 1 0;
node 25 [expr $Axis5] [expr $Floor2] 0 ;
node 251 [expr $Axis5] [expr $Floor2] 0 ;
node 252 [expr $Axis5] [expr $Floor2] 0 ;
node 244   [expr $Axis4+$d_Col12_4_t/2.+$H_offset               ] [expr $Floor2               ] 0;
fix 25   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 251   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 252   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 244   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 253 [expr $Axis5] [expr $Floor2] 0 ;
fix 253   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 35 [expr $Axis5] [expr $Floor3] 0 ;
node 351 [expr $Axis5] [expr $Floor3] 0 ;
node 352 [expr $Axis5] [expr $Floor3] 0 ;
node 344   [expr $Axis4+$d_Col23_4_t/2.+$H_offset               ] [expr $Floor3               ] 0;
fix 35   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 351   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 352   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 344   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 353 [expr $Axis5] [expr $Floor3] 0 ;
fix 353   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 45 [expr $Axis5] [expr $Floor4] 0 ;
node 451 [expr $Axis5] [expr $Floor4] 0 ;
node 452 [expr $Axis5] [expr $Floor4] 0 ;
node 444   [expr $Axis4+$d_Col34_4_t/2.+$H_offset               ] [expr $Floor4               ] 0;
fix 45   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 451   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 452   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 444   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 453 [expr $Axis5] [expr $Floor4] 0 ;
fix 453   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
node 55 [expr $Axis5] [expr $Floor5] 0 ;
node 551 [expr $Axis5] [expr $Floor5] 0 ;
node 552 [expr $Axis5] [expr $Floor5] 0 ;
node 544   [expr $Axis4+$d_Col45_4_t/2.+$H_offset               ] [expr $Floor5               ] 0;
fix 55   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 551   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 552   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;
fix 544   0 0 1 1 1 0;# Constrains for out of plane movement in 3D;

# Leaning Column elements;
element elasticBeamColumn  1503251 1503 251 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $ColTransfTag;
element elasticBeamColumn  244252 244 252 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $BeamTransfTag;
element     zeroLength 25100 251 25 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 25300 253 25 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 25200 252 25 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 24400 244 2404 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element elasticBeamColumn  253351 253 351 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $ColTransfTag;
element elasticBeamColumn  344352 344 352 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $BeamTransfTag;
element     zeroLength 35100 351 35 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 35300 353 35 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 35200 352 35 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 34400 344 3404 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element elasticBeamColumn  353451 353 451 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $ColTransfTag;
element elasticBeamColumn  444452 444 452 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $BeamTransfTag;
element     zeroLength 45100 451 45 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 45300 453 45 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 45200 452 45 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 44400 444 4404 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element elasticBeamColumn  453551 453 551 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $ColTransfTag;
element elasticBeamColumn  544552 544 552 $A_leaningCol $E $G $I_leaningCol $I_leaningCol $I_leaningCol $BeamTransfTag;
element     zeroLength 55100 551 55 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 55200 552 55 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;
element     zeroLength 54400 544 5404 -mat 555 555 555 555 555 666 -dir 1 2 3 4 5 6;

# Floor movement / Rigid Diaphram
equalDOF 2102 2202 1;
equalDOF 2102 2302 1;
equalDOF 2102 2402 1;
equalDOF 2102 25 1;
equalDOF 3102 3202 1;
equalDOF 3102 3302 1;
equalDOF 3102 3402 1;
equalDOF 3102 35 1;
equalDOF 4102 4202 1;
equalDOF 4102 4302 1;
equalDOF 4102 4402 1;
equalDOF 4102 45 1;
equalDOF 5102 5202 1;
equalDOF 5102 5302 1;
equalDOF 5102 5402 1;
equalDOF 5102 55 1;

# Assign mass;
mass 2104 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 2202 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 2204 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 2302 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 2304 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 2402 53.96939815 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3104 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3202 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3204 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3302 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3304 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 3402 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4104 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4202 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4204 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4302 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4304 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 4402 53.64599500 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5104 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5202 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5204 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5302 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5304 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton
mass 5402 50.66770000 1.e-10 1.e-10 1.e-10 1.e-10 1.e-10; #kton

# Create recorders;
# Displacement of equal dof master node in x direction;
recorder Node -file $Result/equalDOFmasterNodeDispX.txt  -time  -node 2102  3102  4102  5102  -dof 1 disp;#equal DOF master node
# Acceleration of equal dof master node in x direction;
recorder Node -file $Result/equalDOFmasterNodeAccel.txt  -time  -node 1103  2102  3102  4102  5102  -dof 1 accel;#equal DOF master node
# Column Displacement in Y direction (i.e. axial);
recorder Node -file $Result/ColumnStorey1DispY.txt  -time  -node 2101  2201  2301  2401  -dof 2 disp;#Column top node
# Column Displacement in X direction;
recorder Node -file $Result/ColumnStorey1DispX.txt  -time  -node 2101  2201  2301  2401  -dof 1 disp;#Column top node
# Reaction Forces  in X direction ;
recorder Node -file $Result/ReactionX.txt -time  -node 1103  1203  1303  1403  1503  -dof 1 reaction;
# Reaction Forces Vertical (Y) direction;
recorder Node -file $Result/ReactionY.txt -time  -node 1103  1203  1303  1403  -dof 2 reaction;
# Reaction Forces Moment (Z) direction;
recorder Node -file $Result/ReactionMZ.txt -time  -node 1103  1203  1303  1403  -dof 6 reaction;
# All columns global forces;
recorder Element -file $Result/Column11032101_globalForce.txt  -time  -ele 11032101 forces;
recorder Element -file $Result/Column12032201_globalForce.txt  -time  -ele 12032201 forces;
recorder Element -file $Result/Column13032301_globalForce.txt  -time  -ele 13032301 forces;
recorder Element -file $Result/Column14032401_globalForce.txt  -time  -ele 14032401 forces;
recorder Element -file $Result/Column21033101_globalForce.txt  -time  -ele 21033101 forces;
recorder Element -file $Result/Column22033201_globalForce.txt  -time  -ele 22033201 forces;
recorder Element -file $Result/Column23033301_globalForce.txt  -time  -ele 23033301 forces;
recorder Element -file $Result/Column24033401_globalForce.txt  -time  -ele 24033401 forces;
recorder Element -file $Result/Column310331031_globalForce.txt  -time  -ele 310331031 forces;
recorder Element -file $Result/Column310314101_globalForce.txt  -time  -ele 310314101 forces;
recorder Element -file $Result/Column320332031_globalForce.txt  -time  -ele 320332031 forces;
recorder Element -file $Result/Column320314201_globalForce.txt  -time  -ele 320314201 forces;
recorder Element -file $Result/Column330333031_globalForce.txt  -time  -ele 330333031 forces;
recorder Element -file $Result/Column330314301_globalForce.txt  -time  -ele 330314301 forces;
recorder Element -file $Result/Column340334031_globalForce.txt  -time  -ele 340334031 forces;
recorder Element -file $Result/Column340314401_globalForce.txt  -time  -ele 340314401 forces;
recorder Element -file $Result/Column41035101_globalForce.txt  -time  -ele 41035101 forces;
recorder Element -file $Result/Column42035201_globalForce.txt  -time  -ele 42035201 forces;
recorder Element -file $Result/Column43035301_globalForce.txt  -time  -ele 43035301 forces;
recorder Element -file $Result/Column44035401_globalForce.txt  -time  -ele 44035401 forces;
# All columns basic deformations;
recorder Element -file $Result/Column11032101_basicDeformations.txt  -time  -ele 11032101 basicDeformation;
recorder Element -file $Result/Column12032201_basicDeformations.txt  -time  -ele 12032201 basicDeformation;
recorder Element -file $Result/Column13032301_basicDeformations.txt  -time  -ele 13032301 basicDeformation;
recorder Element -file $Result/Column14032401_basicDeformations.txt  -time  -ele 14032401 basicDeformation;
recorder Element -file $Result/Column21033101_basicDeformations.txt  -time  -ele 21033101 basicDeformation;
recorder Element -file $Result/Column22033201_basicDeformations.txt  -time  -ele 22033201 basicDeformation;
recorder Element -file $Result/Column23033301_basicDeformations.txt  -time  -ele 23033301 basicDeformation;
recorder Element -file $Result/Column24033401_basicDeformations.txt  -time  -ele 24033401 basicDeformation;
recorder Element -file $Result/Column310331031_basicDeformations.txt  -time  -ele 310331031 basicDeformation;
recorder Element -file $Result/Column310314101_basicDeformations.txt  -time  -ele 310314101 basicDeformation;
recorder Element -file $Result/Column320332031_basicDeformations.txt  -time  -ele 320332031 basicDeformation;
recorder Element -file $Result/Column320314201_basicDeformations.txt  -time  -ele 320314201 basicDeformation;
recorder Element -file $Result/Column330333031_basicDeformations.txt  -time  -ele 330333031 basicDeformation;
recorder Element -file $Result/Column330314301_basicDeformations.txt  -time  -ele 330314301 basicDeformation;
recorder Element -file $Result/Column340334031_basicDeformations.txt  -time  -ele 340334031 basicDeformation;
recorder Element -file $Result/Column340314401_basicDeformations.txt  -time  -ele 340314401 basicDeformation;
recorder Element -file $Result/Column41035101_basicDeformations.txt  -time  -ele 41035101 basicDeformation;
recorder Element -file $Result/Column42035201_basicDeformations.txt  -time  -ele 42035201 basicDeformation;
recorder Element -file $Result/Column43035301_basicDeformations.txt  -time  -ele 43035301 basicDeformation;
recorder Element -file $Result/Column44035401_basicDeformations.txt  -time  -ele 44035401 basicDeformation;
# Beam end Springs;
recorder Element -file $Result/BeamSpring21400_M.txt -time  -ele 21400 force;
recorder Element -file $Result/BeamSpring21400_R.txt -time  -ele 21400 deformation;
recorder Element -file $Result/BeamSpring22200_M.txt -time  -ele 22200 force;
recorder Element -file $Result/BeamSpring22200_R.txt -time  -ele 22200 deformation;
recorder Element -file $Result/BeamSpring31400_M.txt -time  -ele 31400 force;
recorder Element -file $Result/BeamSpring31400_R.txt -time  -ele 31400 deformation;
recorder Element -file $Result/BeamSpring32200_M.txt -time  -ele 32200 force;
recorder Element -file $Result/BeamSpring32200_R.txt -time  -ele 32200 deformation;
recorder Element -file $Result/BeamSpring41400_M.txt -time  -ele 41400 force;
recorder Element -file $Result/BeamSpring41400_R.txt -time  -ele 41400 deformation;
recorder Element -file $Result/BeamSpring42200_M.txt -time  -ele 42200 force;
recorder Element -file $Result/BeamSpring42200_R.txt -time  -ele 42200 deformation;
recorder Element -file $Result/BeamSpring51400_M.txt -time  -ele 51400 force;
recorder Element -file $Result/BeamSpring51400_R.txt -time  -ele 51400 deformation;
recorder Element -file $Result/BeamSpring52200_M.txt -time  -ele 52200 force;
recorder Element -file $Result/BeamSpring52200_R.txt -time  -ele 52200 deformation;
recorder Element -file $Result/BeamSpring22400_M.txt -time  -ele 22400 force;
recorder Element -file $Result/BeamSpring22400_R.txt -time  -ele 22400 deformation;
recorder Element -file $Result/BeamSpring23200_M.txt -time  -ele 23200 force;
recorder Element -file $Result/BeamSpring23200_R.txt -time  -ele 23200 deformation;
recorder Element -file $Result/BeamSpring32400_M.txt -time  -ele 32400 force;
recorder Element -file $Result/BeamSpring32400_R.txt -time  -ele 32400 deformation;
recorder Element -file $Result/BeamSpring33200_M.txt -time  -ele 33200 force;
recorder Element -file $Result/BeamSpring33200_R.txt -time  -ele 33200 deformation;
recorder Element -file $Result/BeamSpring42400_M.txt -time  -ele 42400 force;
recorder Element -file $Result/BeamSpring42400_R.txt -time  -ele 42400 deformation;
recorder Element -file $Result/BeamSpring43200_M.txt -time  -ele 43200 force;
recorder Element -file $Result/BeamSpring43200_R.txt -time  -ele 43200 deformation;
recorder Element -file $Result/BeamSpring52400_M.txt -time  -ele 52400 force;
recorder Element -file $Result/BeamSpring52400_R.txt -time  -ele 52400 deformation;
recorder Element -file $Result/BeamSpring53200_M.txt -time  -ele 53200 force;
recorder Element -file $Result/BeamSpring53200_R.txt -time  -ele 53200 deformation;
recorder Element -file $Result/BeamSpring23400_M.txt -time  -ele 23400 force;
recorder Element -file $Result/BeamSpring23400_R.txt -time  -ele 23400 deformation;
recorder Element -file $Result/BeamSpring24200_M.txt -time  -ele 24200 force;
recorder Element -file $Result/BeamSpring24200_R.txt -time  -ele 24200 deformation;
recorder Element -file $Result/BeamSpring33400_M.txt -time  -ele 33400 force;
recorder Element -file $Result/BeamSpring33400_R.txt -time  -ele 33400 deformation;
recorder Element -file $Result/BeamSpring34200_M.txt -time  -ele 34200 force;
recorder Element -file $Result/BeamSpring34200_R.txt -time  -ele 34200 deformation;
recorder Element -file $Result/BeamSpring43400_M.txt -time  -ele 43400 force;
recorder Element -file $Result/BeamSpring43400_R.txt -time  -ele 43400 deformation;
recorder Element -file $Result/BeamSpring44200_M.txt -time  -ele 44200 force;
recorder Element -file $Result/BeamSpring44200_R.txt -time  -ele 44200 deformation;
recorder Element -file $Result/BeamSpring53400_M.txt -time  -ele 53400 force;
recorder Element -file $Result/BeamSpring53400_R.txt -time  -ele 53400 deformation;
recorder Element -file $Result/BeamSpring54200_M.txt -time  -ele 54200 force;
recorder Element -file $Result/BeamSpring54200_R.txt -time  -ele 54200 deformation;
# Eigen value analysis;
# Mode Shapes;
set pi [expr 2.0*asin(1.0)];
set nEigen 3;
set lambdaNTot [eigen [expr $nEigen]];
set lambdaI [lindex $lambdaNTot 0];
set lambdaJ [lindex $lambdaNTot 1];
set lambdaK [lindex $lambdaNTot 2];
set w1 [expr pow($lambdaI,0.5)];
set w2 [expr pow($lambdaJ,0.5)];
set w3 [expr pow($lambdaK,0.5)];
set T1 [expr 2.0*$pi/$w1];
set T2 [expr 2.0*$pi/$w2];
set T3 [expr 2.0*$pi/$w3];
puts "";
puts "T1 = [expr {double(round($T1*1000))/1000}] s";
puts "T2 = [expr {double(round($T2*1000))/1000}] s";
puts "T3 = [expr {double(round($T3*1000))/1000}] s";
puts "Eigen Analysis Done";

#Store Eigen vector of 1st mode;
set eigenvector2 [nodeEigenvector 2102 1 1];
set eigenvector3 [nodeEigenvector 3102 1 1];
set eigenvector4 [nodeEigenvector 4102 1 1];
set eigenvector5 [nodeEigenvector 5102 1 1];

# Assign Loads, Analysis Type And Conversion Procedure;
# GRAVITY LOADS;
pattern Plain 100 Linear {
load 2101 0. [expr -1.0*190700.0000] 0. 0. 0. 0.;
load 2201 0. [expr -1.0*127130.0000] 0. 0. 0. 0.;
load 2301 0. [expr -1.0*127130.0000] 0. 0. 0. 0.;
load 2401 0. [expr -1.0*190700.0000] 0. 0. 0. 0.;
load 25 0. [expr -1.0*2692494.0000] 0. 0. 0. 0.;
load 3101 0. [expr -1.0*188980.0000] 0. 0. 0. 0.;
load 3201 0. [expr -1.0*125990.0000] 0. 0. 0. 0.;
load 3301 0. [expr -1.0*125990.0000] 0. 0. 0. 0.;
load 3401 0. [expr -1.0*188980.0000] 0. 0. 0. 0.;
load 35 0. [expr -1.0*2684411.0000] 0. 0. 0. 0.;
load 4101 0. [expr -1.0*188980.0000] 0. 0. 0. 0.;
load 4201 0. [expr -1.0*125990.0000] 0. 0. 0. 0.;
load 4301 0. [expr -1.0*125990.0000] 0. 0. 0. 0.;
load 4401 0. [expr -1.0*188980.0000] 0. 0. 0. 0.;
load 45 0. [expr -1.0*2684411.0000] 0. 0. 0. 0.;
load 5101 0. [expr -1.0*156000.0000] 0. 0. 0. 0.;
load 5201 0. [expr -1.0*103970.0000] 0. 0. 0. 0.;
load 5301 0. [expr -1.0*103970.0000] 0. 0. 0. 0.;
load 5401 0. [expr -1.0*156000.0000] 0. 0. 0. 0.;
load 55 0. [expr -1.0*2610000.0000] 0. 0. 0. 0.;
};
# CONVERSION PARAMETERS;
variable constraintsTypeGravity Transformation;		# default;
if {  [info exists RigidDiaphragm] == 1} {
if {$RigidDiaphragm=="ON"} {
variable constraintsTypeGravity Transformation;	#  large model: try Transformation
};	# if rigid diaphragm is on
};	# if rigid diaphragm exists
constraints $constraintsTypeGravity ;     		# how it handles boundary conditions
numberer RCM;
system BandGeneral;
test NormDispIncr 1.0e-4 500;
algorithm Newton;
integrator LoadControl 0.1;
analysis Static;
analyze 10;
loadConst -time 0.0;
wipeAnalysis;
puts "Gravity Done";


# Nonlinear dynamic analysis 

# Rayleigh Damping
# calculate damping parameters for earthquake loading
set zeta_EQ 0.025;		# percentage of critical damping
set zeta_FV 0.5;		# percentage of critical damping
set a0_EQ [expr $zeta_EQ*2.0*$w1*$w3/($w1+$w3)];	# mass damping coefficient based on first and third modes
set a1_EQ [expr $zeta_EQ*2.0/($w1+$w3)];	# stiffness damping coefficient based on first and third modes
set a0_FV [expr $zeta_FV*2.0*$w1*$w3/($w1+$w3)];	# mass damping coefficient based on first and third modes
set a1_FV [expr $zeta_FV*2.0/($w1+$w3)];	# stiffness damping coefficient based on first and third modes
puts "a0_EQ: $a0_EQ";
puts "a1_EQ: $a1_EQ";
set a1_EQ_mod_two [expr $a1_EQ*(1.0+10.0000)/10.0000]; # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_EQ_mod_one [expr (1.0+1.0/(2*10.0000))*$a1_EQ];    # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_FV_mod_two [expr $a1_FV*(1.0+10.0000)/10.0000]; # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_FV_mod_one [expr (1.0+1.0/(2*10.0000))*$a1_FV];    # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.

# Level earthquake

# Damping for level earthquake
# assign damping to frame columns
region 1 -ele  11032101  21033101  41035101  12032201  22033201  42035201  13032301  23033301  43035301  14032401  24033401  44035401  -rayleigh 0.0 0.0 $a1_EQ 0.0;# assign stiffness proportional damping to columns without splices
region 2 -ele  310331031  310314101  320332031  320314201  330333031  330314301  340334031  340314401  -rayleigh 0.0 0.0 $a1_EQ 0.0;# assign stiffness proportional damping to columns with splices
region 3 -ele  214222  314322  414422  514522  224232  324332  424432  524532  234242  334342  434442  534542  -rayleigh 0.0 0.0 $a1_EQ_mod_two 0.0;# assign stiffness proportional damping to beams G1
region 7 -node 2104  2202  2204  2302  2304  2402  3104  3202  3204  3302  3304  3402  4104  4202  4204  4302  4304  4402  5104  5202  5204  5302  5304  5402 -rayleigh $a0_EQ 0.0 0.0 0.0;# assign mass proportional damping to structure (assign to nodes with mass)

# Define ground motion parameters

set pattern1ID 1;              # Pattern ID
set GMXdirection 1;				# ground motion direction (1 = x)
set GMfile "GroundMotions-Historic/Canoga.th";      # ground motion filename
set dt 0.0100;					# timestep of input GM file
set Scalefact 2.1501;				# ground motion scaling factor
set TotalNumberOfSteps 2495;	# number of steps in ground motion
set GMtime [expr $dt*$TotalNumberOfSteps];	# total time of ground motion + free vibration

# define the acceleration series for the ground motion
# syntax:  "Series -dt $timestep_of_record -filePath $filename_with_acc_history -factor $scale_record_by_this_amount
set g 9810;
set accelSeries1 "Series -dt $dt -filePath $GMfile -factor [expr $Scalefact*$g]";

# create load pattern: apply acceleration to all fixed nodes with UniformExcitation
# command: pattern UniformExcitation $patternID $GMdir -accel $timeSeriesID 
pattern UniformExcitation $pattern1ID $GMXdirection -accel $accelSeries1;

puts "Running Dynamic Analysis..."
# define dynamic analysis parameters
set dt_analysis 0.0100;			# timestep of analysis
set FloorNodes [list  1103  2102  3102  4102  5102  ]; 
set FloorElevation [list 0 4300.0 8300.0 12300.0 16300.0 ]; 
set tStart [clock seconds];

# proc DynamicAnalysis {dt  dt_anal_Step   GMtime  numStories numBays DriftLimit FloorNodes  FloorElevation   h1       htyp};
DynamicAnalysis_V03        $dt  $dt_analysis  $GMtime    4       0.20    $FloorNodes     4300.0000      4000.0000;

# output time at end of analysis	
set currentTimeGM [getTime];	# get current analysis time	(after dynamic analysis)
puts "Ground motion time: $currentTimeGM";
set tFinish [clock seconds];
set tFinishGM [expr $tFinish - $tStart];
puts "Ground motion analysis duration: $tFinishGM] s";
loadConst -time 0.0;
wipeAnalysis;
puts "Level ground motion Done";

wipe;
wipe all;
