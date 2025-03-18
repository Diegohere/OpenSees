wipe;
wipe all;

model BasicBuilder -ndm 3 -ndf 6;

set ColTransfTag 1 
set BeamXDirTransfTag 2 
set BeamZDirTransfTag 3 
geomTransf Corotational $ColTransfTag 0 0 1;
geomTransf Linear $BeamXDirTransfTag 0 0 1;
geomTransf Linear $BeamZDirTransfTag 1 0 0;

set Source "0_Source";
source $Source/DisplayModel3D.tcl;
source $Source/DisplayPlane.tcl;
source $Source/DynamicAnalysis_V04.tcl;

file mkdir 4StoryEDefense3dModel_SF1.20_GradientPaper_V22_result;
global Result;
set Result "4StoryEDefense3dModel_SF1.20_GradientPaper_V22_result";

set E 205000.00;
set G 78846.15;

set Nstory 4;
set NBay 2;
set NDept 1;
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

set Depth1 0.00;
set Depth2 6000.00;

set n_fac 10.0;
set H_offset 0.0;

# Column at DEPTH-1 and STORY-1 and AXIS-1 (Bottom);
set            d_Col1_12_1_b 300.00;#Depth
set           bf_Col1_12_1_b 300.00;#Flange width
set           tw_Col1_12_1_b 12.00;#Web thickness
set           tf_Col1_12_1_b 12.00;#Flange thickness
set            r_Col1_12_1_b 0.00;#Radius at the k-area
set            A_Col1_12_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-1 (Bottom);
set            d_Col1_12_1_t 300.00;#Depth
set           bf_Col1_12_1_t 300.00;#Flange width
set           tw_Col1_12_1_t 12.00;#Web thickness
set           tf_Col1_12_1_t 12.00;#Flange thickness
set            r_Col1_12_1_t 0.00;#Radius at the k-area
set            A_Col1_12_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-1 and AXIS-2 (Bottom);
set            d_Col1_12_2_b 300.00;#Depth
set           bf_Col1_12_2_b 300.00;#Flange width
set           tw_Col1_12_2_b 12.00;#Web thickness
set           tf_Col1_12_2_b 12.00;#Flange thickness
set            r_Col1_12_2_b 0.00;#Radius at the k-area
set            A_Col1_12_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-2 (Bottom);
set            d_Col1_12_2_t 300.00;#Depth
set           bf_Col1_12_2_t 300.00;#Flange width
set           tw_Col1_12_2_t 12.00;#Web thickness
set           tf_Col1_12_2_t 12.00;#Flange thickness
set            r_Col1_12_2_t 0.00;#Radius at the k-area
set            A_Col1_12_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-1 and AXIS-3 (Bottom);
set            d_Col1_12_3_b 300.00;#Depth
set           bf_Col1_12_3_b 300.00;#Flange width
set           tw_Col1_12_3_b 12.00;#Web thickness
set           tf_Col1_12_3_b 12.00;#Flange thickness
set            r_Col1_12_3_b 0.00;#Radius at the k-area
set            A_Col1_12_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-3 (Bottom);
set            d_Col1_12_3_t 300.00;#Depth
set           bf_Col1_12_3_t 300.00;#Flange width
set           tw_Col1_12_3_t 12.00;#Web thickness
set           tf_Col1_12_3_t 12.00;#Flange thickness
set            r_Col1_12_3_t 0.00;#Radius at the k-area
set            A_Col1_12_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-1 (Bottom);
set            d_Col1_23_1_b 300.00;#Depth
set           bf_Col1_23_1_b 300.00;#Flange width
set           tw_Col1_23_1_b 12.00;#Web thickness
set           tf_Col1_23_1_b 12.00;#Flange thickness
set            r_Col1_23_1_b 0.00;#Radius at the k-area
set            A_Col1_23_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-1 (Bottom);
set            d_Col1_23_1_t 300.00;#Depth
set           bf_Col1_23_1_t 300.00;#Flange width
set           tw_Col1_23_1_t 12.00;#Web thickness
set           tf_Col1_23_1_t 12.00;#Flange thickness
set            r_Col1_23_1_t 0.00;#Radius at the k-area
set            A_Col1_23_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-2 (Bottom);
set            d_Col1_23_2_b 300.00;#Depth
set           bf_Col1_23_2_b 300.00;#Flange width
set           tw_Col1_23_2_b 12.00;#Web thickness
set           tf_Col1_23_2_b 12.00;#Flange thickness
set            r_Col1_23_2_b 0.00;#Radius at the k-area
set            A_Col1_23_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-2 (Bottom);
set            d_Col1_23_2_t 300.00;#Depth
set           bf_Col1_23_2_t 300.00;#Flange width
set           tw_Col1_23_2_t 12.00;#Web thickness
set           tf_Col1_23_2_t 12.00;#Flange thickness
set            r_Col1_23_2_t 0.00;#Radius at the k-area
set            A_Col1_23_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-3 (Bottom);
set            d_Col1_23_3_b 300.00;#Depth
set           bf_Col1_23_3_b 300.00;#Flange width
set           tw_Col1_23_3_b 12.00;#Web thickness
set           tf_Col1_23_3_b 12.00;#Flange thickness
set            r_Col1_23_3_b 0.00;#Radius at the k-area
set            A_Col1_23_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-3 (Bottom);
set            d_Col1_23_3_t 300.00;#Depth
set           bf_Col1_23_3_t 300.00;#Flange width
set           tw_Col1_23_3_t 12.00;#Web thickness
set           tf_Col1_23_3_t 12.00;#Flange thickness
set            r_Col1_23_3_t 0.00;#Radius at the k-area
set            A_Col1_23_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-1 (Bottom);
set            d_Col1_34_1_b 300.00;#Depth
set           bf_Col1_34_1_b 300.00;#Flange width
set           tw_Col1_34_1_b 12.00;#Web thickness
set           tf_Col1_34_1_b 12.00;#Flange thickness
set            r_Col1_34_1_b 0.00;#Radius at the k-area
set            A_Col1_34_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-1 (Bottom);
set            d_Col1_34_1_t 300.00;#Depth
set           bf_Col1_34_1_t 300.00;#Flange width
set           tw_Col1_34_1_t 12.00;#Web thickness
set           tf_Col1_34_1_t 12.00;#Flange thickness
set            r_Col1_34_1_t 0.00;#Radius at the k-area
set            A_Col1_34_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-2 (Bottom);
set            d_Col1_34_2_b 300.00;#Depth
set           bf_Col1_34_2_b 300.00;#Flange width
set           tw_Col1_34_2_b 12.00;#Web thickness
set           tf_Col1_34_2_b 12.00;#Flange thickness
set            r_Col1_34_2_b 0.00;#Radius at the k-area
set            A_Col1_34_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-2 (Bottom);
set            d_Col1_34_2_t 300.00;#Depth
set           bf_Col1_34_2_t 300.00;#Flange width
set           tw_Col1_34_2_t 12.00;#Web thickness
set           tf_Col1_34_2_t 12.00;#Flange thickness
set            r_Col1_34_2_t 0.00;#Radius at the k-area
set            A_Col1_34_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-3 (Bottom);
set            d_Col1_34_3_b 300.00;#Depth
set           bf_Col1_34_3_b 300.00;#Flange width
set           tw_Col1_34_3_b 12.00;#Web thickness
set           tf_Col1_34_3_b 12.00;#Flange thickness
set            r_Col1_34_3_b 0.00;#Radius at the k-area
set            A_Col1_34_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-3 (Bottom);
set            d_Col1_34_3_t 300.00;#Depth
set           bf_Col1_34_3_t 300.00;#Flange width
set           tw_Col1_34_3_t 12.00;#Web thickness
set           tf_Col1_34_3_t 12.00;#Flange thickness
set            r_Col1_34_3_t 0.00;#Radius at the k-area
set            A_Col1_34_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-1 (Bottom);
set            d_Col1_45_1_b 300.00;#Depth
set           bf_Col1_45_1_b 300.00;#Flange width
set           tw_Col1_45_1_b 12.00;#Web thickness
set           tf_Col1_45_1_b 12.00;#Flange thickness
set            r_Col1_45_1_b 0.00;#Radius at the k-area
set            A_Col1_45_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-1 (Bottom);
set            d_Col1_45_1_t 300.00;#Depth
set           bf_Col1_45_1_t 300.00;#Flange width
set           tw_Col1_45_1_t 12.00;#Web thickness
set           tf_Col1_45_1_t 12.00;#Flange thickness
set            r_Col1_45_1_t 0.00;#Radius at the k-area
set            A_Col1_45_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-2 (Bottom);
set            d_Col1_45_2_b 300.00;#Depth
set           bf_Col1_45_2_b 300.00;#Flange width
set           tw_Col1_45_2_b 12.00;#Web thickness
set           tf_Col1_45_2_b 12.00;#Flange thickness
set            r_Col1_45_2_b 0.00;#Radius at the k-area
set            A_Col1_45_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-2 (Bottom);
set            d_Col1_45_2_t 300.00;#Depth
set           bf_Col1_45_2_t 300.00;#Flange width
set           tw_Col1_45_2_t 12.00;#Web thickness
set           tf_Col1_45_2_t 12.00;#Flange thickness
set            r_Col1_45_2_t 0.00;#Radius at the k-area
set            A_Col1_45_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-3 (Bottom);
set            d_Col1_45_3_b 300.00;#Depth
set           bf_Col1_45_3_b 300.00;#Flange width
set           tw_Col1_45_3_b 12.00;#Web thickness
set           tf_Col1_45_3_b 12.00;#Flange thickness
set            r_Col1_45_3_b 0.00;#Radius at the k-area
set            A_Col1_45_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-3 (Bottom);
set            d_Col1_45_3_t 300.00;#Depth
set           bf_Col1_45_3_t 300.00;#Flange width
set           tw_Col1_45_3_t 12.00;#Web thickness
set           tf_Col1_45_3_t 12.00;#Flange thickness
set            r_Col1_45_3_t 0.00;#Radius at the k-area
set            A_Col1_45_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_3_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-1 and AXIS-1 (Bottom);
set            d_Col2_12_1_b 300.00;#Depth
set           bf_Col2_12_1_b 300.00;#Flange width
set           tw_Col2_12_1_b 12.00;#Web thickness
set           tf_Col2_12_1_b 12.00;#Flange thickness
set            r_Col2_12_1_b 0.00;#Radius at the k-area
set            A_Col2_12_1_b 10270.00;#Cross-sectional area
set           Ix_Col2_12_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_1_b 118.00;#Radius of gyration about weak axis
set            J_Col2_12_1_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-1 and AXIS-1 (Bottom);
set            d_Col2_12_1_t 300.00;#Depth
set           bf_Col2_12_1_t 300.00;#Flange width
set           tw_Col2_12_1_t 12.00;#Web thickness
set           tf_Col2_12_1_t 12.00;#Flange thickness
set            r_Col2_12_1_t 0.00;#Radius at the k-area
set            A_Col2_12_1_t 10270.00;#Cross-sectional area
set           Ix_Col2_12_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_1_t 118.00;#Radius of gyration about weak axis
set            J_Col2_12_1_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-1 and AXIS-2 (Bottom);
set            d_Col2_12_2_b 300.00;#Depth
set           bf_Col2_12_2_b 300.00;#Flange width
set           tw_Col2_12_2_b 12.00;#Web thickness
set           tf_Col2_12_2_b 12.00;#Flange thickness
set            r_Col2_12_2_b 0.00;#Radius at the k-area
set            A_Col2_12_2_b 10270.00;#Cross-sectional area
set           Ix_Col2_12_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_2_b 118.00;#Radius of gyration about weak axis
set            J_Col2_12_2_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-1 and AXIS-2 (Bottom);
set            d_Col2_12_2_t 300.00;#Depth
set           bf_Col2_12_2_t 300.00;#Flange width
set           tw_Col2_12_2_t 12.00;#Web thickness
set           tf_Col2_12_2_t 12.00;#Flange thickness
set            r_Col2_12_2_t 0.00;#Radius at the k-area
set            A_Col2_12_2_t 10270.00;#Cross-sectional area
set           Ix_Col2_12_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_2_t 118.00;#Radius of gyration about weak axis
set            J_Col2_12_2_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-1 and AXIS-3 (Bottom);
set            d_Col2_12_3_b 300.00;#Depth
set           bf_Col2_12_3_b 300.00;#Flange width
set           tw_Col2_12_3_b 12.00;#Web thickness
set           tf_Col2_12_3_b 12.00;#Flange thickness
set            r_Col2_12_3_b 0.00;#Radius at the k-area
set            A_Col2_12_3_b 10270.00;#Cross-sectional area
set           Ix_Col2_12_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_3_b 118.00;#Radius of gyration about weak axis
set            J_Col2_12_3_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-1 and AXIS-3 (Bottom);
set            d_Col2_12_3_t 300.00;#Depth
set           bf_Col2_12_3_t 300.00;#Flange width
set           tw_Col2_12_3_t 12.00;#Web thickness
set           tf_Col2_12_3_t 12.00;#Flange thickness
set            r_Col2_12_3_t 0.00;#Radius at the k-area
set            A_Col2_12_3_t 10270.00;#Cross-sectional area
set           Ix_Col2_12_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_12_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_12_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_12_3_t 118.00;#Radius of gyration about weak axis
set            J_Col2_12_3_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-2 and AXIS-1 (Bottom);
set            d_Col2_23_1_b 300.00;#Depth
set           bf_Col2_23_1_b 300.00;#Flange width
set           tw_Col2_23_1_b 12.00;#Web thickness
set           tf_Col2_23_1_b 12.00;#Flange thickness
set            r_Col2_23_1_b 0.00;#Radius at the k-area
set            A_Col2_23_1_b 10270.00;#Cross-sectional area
set           Ix_Col2_23_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_1_b 118.00;#Radius of gyration about weak axis
set            J_Col2_23_1_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-2 and AXIS-1 (Bottom);
set            d_Col2_23_1_t 300.00;#Depth
set           bf_Col2_23_1_t 300.00;#Flange width
set           tw_Col2_23_1_t 12.00;#Web thickness
set           tf_Col2_23_1_t 12.00;#Flange thickness
set            r_Col2_23_1_t 0.00;#Radius at the k-area
set            A_Col2_23_1_t 10270.00;#Cross-sectional area
set           Ix_Col2_23_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_1_t 118.00;#Radius of gyration about weak axis
set            J_Col2_23_1_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-2 and AXIS-2 (Bottom);
set            d_Col2_23_2_b 300.00;#Depth
set           bf_Col2_23_2_b 300.00;#Flange width
set           tw_Col2_23_2_b 12.00;#Web thickness
set           tf_Col2_23_2_b 12.00;#Flange thickness
set            r_Col2_23_2_b 0.00;#Radius at the k-area
set            A_Col2_23_2_b 10270.00;#Cross-sectional area
set           Ix_Col2_23_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_2_b 118.00;#Radius of gyration about weak axis
set            J_Col2_23_2_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-2 and AXIS-2 (Bottom);
set            d_Col2_23_2_t 300.00;#Depth
set           bf_Col2_23_2_t 300.00;#Flange width
set           tw_Col2_23_2_t 12.00;#Web thickness
set           tf_Col2_23_2_t 12.00;#Flange thickness
set            r_Col2_23_2_t 0.00;#Radius at the k-area
set            A_Col2_23_2_t 10270.00;#Cross-sectional area
set           Ix_Col2_23_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_2_t 118.00;#Radius of gyration about weak axis
set            J_Col2_23_2_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-2 and AXIS-3 (Bottom);
set            d_Col2_23_3_b 300.00;#Depth
set           bf_Col2_23_3_b 300.00;#Flange width
set           tw_Col2_23_3_b 12.00;#Web thickness
set           tf_Col2_23_3_b 12.00;#Flange thickness
set            r_Col2_23_3_b 0.00;#Radius at the k-area
set            A_Col2_23_3_b 10270.00;#Cross-sectional area
set           Ix_Col2_23_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_3_b 118.00;#Radius of gyration about weak axis
set            J_Col2_23_3_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-2 and AXIS-3 (Bottom);
set            d_Col2_23_3_t 300.00;#Depth
set           bf_Col2_23_3_t 300.00;#Flange width
set           tw_Col2_23_3_t 12.00;#Web thickness
set           tf_Col2_23_3_t 12.00;#Flange thickness
set            r_Col2_23_3_t 0.00;#Radius at the k-area
set            A_Col2_23_3_t 10270.00;#Cross-sectional area
set           Ix_Col2_23_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_23_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_23_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_23_3_t 118.00;#Radius of gyration about weak axis
set            J_Col2_23_3_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-3 and AXIS-1 (Bottom);
set            d_Col2_34_1_b 300.00;#Depth
set           bf_Col2_34_1_b 300.00;#Flange width
set           tw_Col2_34_1_b 12.00;#Web thickness
set           tf_Col2_34_1_b 12.00;#Flange thickness
set            r_Col2_34_1_b 0.00;#Radius at the k-area
set            A_Col2_34_1_b 10270.00;#Cross-sectional area
set           Ix_Col2_34_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_1_b 118.00;#Radius of gyration about weak axis
set            J_Col2_34_1_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-3 and AXIS-1 (Bottom);
set            d_Col2_34_1_t 300.00;#Depth
set           bf_Col2_34_1_t 300.00;#Flange width
set           tw_Col2_34_1_t 12.00;#Web thickness
set           tf_Col2_34_1_t 12.00;#Flange thickness
set            r_Col2_34_1_t 0.00;#Radius at the k-area
set            A_Col2_34_1_t 10270.00;#Cross-sectional area
set           Ix_Col2_34_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_1_t 118.00;#Radius of gyration about weak axis
set            J_Col2_34_1_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-3 and AXIS-2 (Bottom);
set            d_Col2_34_2_b 300.00;#Depth
set           bf_Col2_34_2_b 300.00;#Flange width
set           tw_Col2_34_2_b 12.00;#Web thickness
set           tf_Col2_34_2_b 12.00;#Flange thickness
set            r_Col2_34_2_b 0.00;#Radius at the k-area
set            A_Col2_34_2_b 10270.00;#Cross-sectional area
set           Ix_Col2_34_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_2_b 118.00;#Radius of gyration about weak axis
set            J_Col2_34_2_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-3 and AXIS-2 (Bottom);
set            d_Col2_34_2_t 300.00;#Depth
set           bf_Col2_34_2_t 300.00;#Flange width
set           tw_Col2_34_2_t 12.00;#Web thickness
set           tf_Col2_34_2_t 12.00;#Flange thickness
set            r_Col2_34_2_t 0.00;#Radius at the k-area
set            A_Col2_34_2_t 10270.00;#Cross-sectional area
set           Ix_Col2_34_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_2_t 118.00;#Radius of gyration about weak axis
set            J_Col2_34_2_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-3 and AXIS-3 (Bottom);
set            d_Col2_34_3_b 300.00;#Depth
set           bf_Col2_34_3_b 300.00;#Flange width
set           tw_Col2_34_3_b 12.00;#Web thickness
set           tf_Col2_34_3_b 12.00;#Flange thickness
set            r_Col2_34_3_b 0.00;#Radius at the k-area
set            A_Col2_34_3_b 10270.00;#Cross-sectional area
set           Ix_Col2_34_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_3_b 118.00;#Radius of gyration about weak axis
set            J_Col2_34_3_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-3 and AXIS-3 (Bottom);
set            d_Col2_34_3_t 300.00;#Depth
set           bf_Col2_34_3_t 300.00;#Flange width
set           tw_Col2_34_3_t 12.00;#Web thickness
set           tf_Col2_34_3_t 12.00;#Flange thickness
set            r_Col2_34_3_t 0.00;#Radius at the k-area
set            A_Col2_34_3_t 10270.00;#Cross-sectional area
set           Ix_Col2_34_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_34_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_34_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_34_3_t 118.00;#Radius of gyration about weak axis
set            J_Col2_34_3_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-4 and AXIS-1 (Bottom);
set            d_Col2_45_1_b 300.00;#Depth
set           bf_Col2_45_1_b 300.00;#Flange width
set           tw_Col2_45_1_b 12.00;#Web thickness
set           tf_Col2_45_1_b 12.00;#Flange thickness
set            r_Col2_45_1_b 0.00;#Radius at the k-area
set            A_Col2_45_1_b 10270.00;#Cross-sectional area
set           Ix_Col2_45_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_1_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_1_b 118.00;#Radius of gyration about weak axis
set            J_Col2_45_1_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-4 and AXIS-1 (Bottom);
set            d_Col2_45_1_t 300.00;#Depth
set           bf_Col2_45_1_t 300.00;#Flange width
set           tw_Col2_45_1_t 12.00;#Web thickness
set           tf_Col2_45_1_t 12.00;#Flange thickness
set            r_Col2_45_1_t 0.00;#Radius at the k-area
set            A_Col2_45_1_t 10270.00;#Cross-sectional area
set           Ix_Col2_45_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_1_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_1_t 118.00;#Radius of gyration about weak axis
set            J_Col2_45_1_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-4 and AXIS-2 (Bottom);
set            d_Col2_45_2_b 300.00;#Depth
set           bf_Col2_45_2_b 300.00;#Flange width
set           tw_Col2_45_2_b 12.00;#Web thickness
set           tf_Col2_45_2_b 12.00;#Flange thickness
set            r_Col2_45_2_b 0.00;#Radius at the k-area
set            A_Col2_45_2_b 10270.00;#Cross-sectional area
set           Ix_Col2_45_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_2_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_2_b 118.00;#Radius of gyration about weak axis
set            J_Col2_45_2_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-4 and AXIS-2 (Bottom);
set            d_Col2_45_2_t 300.00;#Depth
set           bf_Col2_45_2_t 300.00;#Flange width
set           tw_Col2_45_2_t 12.00;#Web thickness
set           tf_Col2_45_2_t 12.00;#Flange thickness
set            r_Col2_45_2_t 0.00;#Radius at the k-area
set            A_Col2_45_2_t 10270.00;#Cross-sectional area
set           Ix_Col2_45_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_2_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_2_t 118.00;#Radius of gyration about weak axis
set            J_Col2_45_2_t 221779539.00;#Torsion constant


# Column at DEPTH-2 and STORY-4 and AXIS-3 (Bottom);
set            d_Col2_45_3_b 300.00;#Depth
set           bf_Col2_45_3_b 300.00;#Flange width
set           tw_Col2_45_3_b 12.00;#Web thickness
set           tf_Col2_45_3_b 12.00;#Flange thickness
set            r_Col2_45_3_b 0.00;#Radius at the k-area
set            A_Col2_45_3_b 10270.00;#Cross-sectional area
set           Ix_Col2_45_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_3_b 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_3_b 118.00;#Radius of gyration about weak axis
set            J_Col2_45_3_b 221779539.00;#Torsion constant

# Column at DEPTH-2 and STORY-4 and AXIS-3 (Bottom);
set            d_Col2_45_3_t 300.00;#Depth
set           bf_Col2_45_3_t 300.00;#Flange width
set           tw_Col2_45_3_t 12.00;#Web thickness
set           tf_Col2_45_3_t 12.00;#Flange thickness
set            r_Col2_45_3_t 0.00;#Radius at the k-area
set            A_Col2_45_3_t 10270.00;#Cross-sectional area
set           Ix_Col2_45_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col2_45_3_t 1110000.00;#Plastic section modulus abotu strong axis
set           Iy_Col2_45_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col2_45_3_t 118.00;#Radius of gyration about weak axis
set            J_Col2_45_3_t 221779539.00;#Torsion constant


# Beam G1 at Direction-1 and Depth-1 and SPAN-1 and FLOOR-2;
set             d_Beam1_1_12_2 400.00;#Depth
set            bf_Beam1_1_12_2 200.00;#Flange width
set            tw_Beam1_1_12_2 8.00;#Web thickness
set            tf_Beam1_1_12_2 13.00;#Flange thickness
set             r_Beam1_1_12_2 13.00;#Radius at the k-area
set             A_Beam1_1_12_2 8337.07;#Cross-sectional area
set            Ix_Beam1_1_12_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam1_1_12_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_12_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam1_1_12_2 45.63;#Radius of gyration about weak axis
set             J_Beam1_1_12_2 356762.67;#Torsion constant
set   K_mem_canti_Beam1_1_12_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_12_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_12_2 0.00767;#Yield chord rotation 
set         a_mem_Beam1_1_12_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_12_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam1_1_12_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_12_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_12_2 0.40;#Residual moment
set      Mres_mem_Beam1_1_12_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_12_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_12_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam1_1_12_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam1_1_12_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam1_1_12_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_12_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_12_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_12_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_12_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_12_2 134794453023.09;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_12_2 653017771.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_12_2 0.00484;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_12_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_12_2 848923103.46;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_12_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_12_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_12_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_12_2 195905331.56753;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_12_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_12_2 0.02149;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_12_2 1482738983254.01;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_12_2 653017771.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_12_2 0.00199;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_12_2 0.06630;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_12_2 0.22154;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_12_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_12_2 0.19766;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_12_2 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_12_2 1566.67;#Unbraced length
set        Lambda_Beam1_1_12_2 0.96638;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-2 and FLOOR-2;
set             d_Beam1_1_23_2 400.00;#Depth
set            bf_Beam1_1_23_2 200.00;#Flange width
set            tw_Beam1_1_23_2 8.00;#Web thickness
set            tf_Beam1_1_23_2 13.00;#Flange thickness
set             r_Beam1_1_23_2 13.00;#Radius at the k-area
set             A_Beam1_1_23_2 8337.07;#Cross-sectional area
set            Ix_Beam1_1_23_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam1_1_23_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_23_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam1_1_23_2 45.63;#Radius of gyration about weak axis
set             J_Beam1_1_23_2 356762.67;#Torsion constant
set   K_mem_canti_Beam1_1_23_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_23_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_23_2 0.00767;#Yield chord rotation 
set         a_mem_Beam1_1_23_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_23_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam1_1_23_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_23_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_23_2 0.40;#Residual moment
set      Mres_mem_Beam1_1_23_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_23_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_23_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam1_1_23_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam1_1_23_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam1_1_23_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_23_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_23_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_23_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_23_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_23_2 134794453023.09;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_23_2 653017771.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_23_2 0.00484;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_23_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_23_2 848923103.46;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_23_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_23_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_23_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_23_2 195905331.56753;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_23_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_23_2 0.02149;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_23_2 1482738983254.01;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_23_2 653017771.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_23_2 0.00199;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_23_2 0.06630;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_23_2 0.22154;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_23_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_23_2 0.19766;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_23_2 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_23_2 1566.67;#Unbraced length
set        Lambda_Beam1_1_23_2 0.96638;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-1 and FLOOR-3;
set             d_Beam1_1_12_3 396.00;#Depth
set            bf_Beam1_1_12_3 199.00;#Flange width
set            tw_Beam1_1_12_3 7.00;#Web thickness
set            tf_Beam1_1_12_3 11.00;#Flange thickness
set             r_Beam1_1_12_3 13.00;#Radius at the k-area
set             A_Beam1_1_12_3 7141.07;#Cross-sectional area
set            Ix_Beam1_1_12_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam1_1_12_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_12_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam1_1_12_3 45.01;#Radius of gyration about weak axis
set             J_Beam1_1_12_3 219340.00;#Torsion constant
set   K_mem_canti_Beam1_1_12_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_12_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_12_3 0.00737;#Yield chord rotation 
set         a_mem_Beam1_1_12_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_12_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam1_1_12_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_12_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_12_3 0.40;#Residual moment
set      Mres_mem_Beam1_1_12_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_12_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_12_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam1_1_12_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam1_1_12_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam1_1_12_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_12_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_12_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_12_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_12_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_12_3 113896199227.56;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_12_3 531120245.17;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_12_3 0.00466;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_12_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_12_3 690456318.72;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_12_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_12_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_12_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_12_3 159336073.54966;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_12_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_12_3 0.02175;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_12_3 1252858191503.12;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_12_3 531120245.17;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_12_3 0.00202;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_12_3 0.06305;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_12_3 0.19409;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_12_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_12_3 0.19832;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_12_3 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_12_3 1566.67;#Unbraced length
set        Lambda_Beam1_1_12_3 0.74633;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-2 and FLOOR-3;
set             d_Beam1_1_23_3 396.00;#Depth
set            bf_Beam1_1_23_3 199.00;#Flange width
set            tw_Beam1_1_23_3 7.00;#Web thickness
set            tf_Beam1_1_23_3 11.00;#Flange thickness
set             r_Beam1_1_23_3 13.00;#Radius at the k-area
set             A_Beam1_1_23_3 7141.07;#Cross-sectional area
set            Ix_Beam1_1_23_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam1_1_23_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_23_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam1_1_23_3 45.01;#Radius of gyration about weak axis
set             J_Beam1_1_23_3 219340.00;#Torsion constant
set   K_mem_canti_Beam1_1_23_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_23_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_23_3 0.00737;#Yield chord rotation 
set         a_mem_Beam1_1_23_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_23_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam1_1_23_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_23_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_23_3 0.40;#Residual moment
set      Mres_mem_Beam1_1_23_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_23_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_23_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam1_1_23_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam1_1_23_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam1_1_23_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_23_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_23_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_23_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_23_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_23_3 113896199227.56;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_23_3 531120245.17;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_23_3 0.00466;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_23_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_23_3 690456318.72;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_23_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_23_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_23_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_23_3 159336073.54966;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_23_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_23_3 0.02175;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_23_3 1252858191503.12;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_23_3 531120245.17;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_23_3 0.00202;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_23_3 0.06305;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_23_3 0.19409;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_23_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_23_3 0.19832;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_23_3 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_23_3 1566.67;#Unbraced length
set        Lambda_Beam1_1_23_3 0.74633;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-1 and FLOOR-4;
set             d_Beam1_1_12_4 350.00;#Depth
set            bf_Beam1_1_12_4 175.00;#Flange width
set            tw_Beam1_1_12_4 7.00;#Web thickness
set            tf_Beam1_1_12_4 11.00;#Flange thickness
set             r_Beam1_1_12_4 13.00;#Radius at the k-area
set             A_Beam1_1_12_4 6291.07;#Cross-sectional area
set            Ix_Beam1_1_12_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam1_1_12_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_12_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam1_1_12_4 39.55;#Radius of gyration about weak axis
set             J_Beam1_1_12_4 192784.67;#Torsion constant
set   K_mem_canti_Beam1_1_12_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_12_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_12_4 0.00813;#Yield chord rotation 
set         a_mem_Beam1_1_12_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_12_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam1_1_12_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_12_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_12_4 0.40;#Residual moment
set      Mres_mem_Beam1_1_12_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_12_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_12_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam1_1_12_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam1_1_12_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam1_1_12_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_12_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_12_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_12_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_12_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_12_4 96080337885.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_12_4 439382285.18;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_12_4 0.00457;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_12_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_12_4 571196970.73;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_12_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_12_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_12_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_12_4 131814685.55399;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_12_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_12_4 0.01733;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_12_4 1056883716739.73;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_12_4 439382285.18;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_12_4 0.00160;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_12_4 0.07791;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_12_4 0.24985;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_12_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_12_4 0.19717;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_12_4 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_12_4 1566.67;#Unbraced length
set        Lambda_Beam1_1_12_4 0.98456;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-2 and FLOOR-4;
set             d_Beam1_1_23_4 350.00;#Depth
set            bf_Beam1_1_23_4 175.00;#Flange width
set            tw_Beam1_1_23_4 7.00;#Web thickness
set            tf_Beam1_1_23_4 11.00;#Flange thickness
set             r_Beam1_1_23_4 13.00;#Radius at the k-area
set             A_Beam1_1_23_4 6291.07;#Cross-sectional area
set            Ix_Beam1_1_23_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam1_1_23_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_23_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam1_1_23_4 39.55;#Radius of gyration about weak axis
set             J_Beam1_1_23_4 192784.67;#Torsion constant
set   K_mem_canti_Beam1_1_23_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_23_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_23_4 0.00813;#Yield chord rotation 
set         a_mem_Beam1_1_23_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_23_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam1_1_23_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_23_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_23_4 0.40;#Residual moment
set      Mres_mem_Beam1_1_23_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_23_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_23_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam1_1_23_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam1_1_23_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam1_1_23_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_23_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_23_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_23_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_23_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_23_4 96080337885.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_23_4 439382285.18;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_23_4 0.00457;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_23_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_23_4 571196970.73;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_23_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_23_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_23_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_23_4 131814685.55399;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_23_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_23_4 0.01733;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_23_4 1056883716739.73;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_23_4 439382285.18;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_23_4 0.00160;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_23_4 0.07791;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_23_4 0.24985;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_23_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_23_4 0.19717;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_23_4 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_23_4 1566.67;#Unbraced length
set        Lambda_Beam1_1_23_4 0.98456;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-1 and FLOOR-5;
set             d_Beam1_1_12_5 346.00;#Depth
set            bf_Beam1_1_12_5 174.00;#Flange width
set            tw_Beam1_1_12_5 6.00;#Web thickness
set            tf_Beam1_1_12_5 9.00;#Flange thickness
set             r_Beam1_1_12_5 13.00;#Radius at the k-area
set             A_Beam1_1_12_5 5245.07;#Cross-sectional area
set            Ix_Beam1_1_12_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam1_1_12_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_12_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam1_1_12_5 38.84;#Radius of gyration about weak axis
set             J_Beam1_1_12_5 108180.00;#Torsion constant
set   K_mem_canti_Beam1_1_12_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_12_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_12_5 0.00904;#Yield chord rotation 
set         a_mem_Beam1_1_12_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_12_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam1_1_12_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_12_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_12_5 0.40;#Residual moment
set      Mres_mem_Beam1_1_12_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_12_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_12_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam1_1_12_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam1_1_12_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam1_1_12_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_12_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_12_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_12_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_12_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_12_5 74482215930.88;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_12_5 391029469.42;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_12_5 0.00525;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_12_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_12_5 508338310.24;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_12_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_12_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_12_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_12_5 117308840.82498;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_12_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_12_5 0.02185;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_12_5 819304375239.64;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_12_5 391029469.42;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_12_5 0.00203;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_12_5 0.07064;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_12_5 0.17345;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_12_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_12_5 0.19835;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_12_5 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_12_5 1566.67;#Unbraced length
set        Lambda_Beam1_1_12_5 0.68846;#

# Beam G1 at Direction-1 and Depth-1 and SPAN-2 and FLOOR-5;
set             d_Beam1_1_23_5 346.00;#Depth
set            bf_Beam1_1_23_5 174.00;#Flange width
set            tw_Beam1_1_23_5 6.00;#Web thickness
set            tf_Beam1_1_23_5 9.00;#Flange thickness
set             r_Beam1_1_23_5 13.00;#Radius at the k-area
set             A_Beam1_1_23_5 5245.07;#Cross-sectional area
set            Ix_Beam1_1_23_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam1_1_23_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_1_23_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam1_1_23_5 38.84;#Radius of gyration about weak axis
set             J_Beam1_1_23_5 108180.00;#Torsion constant
set   K_mem_canti_Beam1_1_23_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_1_23_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam1_1_23_5 0.00904;#Yield chord rotation 
set         a_mem_Beam1_1_23_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_1_23_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam1_1_23_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_1_23_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam1_1_23_5 0.40;#Residual moment
set      Mres_mem_Beam1_1_23_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_1_23_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_1_23_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam1_1_23_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam1_1_23_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam1_1_23_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_1_23_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_1_23_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_1_23_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_1_23_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_1_23_5 74482215930.88;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_1_23_5 391029469.42;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_1_23_5 0.00525;#Composite Yield chord rotation 
set         a_mem_BeamComp1_1_23_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_1_23_5 508338310.24;#Composite Capping moment
set   Theta_p_mem_BeamComp1_1_23_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_1_23_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_1_23_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_1_23_5 117308840.82498;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_1_23_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_1_23_5 0.02185;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_1_23_5 819304375239.64;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_1_23_5 391029469.42;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_1_23_5 0.00203;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_1_23_5 0.07064;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_1_23_5 0.17345;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_1_23_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_1_23_5 0.19835;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_1_23_5 2350.00;#Effective canti-lever length
set            Lb_Beam1_1_23_5 1566.67;#Unbraced length
set        Lambda_Beam1_1_23_5 0.68846;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-1 and FLOOR-2;
set             d_Beam1_2_12_2 400.00;#Depth
set            bf_Beam1_2_12_2 200.00;#Flange width
set            tw_Beam1_2_12_2 8.00;#Web thickness
set            tf_Beam1_2_12_2 13.00;#Flange thickness
set             r_Beam1_2_12_2 13.00;#Radius at the k-area
set             A_Beam1_2_12_2 8337.07;#Cross-sectional area
set            Ix_Beam1_2_12_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam1_2_12_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_12_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam1_2_12_2 45.63;#Radius of gyration about weak axis
set             J_Beam1_2_12_2 356762.67;#Torsion constant
set   K_mem_canti_Beam1_2_12_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_12_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_12_2 0.00767;#Yield chord rotation 
set         a_mem_Beam1_2_12_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_12_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam1_2_12_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_12_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_12_2 0.40;#Residual moment
set      Mres_mem_Beam1_2_12_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_12_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_12_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam1_2_12_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam1_2_12_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam1_2_12_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_12_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_12_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_12_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_12_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_12_2 134794453023.09;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_12_2 653017771.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_12_2 0.00484;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_12_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_12_2 848923103.46;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_12_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_12_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_12_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_12_2 195905331.56753;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_12_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_12_2 0.02149;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_12_2 1482738983254.01;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_12_2 653017771.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_12_2 0.00199;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_12_2 0.06630;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_12_2 0.22154;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_12_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_12_2 0.19766;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_12_2 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_12_2 1566.67;#Unbraced length
set        Lambda_Beam1_2_12_2 0.96638;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-2 and FLOOR-2;
set             d_Beam1_2_23_2 400.00;#Depth
set            bf_Beam1_2_23_2 200.00;#Flange width
set            tw_Beam1_2_23_2 8.00;#Web thickness
set            tf_Beam1_2_23_2 13.00;#Flange thickness
set             r_Beam1_2_23_2 13.00;#Radius at the k-area
set             A_Beam1_2_23_2 8337.07;#Cross-sectional area
set            Ix_Beam1_2_23_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam1_2_23_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_23_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam1_2_23_2 45.63;#Radius of gyration about weak axis
set             J_Beam1_2_23_2 356762.67;#Torsion constant
set   K_mem_canti_Beam1_2_23_2 61386240554.57;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_23_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_23_2 0.00767;#Yield chord rotation 
set         a_mem_Beam1_2_23_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_23_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam1_2_23_2 0.03756;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_23_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_23_2 0.40;#Residual moment
set      Mres_mem_Beam1_2_23_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_23_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_23_2 0.02041;#Post-yielding stiffness ratio
set           K_s_Beam1_2_23_2 675248646100.22;#Initial stiffness of the spring
set          My_s_Beam1_2_23_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam1_2_23_2 0.00189;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_23_2 0.03687;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_23_2 0.16753;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_23_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_23_2 0.19721;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_23_2 134794453023.09;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_23_2 653017771.89;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_23_2 0.00484;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_23_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_23_2 848923103.46;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_23_2 0.06762;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_23_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_23_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_23_2 195905331.56753;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_23_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_23_2 0.02149;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_23_2 1482738983254.01;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_23_2 653017771.89;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_23_2 0.00199;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_23_2 0.06630;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_23_2 0.22154;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_23_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_23_2 0.19766;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_23_2 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_23_2 1566.67;#Unbraced length
set        Lambda_Beam1_2_23_2 0.96638;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-1 and FLOOR-3;
set             d_Beam1_2_12_3 396.00;#Depth
set            bf_Beam1_2_12_3 199.00;#Flange width
set            tw_Beam1_2_12_3 7.00;#Web thickness
set            tf_Beam1_2_12_3 11.00;#Flange thickness
set             r_Beam1_2_12_3 13.00;#Radius at the k-area
set             A_Beam1_2_12_3 7141.07;#Cross-sectional area
set            Ix_Beam1_2_12_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam1_2_12_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_12_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam1_2_12_3 45.01;#Radius of gyration about weak axis
set             J_Beam1_2_12_3 219340.00;#Torsion constant
set   K_mem_canti_Beam1_2_12_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_12_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_12_3 0.00737;#Yield chord rotation 
set         a_mem_Beam1_2_12_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_12_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam1_2_12_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_12_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_12_3 0.40;#Residual moment
set      Mres_mem_Beam1_2_12_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_12_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_12_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam1_2_12_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam1_2_12_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam1_2_12_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_12_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_12_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_12_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_12_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_12_3 113896199227.56;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_12_3 531120245.17;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_12_3 0.00466;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_12_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_12_3 690456318.72;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_12_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_12_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_12_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_12_3 159336073.54966;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_12_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_12_3 0.02175;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_12_3 1252858191503.12;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_12_3 531120245.17;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_12_3 0.00202;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_12_3 0.06305;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_12_3 0.19409;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_12_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_12_3 0.19832;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_12_3 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_12_3 1566.67;#Unbraced length
set        Lambda_Beam1_2_12_3 0.74633;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-2 and FLOOR-3;
set             d_Beam1_2_23_3 396.00;#Depth
set            bf_Beam1_2_23_3 199.00;#Flange width
set            tw_Beam1_2_23_3 7.00;#Web thickness
set            tf_Beam1_2_23_3 11.00;#Flange thickness
set             r_Beam1_2_23_3 13.00;#Radius at the k-area
set             A_Beam1_2_23_3 7141.07;#Cross-sectional area
set            Ix_Beam1_2_23_3 197709314.77;#Second moment of inertia about strong axis
set            Zx_Beam1_2_23_3 1114254.80;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_23_3 14464404.85;#Second moment of inertia about weak axis
set            ry_Beam1_2_23_3 45.01;#Radius of gyration about weak axis
set             J_Beam1_2_23_3 219340.00;#Torsion constant
set   K_mem_canti_Beam1_2_23_3 51740948333.29;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_23_3 381186566.52;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_23_3 0.00737;#Yield chord rotation 
set         a_mem_Beam1_2_23_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_23_3 419305223.17;#Capping moment
set   Theta_p_mem_Beam1_2_23_3 0.03574;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_23_3 0.13969;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_23_3 0.40;#Residual moment
set      Mres_mem_Beam1_2_23_3 152474626.60798;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_23_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_23_3 0.02062;#Post-yielding stiffness ratio
set           K_s_Beam1_2_23_3 569150431666.18;#Initial stiffness of the spring
set          My_s_Beam1_2_23_3 381186566.52;#Yield moment of the spring
set       Alpha_s_Beam1_2_23_3 0.00191;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_23_3 0.03507;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_23_3 0.14706;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_23_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_23_3 0.19732;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_23_3 113896199227.56;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_23_3 531120245.17;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_23_3 0.00466;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_23_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_23_3 690456318.72;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_23_3 0.06432;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_23_3 0.18858;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_23_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_23_3 159336073.54966;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_23_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_23_3 0.02175;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_23_3 1252858191503.12;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_23_3 531120245.17;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_23_3 0.00202;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_23_3 0.06305;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_23_3 0.19409;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_23_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_23_3 0.19832;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_23_3 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_23_3 1566.67;#Unbraced length
set        Lambda_Beam1_2_23_3 0.74633;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-1 and FLOOR-4;
set             d_Beam1_2_12_4 350.00;#Depth
set            bf_Beam1_2_12_4 175.00;#Flange width
set            tw_Beam1_2_12_4 7.00;#Web thickness
set            tf_Beam1_2_12_4 11.00;#Flange thickness
set             r_Beam1_2_12_4 13.00;#Radius at the k-area
set             A_Beam1_2_12_4 6291.07;#Cross-sectional area
set            Ix_Beam1_2_12_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam1_2_12_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_12_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam1_2_12_4 39.55;#Radius of gyration about weak axis
set             J_Beam1_2_12_4 192784.67;#Torsion constant
set   K_mem_canti_Beam1_2_12_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_12_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_12_4 0.00813;#Yield chord rotation 
set         a_mem_Beam1_2_12_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_12_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam1_2_12_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_12_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_12_4 0.40;#Residual moment
set      Mres_mem_Beam1_2_12_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_12_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_12_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam1_2_12_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam1_2_12_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam1_2_12_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_12_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_12_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_12_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_12_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_12_4 96080337885.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_12_4 439382285.18;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_12_4 0.00457;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_12_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_12_4 571196970.73;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_12_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_12_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_12_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_12_4 131814685.55399;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_12_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_12_4 0.01733;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_12_4 1056883716739.73;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_12_4 439382285.18;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_12_4 0.00160;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_12_4 0.07791;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_12_4 0.24985;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_12_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_12_4 0.19717;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_12_4 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_12_4 1566.67;#Unbraced length
set        Lambda_Beam1_2_12_4 0.98456;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-2 and FLOOR-4;
set             d_Beam1_2_23_4 350.00;#Depth
set            bf_Beam1_2_23_4 175.00;#Flange width
set            tw_Beam1_2_23_4 7.00;#Web thickness
set            tf_Beam1_2_23_4 11.00;#Flange thickness
set             r_Beam1_2_23_4 13.00;#Radius at the k-area
set             A_Beam1_2_23_4 6291.07;#Cross-sectional area
set            Ix_Beam1_2_23_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam1_2_23_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_23_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam1_2_23_4 39.55;#Radius of gyration about weak axis
set             J_Beam1_2_23_4 192784.67;#Torsion constant
set   K_mem_canti_Beam1_2_23_4 35329668036.54;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_23_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_23_4 0.00813;#Yield chord rotation 
set         a_mem_Beam1_2_23_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_23_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam1_2_23_4 0.04398;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_23_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_23_4 0.40;#Residual moment
set      Mres_mem_Beam1_2_23_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_23_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_23_4 0.01848;#Post-yielding stiffness ratio
set           K_s_Beam1_2_23_4 388626348401.89;#Initial stiffness of the spring
set          My_s_Beam1_2_23_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam1_2_23_4 0.00171;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_23_4 0.04324;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_23_4 0.18920;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_23_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_23_4 0.19705;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_23_4 96080337885.43;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_23_4 439382285.18;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_23_4 0.00457;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_23_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_23_4 571196970.73;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_23_4 0.07916;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_23_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_23_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_23_4 131814685.55399;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_23_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_23_4 0.01733;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_23_4 1056883716739.73;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_23_4 439382285.18;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_23_4 0.00160;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_23_4 0.07791;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_23_4 0.24985;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_23_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_23_4 0.19717;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_23_4 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_23_4 1566.67;#Unbraced length
set        Lambda_Beam1_2_23_4 0.98456;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-1 and FLOOR-5;
set             d_Beam1_2_12_5 346.00;#Depth
set            bf_Beam1_2_12_5 174.00;#Flange width
set            tw_Beam1_2_12_5 6.00;#Web thickness
set            tf_Beam1_2_12_5 9.00;#Flange thickness
set             r_Beam1_2_12_5 13.00;#Radius at the k-area
set             A_Beam1_2_12_5 5245.07;#Cross-sectional area
set            Ix_Beam1_2_12_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam1_2_12_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_12_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam1_2_12_5 38.84;#Radius of gyration about weak axis
set             J_Beam1_2_12_5 108180.00;#Torsion constant
set   K_mem_canti_Beam1_2_12_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_12_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_12_5 0.00904;#Yield chord rotation 
set         a_mem_Beam1_2_12_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_12_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam1_2_12_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_12_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_12_5 0.40;#Residual moment
set      Mres_mem_Beam1_2_12_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_12_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_12_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam1_2_12_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam1_2_12_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam1_2_12_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_12_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_12_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_12_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_12_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_12_5 74482215930.88;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_12_5 391029469.42;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_12_5 0.00525;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_12_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_12_5 508338310.24;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_12_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_12_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_12_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_12_5 117308840.82498;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_12_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_12_5 0.02185;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_12_5 819304375239.64;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_12_5 391029469.42;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_12_5 0.00203;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_12_5 0.07064;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_12_5 0.17345;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_12_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_12_5 0.19835;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_12_5 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_12_5 1566.67;#Unbraced length
set        Lambda_Beam1_2_12_5 0.68846;#

# Beam G1 at Direction-1 and Depth-2 and SPAN-2 and FLOOR-5;
set             d_Beam1_2_23_5 346.00;#Depth
set            bf_Beam1_2_23_5 174.00;#Flange width
set            tw_Beam1_2_23_5 6.00;#Web thickness
set            tf_Beam1_2_23_5 9.00;#Flange thickness
set             r_Beam1_2_23_5 13.00;#Radius at the k-area
set             A_Beam1_2_23_5 5245.07;#Cross-sectional area
set            Ix_Beam1_2_23_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam1_2_23_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam1_2_23_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam1_2_23_5 38.84;#Radius of gyration about weak axis
set             J_Beam1_2_23_5 108180.00;#Torsion constant
set   K_mem_canti_Beam1_2_23_5 28879955070.58;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam1_2_23_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam1_2_23_5 0.00904;#Yield chord rotation 
set         a_mem_Beam1_2_23_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam1_2_23_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam1_2_23_5 0.04004;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam1_2_23_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam1_2_23_5 0.40;#Residual moment
set      Mres_mem_Beam1_2_23_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam1_2_23_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam1_2_23_5 0.02257;#Post-yielding stiffness ratio
set           K_s_Beam1_2_23_5 317679505776.36;#Initial stiffness of the spring
set          My_s_Beam1_2_23_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam1_2_23_5 0.00209;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam1_2_23_5 0.03922;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam1_2_23_5 0.13292;#Post-capping plastic rotation of the spring
set         Res_s_Beam1_2_23_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam1_2_23_5 0.19671;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp1_2_23_5 74482215930.88;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp1_2_23_5 391029469.42;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp1_2_23_5 0.00525;#Composite Yield chord rotation 
set         a_mem_BeamComp1_2_23_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp1_2_23_5 508338310.24;#Composite Capping moment
set   Theta_p_mem_BeamComp1_2_23_5 0.07207;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp1_2_23_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp1_2_23_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp1_2_23_5 117308840.82498;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp1_2_23_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp1_2_23_5 0.02185;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp1_2_23_5 819304375239.64;#Composite Initial stiffness of the spring
set          My_s_BeamComp1_2_23_5 391029469.42;#Composite Yield moment of the spring
set       Alpha_s_BeamComp1_2_23_5 0.00203;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp1_2_23_5 0.07064;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp1_2_23_5 0.17345;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp1_2_23_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp1_2_23_5 0.19835;#Composite Ultimate rotation of the spring
set        Lcanti_Beam1_2_23_5 2350.00;#Effective canti-lever length
set            Lb_Beam1_2_23_5 1566.67;#Unbraced length
set        Lambda_Beam1_2_23_5 0.68846;#

# Beam G11 at Direction-2 and Depth-12 and Axis-1 and FLOOR-2;
set             d_Beam2_12_1_2 400.00;#Depth
set             d_Beam4PZ2_12_1_2 400.00;#Depth 4 PZ
set            bf_Beam2_12_1_2 200.00;#Flange width
set            tw_Beam2_12_1_2 8.00;#Web thickness
set            tf_Beam2_12_1_2 13.00;#Flange thickness
set            tf_Beam4PZ2_12_1_2 13.00;#Flange thickness
set             r_Beam2_12_1_2 13.00;#Radius at the k-area
set             A_Beam2_12_1_2 8337.07;#Cross-sectional area
set            Ix_Beam2_12_1_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam2_12_1_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_1_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam2_12_1_2 45.63;#Radius of gyration about weak axis
set             J_Beam2_12_1_2 356762.67;#Torsion constant
set   K_mem_canti_Beam2_12_1_2 50616724667.80;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_1_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_1_2 0.00930;#Yield chord rotation 
set         a_mem_Beam2_12_1_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_1_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam2_12_1_2 0.04011;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_1_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_1_2 0.40;#Residual moment
set      Mres_mem_Beam2_12_1_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_1_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_1_2 0.02318;#Post-yielding stiffness ratio
set           K_s_Beam2_12_1_2 556783971345.80;#Initial stiffness of the spring
set          My_s_Beam2_12_1_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam2_12_1_2 0.00215;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_1_2 0.03927;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_1_2 0.16916;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_1_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_1_2 0.19662;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_1_2 122526928845.57;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_1_2 674891314.04;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_1_2 0.00551;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_1_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_1_2 877358708.25;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_1_2 0.07220;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_1_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_1_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_1_2 202467394.21249;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_1_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_1_2 0.02289;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_1_2 1347796217301.23;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_1_2 674891314.04;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_1_2 0.00212;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_1_2 0.07070;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_1_2 0.22233;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_1_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_1_2 0.19718;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_1_2 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_1_2 5700.00;#Unbraced length
set        Lambda_Beam2_12_1_2 0.96638;#

# Beam G11 at Direction-2 and Depth-12 and Axis-3 and FLOOR-2;
set             d_Beam2_12_3_2 400.00;#Depth
set             d_Beam4PZ2_12_3_2 400.00;#Depth 4 PZ
set            bf_Beam2_12_3_2 200.00;#Flange width
set            tw_Beam2_12_3_2 8.00;#Web thickness
set            tf_Beam2_12_3_2 13.00;#Flange thickness
set            tf_Beam4PZ2_12_3_2 13.00;#Flange thickness
set             r_Beam2_12_3_2 13.00;#Radius at the k-area
set             A_Beam2_12_3_2 8337.07;#Cross-sectional area
set            Ix_Beam2_12_3_2 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam2_12_3_2 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_3_2 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam2_12_3_2 45.63;#Radius of gyration about weak axis
set             J_Beam2_12_3_2 356762.67;#Torsion constant
set   K_mem_canti_Beam2_12_3_2 50616724667.80;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_3_2 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_3_2 0.00930;#Yield chord rotation 
set         a_mem_Beam2_12_3_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_3_2 517791389.60;#Capping moment
set   Theta_p_mem_Beam2_12_3_2 0.04011;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_3_2 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_3_2 0.40;#Residual moment
set      Mres_mem_Beam2_12_3_2 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_3_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_3_2 0.02318;#Post-yielding stiffness ratio
set           K_s_Beam2_12_3_2 556783971345.80;#Initial stiffness of the spring
set          My_s_Beam2_12_3_2 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam2_12_3_2 0.00215;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_3_2 0.03927;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_3_2 0.16916;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_3_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_3_2 0.19662;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_3_2 122526928845.57;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_3_2 674891314.04;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_3_2 0.00551;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_3_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_3_2 877358708.25;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_3_2 0.07220;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_3_2 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_3_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_3_2 202467394.21249;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_3_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_3_2 0.02289;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_3_2 1347796217301.23;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_3_2 674891314.04;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_3_2 0.00212;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_3_2 0.07070;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_3_2 0.22233;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_3_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_3_2 0.19718;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_3_2 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_3_2 5700.00;#Unbraced length
set        Lambda_Beam2_12_3_2 0.96638;#

# Beam G11 at Direction-2 and Depth-12 and Axis-1 and FLOOR-3;
set             d_Beam2_12_1_3 400.00;#Depth
set             d_Beam4PZ2_12_1_3 396.00;#Depth 4 PZ
set            bf_Beam2_12_1_3 200.00;#Flange width
set            tw_Beam2_12_1_3 8.00;#Web thickness
set            tf_Beam2_12_1_3 13.00;#Flange thickness
set            tf_Beam4PZ2_12_1_3 11.00;#Flange thickness
set             r_Beam2_12_1_3 13.00;#Radius at the k-area
set             A_Beam2_12_1_3 8337.07;#Cross-sectional area
set            Ix_Beam2_12_1_3 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam2_12_1_3 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_1_3 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam2_12_1_3 45.63;#Radius of gyration about weak axis
set             J_Beam2_12_1_3 356762.67;#Torsion constant
set   K_mem_canti_Beam2_12_1_3 50616724667.80;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_1_3 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_1_3 0.00930;#Yield chord rotation 
set         a_mem_Beam2_12_1_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_1_3 517791389.60;#Capping moment
set   Theta_p_mem_Beam2_12_1_3 0.04011;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_1_3 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_1_3 0.40;#Residual moment
set      Mres_mem_Beam2_12_1_3 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_1_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_1_3 0.02318;#Post-yielding stiffness ratio
set           K_s_Beam2_12_1_3 556783971345.80;#Initial stiffness of the spring
set          My_s_Beam2_12_1_3 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam2_12_1_3 0.00215;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_1_3 0.03927;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_1_3 0.16916;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_1_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_1_3 0.19662;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_1_3 117469973856.72;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_1_3 669314492.03;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_1_3 0.00570;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_1_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_1_3 870108839.63;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_1_3 0.07220;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_1_3 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_1_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_1_3 200794347.60780;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_1_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_1_3 0.02367;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_1_3 1292169712423.87;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_1_3 669314492.03;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_1_3 0.00220;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_1_3 0.07065;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_1_3 0.22255;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_1_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_1_3 0.19708;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_1_3 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_1_3 5700.00;#Unbraced length
set        Lambda_Beam2_12_1_3 0.96638;#

# Beam G11 at Direction-2 and Depth-12 and Axis-3 and FLOOR-3;
set             d_Beam2_12_3_3 400.00;#Depth
set             d_Beam4PZ2_12_3_3 396.00;#Depth 4 PZ
set            bf_Beam2_12_3_3 200.00;#Flange width
set            tw_Beam2_12_3_3 8.00;#Web thickness
set            tf_Beam2_12_3_3 13.00;#Flange thickness
set            tf_Beam4PZ2_12_3_3 11.00;#Flange thickness
set             r_Beam2_12_3_3 13.00;#Radius at the k-area
set             A_Beam2_12_3_3 8337.07;#Cross-sectional area
set            Ix_Beam2_12_3_3 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam2_12_3_3 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_3_3 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam2_12_3_3 45.63;#Radius of gyration about weak axis
set             J_Beam2_12_3_3 356762.67;#Torsion constant
set   K_mem_canti_Beam2_12_3_3 50616724667.80;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_3_3 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_3_3 0.00930;#Yield chord rotation 
set         a_mem_Beam2_12_3_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_3_3 517791389.60;#Capping moment
set   Theta_p_mem_Beam2_12_3_3 0.04011;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_3_3 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_3_3 0.40;#Residual moment
set      Mres_mem_Beam2_12_3_3 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_3_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_3_3 0.02318;#Post-yielding stiffness ratio
set           K_s_Beam2_12_3_3 556783971345.80;#Initial stiffness of the spring
set          My_s_Beam2_12_3_3 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam2_12_3_3 0.00215;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_3_3 0.03927;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_3_3 0.16916;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_3_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_3_3 0.19662;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_3_3 117469973856.72;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_3_3 669314492.03;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_3_3 0.00570;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_3_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_3_3 870108839.63;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_3_3 0.07220;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_3_3 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_3_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_3_3 200794347.60780;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_3_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_3_3 0.02367;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_3_3 1292169712423.87;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_3_3 669314492.03;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_3_3 0.00220;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_3_3 0.07065;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_3_3 0.22255;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_3_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_3_3 0.19708;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_3_3 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_3_3 5700.00;#Unbraced length
set        Lambda_Beam2_12_3_3 0.96638;#

# Beam G11 at Direction-2 and Depth-12 and Axis-1 and FLOOR-4;
set             d_Beam2_12_1_4 350.00;#Depth
set             d_Beam4PZ2_12_1_4 350.00;#Depth 4 PZ
set            bf_Beam2_12_1_4 175.00;#Flange width
set            tw_Beam2_12_1_4 7.00;#Web thickness
set            tf_Beam2_12_1_4 11.00;#Flange thickness
set            tf_Beam4PZ2_12_1_4 11.00;#Flange thickness
set             r_Beam2_12_1_4 13.00;#Radius at the k-area
set             A_Beam2_12_1_4 6291.07;#Cross-sectional area
set            Ix_Beam2_12_1_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam2_12_1_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_1_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam2_12_1_4 39.55;#Radius of gyration about weak axis
set             J_Beam2_12_1_4 192784.67;#Torsion constant
set   K_mem_canti_Beam2_12_1_4 29131480661.70;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_1_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_1_4 0.00986;#Yield chord rotation 
set         a_mem_Beam2_12_1_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_1_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam2_12_1_4 0.04696;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_1_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_1_4 0.40;#Residual moment
set      Mres_mem_Beam2_12_1_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_1_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_1_4 0.02099;#Post-yielding stiffness ratio
set           K_s_Beam2_12_1_4 320446287278.75;#Initial stiffness of the spring
set          My_s_Beam2_12_1_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam2_12_1_4 0.00195;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_1_4 0.04606;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_1_4 0.19093;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_1_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_1_4 0.19642;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_1_4 91071648173.87;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_1_4 465422649.65;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_1_4 0.00511;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_1_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_1_4 605049444.54;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_1_4 0.08452;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_1_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_1_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_1_4 139626794.89469;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_1_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_1_4 0.01814;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_1_4 1001788129912.59;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_1_4 465422649.65;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_1_4 0.00168;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_1_4 0.08313;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_1_4 0.25049;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_1_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_1_4 0.19669;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_1_4 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_1_4 5700.00;#Unbraced length
set        Lambda_Beam2_12_1_4 0.98456;#

# Beam G11 at Direction-2 and Depth-12 and Axis-3 and FLOOR-4;
set             d_Beam2_12_3_4 350.00;#Depth
set             d_Beam4PZ2_12_3_4 350.00;#Depth 4 PZ
set            bf_Beam2_12_3_4 175.00;#Flange width
set            tw_Beam2_12_3_4 7.00;#Web thickness
set            tf_Beam2_12_3_4 11.00;#Flange thickness
set            tf_Beam4PZ2_12_3_4 11.00;#Flange thickness
set             r_Beam2_12_3_4 13.00;#Radius at the k-area
set             A_Beam2_12_3_4 6291.07;#Cross-sectional area
set            Ix_Beam2_12_3_4 134999544.53;#Second moment of inertia about strong axis
set            Zx_Beam2_12_3_4 864217.20;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_3_4 9840846.02;#Second moment of inertia about weak axis
set            ry_Beam2_12_3_4 39.55;#Radius of gyration about weak axis
set             J_Beam2_12_3_4 192784.67;#Torsion constant
set   K_mem_canti_Beam2_12_3_4 29131480661.70;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_3_4 287092953.03;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_3_4 0.00986;#Yield chord rotation 
set         a_mem_Beam2_12_3_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_3_4 315802248.33;#Capping moment
set   Theta_p_mem_Beam2_12_3_4 0.04696;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_3_4 0.18107;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_3_4 0.40;#Residual moment
set      Mres_mem_Beam2_12_3_4 114837181.21216;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_3_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_3_4 0.02099;#Post-yielding stiffness ratio
set           K_s_Beam2_12_3_4 320446287278.75;#Initial stiffness of the spring
set          My_s_Beam2_12_3_4 287092953.03;#Yield moment of the spring
set       Alpha_s_Beam2_12_3_4 0.00195;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_3_4 0.04606;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_3_4 0.19093;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_3_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_3_4 0.19642;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_3_4 91071648173.87;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_3_4 465422649.65;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_3_4 0.00511;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_3_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_3_4 605049444.54;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_3_4 0.08452;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_3_4 0.24445;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_3_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_3_4 139626794.89469;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_3_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_3_4 0.01814;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_3_4 1001788129912.59;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_3_4 465422649.65;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_3_4 0.00168;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_3_4 0.08313;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_3_4 0.25049;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_3_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_3_4 0.19669;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_3_4 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_3_4 5700.00;#Unbraced length
set        Lambda_Beam2_12_3_4 0.98456;#

# Beam G11 at Direction-2 and Depth-12 and Axis-1 and FLOOR-5;
set             d_Beam2_12_1_5 346.00;#Depth
set             d_Beam4PZ2_12_1_5 346.00;#Depth 4 PZ
set            bf_Beam2_12_1_5 174.00;#Flange width
set            tw_Beam2_12_1_5 6.00;#Web thickness
set            tf_Beam2_12_1_5 9.00;#Flange thickness
set            tf_Beam4PZ2_12_1_5 9.00;#Flange thickness
set             r_Beam2_12_1_5 13.00;#Radius at the k-area
set             A_Beam2_12_1_5 5245.07;#Cross-sectional area
set            Ix_Beam2_12_1_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam2_12_1_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_1_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam2_12_1_5 38.84;#Radius of gyration about weak axis
set             J_Beam2_12_1_5 108180.00;#Torsion constant
set   K_mem_canti_Beam2_12_1_5 23813296286.27;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_1_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_1_5 0.01096;#Yield chord rotation 
set         a_mem_Beam2_12_1_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_1_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam2_12_1_5 0.04275;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_1_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_1_5 0.40;#Residual moment
set      Mres_mem_Beam2_12_1_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_1_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_1_5 0.02564;#Post-yielding stiffness ratio
set           K_s_Beam2_12_1_5 261946259148.93;#Initial stiffness of the spring
set          My_s_Beam2_12_1_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam2_12_1_5 0.00239;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_1_5 0.04175;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_1_5 0.13484;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_1_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_1_5 0.19601;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_1_5 74396066041.06;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_1_5 426222516.96;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_1_5 0.00573;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_1_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_1_5 554089272.05;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_1_5 0.07695;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_1_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_1_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_1_5 127866755.08759;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_1_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_1_5 0.02234;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_1_5 818356726451.67;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_1_5 426222516.96;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_1_5 0.00207;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_1_5 0.07539;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_1_5 0.17401;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_1_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_1_5 0.19798;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_1_5 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_1_5 5700.00;#Unbraced length
set        Lambda_Beam2_12_1_5 0.68846;#

# Beam G11 at Direction-2 and Depth-12 and Axis-3 and FLOOR-5;
set             d_Beam2_12_3_5 346.00;#Depth
set             d_Beam4PZ2_12_3_5 346.00;#Depth 4 PZ
set            bf_Beam2_12_3_5 174.00;#Flange width
set            tw_Beam2_12_3_5 6.00;#Web thickness
set            tf_Beam2_12_3_5 9.00;#Flange thickness
set            tf_Beam4PZ2_12_3_5 9.00;#Flange thickness
set             r_Beam2_12_3_5 13.00;#Radius at the k-area
set             A_Beam2_12_3_5 5245.07;#Cross-sectional area
set            Ix_Beam2_12_3_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam2_12_3_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_3_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam2_12_3_5 38.84;#Radius of gyration about weak axis
set             J_Beam2_12_3_5 108180.00;#Torsion constant
set   K_mem_canti_Beam2_12_3_5 23813296286.27;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_3_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_3_5 0.01096;#Yield chord rotation 
set         a_mem_Beam2_12_3_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_3_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam2_12_3_5 0.04275;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_3_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_3_5 0.40;#Residual moment
set      Mres_mem_Beam2_12_3_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_3_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_3_5 0.02564;#Post-yielding stiffness ratio
set           K_s_Beam2_12_3_5 261946259148.93;#Initial stiffness of the spring
set          My_s_Beam2_12_3_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam2_12_3_5 0.00239;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_3_5 0.04175;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_3_5 0.13484;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_3_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_3_5 0.19601;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_3_5 74396066041.06;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_3_5 426222516.96;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_3_5 0.00573;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_3_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_3_5 554089272.05;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_3_5 0.07695;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_3_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_3_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_3_5 127866755.08759;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_3_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_3_5 0.02234;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_3_5 818356726451.67;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_3_5 426222516.96;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_3_5 0.00207;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_3_5 0.07539;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_3_5 0.17401;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_3_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_3_5 0.19798;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_3_5 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_3_5 5700.00;#Unbraced length
set        Lambda_Beam2_12_3_5 0.68846;#

# Beam G12 at Direction-2 and Depth-12 and Axis-2 and FLOOR-2;
set             d_Beam2_12_2_2 390.00;#Depth
set             d_Beam4PZ2_12_2_2 400.00;#Depth 4 PZ
set            bf_Beam2_12_2_2 200.00;#Flange width
set            tw_Beam2_12_2_2 10.00;#Web thickness
set            tf_Beam2_12_2_2 16.00;#Flange thickness
set            tf_Beam4PZ2_12_2_2 13.00;#Flange thickness
set             r_Beam2_12_2_2 13.00;#Radius at the k-area
set             A_Beam2_12_2_2 10125.07;#Cross-sectional area
set            Ix_Beam2_12_2_2 266672329.12;#Second moment of inertia about strong axis
set            Zx_Beam2_12_2_2 1542756.24;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_2_2 21372230.09;#Second moment of inertia about weak axis
set            ry_Beam2_12_2_2 45.94;#Radius of gyration about weak axis
set             J_Beam2_12_2_2 665466.67;#Torsion constant
set   K_mem_canti_Beam2_12_2_2 57545081546.24;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_2_2 504018464.12;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_2_2 0.00876;#Yield chord rotation 
set         a_mem_Beam2_12_2_2 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_2_2 554420310.53;#Capping moment
set   Theta_p_mem_Beam2_12_2_2 0.04783;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_2_2 0.25301;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_2_2 0.40;#Residual moment
set      Mres_mem_Beam2_12_2_2 201607385.64744;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_2_2 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_2_2 0.01831;#Post-yielding stiffness ratio
set           K_s_Beam2_12_2_2 632995897008.68;#Initial stiffness of the spring
set          My_s_Beam2_12_2_2 504018464.12;#Yield moment of the spring
set       Alpha_s_Beam2_12_2_2 0.00169;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_2_2 0.04703;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_2_2 0.26177;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_2_2 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_2_2 0.19621;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_2_2 147298081249.14;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_2_2 733451905.77;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_2_2 0.00498;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_2_2 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_2_2 953487477.50;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_2_2 0.08609;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_2_2 0.34156;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_2_2 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_2_2 220035571.73090;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_2_2 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_2_2 0.01735;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_2_2 1620278893740.54;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_2_2 733451905.77;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_2_2 0.00160;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_2_2 0.08473;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_2_2 0.34744;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_2_2 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_2_2 0.19599;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_2_2 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_2_2 5700.00;#Unbraced length
set        Lambda_Beam2_12_2_2 1.62413;#

# Beam G12 at Direction-2 and Depth-12 and Axis-2 and FLOOR-3;
set             d_Beam2_12_2_3 400.00;#Depth
set             d_Beam4PZ2_12_2_3 396.00;#Depth 4 PZ
set            bf_Beam2_12_2_3 200.00;#Flange width
set            tw_Beam2_12_2_3 8.00;#Web thickness
set            tf_Beam2_12_2_3 13.00;#Flange thickness
set            tf_Beam4PZ2_12_2_3 11.00;#Flange thickness
set             r_Beam2_12_2_3 13.00;#Radius at the k-area
set             A_Beam2_12_2_3 8337.07;#Cross-sectional area
set            Ix_Beam2_12_2_3 234565309.44;#Second moment of inertia about strong axis
set            Zx_Beam2_12_2_3 1312658.80;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_2_3 17356205.84;#Second moment of inertia about weak axis
set            ry_Beam2_12_2_3 45.63;#Radius of gyration about weak axis
set             J_Beam2_12_2_3 356762.67;#Torsion constant
set   K_mem_canti_Beam2_12_2_3 50616724667.80;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_2_3 470719445.09;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_2_3 0.00930;#Yield chord rotation 
set         a_mem_Beam2_12_2_3 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_2_3 517791389.60;#Capping moment
set   Theta_p_mem_Beam2_12_2_3 0.04011;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_2_3 0.15986;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_2_3 0.40;#Residual moment
set      Mres_mem_Beam2_12_2_3 188287778.03718;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_2_3 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_2_3 0.02318;#Post-yielding stiffness ratio
set           K_s_Beam2_12_2_3 556783971345.80;#Initial stiffness of the spring
set          My_s_Beam2_12_2_3 470719445.09;#Yield moment of the spring
set       Alpha_s_Beam2_12_2_3 0.00215;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_2_3 0.03927;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_2_3 0.16916;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_2_3 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_2_3 0.19662;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_2_3 126740109193.64;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_2_3 675148684.85;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_2_3 0.00533;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_2_3 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_2_3 877693290.31;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_2_3 0.07220;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_2_3 0.21582;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_2_3 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_2_3 202544605.45522;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_2_3 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_2_3 0.02213;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_2_3 1394141201130.02;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_2_3 675148684.85;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_2_3 0.00205;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_2_3 0.07075;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_2_3 0.22211;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_2_3 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_2_3 0.19728;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_2_3 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_2_3 5700.00;#Unbraced length
set        Lambda_Beam2_12_2_3 0.96638;#

# Beam G12 at Direction-2 and Depth-12 and Axis-2 and FLOOR-4;
set             d_Beam2_12_2_4 340.00;#Depth
set             d_Beam4PZ2_12_2_4 350.00;#Depth 4 PZ
set            bf_Beam2_12_2_4 175.00;#Flange width
set            tw_Beam2_12_2_4 9.00;#Web thickness
set            tf_Beam2_12_2_4 14.00;#Flange thickness
set            tf_Beam4PZ2_12_2_4 11.00;#Flange thickness
set             r_Beam2_12_2_4 13.00;#Radius at the k-area
set             A_Beam2_12_2_4 7853.07;#Cross-sectional area
set            Ix_Beam2_12_2_4 156446846.49;#Second moment of inertia about strong axis
set            Zx_Beam2_12_2_4 1039933.64;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_2_4 12532115.36;#Second moment of inertia about weak axis
set            ry_Beam2_12_2_4 39.95;#Radius of gyration about weak axis
set             J_Beam2_12_2_4 395949.33;#Torsion constant
set   K_mem_canti_Beam2_12_2_4 33759582663.61;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_2_4 353473444.50;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_2_4 0.01047;#Yield chord rotation 
set         a_mem_Beam2_12_2_4 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_2_4 388820788.94;#Capping moment
set   Theta_p_mem_Beam2_12_2_4 0.05571;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_2_4 0.25466;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_2_4 0.40;#Residual moment
set      Mres_mem_Beam2_12_2_4 141389377.79813;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_2_4 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_2_4 0.01880;#Post-yielding stiffness ratio
set           K_s_Beam2_12_2_4 371355409299.74;#Initial stiffness of the spring
set          My_s_Beam2_12_2_4 353473444.50;#Yield moment of the spring
set       Alpha_s_Beam2_12_2_4 0.00174;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_2_4 0.05475;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_2_4 0.26513;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_2_4 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_2_4 0.19503;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_2_4 106976157816.28;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_2_4 569718755.99;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_2_4 0.00533;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_2_4 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_2_4 740634382.79;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_2_4 0.10027;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_2_4 0.34379;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_2_4 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_2_4 170915626.79720;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_2_4 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_2_4 0.01593;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_2_4 1176737735979.10;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_2_4 569718755.99;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_2_4 0.00147;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_2_4 0.09882;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_2_4 0.35008;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_2_4 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_2_4 0.19543;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_2_4 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_2_4 5700.00;#Unbraced length
set        Lambda_Beam2_12_2_4 1.69788;#

# Beam G12 at Direction-2 and Depth-12 and Axis-2 and FLOOR-5;
set             d_Beam2_12_2_5 346.00;#Depth
set             d_Beam4PZ2_12_2_5 346.00;#Depth 4 PZ
set            bf_Beam2_12_2_5 174.00;#Flange width
set            tw_Beam2_12_2_5 6.00;#Web thickness
set            tf_Beam2_12_2_5 9.00;#Flange thickness
set            tf_Beam4PZ2_12_2_5 9.00;#Flange thickness
set             r_Beam2_12_2_5 13.00;#Radius at the k-area
set             A_Beam2_12_2_5 5245.07;#Cross-sectional area
set            Ix_Beam2_12_2_5 110354299.86;#Second moment of inertia about strong axis
set            Zx_Beam2_12_2_5 712488.20;#Plastic section modulus abotu strong axis
set            Iy_Beam2_12_2_5 7912997.06;#Second moment of inertia about weak axis
set            ry_Beam2_12_2_5 38.84;#Radius of gyration about weak axis
set             J_Beam2_12_2_5 108180.00;#Torsion constant
set   K_mem_canti_Beam2_12_2_5 23813296286.27;#Cantilever stiffness (Mbase-chord rotation)
set       My_star_Beam2_12_2_5 260984426.77;#Yield moment based on AISC
set   Theta_y_mem_Beam2_12_2_5 0.01096;#Yield chord rotation 
set         a_mem_Beam2_12_2_5 1.10000;#Cappin moment/Yield moment
set        Mc_mem_Beam2_12_2_5 287082869.44;#Capping moment
set   Theta_p_mem_Beam2_12_2_5 0.04275;#Pre-capping plastic chord rotation
set  Theta_pc_mem_Beam2_12_2_5 0.12388;#Post-capping plastic chord rotation
set       Res_mem_Beam2_12_2_5 0.40;#Residual moment
set      Mres_mem_Beam2_12_2_5 104393770.70692;#Residual moment / Yield moment
set Theta_ult_mem_Beam2_12_2_5 0.20000;#Ultimate chord rotation
set     Alpha_mem_Beam2_12_2_5 0.02564;#Post-yielding stiffness ratio
set           K_s_Beam2_12_2_5 261946259148.93;#Initial stiffness of the spring
set          My_s_Beam2_12_2_5 260984426.77;#Yield moment of the spring
set       Alpha_s_Beam2_12_2_5 0.00239;#Post-yielding stiffness ratio of the spring
set     Theta_p_s_Beam2_12_2_5 0.04175;#Pre-capping plastic rotation of the spring
set    Theta_pc_s_Beam2_12_2_5 0.13484;#Post-capping plastic rotation of the spring
set         Res_s_Beam2_12_2_5 0.40000;#Residual moment/Yield moment of the spring
set   Theta_ult_s_Beam2_12_2_5 0.19601;#Ultimate rotation of the spring
set   K_mem_canti_BeamComp2_12_2_5 84530185132.76;#Composite Cantilever stiffness (Mbase-chord rotation)
set       My_star_BeamComp2_12_2_5 442972836.40;#Composite Yield moment based on AISC
set   Theta_y_mem_BeamComp2_12_2_5 0.00524;#Composite Yield chord rotation 
set         a_mem_BeamComp2_12_2_5 1.30000;#Composite Capping moment/Yield moment
set        Mc_mem_BeamComp2_12_2_5 575864687.32;#Composite Capping moment
set   Theta_p_mem_BeamComp2_12_2_5 0.07695;#Composite Pre-capping plastic chord rotation
set  Theta_pc_mem_BeamComp2_12_2_5 0.16724;#Composite Post-capping plastic chord rotation
set       Res_mem_BeamComp2_12_2_5 0.30;#Composite Residual moment
set      Mres_mem_BeamComp2_12_2_5 132891850.92075;#Composite Residual moment / Yield moment
set Theta_ult_mem_BeamComp2_12_2_5 0.20000;#Composite Ultimate chord rotation
set     Alpha_mem_BeamComp2_12_2_5 0.02043;#Composite Post-yielding stiffness ratio
set           K_s_BeamComp2_12_2_5 929832036460.34;#Composite Initial stiffness of the spring
set          My_s_BeamComp2_12_2_5 442972836.40;#Composite Yield moment of the spring
set       Alpha_s_BeamComp2_12_2_5 0.00189;#Composite Post-yielding stiffness ratio of the spring
set     Theta_p_s_BeamComp2_12_2_5 0.07552;#Composite Pre-capping plastic rotation of the spring
set    Theta_pc_s_BeamComp2_12_2_5 0.17344;#Composite Post-capping plastic rotation of the spring
set         Res_s_BeamComp2_12_2_5 0.30000;#Composite Residual moment/Yield moment of the spring
set   Theta_ult_s_BeamComp2_12_2_5 0.19817;#Composite Ultimate rotation of the spring
set        Lcanti_Beam2_12_2_5 2850.00;#Effective canti-lever length
set            Lb_Beam2_12_2_5 5700.00;#Unbraced length
set        Lambda_Beam2_12_2_5 0.68846;#

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-1;
set             KfKe1_1_2_1 0.00547;#Kf/Ke
set    Gamma_1_Panel1_1_2_1 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_1 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_1 0.01302;#3rd distorsion angle
set         M1_Panel1_1_2_1 203669206.26;#Yield moment of the panel
set         M4_Panel1_1_2_1 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_1_2_1 270942383.31;#3rd moment of the panel
set         M1C_Panel1_1_2_1 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_1 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_1 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-2;
set             KfKe1_1_2_2 0.00547;#Kf/Ke
set    Gamma_1_Panel1_1_2_2 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_2 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_2 0.01302;#3rd distorsion angle
set         M1_Panel1_1_2_2 203669206.26;#Yield moment of the panel
set         M4_Panel1_1_2_2 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_1_2_2 270942383.31;#3rd moment of the panel
set         M1C_Panel1_1_2_2 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_2 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_2 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-3;
set             KfKe1_1_2_3 0.00547;#Kf/Ke
set    Gamma_1_Panel1_1_2_3 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_3 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_3 0.01302;#3rd distorsion angle
set         M1_Panel1_1_2_3 203669206.26;#Yield moment of the panel
set         M4_Panel1_1_2_3 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_1_2_3 270942383.31;#3rd moment of the panel
set         M1C_Panel1_1_2_3 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_3 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_3 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-1;
set             KfKe1_1_3_1 0.00556;#Kf/Ke
set    Gamma_1_Panel1_1_3_1 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_1 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_1 0.01308;#3rd distorsion angle
set         M1_Panel1_1_3_1 203900450.68;#Yield moment of the panel
set         M4_Panel1_1_3_1 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_1_3_1 271231571.89;#3rd moment of the panel
set         M1C_Panel1_1_3_1 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_1 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_1 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-2;
set             KfKe1_1_3_2 0.00556;#Kf/Ke
set    Gamma_1_Panel1_1_3_2 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_2 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_2 0.01308;#3rd distorsion angle
set         M1_Panel1_1_3_2 203900450.68;#Yield moment of the panel
set         M4_Panel1_1_3_2 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_1_3_2 271231571.89;#3rd moment of the panel
set         M1C_Panel1_1_3_2 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_2 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_2 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-3;
set             KfKe1_1_3_3 0.00556;#Kf/Ke
set    Gamma_1_Panel1_1_3_3 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_3 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_3 0.01308;#3rd distorsion angle
set         M1_Panel1_1_3_3 203900450.68;#Yield moment of the panel
set         M4_Panel1_1_3_3 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_1_3_3 271231571.89;#3rd moment of the panel
set         M1C_Panel1_1_3_3 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_3 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_3 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-1;
set             KfKe1_1_4_1 0.00695;#Kf/Ke
set    Gamma_1_Panel1_1_4_1 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_1 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_1 0.01282;#3rd distorsion angle
set         M1_Panel1_1_4_1 180229697.99;#Yield moment of the panel
set         M4_Panel1_1_4_1 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_1_4_1 239516061.87;#3rd moment of the panel
set         M1C_Panel1_1_4_1 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_1 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_1 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-2;
set             KfKe1_1_4_2 0.00695;#Kf/Ke
set    Gamma_1_Panel1_1_4_2 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_2 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_2 0.01282;#3rd distorsion angle
set         M1_Panel1_1_4_2 180229697.99;#Yield moment of the panel
set         M4_Panel1_1_4_2 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_1_4_2 239516061.87;#3rd moment of the panel
set         M1C_Panel1_1_4_2 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_2 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_2 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-3;
set             KfKe1_1_4_3 0.00695;#Kf/Ke
set    Gamma_1_Panel1_1_4_3 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_3 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_3 0.01282;#3rd distorsion angle
set         M1_Panel1_1_4_3 180229697.99;#Yield moment of the panel
set         M4_Panel1_1_4_3 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_1_4_3 239516061.87;#3rd moment of the panel
set         M1C_Panel1_1_4_3 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_3 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_3 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-1;
set             KfKe1_1_5_1 0.00710;#Kf/Ke
set    Gamma_1_Panel1_1_5_1 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_1 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_1 0.01280;#3rd distorsion angle
set         M1_Panel1_1_5_1 179239381.46;#Yield moment of the panel
set         M4_Panel1_1_5_1 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_1_5_1 238175973.28;#3rd moment of the panel
set         M1C_Panel1_1_5_1 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_1 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_1 329700568.36;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-2;
set             KfKe1_1_5_2 0.00710;#Kf/Ke
set    Gamma_1_Panel1_1_5_2 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_2 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_2 0.01280;#3rd distorsion angle
set         M1_Panel1_1_5_2 179239381.46;#Yield moment of the panel
set         M4_Panel1_1_5_2 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_1_5_2 238175973.28;#3rd moment of the panel
set         M1C_Panel1_1_5_2 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_2 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_2 329700568.36;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-3;
set             KfKe1_1_5_3 0.00710;#Kf/Ke
set    Gamma_1_Panel1_1_5_3 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_3 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_3 0.01280;#3rd distorsion angle
set         M1_Panel1_1_5_3 179239381.46;#Yield moment of the panel
set         M4_Panel1_1_5_3 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_1_5_3 238175973.28;#3rd moment of the panel
set         M1C_Panel1_1_5_3 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_3 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_3 329700568.36;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-2 and AXIS-1;
set             KfKe1_2_2_1 0.00547;#Kf/Ke
set    Gamma_1_Panel1_2_2_1 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_2_2_1 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_2_1 0.01302;#3rd distorsion angle
set         M1_Panel1_2_2_1 203669206.26;#Yield moment of the panel
set         M4_Panel1_2_2_1 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_2_2_1 270942383.31;#3rd moment of the panel
set         M1C_Panel1_2_2_1 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_2_2_1 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_2_1 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-2 and AXIS-2;
set             KfKe1_2_2_2 0.00547;#Kf/Ke
set    Gamma_1_Panel1_2_2_2 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_2_2_2 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_2_2 0.01302;#3rd distorsion angle
set         M1_Panel1_2_2_2 203669206.26;#Yield moment of the panel
set         M4_Panel1_2_2_2 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_2_2_2 270942383.31;#3rd moment of the panel
set         M1C_Panel1_2_2_2 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_2_2_2 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_2_2 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-2 and AXIS-3;
set             KfKe1_2_2_3 0.00547;#Kf/Ke
set    Gamma_1_Panel1_2_2_3 0.00217;#Yield distorsion angle
set    Gamma_4_Panel1_2_2_3 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_2_3 0.01302;#3rd distorsion angle
set         M1_Panel1_2_2_3 203669206.26;#Yield moment of the panel
set         M4_Panel1_2_2_3 254376786.51;#Ultimate moment of the panel
set         M6_Panel1_2_2_3 270942383.31;#3rd moment of the panel
set         M1C_Panel1_2_2_3 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel1_2_2_3 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_2_3 363006784.88;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-3 and AXIS-1;
set             KfKe1_2_3_1 0.00556;#Kf/Ke
set    Gamma_1_Panel1_2_3_1 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_2_3_1 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_3_1 0.01308;#3rd distorsion angle
set         M1_Panel1_2_3_1 203900450.68;#Yield moment of the panel
set         M4_Panel1_2_3_1 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_2_3_1 271231571.89;#3rd moment of the panel
set         M1C_Panel1_2_3_1 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_2_3_1 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_3_1 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-3 and AXIS-2;
set             KfKe1_2_3_2 0.00556;#Kf/Ke
set    Gamma_1_Panel1_2_3_2 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_2_3_2 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_3_2 0.01308;#3rd distorsion angle
set         M1_Panel1_2_3_2 203900450.68;#Yield moment of the panel
set         M4_Panel1_2_3_2 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_2_3_2 271231571.89;#3rd moment of the panel
set         M1C_Panel1_2_3_2 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_2_3_2 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_3_2 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-3 and AXIS-3;
set             KfKe1_2_3_3 0.00556;#Kf/Ke
set    Gamma_1_Panel1_2_3_3 0.00218;#Yield distorsion angle
set    Gamma_4_Panel1_2_3_3 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_3_3 0.01308;#3rd distorsion angle
set         M1_Panel1_2_3_3 203900450.68;#Yield moment of the panel
set         M4_Panel1_2_3_3 254741016.69;#Ultimate moment of the panel
set         M6_Panel1_2_3_3 271231571.89;#3rd moment of the panel
set         M1C_Panel1_2_3_3 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel1_2_3_3 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_3_3 363168507.30;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-4 and AXIS-1;
set             KfKe1_2_4_1 0.00695;#Kf/Ke
set    Gamma_1_Panel1_2_4_1 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_2_4_1 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_4_1 0.01282;#3rd distorsion angle
set         M1_Panel1_2_4_1 180229697.99;#Yield moment of the panel
set         M4_Panel1_2_4_1 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_2_4_1 239516061.87;#3rd moment of the panel
set         M1C_Panel1_2_4_1 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_2_4_1 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_4_1 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-4 and AXIS-2;
set             KfKe1_2_4_2 0.00695;#Kf/Ke
set    Gamma_1_Panel1_2_4_2 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_2_4_2 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_4_2 0.01282;#3rd distorsion angle
set         M1_Panel1_2_4_2 180229697.99;#Yield moment of the panel
set         M4_Panel1_2_4_2 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_2_4_2 239516061.87;#3rd moment of the panel
set         M1C_Panel1_2_4_2 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_2_4_2 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_4_2 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-4 and AXIS-3;
set             KfKe1_2_4_3 0.00695;#Kf/Ke
set    Gamma_1_Panel1_2_4_3 0.00214;#Yield distorsion angle
set    Gamma_4_Panel1_2_4_3 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_4_3 0.01282;#3rd distorsion angle
set         M1_Panel1_2_4_3 180229697.99;#Yield moment of the panel
set         M4_Panel1_2_4_3 226102013.30;#Ultimate moment of the panel
set         M6_Panel1_2_4_3 239516061.87;#3rd moment of the panel
set         M1C_Panel1_2_4_3 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel1_2_4_3 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_4_3 331719147.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-5 and AXIS-1;
set             KfKe1_2_5_1 0.00710;#Kf/Ke
set    Gamma_1_Panel1_2_5_1 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_2_5_1 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_5_1 0.01280;#3rd distorsion angle
set         M1_Panel1_2_5_1 179239381.46;#Yield moment of the panel
set         M4_Panel1_2_5_1 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_2_5_1 238175973.28;#3rd moment of the panel
set         M1C_Panel1_2_5_1 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_2_5_1 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_5_1 329700568.36;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-5 and AXIS-2;
set             KfKe1_2_5_2 0.00710;#Kf/Ke
set    Gamma_1_Panel1_2_5_2 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_2_5_2 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_5_2 0.01280;#3rd distorsion angle
set         M1_Panel1_2_5_2 179239381.46;#Yield moment of the panel
set         M4_Panel1_2_5_2 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_2_5_2 238175973.28;#3rd moment of the panel
set         M1C_Panel1_2_5_2 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_2_5_2 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_5_2 329700568.36;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-2 FLOOR-5 and AXIS-3;
set             KfKe1_2_5_3 0.00710;#Kf/Ke
set    Gamma_1_Panel1_2_5_3 0.00213;#Yield distorsion angle
set    Gamma_4_Panel1_2_5_3 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel1_2_5_3 0.01280;#3rd distorsion angle
set         M1_Panel1_2_5_3 179239381.46;#Yield moment of the panel
set         M4_Panel1_2_5_3 224957840.49;#Ultimate moment of the panel
set         M6_Panel1_2_5_3 238175973.28;#3rd moment of the panel
set         M1C_Panel1_2_5_3 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel1_2_5_3 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel1_2_5_3 329700568.36;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-2 and AXIS-1;
set             KfKe2_1_2_1 0.00547;#Kf/Ke
set    Gamma_1_Panel2_1_2_1 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_1_2_1 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_2_1 0.01302;#3rd distorsion angle
set         M1_Panel2_1_2_1 203669206.26;#Yield moment of the panel
set         M4_Panel2_1_2_1 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_1_2_1 270942383.31;#3rd moment of the panel
set         M1C_Panel2_1_2_1 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_1_2_1 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_2_1 363006784.88;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-2 and AXIS-3;
set             KfKe2_1_2_3 0.00547;#Kf/Ke
set    Gamma_1_Panel2_1_2_3 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_1_2_3 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_2_3 0.01302;#3rd distorsion angle
set         M1_Panel2_1_2_3 203669206.26;#Yield moment of the panel
set         M4_Panel2_1_2_3 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_1_2_3 270942383.31;#3rd moment of the panel
set         M1C_Panel2_1_2_3 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_1_2_3 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_2_3 363006784.88;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-3 and AXIS-1;
set             KfKe2_1_3_1 0.00556;#Kf/Ke
set    Gamma_1_Panel2_1_3_1 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_1_3_1 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_3_1 0.01308;#3rd distorsion angle
set         M1_Panel2_1_3_1 203900450.68;#Yield moment of the panel
set         M4_Panel2_1_3_1 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_1_3_1 271231571.89;#3rd moment of the panel
set         M1C_Panel2_1_3_1 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_1_3_1 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_3_1 363168507.30;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-3 and AXIS-3;
set             KfKe2_1_3_3 0.00556;#Kf/Ke
set    Gamma_1_Panel2_1_3_3 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_1_3_3 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_3_3 0.01308;#3rd distorsion angle
set         M1_Panel2_1_3_3 203900450.68;#Yield moment of the panel
set         M4_Panel2_1_3_3 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_1_3_3 271231571.89;#3rd moment of the panel
set         M1C_Panel2_1_3_3 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_1_3_3 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_3_3 363168507.30;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-4 and AXIS-1;
set             KfKe2_1_4_1 0.00695;#Kf/Ke
set    Gamma_1_Panel2_1_4_1 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_1_4_1 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_4_1 0.01282;#3rd distorsion angle
set         M1_Panel2_1_4_1 180229697.99;#Yield moment of the panel
set         M4_Panel2_1_4_1 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_1_4_1 239516061.87;#3rd moment of the panel
set         M1C_Panel2_1_4_1 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_1_4_1 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_4_1 331719147.63;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-4 and AXIS-3;
set             KfKe2_1_4_3 0.00695;#Kf/Ke
set    Gamma_1_Panel2_1_4_3 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_1_4_3 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_4_3 0.01282;#3rd distorsion angle
set         M1_Panel2_1_4_3 180229697.99;#Yield moment of the panel
set         M4_Panel2_1_4_3 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_1_4_3 239516061.87;#3rd moment of the panel
set         M1C_Panel2_1_4_3 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_1_4_3 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_4_3 331719147.63;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-5 and AXIS-1;
set             KfKe2_1_5_1 0.00710;#Kf/Ke
set    Gamma_1_Panel2_1_5_1 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_1_5_1 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_5_1 0.01280;#3rd distorsion angle
set         M1_Panel2_1_5_1 179239381.46;#Yield moment of the panel
set         M4_Panel2_1_5_1 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_1_5_1 238175973.28;#3rd moment of the panel
set         M1C_Panel2_1_5_1 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_1_5_1 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_5_1 329700568.36;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-1 FLOOR-5 and AXIS-3;
set             KfKe2_1_5_3 0.00710;#Kf/Ke
set    Gamma_1_Panel2_1_5_3 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_1_5_3 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_5_3 0.01280;#3rd distorsion angle
set         M1_Panel2_1_5_3 179239381.46;#Yield moment of the panel
set         M4_Panel2_1_5_3 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_1_5_3 238175973.28;#3rd moment of the panel
set         M1C_Panel2_1_5_3 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_1_5_3 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_5_3 329700568.36;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-2 and AXIS-1;
set             KfKe2_2_2_1 0.00547;#Kf/Ke
set    Gamma_1_Panel2_2_2_1 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_2_2_1 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_2_1 0.01302;#3rd distorsion angle
set         M1_Panel2_2_2_1 203669206.26;#Yield moment of the panel
set         M4_Panel2_2_2_1 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_2_2_1 270942383.31;#3rd moment of the panel
set         M1C_Panel2_2_2_1 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_2_2_1 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_2_1 363006784.88;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-2 and AXIS-3;
set             KfKe2_2_2_3 0.00547;#Kf/Ke
set    Gamma_1_Panel2_2_2_3 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_2_2_3 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_2_3 0.01302;#3rd distorsion angle
set         M1_Panel2_2_2_3 203669206.26;#Yield moment of the panel
set         M4_Panel2_2_2_3 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_2_2_3 270942383.31;#3rd moment of the panel
set         M1C_Panel2_2_2_3 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_2_2_3 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_2_3 363006784.88;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-3 and AXIS-1;
set             KfKe2_2_3_1 0.00556;#Kf/Ke
set    Gamma_1_Panel2_2_3_1 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_2_3_1 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_3_1 0.01308;#3rd distorsion angle
set         M1_Panel2_2_3_1 203900450.68;#Yield moment of the panel
set         M4_Panel2_2_3_1 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_2_3_1 271231571.89;#3rd moment of the panel
set         M1C_Panel2_2_3_1 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_2_3_1 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_3_1 363168507.30;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-3 and AXIS-3;
set             KfKe2_2_3_3 0.00556;#Kf/Ke
set    Gamma_1_Panel2_2_3_3 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_2_3_3 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_3_3 0.01308;#3rd distorsion angle
set         M1_Panel2_2_3_3 203900450.68;#Yield moment of the panel
set         M4_Panel2_2_3_3 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_2_3_3 271231571.89;#3rd moment of the panel
set         M1C_Panel2_2_3_3 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_2_3_3 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_3_3 363168507.30;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-4 and AXIS-1;
set             KfKe2_2_4_1 0.00695;#Kf/Ke
set    Gamma_1_Panel2_2_4_1 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_2_4_1 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_4_1 0.01282;#3rd distorsion angle
set         M1_Panel2_2_4_1 180229697.99;#Yield moment of the panel
set         M4_Panel2_2_4_1 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_2_4_1 239516061.87;#3rd moment of the panel
set         M1C_Panel2_2_4_1 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_2_4_1 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_4_1 331719147.63;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-4 and AXIS-3;
set             KfKe2_2_4_3 0.00695;#Kf/Ke
set    Gamma_1_Panel2_2_4_3 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_2_4_3 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_4_3 0.01282;#3rd distorsion angle
set         M1_Panel2_2_4_3 180229697.99;#Yield moment of the panel
set         M4_Panel2_2_4_3 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_2_4_3 239516061.87;#3rd moment of the panel
set         M1C_Panel2_2_4_3 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_2_4_3 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_4_3 331719147.63;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-5 and AXIS-1;
set             KfKe2_2_5_1 0.00710;#Kf/Ke
set    Gamma_1_Panel2_2_5_1 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_2_5_1 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_5_1 0.01280;#3rd distorsion angle
set         M1_Panel2_2_5_1 179239381.46;#Yield moment of the panel
set         M4_Panel2_2_5_1 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_2_5_1 238175973.28;#3rd moment of the panel
set         M1C_Panel2_2_5_1 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_2_5_1 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_5_1 329700568.36;#Composite 3rd moment of the panel

# Panel zone G11 at Direction-2 and Depth-2 FLOOR-5 and AXIS-3;
set             KfKe2_2_5_3 0.00710;#Kf/Ke
set    Gamma_1_Panel2_2_5_3 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_2_5_3 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_5_3 0.01280;#3rd distorsion angle
set         M1_Panel2_2_5_3 179239381.46;#Yield moment of the panel
set         M4_Panel2_2_5_3 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_2_5_3 238175973.28;#3rd moment of the panel
set         M1C_Panel2_2_5_3 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_2_5_3 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_5_3 329700568.36;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-1 FLOOR-2 and AXIS-2;
set             KfKe2_1_2_2 0.00547;#Kf/Ke
set    Gamma_1_Panel2_1_2_2 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_1_2_2 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_2_2 0.01302;#3rd distorsion angle
set         M1_Panel2_1_2_2 203669206.26;#Yield moment of the panel
set         M4_Panel2_1_2_2 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_1_2_2 270942383.31;#3rd moment of the panel
set         M1C_Panel2_1_2_2 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_1_2_2 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_2_2 363006784.88;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-1 FLOOR-3 and AXIS-2;
set             KfKe2_1_3_2 0.00556;#Kf/Ke
set    Gamma_1_Panel2_1_3_2 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_1_3_2 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_3_2 0.01308;#3rd distorsion angle
set         M1_Panel2_1_3_2 203900450.68;#Yield moment of the panel
set         M4_Panel2_1_3_2 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_1_3_2 271231571.89;#3rd moment of the panel
set         M1C_Panel2_1_3_2 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_1_3_2 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_3_2 363168507.30;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-1 FLOOR-4 and AXIS-2;
set             KfKe2_1_4_2 0.00695;#Kf/Ke
set    Gamma_1_Panel2_1_4_2 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_1_4_2 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_4_2 0.01282;#3rd distorsion angle
set         M1_Panel2_1_4_2 180229697.99;#Yield moment of the panel
set         M4_Panel2_1_4_2 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_1_4_2 239516061.87;#3rd moment of the panel
set         M1C_Panel2_1_4_2 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_1_4_2 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_4_2 331719147.63;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-1 FLOOR-5 and AXIS-2;
set             KfKe2_1_5_2 0.00710;#Kf/Ke
set    Gamma_1_Panel2_1_5_2 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_1_5_2 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_1_5_2 0.01280;#3rd distorsion angle
set         M1_Panel2_1_5_2 179239381.46;#Yield moment of the panel
set         M4_Panel2_1_5_2 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_1_5_2 238175973.28;#3rd moment of the panel
set         M1C_Panel2_1_5_2 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_1_5_2 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_1_5_2 329700568.36;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-2 FLOOR-2 and AXIS-2;
set             KfKe2_2_2_2 0.00547;#Kf/Ke
set    Gamma_1_Panel2_2_2_2 0.00217;#Yield distorsion angle
set    Gamma_4_Panel2_2_2_2 0.00868;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_2_2 0.01302;#3rd distorsion angle
set         M1_Panel2_2_2_2 203669206.26;#Yield moment of the panel
set         M4_Panel2_2_2_2 254376786.51;#Ultimate moment of the panel
set         M6_Panel2_2_2_2 270942383.31;#3rd moment of the panel
set         M1C_Panel2_2_2_2 272874634.23;#Composite Yield moment of the panel
set         M4C_Panel2_2_2_2 340812309.57;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_2_2 363006784.88;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-2 FLOOR-3 and AXIS-2;
set             KfKe2_2_3_2 0.00556;#Kf/Ke
set    Gamma_1_Panel2_2_3_2 0.00218;#Yield distorsion angle
set    Gamma_4_Panel2_2_3_2 0.00872;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_3_2 0.01308;#3rd distorsion angle
set         M1_Panel2_2_3_2 203900450.68;#Yield moment of the panel
set         M4_Panel2_2_3_2 254741016.69;#Ultimate moment of the panel
set         M6_Panel2_2_3_2 271231571.89;#3rd moment of the panel
set         M1C_Panel2_2_3_2 273014759.28;#Composite Yield moment of the panel
set         M4C_Panel2_2_3_2 341088296.37;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_3_2 363168507.30;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-2 FLOOR-4 and AXIS-2;
set             KfKe2_2_4_2 0.00695;#Kf/Ke
set    Gamma_1_Panel2_2_4_2 0.00214;#Yield distorsion angle
set    Gamma_4_Panel2_2_4_2 0.00854;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_4_2 0.01282;#3rd distorsion angle
set         M1_Panel2_2_4_2 180229697.99;#Yield moment of the panel
set         M4_Panel2_2_4_2 226102013.30;#Ultimate moment of the panel
set         M6_Panel2_2_4_2 239516061.87;#3rd moment of the panel
set         M1C_Panel2_2_4_2 249610156.95;#Composite Yield moment of the panel
set         M4C_Panel2_2_4_2 313141283.91;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_4_2 331719147.63;#Composite 3rd moment of the panel

# Panel zone G12 at Direction-2 and Depth-2 FLOOR-5 and AXIS-2;
set             KfKe2_2_5_2 0.00710;#Kf/Ke
set    Gamma_1_Panel2_2_5_2 0.00213;#Yield distorsion angle
set    Gamma_4_Panel2_2_5_2 0.00853;#Ultimate distorsion angle
set    Gamma_6_Panel2_2_5_2 0.01280;#3rd distorsion angle
set         M1_Panel2_2_5_2 179239381.46;#Yield moment of the panel
set         M4_Panel2_2_5_2 224957840.49;#Ultimate moment of the panel
set         M6_Panel2_2_5_2 238175973.28;#3rd moment of the panel
set         M1C_Panel2_2_5_2 248116235.77;#Composite Yield moment of the panel
set         M4C_Panel2_2_5_2 311403064.06;#Composite Ultimate moment of the panel
set         M6C_Panel2_2_5_2 329700568.36;#Composite 3rd moment of the panel

# Floor 1 Depth-1 MRF Column Bases;
node 011103 [expr $Axis1] [expr $Floor1] [expr $Depth1] ;
fix  011103 1 1 1 1 1 1;

node 011203 [expr $Axis2] [expr $Floor1] [expr $Depth1] ;
fix  011203 1 1 1 1 1 1;

node 011303 [expr $Axis3] [expr $Floor1] [expr $Depth1] ;
fix  011303 1 1 1 1 1 1;


# Floor 1 Depth-2 MRF Column Bases;
node 021103 [expr $Axis1] [expr $Floor1] [expr $Depth2] ;
fix  021103 1 1 1 1 1 1;

node 021203 [expr $Axis2] [expr $Floor1] [expr $Depth2] ;
fix  021203 1 1 1 1 1 1;

node 021303 [expr $Axis3] [expr $Floor1] [expr $Depth2] ;
fix  021303 1 1 1 1 1 1;


# Panel zone G1;
# Direction-1, Depth-1 AXIS-1, FLOOR-2;
node 012101  [expr $Axis1                               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom middle ;
node 112105  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom left ;
node 112106  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom left ;
node 112112  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom right ;
node 112111  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom right;
node 112102  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle left  ;
node 112104  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle right ;
node 112107  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top left  ;
node 112108  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top left;
node 112109  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top right;
node 112110  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top right;
node 012103  [expr $Axis1                               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top middle;
node 11214   [expr $Axis1+$d_Col1_12_1_t/2.+$H_offset               ] [expr $Floor2               ] [expr $Depth1] ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-3;
node 013101  [expr $Axis1                               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom middle ;
node 113105  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom left ;
node 113106  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom left ;
node 113112  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom right ;
node 113111  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom right;
node 113102  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle left  ;
node 113104  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle right ;
node 113107  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top left  ;
node 113108  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top left;
node 113109  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top right;
node 113110  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top right;
node 013103  [expr $Axis1                               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top middle;
node 11314   [expr $Axis1+$d_Col1_23_1_t/2.+$H_offset               ] [expr $Floor3               ] [expr $Depth1] ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-4;
node 014101  [expr $Axis1                               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom middle ;
node 114105  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom left ;
node 114106  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom left ;
node 114112  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom right ;
node 114111  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom right;
node 114102  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle left  ;
node 114104  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle right ;
node 114107  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top left  ;
node 114108  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top left;
node 114109  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top right;
node 114110  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top right;
node 014103  [expr $Axis1                               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top middle;
node 11414   [expr $Axis1+$d_Col1_34_1_t/2.+$H_offset               ] [expr $Floor4               ] [expr $Depth1] ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-5;
node 015101  [expr $Axis1                               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom middle ;
node 115105  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom left ;
node 115106  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom left ;
node 115112  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom right ;
node 115111  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom right;
node 115102  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle left  ;
node 115104  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle right ;
node 115107  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top left  ;
node 115108  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top left;
node 115109  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top right;
node 115110  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top right;
node 015103  [expr $Axis1                               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top middle;
node 11514   [expr $Axis1+$d_Col1_45_1_t/2.+$H_offset               ] [expr $Floor5               ] [expr $Depth1] ;# WUF-Wright;


#Direction-1, Depth-1 AXIS-2, FLOOR-2;
node 012201  [expr $Axis2                               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom middle  ;
node 112205  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom left    ;
node 112206  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom left    ;
node 112212  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom right   ;
node 112211  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] [expr $Depth1] ;# bottom right   ;
node 112202  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle left    ;
node 112204  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle right   ;
node 112207  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top left       ;
node 112208  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top left       ;
node 112209  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top right      ;
node 112210  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top right      ;
node 012203  [expr $Axis2                               ] [expr $Floor2+$d_Beam1_1_12_2/2.] [expr $Depth1] ;# top middle     ;
node 11222   [expr $Axis2-$d_Col1_12_2_t/2.-$H_offset               ] [expr $Floor2               ] [expr $Depth1] ;# WUF-Wleft ;
node 11224   [expr $Axis2+$d_Col1_12_2_t/2.+$H_offset               ] [expr $Floor2               ] [expr $Depth1] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-3;
node 013201  [expr $Axis2                               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom middle  ;
node 113205  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom left    ;
node 113206  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom left    ;
node 113212  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom right   ;
node 113211  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] [expr $Depth1] ;# bottom right   ;
node 113202  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle left    ;
node 113204  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle right   ;
node 113207  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top left       ;
node 113208  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top left       ;
node 113209  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top right      ;
node 113210  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top right      ;
node 013203  [expr $Axis2                               ] [expr $Floor3+$d_Beam1_1_12_3/2.] [expr $Depth1] ;# top middle     ;
node 11322   [expr $Axis2-$d_Col1_23_2_t/2.-$H_offset               ] [expr $Floor3               ] [expr $Depth1] ;# WUF-Wleft ;
node 11324   [expr $Axis2+$d_Col1_23_2_t/2.+$H_offset               ] [expr $Floor3               ] [expr $Depth1] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-4;
node 014201  [expr $Axis2                               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom middle  ;
node 114205  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom left    ;
node 114206  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom left    ;
node 114212  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom right   ;
node 114211  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] [expr $Depth1] ;# bottom right   ;
node 114202  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle left    ;
node 114204  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle right   ;
node 114207  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top left       ;
node 114208  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top left       ;
node 114209  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top right      ;
node 114210  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top right      ;
node 014203  [expr $Axis2                               ] [expr $Floor4+$d_Beam1_1_12_4/2.] [expr $Depth1] ;# top middle     ;
node 11422   [expr $Axis2-$d_Col1_34_2_t/2.-$H_offset               ] [expr $Floor4               ] [expr $Depth1] ;# WUF-Wleft ;
node 11424   [expr $Axis2+$d_Col1_34_2_t/2.+$H_offset               ] [expr $Floor4               ] [expr $Depth1] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-5;
node 015201  [expr $Axis2                               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom middle  ;
node 115205  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom left    ;
node 115206  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom left    ;
node 115212  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom right   ;
node 115211  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] [expr $Depth1] ;# bottom right   ;
node 115202  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle left    ;
node 115204  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle right   ;
node 115207  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top left       ;
node 115208  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top left       ;
node 115209  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top right      ;
node 115210  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top right      ;
node 015203  [expr $Axis2                               ] [expr $Floor5+$d_Beam1_1_12_5/2.] [expr $Depth1] ;# top middle     ;
node 11522   [expr $Axis2-$d_Col1_45_2_t/2.-$H_offset               ] [expr $Floor5               ] [expr $Depth1] ;# WUF-Wleft ;
node 11524   [expr $Axis2+$d_Col1_45_2_t/2.+$H_offset               ] [expr $Floor5               ] [expr $Depth1] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-3, FLOOR-2;
node 012301  [expr $Axis3                               ] [expr $Floor2-$d_Beam1_1_23_2/2.] [expr $Depth1] ;# bottom middle  ;
node 112305  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.] [expr $Depth1] ;# bottom left    ;
node 112306  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.] [expr $Depth1] ;# bottom left    ;
node 112312  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.] [expr $Depth1] ;# bottom right   ;
node 112311  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.] [expr $Depth1] ;# bottom right   ;
node 112302  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle left    ;
node 112304  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2               ] [expr $Depth1] ;# middle right   ;
node 112307  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.] [expr $Depth1] ;# top left       ;
node 112308  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.] [expr $Depth1] ;# top left       ;
node 112309  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.] [expr $Depth1] ;# top right      ;
node 112310  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.] [expr $Depth1] ;# top right      ;
node 012303  [expr $Axis3                               ] [expr $Floor2+$d_Beam1_1_23_2/2.] [expr $Depth1] ;# top middle     ;
node 11232   [expr $Axis3-$d_Col1_12_3_t/2.-$H_offset               ] [expr $Floor2               ] [expr $Depth1] ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-3;
node 013301  [expr $Axis3                               ] [expr $Floor3-$d_Beam1_1_23_3/2.] [expr $Depth1] ;# bottom middle  ;
node 113305  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.] [expr $Depth1] ;# bottom left    ;
node 113306  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.] [expr $Depth1] ;# bottom left    ;
node 113312  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.] [expr $Depth1] ;# bottom right   ;
node 113311  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.] [expr $Depth1] ;# bottom right   ;
node 113302  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle left    ;
node 113304  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3               ] [expr $Depth1] ;# middle right   ;
node 113307  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.] [expr $Depth1] ;# top left       ;
node 113308  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.] [expr $Depth1] ;# top left       ;
node 113309  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.] [expr $Depth1] ;# top right      ;
node 113310  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.] [expr $Depth1] ;# top right      ;
node 013303  [expr $Axis3                               ] [expr $Floor3+$d_Beam1_1_23_3/2.] [expr $Depth1] ;# top middle     ;
node 11332   [expr $Axis3-$d_Col1_23_3_t/2.-$H_offset               ] [expr $Floor3               ] [expr $Depth1] ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-4;
node 014301  [expr $Axis3                               ] [expr $Floor4-$d_Beam1_1_23_4/2.] [expr $Depth1] ;# bottom middle  ;
node 114305  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.] [expr $Depth1] ;# bottom left    ;
node 114306  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.] [expr $Depth1] ;# bottom left    ;
node 114312  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.] [expr $Depth1] ;# bottom right   ;
node 114311  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.] [expr $Depth1] ;# bottom right   ;
node 114302  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle left    ;
node 114304  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4               ] [expr $Depth1] ;# middle right   ;
node 114307  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.] [expr $Depth1] ;# top left       ;
node 114308  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.] [expr $Depth1] ;# top left       ;
node 114309  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.] [expr $Depth1] ;# top right      ;
node 114310  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.] [expr $Depth1] ;# top right      ;
node 014303  [expr $Axis3                               ] [expr $Floor4+$d_Beam1_1_23_4/2.] [expr $Depth1] ;# top middle     ;
node 11432   [expr $Axis3-$d_Col1_34_3_t/2.-$H_offset               ] [expr $Floor4               ] [expr $Depth1] ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-5;
node 015301  [expr $Axis3                               ] [expr $Floor5-$d_Beam1_1_23_5/2.] [expr $Depth1] ;# bottom middle  ;
node 115305  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.] [expr $Depth1] ;# bottom left    ;
node 115306  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.] [expr $Depth1] ;# bottom left    ;
node 115312  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.] [expr $Depth1] ;# bottom right   ;
node 115311  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.] [expr $Depth1] ;# bottom right   ;
node 115302  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle left    ;
node 115304  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5               ] [expr $Depth1] ;# middle right   ;
node 115307  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.] [expr $Depth1] ;# top left       ;
node 115308  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.] [expr $Depth1] ;# top left       ;
node 115309  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.] [expr $Depth1] ;# top right      ;
node 115310  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.] [expr $Depth1] ;# top right      ;
node 015303  [expr $Axis3                               ] [expr $Floor5+$d_Beam1_1_23_5/2.] [expr $Depth1] ;# top middle     ;
node 11532   [expr $Axis3-$d_Col1_45_3_t/2.-$H_offset               ] [expr $Floor5               ] [expr $Depth1] ;# WUF-Wleft ;

# Direction-1, Depth-2 AXIS-1, FLOOR-2;
node 022101  [expr $Axis1                               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom middle ;
node 122105  [expr $Axis1-$d_Col2_12_1_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom left ;
node 122106  [expr $Axis1-$d_Col2_12_1_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom left ;
node 122112  [expr $Axis1+$d_Col2_12_1_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom right ;
node 122111  [expr $Axis1+$d_Col2_12_1_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom right;
node 122102  [expr $Axis1-$d_Col2_12_1_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle left  ;
node 122104  [expr $Axis1+$d_Col2_12_1_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle right ;
node 122107  [expr $Axis1-$d_Col2_12_1_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top left  ;
node 122108  [expr $Axis1-$d_Col2_12_1_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top left;
node 122109  [expr $Axis1+$d_Col2_12_1_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top right;
node 122110  [expr $Axis1+$d_Col2_12_1_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top right;
node 022103  [expr $Axis1                               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top middle;
node 12214   [expr $Axis1+$d_Col2_12_1_t/2.+$H_offset               ] [expr $Floor2               ] [expr $Depth2] ;# WUF-Wright;


# Direction-1, Depth-2 AXIS-1, FLOOR-3;
node 023101  [expr $Axis1                               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom middle ;
node 123105  [expr $Axis1-$d_Col2_23_1_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom left ;
node 123106  [expr $Axis1-$d_Col2_23_1_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom left ;
node 123112  [expr $Axis1+$d_Col2_23_1_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom right ;
node 123111  [expr $Axis1+$d_Col2_23_1_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom right;
node 123102  [expr $Axis1-$d_Col2_23_1_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle left  ;
node 123104  [expr $Axis1+$d_Col2_23_1_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle right ;
node 123107  [expr $Axis1-$d_Col2_23_1_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top left  ;
node 123108  [expr $Axis1-$d_Col2_23_1_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top left;
node 123109  [expr $Axis1+$d_Col2_23_1_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top right;
node 123110  [expr $Axis1+$d_Col2_23_1_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top right;
node 023103  [expr $Axis1                               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top middle;
node 12314   [expr $Axis1+$d_Col2_23_1_t/2.+$H_offset               ] [expr $Floor3               ] [expr $Depth2] ;# WUF-Wright;


# Direction-1, Depth-2 AXIS-1, FLOOR-4;
node 024101  [expr $Axis1                               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom middle ;
node 124105  [expr $Axis1-$d_Col2_34_1_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom left ;
node 124106  [expr $Axis1-$d_Col2_34_1_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom left ;
node 124112  [expr $Axis1+$d_Col2_34_1_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom right ;
node 124111  [expr $Axis1+$d_Col2_34_1_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom right;
node 124102  [expr $Axis1-$d_Col2_34_1_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle left  ;
node 124104  [expr $Axis1+$d_Col2_34_1_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle right ;
node 124107  [expr $Axis1-$d_Col2_34_1_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top left  ;
node 124108  [expr $Axis1-$d_Col2_34_1_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top left;
node 124109  [expr $Axis1+$d_Col2_34_1_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top right;
node 124110  [expr $Axis1+$d_Col2_34_1_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top right;
node 024103  [expr $Axis1                               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top middle;
node 12414   [expr $Axis1+$d_Col2_34_1_t/2.+$H_offset               ] [expr $Floor4               ] [expr $Depth2] ;# WUF-Wright;


# Direction-1, Depth-2 AXIS-1, FLOOR-5;
node 025101  [expr $Axis1                               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom middle ;
node 125105  [expr $Axis1-$d_Col2_45_1_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom left ;
node 125106  [expr $Axis1-$d_Col2_45_1_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom left ;
node 125112  [expr $Axis1+$d_Col2_45_1_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom right ;
node 125111  [expr $Axis1+$d_Col2_45_1_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom right;
node 125102  [expr $Axis1-$d_Col2_45_1_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle left  ;
node 125104  [expr $Axis1+$d_Col2_45_1_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle right ;
node 125107  [expr $Axis1-$d_Col2_45_1_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top left  ;
node 125108  [expr $Axis1-$d_Col2_45_1_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top left;
node 125109  [expr $Axis1+$d_Col2_45_1_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top right;
node 125110  [expr $Axis1+$d_Col2_45_1_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top right;
node 025103  [expr $Axis1                               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top middle;
node 12514   [expr $Axis1+$d_Col2_45_1_t/2.+$H_offset               ] [expr $Floor5               ] [expr $Depth2] ;# WUF-Wright;


#Direction-1, Depth-2 AXIS-2, FLOOR-2;
node 022201  [expr $Axis2                               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom middle  ;
node 122205  [expr $Axis2-$d_Col2_12_2_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom left    ;
node 122206  [expr $Axis2-$d_Col2_12_2_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom left    ;
node 122212  [expr $Axis2+$d_Col2_12_2_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom right   ;
node 122211  [expr $Axis2+$d_Col2_12_2_t/2.               ] [expr $Floor2-$d_Beam1_2_12_2/2.] [expr $Depth2] ;# bottom right   ;
node 122202  [expr $Axis2-$d_Col2_12_2_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle left    ;
node 122204  [expr $Axis2+$d_Col2_12_2_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle right   ;
node 122207  [expr $Axis2-$d_Col2_12_2_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top left       ;
node 122208  [expr $Axis2-$d_Col2_12_2_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top left       ;
node 122209  [expr $Axis2+$d_Col2_12_2_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top right      ;
node 122210  [expr $Axis2+$d_Col2_12_2_t/2.               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top right      ;
node 022203  [expr $Axis2                               ] [expr $Floor2+$d_Beam1_2_12_2/2.] [expr $Depth2] ;# top middle     ;
node 12222   [expr $Axis2-$d_Col2_12_2_t/2.-$H_offset               ] [expr $Floor2               ] [expr $Depth2] ;# WUF-Wleft ;
node 12224   [expr $Axis2+$d_Col2_12_2_t/2.+$H_offset               ] [expr $Floor2               ] [expr $Depth2] ;# WUF-Wright;

#Direction-1, Depth-2 AXIS-2, FLOOR-3;
node 023201  [expr $Axis2                               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom middle  ;
node 123205  [expr $Axis2-$d_Col2_23_2_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom left    ;
node 123206  [expr $Axis2-$d_Col2_23_2_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom left    ;
node 123212  [expr $Axis2+$d_Col2_23_2_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom right   ;
node 123211  [expr $Axis2+$d_Col2_23_2_t/2.               ] [expr $Floor3-$d_Beam1_2_12_3/2.] [expr $Depth2] ;# bottom right   ;
node 123202  [expr $Axis2-$d_Col2_23_2_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle left    ;
node 123204  [expr $Axis2+$d_Col2_23_2_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle right   ;
node 123207  [expr $Axis2-$d_Col2_23_2_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top left       ;
node 123208  [expr $Axis2-$d_Col2_23_2_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top left       ;
node 123209  [expr $Axis2+$d_Col2_23_2_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top right      ;
node 123210  [expr $Axis2+$d_Col2_23_2_t/2.               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top right      ;
node 023203  [expr $Axis2                               ] [expr $Floor3+$d_Beam1_2_12_3/2.] [expr $Depth2] ;# top middle     ;
node 12322   [expr $Axis2-$d_Col2_23_2_t/2.-$H_offset               ] [expr $Floor3               ] [expr $Depth2] ;# WUF-Wleft ;
node 12324   [expr $Axis2+$d_Col2_23_2_t/2.+$H_offset               ] [expr $Floor3               ] [expr $Depth2] ;# WUF-Wright;

#Direction-1, Depth-2 AXIS-2, FLOOR-4;
node 024201  [expr $Axis2                               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom middle  ;
node 124205  [expr $Axis2-$d_Col2_34_2_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom left    ;
node 124206  [expr $Axis2-$d_Col2_34_2_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom left    ;
node 124212  [expr $Axis2+$d_Col2_34_2_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom right   ;
node 124211  [expr $Axis2+$d_Col2_34_2_t/2.               ] [expr $Floor4-$d_Beam1_2_12_4/2.] [expr $Depth2] ;# bottom right   ;
node 124202  [expr $Axis2-$d_Col2_34_2_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle left    ;
node 124204  [expr $Axis2+$d_Col2_34_2_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle right   ;
node 124207  [expr $Axis2-$d_Col2_34_2_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top left       ;
node 124208  [expr $Axis2-$d_Col2_34_2_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top left       ;
node 124209  [expr $Axis2+$d_Col2_34_2_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top right      ;
node 124210  [expr $Axis2+$d_Col2_34_2_t/2.               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top right      ;
node 024203  [expr $Axis2                               ] [expr $Floor4+$d_Beam1_2_12_4/2.] [expr $Depth2] ;# top middle     ;
node 12422   [expr $Axis2-$d_Col2_34_2_t/2.-$H_offset               ] [expr $Floor4               ] [expr $Depth2] ;# WUF-Wleft ;
node 12424   [expr $Axis2+$d_Col2_34_2_t/2.+$H_offset               ] [expr $Floor4               ] [expr $Depth2] ;# WUF-Wright;

#Direction-1, Depth-2 AXIS-2, FLOOR-5;
node 025201  [expr $Axis2                               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom middle  ;
node 125205  [expr $Axis2-$d_Col2_45_2_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom left    ;
node 125206  [expr $Axis2-$d_Col2_45_2_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom left    ;
node 125212  [expr $Axis2+$d_Col2_45_2_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom right   ;
node 125211  [expr $Axis2+$d_Col2_45_2_t/2.               ] [expr $Floor5-$d_Beam1_2_12_5/2.] [expr $Depth2] ;# bottom right   ;
node 125202  [expr $Axis2-$d_Col2_45_2_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle left    ;
node 125204  [expr $Axis2+$d_Col2_45_2_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle right   ;
node 125207  [expr $Axis2-$d_Col2_45_2_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top left       ;
node 125208  [expr $Axis2-$d_Col2_45_2_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top left       ;
node 125209  [expr $Axis2+$d_Col2_45_2_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top right      ;
node 125210  [expr $Axis2+$d_Col2_45_2_t/2.               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top right      ;
node 025203  [expr $Axis2                               ] [expr $Floor5+$d_Beam1_2_12_5/2.] [expr $Depth2] ;# top middle     ;
node 12522   [expr $Axis2-$d_Col2_45_2_t/2.-$H_offset               ] [expr $Floor5               ] [expr $Depth2] ;# WUF-Wleft ;
node 12524   [expr $Axis2+$d_Col2_45_2_t/2.+$H_offset               ] [expr $Floor5               ] [expr $Depth2] ;# WUF-Wright;

#Direction-1, Depth-2 AXIS-3, FLOOR-2;
node 022301  [expr $Axis3                               ] [expr $Floor2-$d_Beam1_2_23_2/2.] [expr $Depth2] ;# bottom middle  ;
node 122305  [expr $Axis3-$d_Col2_12_3_t/2.               ] [expr $Floor2-$d_Beam1_2_23_2/2.] [expr $Depth2] ;# bottom left    ;
node 122306  [expr $Axis3-$d_Col2_12_3_t/2.               ] [expr $Floor2-$d_Beam1_2_23_2/2.] [expr $Depth2] ;# bottom left    ;
node 122312  [expr $Axis3+$d_Col2_12_3_t/2.               ] [expr $Floor2-$d_Beam1_2_23_2/2.] [expr $Depth2] ;# bottom right   ;
node 122311  [expr $Axis3+$d_Col2_12_3_t/2.               ] [expr $Floor2-$d_Beam1_2_23_2/2.] [expr $Depth2] ;# bottom right   ;
node 122302  [expr $Axis3-$d_Col2_12_3_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle left    ;
node 122304  [expr $Axis3+$d_Col2_12_3_t/2.               ] [expr $Floor2               ] [expr $Depth2] ;# middle right   ;
node 122307  [expr $Axis3-$d_Col2_12_3_t/2.               ] [expr $Floor2+$d_Beam1_2_23_2/2.] [expr $Depth2] ;# top left       ;
node 122308  [expr $Axis3-$d_Col2_12_3_t/2.               ] [expr $Floor2+$d_Beam1_2_23_2/2.] [expr $Depth2] ;# top left       ;
node 122309  [expr $Axis3+$d_Col2_12_3_t/2.               ] [expr $Floor2+$d_Beam1_2_23_2/2.] [expr $Depth2] ;# top right      ;
node 122310  [expr $Axis3+$d_Col2_12_3_t/2.               ] [expr $Floor2+$d_Beam1_2_23_2/2.] [expr $Depth2] ;# top right      ;
node 022303  [expr $Axis3                               ] [expr $Floor2+$d_Beam1_2_23_2/2.] [expr $Depth2] ;# top middle     ;
node 12232   [expr $Axis3-$d_Col2_12_3_t/2.-$H_offset               ] [expr $Floor2               ] [expr $Depth2] ;# WUF-Wleft ;

#Direction-1, Depth-2 AXIS-3, FLOOR-3;
node 023301  [expr $Axis3                               ] [expr $Floor3-$d_Beam1_2_23_3/2.] [expr $Depth2] ;# bottom middle  ;
node 123305  [expr $Axis3-$d_Col2_23_3_t/2.               ] [expr $Floor3-$d_Beam1_2_23_3/2.] [expr $Depth2] ;# bottom left    ;
node 123306  [expr $Axis3-$d_Col2_23_3_t/2.               ] [expr $Floor3-$d_Beam1_2_23_3/2.] [expr $Depth2] ;# bottom left    ;
node 123312  [expr $Axis3+$d_Col2_23_3_t/2.               ] [expr $Floor3-$d_Beam1_2_23_3/2.] [expr $Depth2] ;# bottom right   ;
node 123311  [expr $Axis3+$d_Col2_23_3_t/2.               ] [expr $Floor3-$d_Beam1_2_23_3/2.] [expr $Depth2] ;# bottom right   ;
node 123302  [expr $Axis3-$d_Col2_23_3_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle left    ;
node 123304  [expr $Axis3+$d_Col2_23_3_t/2.               ] [expr $Floor3               ] [expr $Depth2] ;# middle right   ;
node 123307  [expr $Axis3-$d_Col2_23_3_t/2.               ] [expr $Floor3+$d_Beam1_2_23_3/2.] [expr $Depth2] ;# top left       ;
node 123308  [expr $Axis3-$d_Col2_23_3_t/2.               ] [expr $Floor3+$d_Beam1_2_23_3/2.] [expr $Depth2] ;# top left       ;
node 123309  [expr $Axis3+$d_Col2_23_3_t/2.               ] [expr $Floor3+$d_Beam1_2_23_3/2.] [expr $Depth2] ;# top right      ;
node 123310  [expr $Axis3+$d_Col2_23_3_t/2.               ] [expr $Floor3+$d_Beam1_2_23_3/2.] [expr $Depth2] ;# top right      ;
node 023303  [expr $Axis3                               ] [expr $Floor3+$d_Beam1_2_23_3/2.] [expr $Depth2] ;# top middle     ;
node 12332   [expr $Axis3-$d_Col2_23_3_t/2.-$H_offset               ] [expr $Floor3               ] [expr $Depth2] ;# WUF-Wleft ;

#Direction-1, Depth-2 AXIS-3, FLOOR-4;
node 024301  [expr $Axis3                               ] [expr $Floor4-$d_Beam1_2_23_4/2.] [expr $Depth2] ;# bottom middle  ;
node 124305  [expr $Axis3-$d_Col2_34_3_t/2.               ] [expr $Floor4-$d_Beam1_2_23_4/2.] [expr $Depth2] ;# bottom left    ;
node 124306  [expr $Axis3-$d_Col2_34_3_t/2.               ] [expr $Floor4-$d_Beam1_2_23_4/2.] [expr $Depth2] ;# bottom left    ;
node 124312  [expr $Axis3+$d_Col2_34_3_t/2.               ] [expr $Floor4-$d_Beam1_2_23_4/2.] [expr $Depth2] ;# bottom right   ;
node 124311  [expr $Axis3+$d_Col2_34_3_t/2.               ] [expr $Floor4-$d_Beam1_2_23_4/2.] [expr $Depth2] ;# bottom right   ;
node 124302  [expr $Axis3-$d_Col2_34_3_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle left    ;
node 124304  [expr $Axis3+$d_Col2_34_3_t/2.               ] [expr $Floor4               ] [expr $Depth2] ;# middle right   ;
node 124307  [expr $Axis3-$d_Col2_34_3_t/2.               ] [expr $Floor4+$d_Beam1_2_23_4/2.] [expr $Depth2] ;# top left       ;
node 124308  [expr $Axis3-$d_Col2_34_3_t/2.               ] [expr $Floor4+$d_Beam1_2_23_4/2.] [expr $Depth2] ;# top left       ;
node 124309  [expr $Axis3+$d_Col2_34_3_t/2.               ] [expr $Floor4+$d_Beam1_2_23_4/2.] [expr $Depth2] ;# top right      ;
node 124310  [expr $Axis3+$d_Col2_34_3_t/2.               ] [expr $Floor4+$d_Beam1_2_23_4/2.] [expr $Depth2] ;# top right      ;
node 024303  [expr $Axis3                               ] [expr $Floor4+$d_Beam1_2_23_4/2.] [expr $Depth2] ;# top middle     ;
node 12432   [expr $Axis3-$d_Col2_34_3_t/2.-$H_offset               ] [expr $Floor4               ] [expr $Depth2] ;# WUF-Wleft ;

#Direction-1, Depth-2 AXIS-3, FLOOR-5;
node 025301  [expr $Axis3                               ] [expr $Floor5-$d_Beam1_2_23_5/2.] [expr $Depth2] ;# bottom middle  ;
node 125305  [expr $Axis3-$d_Col2_45_3_t/2.               ] [expr $Floor5-$d_Beam1_2_23_5/2.] [expr $Depth2] ;# bottom left    ;
node 125306  [expr $Axis3-$d_Col2_45_3_t/2.               ] [expr $Floor5-$d_Beam1_2_23_5/2.] [expr $Depth2] ;# bottom left    ;
node 125312  [expr $Axis3+$d_Col2_45_3_t/2.               ] [expr $Floor5-$d_Beam1_2_23_5/2.] [expr $Depth2] ;# bottom right   ;
node 125311  [expr $Axis3+$d_Col2_45_3_t/2.               ] [expr $Floor5-$d_Beam1_2_23_5/2.] [expr $Depth2] ;# bottom right   ;
node 125302  [expr $Axis3-$d_Col2_45_3_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle left    ;
node 125304  [expr $Axis3+$d_Col2_45_3_t/2.               ] [expr $Floor5               ] [expr $Depth2] ;# middle right   ;
node 125307  [expr $Axis3-$d_Col2_45_3_t/2.               ] [expr $Floor5+$d_Beam1_2_23_5/2.] [expr $Depth2] ;# top left       ;
node 125308  [expr $Axis3-$d_Col2_45_3_t/2.               ] [expr $Floor5+$d_Beam1_2_23_5/2.] [expr $Depth2] ;# top left       ;
node 125309  [expr $Axis3+$d_Col2_45_3_t/2.               ] [expr $Floor5+$d_Beam1_2_23_5/2.] [expr $Depth2] ;# top right      ;
node 125310  [expr $Axis3+$d_Col2_45_3_t/2.               ] [expr $Floor5+$d_Beam1_2_23_5/2.] [expr $Depth2] ;# top right      ;
node 025303  [expr $Axis3                               ] [expr $Floor5+$d_Beam1_2_23_5/2.] [expr $Depth2] ;# top middle     ;
node 12532   [expr $Axis3-$d_Col2_45_3_t/2.-$H_offset               ] [expr $Floor5               ] [expr $Depth2] ;# WUF-Wleft ;


# Panel zone G11 and G12;
# Direction-2, Depth-1 AXIS-1, FLOOR-2;
node 212105  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth1-$d_Col1_12_1_t/2.] ;# bottom left ;
node 212106  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth1-$d_Col1_12_1_t/2.] ;# bottom left ;
node 212112  [expr $Axis1            ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth1+$d_Col1_12_1_t/2.   ] ;# bottom right ;
node 212111  [expr $Axis1              ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth1+$d_Col1_12_1_t/2. ] ;# bottom right;
node 212102  [expr $Axis1               ] [expr $Floor2               ] [expr $Depth1-$d_Col1_12_1_t/2.] ;# middle left  ;
node 212104  [expr $Axis1               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_1_t/2.] ;# middle right ;
node 212107  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth1-$d_Col1_12_1_t/2.] ;# top left  ;
node 212108  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth1-$d_Col1_12_1_t/2.] ;# top left;
node 212109  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth1+$d_Col1_12_1_t/2.] ;# top right;
node 212110  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth1+$d_Col1_12_1_t/2.] ;# top right;
node 21214   [expr $Axis1               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_1_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-1, FLOOR-3;
node 213105  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth1-$d_Col1_23_1_t/2.] ;# bottom left ;
node 213106  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth1-$d_Col1_23_1_t/2.] ;# bottom left ;
node 213112  [expr $Axis1            ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth1+$d_Col1_23_1_t/2.   ] ;# bottom right ;
node 213111  [expr $Axis1              ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth1+$d_Col1_23_1_t/2. ] ;# bottom right;
node 213102  [expr $Axis1               ] [expr $Floor3               ] [expr $Depth1-$d_Col1_23_1_t/2.] ;# middle left  ;
node 213104  [expr $Axis1               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_1_t/2.] ;# middle right ;
node 213107  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth1-$d_Col1_23_1_t/2.] ;# top left  ;
node 213108  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth1-$d_Col1_23_1_t/2.] ;# top left;
node 213109  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth1+$d_Col1_23_1_t/2.] ;# top right;
node 213110  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth1+$d_Col1_23_1_t/2.] ;# top right;
node 21314   [expr $Axis1               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_1_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-1, FLOOR-4;
node 214105  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth1-$d_Col1_34_1_t/2.] ;# bottom left ;
node 214106  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth1-$d_Col1_34_1_t/2.] ;# bottom left ;
node 214112  [expr $Axis1            ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth1+$d_Col1_34_1_t/2.   ] ;# bottom right ;
node 214111  [expr $Axis1              ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth1+$d_Col1_34_1_t/2. ] ;# bottom right;
node 214102  [expr $Axis1               ] [expr $Floor4               ] [expr $Depth1-$d_Col1_34_1_t/2.] ;# middle left  ;
node 214104  [expr $Axis1               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_1_t/2.] ;# middle right ;
node 214107  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth1-$d_Col1_34_1_t/2.] ;# top left  ;
node 214108  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth1-$d_Col1_34_1_t/2.] ;# top left;
node 214109  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth1+$d_Col1_34_1_t/2.] ;# top right;
node 214110  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth1+$d_Col1_34_1_t/2.] ;# top right;
node 21414   [expr $Axis1               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_1_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-1, FLOOR-5;
node 215105  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth1-$d_Col1_45_1_t/2.] ;# bottom left ;
node 215106  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth1-$d_Col1_45_1_t/2.] ;# bottom left ;
node 215112  [expr $Axis1            ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth1+$d_Col1_45_1_t/2.   ] ;# bottom right ;
node 215111  [expr $Axis1              ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth1+$d_Col1_45_1_t/2. ] ;# bottom right;
node 215102  [expr $Axis1               ] [expr $Floor5               ] [expr $Depth1-$d_Col1_45_1_t/2.] ;# middle left  ;
node 215104  [expr $Axis1               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_1_t/2.] ;# middle right ;
node 215107  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth1-$d_Col1_45_1_t/2.] ;# top left  ;
node 215108  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth1-$d_Col1_45_1_t/2.] ;# top left;
node 215109  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth1+$d_Col1_45_1_t/2.] ;# top right;
node 215110  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth1+$d_Col1_45_1_t/2.] ;# top right;
node 21514   [expr $Axis1               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_1_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-2, FLOOR-2;
node 212205  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth1-$d_Col1_12_2_t/2.] ;# bottom left ;
node 212206  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth1-$d_Col1_12_2_t/2.] ;# bottom left ;
node 212212  [expr $Axis2            ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth1+$d_Col1_12_2_t/2.   ] ;# bottom right ;
node 212211  [expr $Axis2              ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth1+$d_Col1_12_2_t/2. ] ;# bottom right;
node 212202  [expr $Axis2               ] [expr $Floor2               ] [expr $Depth1-$d_Col1_12_2_t/2.] ;# middle left  ;
node 212204  [expr $Axis2               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_2_t/2.] ;# middle right ;
node 212207  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth1-$d_Col1_12_2_t/2.] ;# top left  ;
node 212208  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth1-$d_Col1_12_2_t/2.] ;# top left;
node 212209  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth1+$d_Col1_12_2_t/2.] ;# top right;
node 212210  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth1+$d_Col1_12_2_t/2.] ;# top right;
node 21224   [expr $Axis2               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_2_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-2, FLOOR-3;
node 213205  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth1-$d_Col1_23_2_t/2.] ;# bottom left ;
node 213206  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth1-$d_Col1_23_2_t/2.] ;# bottom left ;
node 213212  [expr $Axis2            ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth1+$d_Col1_23_2_t/2.   ] ;# bottom right ;
node 213211  [expr $Axis2              ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth1+$d_Col1_23_2_t/2. ] ;# bottom right;
node 213202  [expr $Axis2               ] [expr $Floor3               ] [expr $Depth1-$d_Col1_23_2_t/2.] ;# middle left  ;
node 213204  [expr $Axis2               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_2_t/2.] ;# middle right ;
node 213207  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth1-$d_Col1_23_2_t/2.] ;# top left  ;
node 213208  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth1-$d_Col1_23_2_t/2.] ;# top left;
node 213209  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth1+$d_Col1_23_2_t/2.] ;# top right;
node 213210  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth1+$d_Col1_23_2_t/2.] ;# top right;
node 21324   [expr $Axis2               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_2_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-2, FLOOR-4;
node 214205  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth1-$d_Col1_34_2_t/2.] ;# bottom left ;
node 214206  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth1-$d_Col1_34_2_t/2.] ;# bottom left ;
node 214212  [expr $Axis2            ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth1+$d_Col1_34_2_t/2.   ] ;# bottom right ;
node 214211  [expr $Axis2              ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth1+$d_Col1_34_2_t/2. ] ;# bottom right;
node 214202  [expr $Axis2               ] [expr $Floor4               ] [expr $Depth1-$d_Col1_34_2_t/2.] ;# middle left  ;
node 214204  [expr $Axis2               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_2_t/2.] ;# middle right ;
node 214207  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth1-$d_Col1_34_2_t/2.] ;# top left  ;
node 214208  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth1-$d_Col1_34_2_t/2.] ;# top left;
node 214209  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth1+$d_Col1_34_2_t/2.] ;# top right;
node 214210  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth1+$d_Col1_34_2_t/2.] ;# top right;
node 21424   [expr $Axis2               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_2_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-2, FLOOR-5;
node 215205  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth1-$d_Col1_45_2_t/2.] ;# bottom left ;
node 215206  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth1-$d_Col1_45_2_t/2.] ;# bottom left ;
node 215212  [expr $Axis2            ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth1+$d_Col1_45_2_t/2.   ] ;# bottom right ;
node 215211  [expr $Axis2              ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth1+$d_Col1_45_2_t/2. ] ;# bottom right;
node 215202  [expr $Axis2               ] [expr $Floor5               ] [expr $Depth1-$d_Col1_45_2_t/2.] ;# middle left  ;
node 215204  [expr $Axis2               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_2_t/2.] ;# middle right ;
node 215207  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth1-$d_Col1_45_2_t/2.] ;# top left  ;
node 215208  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth1-$d_Col1_45_2_t/2.] ;# top left;
node 215209  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth1+$d_Col1_45_2_t/2.] ;# top right;
node 215210  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth1+$d_Col1_45_2_t/2.] ;# top right;
node 21524   [expr $Axis2               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_2_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-3, FLOOR-2;
node 212305  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth1-$d_Col1_12_3_t/2.] ;# bottom left ;
node 212306  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth1-$d_Col1_12_3_t/2.] ;# bottom left ;
node 212312  [expr $Axis3            ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth1+$d_Col1_12_3_t/2.   ] ;# bottom right ;
node 212311  [expr $Axis3              ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth1+$d_Col1_12_3_t/2. ] ;# bottom right;
node 212302  [expr $Axis3               ] [expr $Floor2               ] [expr $Depth1-$d_Col1_12_3_t/2.] ;# middle left  ;
node 212304  [expr $Axis3               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_3_t/2.] ;# middle right ;
node 212307  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth1-$d_Col1_12_3_t/2.] ;# top left  ;
node 212308  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth1-$d_Col1_12_3_t/2.] ;# top left;
node 212309  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth1+$d_Col1_12_3_t/2.] ;# top right;
node 212310  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth1+$d_Col1_12_3_t/2.] ;# top right;
node 21234   [expr $Axis3               ] [expr $Floor2               ] [expr $Depth1+$d_Col1_12_3_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-3, FLOOR-3;
node 213305  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth1-$d_Col1_23_3_t/2.] ;# bottom left ;
node 213306  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth1-$d_Col1_23_3_t/2.] ;# bottom left ;
node 213312  [expr $Axis3            ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth1+$d_Col1_23_3_t/2.   ] ;# bottom right ;
node 213311  [expr $Axis3              ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth1+$d_Col1_23_3_t/2. ] ;# bottom right;
node 213302  [expr $Axis3               ] [expr $Floor3               ] [expr $Depth1-$d_Col1_23_3_t/2.] ;# middle left  ;
node 213304  [expr $Axis3               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_3_t/2.] ;# middle right ;
node 213307  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth1-$d_Col1_23_3_t/2.] ;# top left  ;
node 213308  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth1-$d_Col1_23_3_t/2.] ;# top left;
node 213309  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth1+$d_Col1_23_3_t/2.] ;# top right;
node 213310  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth1+$d_Col1_23_3_t/2.] ;# top right;
node 21334   [expr $Axis3               ] [expr $Floor3               ] [expr $Depth1+$d_Col1_23_3_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-3, FLOOR-4;
node 214305  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth1-$d_Col1_34_3_t/2.] ;# bottom left ;
node 214306  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth1-$d_Col1_34_3_t/2.] ;# bottom left ;
node 214312  [expr $Axis3            ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth1+$d_Col1_34_3_t/2.   ] ;# bottom right ;
node 214311  [expr $Axis3              ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth1+$d_Col1_34_3_t/2. ] ;# bottom right;
node 214302  [expr $Axis3               ] [expr $Floor4               ] [expr $Depth1-$d_Col1_34_3_t/2.] ;# middle left  ;
node 214304  [expr $Axis3               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_3_t/2.] ;# middle right ;
node 214307  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth1-$d_Col1_34_3_t/2.] ;# top left  ;
node 214308  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth1-$d_Col1_34_3_t/2.] ;# top left;
node 214309  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth1+$d_Col1_34_3_t/2.] ;# top right;
node 214310  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth1+$d_Col1_34_3_t/2.] ;# top right;
node 21434   [expr $Axis3               ] [expr $Floor4               ] [expr $Depth1+$d_Col1_34_3_t/2.+$H_offset] ;# WUF-Wright;

# Direction-2, Depth-1 AXIS-3, FLOOR-5;
node 215305  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth1-$d_Col1_45_3_t/2.] ;# bottom left ;
node 215306  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth1-$d_Col1_45_3_t/2.] ;# bottom left ;
node 215312  [expr $Axis3            ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth1+$d_Col1_45_3_t/2.   ] ;# bottom right ;
node 215311  [expr $Axis3              ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth1+$d_Col1_45_3_t/2. ] ;# bottom right;
node 215302  [expr $Axis3               ] [expr $Floor5               ] [expr $Depth1-$d_Col1_45_3_t/2.] ;# middle left  ;
node 215304  [expr $Axis3               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_3_t/2.] ;# middle right ;
node 215307  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth1-$d_Col1_45_3_t/2.] ;# top left  ;
node 215308  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth1-$d_Col1_45_3_t/2.] ;# top left;
node 215309  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth1+$d_Col1_45_3_t/2.] ;# top right;
node 215310  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth1+$d_Col1_45_3_t/2.] ;# top right;
node 21534   [expr $Axis3               ] [expr $Floor5               ] [expr $Depth1+$d_Col1_45_3_t/2.+$H_offset] ;# WUF-Wright;

#Direction-2, Depth-2 AXIS-1, FLOOR-2;
node 222105  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth2-$d_Col2_12_1_t/2.] ;# bottom left    ;
node 222106  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth2-$d_Col2_12_1_t/2.] ;# bottom left    ;
node 222112  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth2+$d_Col2_12_1_t/2.] ;# bottom right   ;
node 222111  [expr $Axis1               ] [expr $Floor2-$d_Beam4PZ2_12_1_2/2.] [expr $Depth2+$d_Col2_12_1_t/2.] ;# bottom right   ;
node 222102  [expr $Axis1               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_1_t/2.] ;# middle left    ;
node 222104  [expr $Axis1               ] [expr $Floor2               ] [expr $Depth2+$d_Col2_12_1_t/2.] ;# middle right   ;
node 222107  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth2-$d_Col2_12_1_t/2.] ;# top left       ;
node 222108  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth2-$d_Col2_12_1_t/2.] ;# top left       ;
node 222109  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth2+$d_Col2_12_1_t/2.] ;# top right      ;
node 222110  [expr $Axis1               ] [expr $Floor2+$d_Beam4PZ2_12_1_2/2.] [expr $Depth2+$d_Col2_12_1_t/2.] ;# top right      ;
node 22212   [expr $Axis1               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_1_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-1, FLOOR-3;
node 223105  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth2-$d_Col2_23_1_t/2.] ;# bottom left    ;
node 223106  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth2-$d_Col2_23_1_t/2.] ;# bottom left    ;
node 223112  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth2+$d_Col2_23_1_t/2.] ;# bottom right   ;
node 223111  [expr $Axis1               ] [expr $Floor3-$d_Beam4PZ2_12_1_3/2.] [expr $Depth2+$d_Col2_23_1_t/2.] ;# bottom right   ;
node 223102  [expr $Axis1               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_1_t/2.] ;# middle left    ;
node 223104  [expr $Axis1               ] [expr $Floor3               ] [expr $Depth2+$d_Col2_23_1_t/2.] ;# middle right   ;
node 223107  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth2-$d_Col2_23_1_t/2.] ;# top left       ;
node 223108  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth2-$d_Col2_23_1_t/2.] ;# top left       ;
node 223109  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth2+$d_Col2_23_1_t/2.] ;# top right      ;
node 223110  [expr $Axis1               ] [expr $Floor3+$d_Beam4PZ2_12_1_3/2.] [expr $Depth2+$d_Col2_23_1_t/2.] ;# top right      ;
node 22312   [expr $Axis1               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_1_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-1, FLOOR-4;
node 224105  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth2-$d_Col2_34_1_t/2.] ;# bottom left    ;
node 224106  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth2-$d_Col2_34_1_t/2.] ;# bottom left    ;
node 224112  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth2+$d_Col2_34_1_t/2.] ;# bottom right   ;
node 224111  [expr $Axis1               ] [expr $Floor4-$d_Beam4PZ2_12_1_4/2.] [expr $Depth2+$d_Col2_34_1_t/2.] ;# bottom right   ;
node 224102  [expr $Axis1               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_1_t/2.] ;# middle left    ;
node 224104  [expr $Axis1               ] [expr $Floor4               ] [expr $Depth2+$d_Col2_34_1_t/2.] ;# middle right   ;
node 224107  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth2-$d_Col2_34_1_t/2.] ;# top left       ;
node 224108  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth2-$d_Col2_34_1_t/2.] ;# top left       ;
node 224109  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth2+$d_Col2_34_1_t/2.] ;# top right      ;
node 224110  [expr $Axis1               ] [expr $Floor4+$d_Beam4PZ2_12_1_4/2.] [expr $Depth2+$d_Col2_34_1_t/2.] ;# top right      ;
node 22412   [expr $Axis1               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_1_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-1, FLOOR-5;
node 225105  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth2-$d_Col2_45_1_t/2.] ;# bottom left    ;
node 225106  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth2-$d_Col2_45_1_t/2.] ;# bottom left    ;
node 225112  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth2+$d_Col2_45_1_t/2.] ;# bottom right   ;
node 225111  [expr $Axis1               ] [expr $Floor5-$d_Beam4PZ2_12_1_5/2.] [expr $Depth2+$d_Col2_45_1_t/2.] ;# bottom right   ;
node 225102  [expr $Axis1               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_1_t/2.] ;# middle left    ;
node 225104  [expr $Axis1               ] [expr $Floor5               ] [expr $Depth2+$d_Col2_45_1_t/2.] ;# middle right   ;
node 225107  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth2-$d_Col2_45_1_t/2.] ;# top left       ;
node 225108  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth2-$d_Col2_45_1_t/2.] ;# top left       ;
node 225109  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth2+$d_Col2_45_1_t/2.] ;# top right      ;
node 225110  [expr $Axis1               ] [expr $Floor5+$d_Beam4PZ2_12_1_5/2.] [expr $Depth2+$d_Col2_45_1_t/2.] ;# top right      ;
node 22512   [expr $Axis1               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_1_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-2, FLOOR-2;
node 222205  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth2-$d_Col2_12_2_t/2.] ;# bottom left    ;
node 222206  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth2-$d_Col2_12_2_t/2.] ;# bottom left    ;
node 222212  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth2+$d_Col2_12_2_t/2.] ;# bottom right   ;
node 222211  [expr $Axis2               ] [expr $Floor2-$d_Beam4PZ2_12_2_2/2.] [expr $Depth2+$d_Col2_12_2_t/2.] ;# bottom right   ;
node 222202  [expr $Axis2               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_2_t/2.] ;# middle left    ;
node 222204  [expr $Axis2               ] [expr $Floor2               ] [expr $Depth2+$d_Col2_12_2_t/2.] ;# middle right   ;
node 222207  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth2-$d_Col2_12_2_t/2.] ;# top left       ;
node 222208  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth2-$d_Col2_12_2_t/2.] ;# top left       ;
node 222209  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth2+$d_Col2_12_2_t/2.] ;# top right      ;
node 222210  [expr $Axis2               ] [expr $Floor2+$d_Beam4PZ2_12_2_2/2.] [expr $Depth2+$d_Col2_12_2_t/2.] ;# top right      ;
node 22222   [expr $Axis2               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_2_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-2, FLOOR-3;
node 223205  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth2-$d_Col2_23_2_t/2.] ;# bottom left    ;
node 223206  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth2-$d_Col2_23_2_t/2.] ;# bottom left    ;
node 223212  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth2+$d_Col2_23_2_t/2.] ;# bottom right   ;
node 223211  [expr $Axis2               ] [expr $Floor3-$d_Beam4PZ2_12_2_3/2.] [expr $Depth2+$d_Col2_23_2_t/2.] ;# bottom right   ;
node 223202  [expr $Axis2               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_2_t/2.] ;# middle left    ;
node 223204  [expr $Axis2               ] [expr $Floor3               ] [expr $Depth2+$d_Col2_23_2_t/2.] ;# middle right   ;
node 223207  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth2-$d_Col2_23_2_t/2.] ;# top left       ;
node 223208  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth2-$d_Col2_23_2_t/2.] ;# top left       ;
node 223209  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth2+$d_Col2_23_2_t/2.] ;# top right      ;
node 223210  [expr $Axis2               ] [expr $Floor3+$d_Beam4PZ2_12_2_3/2.] [expr $Depth2+$d_Col2_23_2_t/2.] ;# top right      ;
node 22322   [expr $Axis2               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_2_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-2, FLOOR-4;
node 224205  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth2-$d_Col2_34_2_t/2.] ;# bottom left    ;
node 224206  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth2-$d_Col2_34_2_t/2.] ;# bottom left    ;
node 224212  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth2+$d_Col2_34_2_t/2.] ;# bottom right   ;
node 224211  [expr $Axis2               ] [expr $Floor4-$d_Beam4PZ2_12_2_4/2.] [expr $Depth2+$d_Col2_34_2_t/2.] ;# bottom right   ;
node 224202  [expr $Axis2               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_2_t/2.] ;# middle left    ;
node 224204  [expr $Axis2               ] [expr $Floor4               ] [expr $Depth2+$d_Col2_34_2_t/2.] ;# middle right   ;
node 224207  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth2-$d_Col2_34_2_t/2.] ;# top left       ;
node 224208  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth2-$d_Col2_34_2_t/2.] ;# top left       ;
node 224209  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth2+$d_Col2_34_2_t/2.] ;# top right      ;
node 224210  [expr $Axis2               ] [expr $Floor4+$d_Beam4PZ2_12_2_4/2.] [expr $Depth2+$d_Col2_34_2_t/2.] ;# top right      ;
node 22422   [expr $Axis2               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_2_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-2, FLOOR-5;
node 225205  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth2-$d_Col2_45_2_t/2.] ;# bottom left    ;
node 225206  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth2-$d_Col2_45_2_t/2.] ;# bottom left    ;
node 225212  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth2+$d_Col2_45_2_t/2.] ;# bottom right   ;
node 225211  [expr $Axis2               ] [expr $Floor5-$d_Beam4PZ2_12_2_5/2.] [expr $Depth2+$d_Col2_45_2_t/2.] ;# bottom right   ;
node 225202  [expr $Axis2               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_2_t/2.] ;# middle left    ;
node 225204  [expr $Axis2               ] [expr $Floor5               ] [expr $Depth2+$d_Col2_45_2_t/2.] ;# middle right   ;
node 225207  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth2-$d_Col2_45_2_t/2.] ;# top left       ;
node 225208  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth2-$d_Col2_45_2_t/2.] ;# top left       ;
node 225209  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth2+$d_Col2_45_2_t/2.] ;# top right      ;
node 225210  [expr $Axis2               ] [expr $Floor5+$d_Beam4PZ2_12_2_5/2.] [expr $Depth2+$d_Col2_45_2_t/2.] ;# top right      ;
node 22522   [expr $Axis2               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_2_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-3, FLOOR-2;
node 222305  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth2-$d_Col2_12_3_t/2.] ;# bottom left    ;
node 222306  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth2-$d_Col2_12_3_t/2.] ;# bottom left    ;
node 222312  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth2+$d_Col2_12_3_t/2.] ;# bottom right   ;
node 222311  [expr $Axis3               ] [expr $Floor2-$d_Beam4PZ2_12_3_2/2.] [expr $Depth2+$d_Col2_12_3_t/2.] ;# bottom right   ;
node 222302  [expr $Axis3               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_3_t/2.] ;# middle left    ;
node 222304  [expr $Axis3               ] [expr $Floor2               ] [expr $Depth2+$d_Col2_12_3_t/2.] ;# middle right   ;
node 222307  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth2-$d_Col2_12_3_t/2.] ;# top left       ;
node 222308  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth2-$d_Col2_12_3_t/2.] ;# top left       ;
node 222309  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth2+$d_Col2_12_3_t/2.] ;# top right      ;
node 222310  [expr $Axis3               ] [expr $Floor2+$d_Beam4PZ2_12_3_2/2.] [expr $Depth2+$d_Col2_12_3_t/2.] ;# top right      ;
node 22232   [expr $Axis3               ] [expr $Floor2               ] [expr $Depth2-$d_Col2_12_3_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-3, FLOOR-3;
node 223305  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth2-$d_Col2_23_3_t/2.] ;# bottom left    ;
node 223306  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth2-$d_Col2_23_3_t/2.] ;# bottom left    ;
node 223312  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth2+$d_Col2_23_3_t/2.] ;# bottom right   ;
node 223311  [expr $Axis3               ] [expr $Floor3-$d_Beam4PZ2_12_3_3/2.] [expr $Depth2+$d_Col2_23_3_t/2.] ;# bottom right   ;
node 223302  [expr $Axis3               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_3_t/2.] ;# middle left    ;
node 223304  [expr $Axis3               ] [expr $Floor3               ] [expr $Depth2+$d_Col2_23_3_t/2.] ;# middle right   ;
node 223307  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth2-$d_Col2_23_3_t/2.] ;# top left       ;
node 223308  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth2-$d_Col2_23_3_t/2.] ;# top left       ;
node 223309  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth2+$d_Col2_23_3_t/2.] ;# top right      ;
node 223310  [expr $Axis3               ] [expr $Floor3+$d_Beam4PZ2_12_3_3/2.] [expr $Depth2+$d_Col2_23_3_t/2.] ;# top right      ;
node 22332   [expr $Axis3               ] [expr $Floor3               ] [expr $Depth2-$d_Col2_23_3_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-3, FLOOR-4;
node 224305  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth2-$d_Col2_34_3_t/2.] ;# bottom left    ;
node 224306  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth2-$d_Col2_34_3_t/2.] ;# bottom left    ;
node 224312  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth2+$d_Col2_34_3_t/2.] ;# bottom right   ;
node 224311  [expr $Axis3               ] [expr $Floor4-$d_Beam4PZ2_12_3_4/2.] [expr $Depth2+$d_Col2_34_3_t/2.] ;# bottom right   ;
node 224302  [expr $Axis3               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_3_t/2.] ;# middle left    ;
node 224304  [expr $Axis3               ] [expr $Floor4               ] [expr $Depth2+$d_Col2_34_3_t/2.] ;# middle right   ;
node 224307  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth2-$d_Col2_34_3_t/2.] ;# top left       ;
node 224308  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth2-$d_Col2_34_3_t/2.] ;# top left       ;
node 224309  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth2+$d_Col2_34_3_t/2.] ;# top right      ;
node 224310  [expr $Axis3               ] [expr $Floor4+$d_Beam4PZ2_12_3_4/2.] [expr $Depth2+$d_Col2_34_3_t/2.] ;# top right      ;
node 22432   [expr $Axis3               ] [expr $Floor4               ] [expr $Depth2-$d_Col2_34_3_t/2.-$H_offset] ;# WUF-Wleft ;

#Direction-2, Depth-2 AXIS-3, FLOOR-5;
node 225305  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth2-$d_Col2_45_3_t/2.] ;# bottom left    ;
node 225306  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth2-$d_Col2_45_3_t/2.] ;# bottom left    ;
node 225312  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth2+$d_Col2_45_3_t/2.] ;# bottom right   ;
node 225311  [expr $Axis3               ] [expr $Floor5-$d_Beam4PZ2_12_3_5/2.] [expr $Depth2+$d_Col2_45_3_t/2.] ;# bottom right   ;
node 225302  [expr $Axis3               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_3_t/2.] ;# middle left    ;
node 225304  [expr $Axis3               ] [expr $Floor5               ] [expr $Depth2+$d_Col2_45_3_t/2.] ;# middle right   ;
node 225307  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth2-$d_Col2_45_3_t/2.] ;# top left       ;
node 225308  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth2-$d_Col2_45_3_t/2.] ;# top left       ;
node 225309  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth2+$d_Col2_45_3_t/2.] ;# top right      ;
node 225310  [expr $Axis3               ] [expr $Floor5+$d_Beam4PZ2_12_3_5/2.] [expr $Depth2+$d_Col2_45_3_t/2.] ;# top right      ;
node 22532   [expr $Axis3               ] [expr $Floor5               ] [expr $Depth2-$d_Col2_45_3_t/2.-$H_offset] ;# WUF-Wleft ;


uniaxialMaterial Elastic 555 [expr 10009999.*$E];
uniaxialMaterial Elastic 556 [expr 999999999999999999.];
uniaxialMaterial Elastic 666 [expr 0.0001];
set A_pz_rigid 10547290000.0000;
set I_pz_rigid 51506823512.8888;
set J_pz_flexible 0.00000001;

# Spring Elements in X direction;
# DirectionDepthFloorAxis = 1121;
# Panel Rigid Link;
element elasticBeamColumn 100112101 112105 012101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112108 012101 112112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112107 112111 112104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112106 112104 112110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112105 112109 012103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112104 012103 112108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112103 112107 112102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112102 112106 112102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112105 112106 1 2 3 4 5;
equalDOF 112112 112111 1 2 3 4 5;
equalDOF 112110 112109 1 2 3 4 5;
equalDOF 112107 112108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112100 $M1C_Panel1_1_2_1 $Gamma_1_Panel1_1_2_1 $M4C_Panel1_1_2_1 $Gamma_4_Panel1_1_2_1 $M6C_Panel1_1_2_1 $Gamma_6_Panel1_1_2_1 -$M1_Panel1_1_2_1 -$Gamma_1_Panel1_1_2_1 -$M4_Panel1_1_2_1 -$Gamma_4_Panel1_1_2_1 -$M6_Panel1_1_2_1 -$Gamma_6_Panel1_1_2_1 0.25 0.75 0 0 0;
element zeroLength          100112100  112109 112110 -mat 100112100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1121400 $K_s_Beam1_1_12_2 $Alpha_s_Beam1_1_12_2 $Alpha_s_BeamComp1_1_12_2 $My_s_Beam1_1_12_2 -$My_s_BeamComp1_1_12_2  $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_2  $Theta_p_s_BeamComp1_1_12_2  $Theta_pc_s_Beam1_1_12_2  $Theta_pc_s_BeamComp1_1_12_2  $Res_s_Beam1_1_12_2  $Res_s_BeamComp1_1_12_2  $Theta_ult_s_Beam1_1_12_2  $Theta_ult_s_BeamComp1_1_12_2  1. 1.15;
element     zeroLength 1121400 11214 112104 -mat 1121400 -dir 6;
equalDOF                     11214 112104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1131;
# Panel Rigid Link;
element elasticBeamColumn 100113101 113105 013101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113108 013101 113112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113107 113111 113104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113106 113104 113110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113105 113109 013103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113104 013103 113108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113103 113107 113102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113102 113106 113102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113105 113106 1 2 3 4 5;
equalDOF 113112 113111 1 2 3 4 5;
equalDOF 113110 113109 1 2 3 4 5;
equalDOF 113107 113108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113100 $M1C_Panel1_1_3_1 $Gamma_1_Panel1_1_3_1 $M4C_Panel1_1_3_1 $Gamma_4_Panel1_1_3_1 $M6C_Panel1_1_3_1 $Gamma_6_Panel1_1_3_1 -$M1_Panel1_1_3_1 -$Gamma_1_Panel1_1_3_1 -$M4_Panel1_1_3_1 -$Gamma_4_Panel1_1_3_1 -$M6_Panel1_1_3_1 -$Gamma_6_Panel1_1_3_1 0.25 0.75 0 0 0;
element zeroLength          100113100  113109 113110 -mat 100113100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1131400 $K_s_Beam1_1_12_3 $Alpha_s_Beam1_1_12_3 $Alpha_s_BeamComp1_1_12_3 $My_s_Beam1_1_12_3 -$My_s_BeamComp1_1_12_3  $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_3  $Theta_p_s_BeamComp1_1_12_3  $Theta_pc_s_Beam1_1_12_3  $Theta_pc_s_BeamComp1_1_12_3  $Res_s_Beam1_1_12_3  $Res_s_BeamComp1_1_12_3  $Theta_ult_s_Beam1_1_12_3  $Theta_ult_s_BeamComp1_1_12_3  1. 1.15;
element     zeroLength 1131400 11314 113104 -mat 1131400 -dir 6;
equalDOF                     11314 113104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1141;
# Panel Rigid Link;
element elasticBeamColumn 100114101 114105 014101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114108 014101 114112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114107 114111 114104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114106 114104 114110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114105 114109 014103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114104 014103 114108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114103 114107 114102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114102 114106 114102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114105 114106 1 2 3 4 5;
equalDOF 114112 114111 1 2 3 4 5;
equalDOF 114110 114109 1 2 3 4 5;
equalDOF 114107 114108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114100 $M1C_Panel1_1_4_1 $Gamma_1_Panel1_1_4_1 $M4C_Panel1_1_4_1 $Gamma_4_Panel1_1_4_1 $M6C_Panel1_1_4_1 $Gamma_6_Panel1_1_4_1 -$M1_Panel1_1_4_1 -$Gamma_1_Panel1_1_4_1 -$M4_Panel1_1_4_1 -$Gamma_4_Panel1_1_4_1 -$M6_Panel1_1_4_1 -$Gamma_6_Panel1_1_4_1 0.25 0.75 0 0 0;
element zeroLength          100114100  114109 114110 -mat 100114100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1141400 $K_s_Beam1_1_12_4 $Alpha_s_Beam1_1_12_4 $Alpha_s_BeamComp1_1_12_4 $My_s_Beam1_1_12_4 -$My_s_BeamComp1_1_12_4  $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_4  $Theta_p_s_BeamComp1_1_12_4  $Theta_pc_s_Beam1_1_12_4  $Theta_pc_s_BeamComp1_1_12_4  $Res_s_Beam1_1_12_4  $Res_s_BeamComp1_1_12_4  $Theta_ult_s_Beam1_1_12_4  $Theta_ult_s_BeamComp1_1_12_4  1. 1.15;
element     zeroLength 1141400 11414 114104 -mat 1141400 -dir 6;
equalDOF                     11414 114104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1151;
# Panel Rigid Link;
element elasticBeamColumn 100115101 115105 015101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115108 015101 115112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115107 115111 115104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115106 115104 115110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115105 115109 015103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115104 015103 115108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115103 115107 115102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115102 115106 115102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115105 115106 1 2 3 4 5;
equalDOF 115112 115111 1 2 3 4 5;
equalDOF 115110 115109 1 2 3 4 5;
equalDOF 115107 115108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115100 $M1C_Panel1_1_5_1 $Gamma_1_Panel1_1_5_1 $M4C_Panel1_1_5_1 $Gamma_4_Panel1_1_5_1 $M6C_Panel1_1_5_1 $Gamma_6_Panel1_1_5_1 -$M1_Panel1_1_5_1 -$Gamma_1_Panel1_1_5_1 -$M4_Panel1_1_5_1 -$Gamma_4_Panel1_1_5_1 -$M6_Panel1_1_5_1 -$Gamma_6_Panel1_1_5_1 0.25 0.75 0 0 0;
element zeroLength          100115100  115109 115110 -mat 100115100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1151400 $K_s_Beam1_1_12_5 $Alpha_s_Beam1_1_12_5 $Alpha_s_BeamComp1_1_12_5 $My_s_Beam1_1_12_5 -$My_s_BeamComp1_1_12_5  $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_5  $Theta_p_s_BeamComp1_1_12_5  $Theta_pc_s_Beam1_1_12_5  $Theta_pc_s_BeamComp1_1_12_5  $Res_s_Beam1_1_12_5  $Res_s_BeamComp1_1_12_5  $Theta_ult_s_Beam1_1_12_5  $Theta_ult_s_BeamComp1_1_12_5  1. 1.15;
element     zeroLength 1151400 11514 115104 -mat 1151400 -dir 6;
equalDOF                     11514 115104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1122;
# Panel Rigid Link;
element elasticBeamColumn 100112201 112205 012201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112208 012201 112212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112207 112211 112204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112206 112204 112210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112205 112209 012203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112204 012203 112208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112203 112207 112202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112202 112206 112202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112205 112206 1 2 3 4 5;
equalDOF 112212 112211 1 2 3 4 5;
equalDOF 112210 112209 1 2 3 4 5;
equalDOF 112207 112208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112200 $M1C_Panel1_1_2_2 $Gamma_1_Panel1_1_2_2 $M4C_Panel1_1_2_2 $Gamma_4_Panel1_1_2_2 $M6C_Panel1_1_2_2 $Gamma_6_Panel1_1_2_2 -$M1C_Panel1_1_2_2 -$Gamma_1_Panel1_1_2_2 -$M4C_Panel1_1_2_2 -$Gamma_4_Panel1_1_2_2 -$M6C_Panel1_1_2_2 -$Gamma_6_Panel1_1_2_2 0.25 0.75 0 0 0;
element zeroLength          100112200  112209 112210 -mat 100112200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1122200 $K_s_Beam1_1_12_2 $Alpha_s_BeamComp1_1_12_2 $Alpha_s_Beam1_1_12_2 $My_s_BeamComp1_1_12_2 -$My_s_Beam1_1_12_2  $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_2  $Theta_p_s_Beam1_1_12_2  $Theta_pc_s_BeamComp1_1_12_2  $Theta_pc_s_Beam1_1_12_2  $Res_s_BeamComp1_1_12_2  $Res_s_Beam1_1_12_2  $Theta_ult_s_BeamComp1_1_12_2  $Theta_ult_s_Beam1_1_12_2  1.15 1.;
element     zeroLength 1122200 11222 112202 -mat 1122200 -dir 6;
equalDOF                     11222 112202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1122400 $K_s_Beam1_1_23_2 $Alpha_s_Beam1_1_23_2 $Alpha_s_BeamComp1_1_23_2 $My_s_Beam1_1_23_2 -$My_s_BeamComp1_1_23_2  $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_2  $Theta_p_s_BeamComp1_1_23_2  $Theta_pc_s_Beam1_1_23_2  $Theta_pc_s_BeamComp1_1_23_2  $Res_s_Beam1_1_23_2  $Res_s_BeamComp1_1_23_2  $Theta_ult_s_Beam1_1_23_2  $Theta_ult_s_BeamComp1_1_23_2  1. 1.15;
element     zeroLength 1122400 11224 112204 -mat 1122400 -dir 6;
equalDOF                     11224 112204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1132;
# Panel Rigid Link;
element elasticBeamColumn 100113201 113205 013201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113208 013201 113212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113207 113211 113204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113206 113204 113210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113205 113209 013203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113204 013203 113208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113203 113207 113202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113202 113206 113202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113205 113206 1 2 3 4 5;
equalDOF 113212 113211 1 2 3 4 5;
equalDOF 113210 113209 1 2 3 4 5;
equalDOF 113207 113208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113200 $M1C_Panel1_1_3_2 $Gamma_1_Panel1_1_3_2 $M4C_Panel1_1_3_2 $Gamma_4_Panel1_1_3_2 $M6C_Panel1_1_3_2 $Gamma_6_Panel1_1_3_2 -$M1C_Panel1_1_3_2 -$Gamma_1_Panel1_1_3_2 -$M4C_Panel1_1_3_2 -$Gamma_4_Panel1_1_3_2 -$M6C_Panel1_1_3_2 -$Gamma_6_Panel1_1_3_2 0.25 0.75 0 0 0;
element zeroLength          100113200  113209 113210 -mat 100113200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1132200 $K_s_Beam1_1_12_3 $Alpha_s_BeamComp1_1_12_3 $Alpha_s_Beam1_1_12_3 $My_s_BeamComp1_1_12_3 -$My_s_Beam1_1_12_3  $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_3  $Theta_p_s_Beam1_1_12_3  $Theta_pc_s_BeamComp1_1_12_3  $Theta_pc_s_Beam1_1_12_3  $Res_s_BeamComp1_1_12_3  $Res_s_Beam1_1_12_3  $Theta_ult_s_BeamComp1_1_12_3  $Theta_ult_s_Beam1_1_12_3  1.15 1.;
element     zeroLength 1132200 11322 113202 -mat 1132200 -dir 6;
equalDOF                     11322 113202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1132400 $K_s_Beam1_1_23_3 $Alpha_s_Beam1_1_23_3 $Alpha_s_BeamComp1_1_23_3 $My_s_Beam1_1_23_3 -$My_s_BeamComp1_1_23_3  $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_3  $Theta_p_s_BeamComp1_1_23_3  $Theta_pc_s_Beam1_1_23_3  $Theta_pc_s_BeamComp1_1_23_3  $Res_s_Beam1_1_23_3  $Res_s_BeamComp1_1_23_3  $Theta_ult_s_Beam1_1_23_3  $Theta_ult_s_BeamComp1_1_23_3  1. 1.15;
element     zeroLength 1132400 11324 113204 -mat 1132400 -dir 6;
equalDOF                     11324 113204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1142;
# Panel Rigid Link;
element elasticBeamColumn 100114201 114205 014201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114208 014201 114212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114207 114211 114204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114206 114204 114210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114205 114209 014203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114204 014203 114208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114203 114207 114202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114202 114206 114202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114205 114206 1 2 3 4 5;
equalDOF 114212 114211 1 2 3 4 5;
equalDOF 114210 114209 1 2 3 4 5;
equalDOF 114207 114208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114200 $M1C_Panel1_1_4_2 $Gamma_1_Panel1_1_4_2 $M4C_Panel1_1_4_2 $Gamma_4_Panel1_1_4_2 $M6C_Panel1_1_4_2 $Gamma_6_Panel1_1_4_2 -$M1C_Panel1_1_4_2 -$Gamma_1_Panel1_1_4_2 -$M4C_Panel1_1_4_2 -$Gamma_4_Panel1_1_4_2 -$M6C_Panel1_1_4_2 -$Gamma_6_Panel1_1_4_2 0.25 0.75 0 0 0;
element zeroLength          100114200  114209 114210 -mat 100114200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1142200 $K_s_Beam1_1_12_4 $Alpha_s_BeamComp1_1_12_4 $Alpha_s_Beam1_1_12_4 $My_s_BeamComp1_1_12_4 -$My_s_Beam1_1_12_4  $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_4  $Theta_p_s_Beam1_1_12_4  $Theta_pc_s_BeamComp1_1_12_4  $Theta_pc_s_Beam1_1_12_4  $Res_s_BeamComp1_1_12_4  $Res_s_Beam1_1_12_4  $Theta_ult_s_BeamComp1_1_12_4  $Theta_ult_s_Beam1_1_12_4  1.15 1.;
element     zeroLength 1142200 11422 114202 -mat 1142200 -dir 6;
equalDOF                     11422 114202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1142400 $K_s_Beam1_1_23_4 $Alpha_s_Beam1_1_23_4 $Alpha_s_BeamComp1_1_23_4 $My_s_Beam1_1_23_4 -$My_s_BeamComp1_1_23_4  $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_4  $Theta_p_s_BeamComp1_1_23_4  $Theta_pc_s_Beam1_1_23_4  $Theta_pc_s_BeamComp1_1_23_4  $Res_s_Beam1_1_23_4  $Res_s_BeamComp1_1_23_4  $Theta_ult_s_Beam1_1_23_4  $Theta_ult_s_BeamComp1_1_23_4  1. 1.15;
element     zeroLength 1142400 11424 114204 -mat 1142400 -dir 6;
equalDOF                     11424 114204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1152;
# Panel Rigid Link;
element elasticBeamColumn 100115201 115205 015201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115208 015201 115212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115207 115211 115204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115206 115204 115210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115205 115209 015203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115204 015203 115208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115203 115207 115202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115202 115206 115202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115205 115206 1 2 3 4 5;
equalDOF 115212 115211 1 2 3 4 5;
equalDOF 115210 115209 1 2 3 4 5;
equalDOF 115207 115208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115200 $M1C_Panel1_1_5_2 $Gamma_1_Panel1_1_5_2 $M4C_Panel1_1_5_2 $Gamma_4_Panel1_1_5_2 $M6C_Panel1_1_5_2 $Gamma_6_Panel1_1_5_2 -$M1C_Panel1_1_5_2 -$Gamma_1_Panel1_1_5_2 -$M4C_Panel1_1_5_2 -$Gamma_4_Panel1_1_5_2 -$M6C_Panel1_1_5_2 -$Gamma_6_Panel1_1_5_2 0.25 0.75 0 0 0;
element zeroLength          100115200  115209 115210 -mat 100115200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1152200 $K_s_Beam1_1_12_5 $Alpha_s_BeamComp1_1_12_5 $Alpha_s_Beam1_1_12_5 $My_s_BeamComp1_1_12_5 -$My_s_Beam1_1_12_5  $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_5  $Theta_p_s_Beam1_1_12_5  $Theta_pc_s_BeamComp1_1_12_5  $Theta_pc_s_Beam1_1_12_5  $Res_s_BeamComp1_1_12_5  $Res_s_Beam1_1_12_5  $Theta_ult_s_BeamComp1_1_12_5  $Theta_ult_s_Beam1_1_12_5  1.15 1.;
element     zeroLength 1152200 11522 115202 -mat 1152200 -dir 6;
equalDOF                     11522 115202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1152400 $K_s_Beam1_1_23_5 $Alpha_s_Beam1_1_23_5 $Alpha_s_BeamComp1_1_23_5 $My_s_Beam1_1_23_5 -$My_s_BeamComp1_1_23_5  $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_5  $Theta_p_s_BeamComp1_1_23_5  $Theta_pc_s_Beam1_1_23_5  $Theta_pc_s_BeamComp1_1_23_5  $Res_s_Beam1_1_23_5  $Res_s_BeamComp1_1_23_5  $Theta_ult_s_Beam1_1_23_5  $Theta_ult_s_BeamComp1_1_23_5  1. 1.15;
element     zeroLength 1152400 11524 115204 -mat 1152400 -dir 6;
equalDOF                     11524 115204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1123;
# Panel Rigid Link;
element elasticBeamColumn 100112301 112305 012301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112308 012301 112312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112307 112311 112304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112306 112304 112310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112305 112309 012303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112304 012303 112308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112303 112307 112302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112302 112306 112302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112305 112306 1 2 3 4 5;
equalDOF 112312 112311 1 2 3 4 5;
equalDOF 112310 112309 1 2 3 4 5;
equalDOF 112307 112308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112300 $M1_Panel1_1_2_3 $Gamma_1_Panel1_1_2_3 $M4_Panel1_1_2_3 $Gamma_4_Panel1_1_2_3 $M6_Panel1_1_2_3 $Gamma_6_Panel1_1_2_3 -$M1C_Panel1_1_2_3 -$Gamma_1_Panel1_1_2_3 -$M4C_Panel1_1_2_3 -$Gamma_4_Panel1_1_2_3 -$M6C_Panel1_1_2_3 -$Gamma_6_Panel1_1_2_3 0.25 0.75 0 0 0;
element zeroLength          100112300  112309 112310 -mat 100112300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1123200 $K_s_Beam1_1_23_2 $Alpha_s_BeamComp1_1_23_2 $Alpha_s_Beam1_1_23_2 $My_s_BeamComp1_1_23_2 -$My_s_Beam1_1_23_2  $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_2  $Theta_p_s_Beam1_1_23_2  $Theta_pc_s_BeamComp1_1_23_2  $Theta_pc_s_Beam1_1_23_2  $Res_s_BeamComp1_1_23_2  $Res_s_Beam1_1_23_2  $Theta_ult_s_BeamComp1_1_23_2  $Theta_ult_s_Beam1_1_23_2  1.15 1.;
element     zeroLength 1123200 11232 112302 -mat 1123200 -dir 6;
equalDOF                     11232 112302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1133;
# Panel Rigid Link;
element elasticBeamColumn 100113301 113305 013301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113308 013301 113312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113307 113311 113304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113306 113304 113310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113305 113309 013303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113304 013303 113308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113303 113307 113302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113302 113306 113302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113305 113306 1 2 3 4 5;
equalDOF 113312 113311 1 2 3 4 5;
equalDOF 113310 113309 1 2 3 4 5;
equalDOF 113307 113308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113300 $M1_Panel1_1_3_3 $Gamma_1_Panel1_1_3_3 $M4_Panel1_1_3_3 $Gamma_4_Panel1_1_3_3 $M6_Panel1_1_3_3 $Gamma_6_Panel1_1_3_3 -$M1C_Panel1_1_3_3 -$Gamma_1_Panel1_1_3_3 -$M4C_Panel1_1_3_3 -$Gamma_4_Panel1_1_3_3 -$M6C_Panel1_1_3_3 -$Gamma_6_Panel1_1_3_3 0.25 0.75 0 0 0;
element zeroLength          100113300  113309 113310 -mat 100113300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1133200 $K_s_Beam1_1_23_3 $Alpha_s_BeamComp1_1_23_3 $Alpha_s_Beam1_1_23_3 $My_s_BeamComp1_1_23_3 -$My_s_Beam1_1_23_3  $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_3  $Theta_p_s_Beam1_1_23_3  $Theta_pc_s_BeamComp1_1_23_3  $Theta_pc_s_Beam1_1_23_3  $Res_s_BeamComp1_1_23_3  $Res_s_Beam1_1_23_3  $Theta_ult_s_BeamComp1_1_23_3  $Theta_ult_s_Beam1_1_23_3  1.15 1.;
element     zeroLength 1133200 11332 113302 -mat 1133200 -dir 6;
equalDOF                     11332 113302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1143;
# Panel Rigid Link;
element elasticBeamColumn 100114301 114305 014301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114308 014301 114312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114307 114311 114304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114306 114304 114310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114305 114309 014303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114304 014303 114308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114303 114307 114302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114302 114306 114302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114305 114306 1 2 3 4 5;
equalDOF 114312 114311 1 2 3 4 5;
equalDOF 114310 114309 1 2 3 4 5;
equalDOF 114307 114308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114300 $M1_Panel1_1_4_3 $Gamma_1_Panel1_1_4_3 $M4_Panel1_1_4_3 $Gamma_4_Panel1_1_4_3 $M6_Panel1_1_4_3 $Gamma_6_Panel1_1_4_3 -$M1C_Panel1_1_4_3 -$Gamma_1_Panel1_1_4_3 -$M4C_Panel1_1_4_3 -$Gamma_4_Panel1_1_4_3 -$M6C_Panel1_1_4_3 -$Gamma_6_Panel1_1_4_3 0.25 0.75 0 0 0;
element zeroLength          100114300  114309 114310 -mat 100114300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1143200 $K_s_Beam1_1_23_4 $Alpha_s_BeamComp1_1_23_4 $Alpha_s_Beam1_1_23_4 $My_s_BeamComp1_1_23_4 -$My_s_Beam1_1_23_4  $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_4  $Theta_p_s_Beam1_1_23_4  $Theta_pc_s_BeamComp1_1_23_4  $Theta_pc_s_Beam1_1_23_4  $Res_s_BeamComp1_1_23_4  $Res_s_Beam1_1_23_4  $Theta_ult_s_BeamComp1_1_23_4  $Theta_ult_s_Beam1_1_23_4  1.15 1.;
element     zeroLength 1143200 11432 114302 -mat 1143200 -dir 6;
equalDOF                     11432 114302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1153;
# Panel Rigid Link;
element elasticBeamColumn 100115301 115305 015301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115308 015301 115312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115307 115311 115304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115306 115304 115310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115305 115309 015303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115304 015303 115308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115303 115307 115302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115302 115306 115302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115305 115306 1 2 3 4 5;
equalDOF 115312 115311 1 2 3 4 5;
equalDOF 115310 115309 1 2 3 4 5;
equalDOF 115307 115308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115300 $M1_Panel1_1_5_3 $Gamma_1_Panel1_1_5_3 $M4_Panel1_1_5_3 $Gamma_4_Panel1_1_5_3 $M6_Panel1_1_5_3 $Gamma_6_Panel1_1_5_3 -$M1C_Panel1_1_5_3 -$Gamma_1_Panel1_1_5_3 -$M4C_Panel1_1_5_3 -$Gamma_4_Panel1_1_5_3 -$M6C_Panel1_1_5_3 -$Gamma_6_Panel1_1_5_3 0.25 0.75 0 0 0;
element zeroLength          100115300  115309 115310 -mat 100115300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1153200 $K_s_Beam1_1_23_5 $Alpha_s_BeamComp1_1_23_5 $Alpha_s_Beam1_1_23_5 $My_s_BeamComp1_1_23_5 -$My_s_Beam1_1_23_5  $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_5  $Theta_p_s_Beam1_1_23_5  $Theta_pc_s_BeamComp1_1_23_5  $Theta_pc_s_Beam1_1_23_5  $Res_s_BeamComp1_1_23_5  $Res_s_Beam1_1_23_5  $Theta_ult_s_BeamComp1_1_23_5  $Theta_ult_s_Beam1_1_23_5  1.15 1.;
element     zeroLength 1153200 11532 115302 -mat 1153200 -dir 6;
equalDOF                     11532 115302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1221;
# Panel Rigid Link;
element elasticBeamColumn 100122101 122105 022101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122108 022101 122112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122107 122111 122104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122106 122104 122110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122105 122109 022103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122104 022103 122108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122103 122107 122102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122102 122106 122102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 122105 122106 1 2 3 4 5;
equalDOF 122112 122111 1 2 3 4 5;
equalDOF 122110 122109 1 2 3 4 5;
equalDOF 122107 122108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100122100 $M1C_Panel1_2_2_1 $Gamma_1_Panel1_2_2_1 $M4C_Panel1_2_2_1 $Gamma_4_Panel1_2_2_1 $M6C_Panel1_2_2_1 $Gamma_6_Panel1_2_2_1 -$M1_Panel1_2_2_1 -$Gamma_1_Panel1_2_2_1 -$M4_Panel1_2_2_1 -$Gamma_4_Panel1_2_2_1 -$M6_Panel1_2_2_1 -$Gamma_6_Panel1_2_2_1 0.25 0.75 0 0 0;
element zeroLength          100122100  122109 122110 -mat 100122100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1221400 $K_s_Beam1_2_12_2 $Alpha_s_Beam1_2_12_2 $Alpha_s_BeamComp1_2_12_2 $My_s_Beam1_2_12_2 -$My_s_BeamComp1_2_12_2  $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 1. 1. 1. 1.  $Theta_p_s_Beam1_2_12_2  $Theta_p_s_BeamComp1_2_12_2  $Theta_pc_s_Beam1_2_12_2  $Theta_pc_s_BeamComp1_2_12_2  $Res_s_Beam1_2_12_2  $Res_s_BeamComp1_2_12_2  $Theta_ult_s_Beam1_2_12_2  $Theta_ult_s_BeamComp1_2_12_2  1. 1.15;
element     zeroLength 1221400 12214 122104 -mat 1221400 -dir 6;
equalDOF                     12214 122104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1231;
# Panel Rigid Link;
element elasticBeamColumn 100123101 123105 023101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123108 023101 123112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123107 123111 123104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123106 123104 123110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123105 123109 023103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123104 023103 123108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123103 123107 123102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123102 123106 123102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 123105 123106 1 2 3 4 5;
equalDOF 123112 123111 1 2 3 4 5;
equalDOF 123110 123109 1 2 3 4 5;
equalDOF 123107 123108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100123100 $M1C_Panel1_2_3_1 $Gamma_1_Panel1_2_3_1 $M4C_Panel1_2_3_1 $Gamma_4_Panel1_2_3_1 $M6C_Panel1_2_3_1 $Gamma_6_Panel1_2_3_1 -$M1_Panel1_2_3_1 -$Gamma_1_Panel1_2_3_1 -$M4_Panel1_2_3_1 -$Gamma_4_Panel1_2_3_1 -$M6_Panel1_2_3_1 -$Gamma_6_Panel1_2_3_1 0.25 0.75 0 0 0;
element zeroLength          100123100  123109 123110 -mat 100123100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1231400 $K_s_Beam1_2_12_3 $Alpha_s_Beam1_2_12_3 $Alpha_s_BeamComp1_2_12_3 $My_s_Beam1_2_12_3 -$My_s_BeamComp1_2_12_3  $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 1. 1. 1. 1.  $Theta_p_s_Beam1_2_12_3  $Theta_p_s_BeamComp1_2_12_3  $Theta_pc_s_Beam1_2_12_3  $Theta_pc_s_BeamComp1_2_12_3  $Res_s_Beam1_2_12_3  $Res_s_BeamComp1_2_12_3  $Theta_ult_s_Beam1_2_12_3  $Theta_ult_s_BeamComp1_2_12_3  1. 1.15;
element     zeroLength 1231400 12314 123104 -mat 1231400 -dir 6;
equalDOF                     12314 123104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1241;
# Panel Rigid Link;
element elasticBeamColumn 100124101 124105 024101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124108 024101 124112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124107 124111 124104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124106 124104 124110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124105 124109 024103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124104 024103 124108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124103 124107 124102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124102 124106 124102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 124105 124106 1 2 3 4 5;
equalDOF 124112 124111 1 2 3 4 5;
equalDOF 124110 124109 1 2 3 4 5;
equalDOF 124107 124108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100124100 $M1C_Panel1_2_4_1 $Gamma_1_Panel1_2_4_1 $M4C_Panel1_2_4_1 $Gamma_4_Panel1_2_4_1 $M6C_Panel1_2_4_1 $Gamma_6_Panel1_2_4_1 -$M1_Panel1_2_4_1 -$Gamma_1_Panel1_2_4_1 -$M4_Panel1_2_4_1 -$Gamma_4_Panel1_2_4_1 -$M6_Panel1_2_4_1 -$Gamma_6_Panel1_2_4_1 0.25 0.75 0 0 0;
element zeroLength          100124100  124109 124110 -mat 100124100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1241400 $K_s_Beam1_2_12_4 $Alpha_s_Beam1_2_12_4 $Alpha_s_BeamComp1_2_12_4 $My_s_Beam1_2_12_4 -$My_s_BeamComp1_2_12_4  $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 1. 1. 1. 1.  $Theta_p_s_Beam1_2_12_4  $Theta_p_s_BeamComp1_2_12_4  $Theta_pc_s_Beam1_2_12_4  $Theta_pc_s_BeamComp1_2_12_4  $Res_s_Beam1_2_12_4  $Res_s_BeamComp1_2_12_4  $Theta_ult_s_Beam1_2_12_4  $Theta_ult_s_BeamComp1_2_12_4  1. 1.15;
element     zeroLength 1241400 12414 124104 -mat 1241400 -dir 6;
equalDOF                     12414 124104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1251;
# Panel Rigid Link;
element elasticBeamColumn 100125101 125105 025101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125108 025101 125112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125107 125111 125104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125106 125104 125110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125105 125109 025103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125104 025103 125108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125103 125107 125102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125102 125106 125102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 125105 125106 1 2 3 4 5;
equalDOF 125112 125111 1 2 3 4 5;
equalDOF 125110 125109 1 2 3 4 5;
equalDOF 125107 125108 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100125100 $M1C_Panel1_2_5_1 $Gamma_1_Panel1_2_5_1 $M4C_Panel1_2_5_1 $Gamma_4_Panel1_2_5_1 $M6C_Panel1_2_5_1 $Gamma_6_Panel1_2_5_1 -$M1_Panel1_2_5_1 -$Gamma_1_Panel1_2_5_1 -$M4_Panel1_2_5_1 -$Gamma_4_Panel1_2_5_1 -$M6_Panel1_2_5_1 -$Gamma_6_Panel1_2_5_1 0.25 0.75 0 0 0;
element zeroLength          100125100  125109 125110 -mat 100125100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1251400 $K_s_Beam1_2_12_5 $Alpha_s_Beam1_2_12_5 $Alpha_s_BeamComp1_2_12_5 $My_s_Beam1_2_12_5 -$My_s_BeamComp1_2_12_5  $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 1. 1. 1. 1.  $Theta_p_s_Beam1_2_12_5  $Theta_p_s_BeamComp1_2_12_5  $Theta_pc_s_Beam1_2_12_5  $Theta_pc_s_BeamComp1_2_12_5  $Res_s_Beam1_2_12_5  $Res_s_BeamComp1_2_12_5  $Theta_ult_s_Beam1_2_12_5  $Theta_ult_s_BeamComp1_2_12_5  1. 1.15;
element     zeroLength 1251400 12514 125104 -mat 1251400 -dir 6;
equalDOF                     12514 125104 1 2 3 4 5;

# DirectionDepthFloorAxis = 1222;
# Panel Rigid Link;
element elasticBeamColumn 100122201 122205 022201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122208 022201 122212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122207 122211 122204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122206 122204 122210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122205 122209 022203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122204 022203 122208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122203 122207 122202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122202 122206 122202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 122205 122206 1 2 3 4 5;
equalDOF 122212 122211 1 2 3 4 5;
equalDOF 122210 122209 1 2 3 4 5;
equalDOF 122207 122208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100122200 $M1C_Panel1_2_2_2 $Gamma_1_Panel1_2_2_2 $M4C_Panel1_2_2_2 $Gamma_4_Panel1_2_2_2 $M6C_Panel1_2_2_2 $Gamma_6_Panel1_2_2_2 -$M1C_Panel1_2_2_2 -$Gamma_1_Panel1_2_2_2 -$M4C_Panel1_2_2_2 -$Gamma_4_Panel1_2_2_2 -$M6C_Panel1_2_2_2 -$Gamma_6_Panel1_2_2_2 0.25 0.75 0 0 0;
element zeroLength          100122200  122209 122210 -mat 100122200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1222200 $K_s_Beam1_2_12_2 $Alpha_s_BeamComp1_2_12_2 $Alpha_s_Beam1_2_12_2 $My_s_BeamComp1_2_12_2 -$My_s_Beam1_2_12_2  $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 $Lambda_Beam1_2_12_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_12_2  $Theta_p_s_Beam1_2_12_2  $Theta_pc_s_BeamComp1_2_12_2  $Theta_pc_s_Beam1_2_12_2  $Res_s_BeamComp1_2_12_2  $Res_s_Beam1_2_12_2  $Theta_ult_s_BeamComp1_2_12_2  $Theta_ult_s_Beam1_2_12_2  1.15 1.;
element     zeroLength 1222200 12222 122202 -mat 1222200 -dir 6;
equalDOF                     12222 122202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1222400 $K_s_Beam1_2_23_2 $Alpha_s_Beam1_2_23_2 $Alpha_s_BeamComp1_2_23_2 $My_s_Beam1_2_23_2 -$My_s_BeamComp1_2_23_2  $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 1. 1. 1. 1.  $Theta_p_s_Beam1_2_23_2  $Theta_p_s_BeamComp1_2_23_2  $Theta_pc_s_Beam1_2_23_2  $Theta_pc_s_BeamComp1_2_23_2  $Res_s_Beam1_2_23_2  $Res_s_BeamComp1_2_23_2  $Theta_ult_s_Beam1_2_23_2  $Theta_ult_s_BeamComp1_2_23_2  1. 1.15;
element     zeroLength 1222400 12224 122204 -mat 1222400 -dir 6;
equalDOF                     12224 122204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1232;
# Panel Rigid Link;
element elasticBeamColumn 100123201 123205 023201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123208 023201 123212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123207 123211 123204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123206 123204 123210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123205 123209 023203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123204 023203 123208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123203 123207 123202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123202 123206 123202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 123205 123206 1 2 3 4 5;
equalDOF 123212 123211 1 2 3 4 5;
equalDOF 123210 123209 1 2 3 4 5;
equalDOF 123207 123208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100123200 $M1C_Panel1_2_3_2 $Gamma_1_Panel1_2_3_2 $M4C_Panel1_2_3_2 $Gamma_4_Panel1_2_3_2 $M6C_Panel1_2_3_2 $Gamma_6_Panel1_2_3_2 -$M1C_Panel1_2_3_2 -$Gamma_1_Panel1_2_3_2 -$M4C_Panel1_2_3_2 -$Gamma_4_Panel1_2_3_2 -$M6C_Panel1_2_3_2 -$Gamma_6_Panel1_2_3_2 0.25 0.75 0 0 0;
element zeroLength          100123200  123209 123210 -mat 100123200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1232200 $K_s_Beam1_2_12_3 $Alpha_s_BeamComp1_2_12_3 $Alpha_s_Beam1_2_12_3 $My_s_BeamComp1_2_12_3 -$My_s_Beam1_2_12_3  $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 $Lambda_Beam1_2_12_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_12_3  $Theta_p_s_Beam1_2_12_3  $Theta_pc_s_BeamComp1_2_12_3  $Theta_pc_s_Beam1_2_12_3  $Res_s_BeamComp1_2_12_3  $Res_s_Beam1_2_12_3  $Theta_ult_s_BeamComp1_2_12_3  $Theta_ult_s_Beam1_2_12_3  1.15 1.;
element     zeroLength 1232200 12322 123202 -mat 1232200 -dir 6;
equalDOF                     12322 123202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1232400 $K_s_Beam1_2_23_3 $Alpha_s_Beam1_2_23_3 $Alpha_s_BeamComp1_2_23_3 $My_s_Beam1_2_23_3 -$My_s_BeamComp1_2_23_3  $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 1. 1. 1. 1.  $Theta_p_s_Beam1_2_23_3  $Theta_p_s_BeamComp1_2_23_3  $Theta_pc_s_Beam1_2_23_3  $Theta_pc_s_BeamComp1_2_23_3  $Res_s_Beam1_2_23_3  $Res_s_BeamComp1_2_23_3  $Theta_ult_s_Beam1_2_23_3  $Theta_ult_s_BeamComp1_2_23_3  1. 1.15;
element     zeroLength 1232400 12324 123204 -mat 1232400 -dir 6;
equalDOF                     12324 123204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1242;
# Panel Rigid Link;
element elasticBeamColumn 100124201 124205 024201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124208 024201 124212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124207 124211 124204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124206 124204 124210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124205 124209 024203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124204 024203 124208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124203 124207 124202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124202 124206 124202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 124205 124206 1 2 3 4 5;
equalDOF 124212 124211 1 2 3 4 5;
equalDOF 124210 124209 1 2 3 4 5;
equalDOF 124207 124208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100124200 $M1C_Panel1_2_4_2 $Gamma_1_Panel1_2_4_2 $M4C_Panel1_2_4_2 $Gamma_4_Panel1_2_4_2 $M6C_Panel1_2_4_2 $Gamma_6_Panel1_2_4_2 -$M1C_Panel1_2_4_2 -$Gamma_1_Panel1_2_4_2 -$M4C_Panel1_2_4_2 -$Gamma_4_Panel1_2_4_2 -$M6C_Panel1_2_4_2 -$Gamma_6_Panel1_2_4_2 0.25 0.75 0 0 0;
element zeroLength          100124200  124209 124210 -mat 100124200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1242200 $K_s_Beam1_2_12_4 $Alpha_s_BeamComp1_2_12_4 $Alpha_s_Beam1_2_12_4 $My_s_BeamComp1_2_12_4 -$My_s_Beam1_2_12_4  $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 $Lambda_Beam1_2_12_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_12_4  $Theta_p_s_Beam1_2_12_4  $Theta_pc_s_BeamComp1_2_12_4  $Theta_pc_s_Beam1_2_12_4  $Res_s_BeamComp1_2_12_4  $Res_s_Beam1_2_12_4  $Theta_ult_s_BeamComp1_2_12_4  $Theta_ult_s_Beam1_2_12_4  1.15 1.;
element     zeroLength 1242200 12422 124202 -mat 1242200 -dir 6;
equalDOF                     12422 124202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1242400 $K_s_Beam1_2_23_4 $Alpha_s_Beam1_2_23_4 $Alpha_s_BeamComp1_2_23_4 $My_s_Beam1_2_23_4 -$My_s_BeamComp1_2_23_4  $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 1. 1. 1. 1.  $Theta_p_s_Beam1_2_23_4  $Theta_p_s_BeamComp1_2_23_4  $Theta_pc_s_Beam1_2_23_4  $Theta_pc_s_BeamComp1_2_23_4  $Res_s_Beam1_2_23_4  $Res_s_BeamComp1_2_23_4  $Theta_ult_s_Beam1_2_23_4  $Theta_ult_s_BeamComp1_2_23_4  1. 1.15;
element     zeroLength 1242400 12424 124204 -mat 1242400 -dir 6;
equalDOF                     12424 124204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1252;
# Panel Rigid Link;
element elasticBeamColumn 100125201 125205 025201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125208 025201 125212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125207 125211 125204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125206 125204 125210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125205 125209 025203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125204 025203 125208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125203 125207 125202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125202 125206 125202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 125205 125206 1 2 3 4 5;
equalDOF 125212 125211 1 2 3 4 5;
equalDOF 125210 125209 1 2 3 4 5;
equalDOF 125207 125208 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100125200 $M1C_Panel1_2_5_2 $Gamma_1_Panel1_2_5_2 $M4C_Panel1_2_5_2 $Gamma_4_Panel1_2_5_2 $M6C_Panel1_2_5_2 $Gamma_6_Panel1_2_5_2 -$M1C_Panel1_2_5_2 -$Gamma_1_Panel1_2_5_2 -$M4C_Panel1_2_5_2 -$Gamma_4_Panel1_2_5_2 -$M6C_Panel1_2_5_2 -$Gamma_6_Panel1_2_5_2 0.25 0.75 0 0 0;
element zeroLength          100125200  125209 125210 -mat 100125200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1252200 $K_s_Beam1_2_12_5 $Alpha_s_BeamComp1_2_12_5 $Alpha_s_Beam1_2_12_5 $My_s_BeamComp1_2_12_5 -$My_s_Beam1_2_12_5  $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 $Lambda_Beam1_2_12_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_12_5  $Theta_p_s_Beam1_2_12_5  $Theta_pc_s_BeamComp1_2_12_5  $Theta_pc_s_Beam1_2_12_5  $Res_s_BeamComp1_2_12_5  $Res_s_Beam1_2_12_5  $Theta_ult_s_BeamComp1_2_12_5  $Theta_ult_s_Beam1_2_12_5  1.15 1.;
element     zeroLength 1252200 12522 125202 -mat 1252200 -dir 6;
equalDOF                     12522 125202 1 2 3 4 5;
# Right WUF-W;
uniaxialMaterial Bilin 1252400 $K_s_Beam1_2_23_5 $Alpha_s_Beam1_2_23_5 $Alpha_s_BeamComp1_2_23_5 $My_s_Beam1_2_23_5 -$My_s_BeamComp1_2_23_5  $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 1. 1. 1. 1.  $Theta_p_s_Beam1_2_23_5  $Theta_p_s_BeamComp1_2_23_5  $Theta_pc_s_Beam1_2_23_5  $Theta_pc_s_BeamComp1_2_23_5  $Res_s_Beam1_2_23_5  $Res_s_BeamComp1_2_23_5  $Theta_ult_s_Beam1_2_23_5  $Theta_ult_s_BeamComp1_2_23_5  1. 1.15;
element     zeroLength 1252400 12524 125204 -mat 1252400 -dir 6;
equalDOF                     12524 125204 1 2 3 4 5;

# DirectionDepthFloorAxis = 1223;
# Panel Rigid Link;
element elasticBeamColumn 100122301 122305 022301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122308 022301 122312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122307 122311 122304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122306 122304 122310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122305 122309 022303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122304 022303 122308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122303 122307 122302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100122302 122306 122302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 122305 122306 1 2 3 4 5;
equalDOF 122312 122311 1 2 3 4 5;
equalDOF 122310 122309 1 2 3 4 5;
equalDOF 122307 122308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100122300 $M1_Panel1_2_2_3 $Gamma_1_Panel1_2_2_3 $M4_Panel1_2_2_3 $Gamma_4_Panel1_2_2_3 $M6_Panel1_2_2_3 $Gamma_6_Panel1_2_2_3 -$M1C_Panel1_2_2_3 -$Gamma_1_Panel1_2_2_3 -$M4C_Panel1_2_2_3 -$Gamma_4_Panel1_2_2_3 -$M6C_Panel1_2_2_3 -$Gamma_6_Panel1_2_2_3 0.25 0.75 0 0 0;
element zeroLength          100122300  122309 122310 -mat 100122300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1223200 $K_s_Beam1_2_23_2 $Alpha_s_BeamComp1_2_23_2 $Alpha_s_Beam1_2_23_2 $My_s_BeamComp1_2_23_2 -$My_s_Beam1_2_23_2  $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 $Lambda_Beam1_2_23_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_23_2  $Theta_p_s_Beam1_2_23_2  $Theta_pc_s_BeamComp1_2_23_2  $Theta_pc_s_Beam1_2_23_2  $Res_s_BeamComp1_2_23_2  $Res_s_Beam1_2_23_2  $Theta_ult_s_BeamComp1_2_23_2  $Theta_ult_s_Beam1_2_23_2  1.15 1.;
element     zeroLength 1223200 12232 122302 -mat 1223200 -dir 6;
equalDOF                     12232 122302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1233;
# Panel Rigid Link;
element elasticBeamColumn 100123301 123305 023301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123308 023301 123312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123307 123311 123304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123306 123304 123310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123305 123309 023303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123304 023303 123308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123303 123307 123302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100123302 123306 123302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 123305 123306 1 2 3 4 5;
equalDOF 123312 123311 1 2 3 4 5;
equalDOF 123310 123309 1 2 3 4 5;
equalDOF 123307 123308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100123300 $M1_Panel1_2_3_3 $Gamma_1_Panel1_2_3_3 $M4_Panel1_2_3_3 $Gamma_4_Panel1_2_3_3 $M6_Panel1_2_3_3 $Gamma_6_Panel1_2_3_3 -$M1C_Panel1_2_3_3 -$Gamma_1_Panel1_2_3_3 -$M4C_Panel1_2_3_3 -$Gamma_4_Panel1_2_3_3 -$M6C_Panel1_2_3_3 -$Gamma_6_Panel1_2_3_3 0.25 0.75 0 0 0;
element zeroLength          100123300  123309 123310 -mat 100123300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1233200 $K_s_Beam1_2_23_3 $Alpha_s_BeamComp1_2_23_3 $Alpha_s_Beam1_2_23_3 $My_s_BeamComp1_2_23_3 -$My_s_Beam1_2_23_3  $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 $Lambda_Beam1_2_23_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_23_3  $Theta_p_s_Beam1_2_23_3  $Theta_pc_s_BeamComp1_2_23_3  $Theta_pc_s_Beam1_2_23_3  $Res_s_BeamComp1_2_23_3  $Res_s_Beam1_2_23_3  $Theta_ult_s_BeamComp1_2_23_3  $Theta_ult_s_Beam1_2_23_3  1.15 1.;
element     zeroLength 1233200 12332 123302 -mat 1233200 -dir 6;
equalDOF                     12332 123302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1243;
# Panel Rigid Link;
element elasticBeamColumn 100124301 124305 024301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124308 024301 124312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124307 124311 124304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124306 124304 124310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124305 124309 024303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124304 024303 124308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124303 124307 124302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100124302 124306 124302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 124305 124306 1 2 3 4 5;
equalDOF 124312 124311 1 2 3 4 5;
equalDOF 124310 124309 1 2 3 4 5;
equalDOF 124307 124308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100124300 $M1_Panel1_2_4_3 $Gamma_1_Panel1_2_4_3 $M4_Panel1_2_4_3 $Gamma_4_Panel1_2_4_3 $M6_Panel1_2_4_3 $Gamma_6_Panel1_2_4_3 -$M1C_Panel1_2_4_3 -$Gamma_1_Panel1_2_4_3 -$M4C_Panel1_2_4_3 -$Gamma_4_Panel1_2_4_3 -$M6C_Panel1_2_4_3 -$Gamma_6_Panel1_2_4_3 0.25 0.75 0 0 0;
element zeroLength          100124300  124309 124310 -mat 100124300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1243200 $K_s_Beam1_2_23_4 $Alpha_s_BeamComp1_2_23_4 $Alpha_s_Beam1_2_23_4 $My_s_BeamComp1_2_23_4 -$My_s_Beam1_2_23_4  $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 $Lambda_Beam1_2_23_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_23_4  $Theta_p_s_Beam1_2_23_4  $Theta_pc_s_BeamComp1_2_23_4  $Theta_pc_s_Beam1_2_23_4  $Res_s_BeamComp1_2_23_4  $Res_s_Beam1_2_23_4  $Theta_ult_s_BeamComp1_2_23_4  $Theta_ult_s_Beam1_2_23_4  1.15 1.;
element     zeroLength 1243200 12432 124302 -mat 1243200 -dir 6;
equalDOF                     12432 124302 1 2 3 4 5;

# DirectionDepthFloorAxis = 1253;
# Panel Rigid Link;
element elasticBeamColumn 100125301 125305 025301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125308 025301 125312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125307 125311 125304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125306 125304 125310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125305 125309 025303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125304 025303 125308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125303 125307 125302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100125302 125306 125302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamXDirTransfTag;
equalDOF 125305 125306 1 2 3 4 5;
equalDOF 125312 125311 1 2 3 4 5;
equalDOF 125310 125309 1 2 3 4 5;
equalDOF 125307 125308 1 2 3 4 5;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100125300 $M1_Panel1_2_5_3 $Gamma_1_Panel1_2_5_3 $M4_Panel1_2_5_3 $Gamma_4_Panel1_2_5_3 $M6_Panel1_2_5_3 $Gamma_6_Panel1_2_5_3 -$M1C_Panel1_2_5_3 -$Gamma_1_Panel1_2_5_3 -$M4C_Panel1_2_5_3 -$Gamma_4_Panel1_2_5_3 -$M6C_Panel1_2_5_3 -$Gamma_6_Panel1_2_5_3 0.25 0.75 0 0 0;
element zeroLength          100125300  125309 125310 -mat 100125300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1253200 $K_s_Beam1_2_23_5 $Alpha_s_BeamComp1_2_23_5 $Alpha_s_Beam1_2_23_5 $My_s_BeamComp1_2_23_5 -$My_s_Beam1_2_23_5  $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 $Lambda_Beam1_2_23_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_2_23_5  $Theta_p_s_Beam1_2_23_5  $Theta_pc_s_BeamComp1_2_23_5  $Theta_pc_s_Beam1_2_23_5  $Res_s_BeamComp1_2_23_5  $Res_s_Beam1_2_23_5  $Theta_ult_s_BeamComp1_2_23_5  $Theta_ult_s_Beam1_2_23_5  1.15 1.;
element     zeroLength 1253200 12532 125302 -mat 1253200 -dir 6;
equalDOF                     12532 125302 1 2 3 4 5;

# Spring Elements in Z direction;
# DirectionDepthFloorAxis = 2121;
# Panel Rigid Link;
element elasticBeamColumn 100212101 212105 012101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212108 012101 212112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212107 212111 212104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212106 212104 212110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212105 212109 012103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212104 012103 212108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212103 212107 212102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212102 212106 212102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 212105 212106 1 2 3 5 6;
equalDOF 212112 212111 1 2 3 5 6;
equalDOF 212110 212109 1 2 3 5 6;
equalDOF 212107 212108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100212100 $M1_Panel2_1_2_1 $Gamma_1_Panel2_1_2_1 $M4_Panel2_1_2_1 $Gamma_4_Panel2_1_2_1 $M6_Panel2_1_2_1 $Gamma_6_Panel2_1_2_1 -$M1C_Panel2_1_2_1 -$Gamma_1_Panel2_1_2_1 -$M4C_Panel2_1_2_1 -$Gamma_4_Panel2_1_2_1 -$M6C_Panel2_1_2_1 -$Gamma_6_Panel2_1_2_1 0.25 0.75 0 0 0;
element zeroLength          100212100  212109 212110 -mat 100212100 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2121400 $K_s_Beam2_12_1_2 $Alpha_s_BeamComp2_12_1_2 $Alpha_s_Beam2_12_1_2 $My_s_BeamComp2_12_1_2 -$My_s_Beam2_12_1_2  $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_1_2  $Theta_p_s_Beam2_12_1_2  $Theta_pc_s_BeamComp2_12_1_2  $Theta_pc_s_Beam2_12_1_2  $Res_s_BeamComp2_12_1_2  $Res_s_Beam2_12_1_2  $Theta_ult_s_BeamComp2_12_1_2  $Theta_ult_s_Beam2_12_1_2  1.15 1.;
element     zeroLength 2121400 21214 212104 -mat 2121400 -dir 4;
equalDOF                     21214 212104 1 2 3 5 6;

# DirectionDepthFloorAxis = 2131;
# Panel Rigid Link;
element elasticBeamColumn 100213101 213105 013101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213108 013101 213112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213107 213111 213104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213106 213104 213110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213105 213109 013103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213104 013103 213108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213103 213107 213102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213102 213106 213102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 213105 213106 1 2 3 5 6;
equalDOF 213112 213111 1 2 3 5 6;
equalDOF 213110 213109 1 2 3 5 6;
equalDOF 213107 213108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100213100 $M1_Panel2_1_3_1 $Gamma_1_Panel2_1_3_1 $M4_Panel2_1_3_1 $Gamma_4_Panel2_1_3_1 $M6_Panel2_1_3_1 $Gamma_6_Panel2_1_3_1 -$M1C_Panel2_1_3_1 -$Gamma_1_Panel2_1_3_1 -$M4C_Panel2_1_3_1 -$Gamma_4_Panel2_1_3_1 -$M6C_Panel2_1_3_1 -$Gamma_6_Panel2_1_3_1 0.25 0.75 0 0 0;
element zeroLength          100213100  213109 213110 -mat 100213100 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2131400 $K_s_Beam2_12_1_3 $Alpha_s_BeamComp2_12_1_3 $Alpha_s_Beam2_12_1_3 $My_s_BeamComp2_12_1_3 -$My_s_Beam2_12_1_3  $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_1_3  $Theta_p_s_Beam2_12_1_3  $Theta_pc_s_BeamComp2_12_1_3  $Theta_pc_s_Beam2_12_1_3  $Res_s_BeamComp2_12_1_3  $Res_s_Beam2_12_1_3  $Theta_ult_s_BeamComp2_12_1_3  $Theta_ult_s_Beam2_12_1_3  1.15 1.;
element     zeroLength 2131400 21314 213104 -mat 2131400 -dir 4;
equalDOF                     21314 213104 1 2 3 5 6;

# DirectionDepthFloorAxis = 2141;
# Panel Rigid Link;
element elasticBeamColumn 100214101 214105 014101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214108 014101 214112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214107 214111 214104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214106 214104 214110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214105 214109 014103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214104 014103 214108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214103 214107 214102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214102 214106 214102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 214105 214106 1 2 3 5 6;
equalDOF 214112 214111 1 2 3 5 6;
equalDOF 214110 214109 1 2 3 5 6;
equalDOF 214107 214108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100214100 $M1_Panel2_1_4_1 $Gamma_1_Panel2_1_4_1 $M4_Panel2_1_4_1 $Gamma_4_Panel2_1_4_1 $M6_Panel2_1_4_1 $Gamma_6_Panel2_1_4_1 -$M1C_Panel2_1_4_1 -$Gamma_1_Panel2_1_4_1 -$M4C_Panel2_1_4_1 -$Gamma_4_Panel2_1_4_1 -$M6C_Panel2_1_4_1 -$Gamma_6_Panel2_1_4_1 0.25 0.75 0 0 0;
element zeroLength          100214100  214109 214110 -mat 100214100 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2141400 $K_s_Beam2_12_1_4 $Alpha_s_BeamComp2_12_1_4 $Alpha_s_Beam2_12_1_4 $My_s_BeamComp2_12_1_4 -$My_s_Beam2_12_1_4  $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_1_4  $Theta_p_s_Beam2_12_1_4  $Theta_pc_s_BeamComp2_12_1_4  $Theta_pc_s_Beam2_12_1_4  $Res_s_BeamComp2_12_1_4  $Res_s_Beam2_12_1_4  $Theta_ult_s_BeamComp2_12_1_4  $Theta_ult_s_Beam2_12_1_4  1.15 1.;
element     zeroLength 2141400 21414 214104 -mat 2141400 -dir 4;
equalDOF                     21414 214104 1 2 3 5 6;

# DirectionDepthFloorAxis = 2151;
# Panel Rigid Link;
element elasticBeamColumn 100215101 215105 015101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215108 015101 215112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215107 215111 215104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215106 215104 215110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215105 215109 015103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215104 015103 215108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215103 215107 215102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215102 215106 215102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 215105 215106 1 2 3 5 6;
equalDOF 215112 215111 1 2 3 5 6;
equalDOF 215110 215109 1 2 3 5 6;
equalDOF 215107 215108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100215100 $M1_Panel2_1_5_1 $Gamma_1_Panel2_1_5_1 $M4_Panel2_1_5_1 $Gamma_4_Panel2_1_5_1 $M6_Panel2_1_5_1 $Gamma_6_Panel2_1_5_1 -$M1C_Panel2_1_5_1 -$Gamma_1_Panel2_1_5_1 -$M4C_Panel2_1_5_1 -$Gamma_4_Panel2_1_5_1 -$M6C_Panel2_1_5_1 -$Gamma_6_Panel2_1_5_1 0.25 0.75 0 0 0;
element zeroLength          100215100  215109 215110 -mat 100215100 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2151400 $K_s_Beam2_12_1_5 $Alpha_s_BeamComp2_12_1_5 $Alpha_s_Beam2_12_1_5 $My_s_BeamComp2_12_1_5 -$My_s_Beam2_12_1_5  $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_1_5  $Theta_p_s_Beam2_12_1_5  $Theta_pc_s_BeamComp2_12_1_5  $Theta_pc_s_Beam2_12_1_5  $Res_s_BeamComp2_12_1_5  $Res_s_Beam2_12_1_5  $Theta_ult_s_BeamComp2_12_1_5  $Theta_ult_s_Beam2_12_1_5  1.15 1.;
element     zeroLength 2151400 21514 215104 -mat 2151400 -dir 4;
equalDOF                     21514 215104 1 2 3 5 6;

# DirectionDepthFloorAxis = 2122;
# Panel Rigid Link;
element elasticBeamColumn 100212201 212205 012201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212208 012201 212212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212207 212211 212204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212206 212204 212210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212205 212209 012203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212204 012203 212208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212203 212207 212202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212202 212206 212202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 212205 212206 1 2 3 5 6;
equalDOF 212212 212211 1 2 3 5 6;
equalDOF 212210 212209 1 2 3 5 6;
equalDOF 212207 212208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100212200 $M1_Panel2_1_2_2 $Gamma_1_Panel2_1_2_2 $M4_Panel2_1_2_2 $Gamma_4_Panel2_1_2_2 $M6_Panel2_1_2_2 $Gamma_6_Panel2_1_2_2 -$M1C_Panel2_1_2_2 -$Gamma_1_Panel2_1_2_2 -$M4C_Panel2_1_2_2 -$Gamma_4_Panel2_1_2_2 -$M6C_Panel2_1_2_2 -$Gamma_6_Panel2_1_2_2 0.25 0.75 0 0 0;
element zeroLength          100212200  212209 212210 -mat 100212200 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2122400 $K_s_Beam2_12_2_2 $Alpha_s_BeamComp2_12_2_2 $Alpha_s_Beam2_12_2_2 $My_s_BeamComp2_12_2_2 -$My_s_Beam2_12_2_2  $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_2_2  $Theta_p_s_Beam2_12_2_2  $Theta_pc_s_BeamComp2_12_2_2  $Theta_pc_s_Beam2_12_2_2  $Res_s_BeamComp2_12_2_2  $Res_s_Beam2_12_2_2  $Theta_ult_s_BeamComp2_12_2_2  $Theta_ult_s_Beam2_12_2_2  1.15 1.;
element     zeroLength 2122400 21224 212204 -mat 2122400 -dir 4;
equalDOF                     21224 212204 1 2 3 5 6;

# DirectionDepthFloorAxis = 2132;
# Panel Rigid Link;
element elasticBeamColumn 100213201 213205 013201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213208 013201 213212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213207 213211 213204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213206 213204 213210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213205 213209 013203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213204 013203 213208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213203 213207 213202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213202 213206 213202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 213205 213206 1 2 3 5 6;
equalDOF 213212 213211 1 2 3 5 6;
equalDOF 213210 213209 1 2 3 5 6;
equalDOF 213207 213208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100213200 $M1_Panel2_1_3_2 $Gamma_1_Panel2_1_3_2 $M4_Panel2_1_3_2 $Gamma_4_Panel2_1_3_2 $M6_Panel2_1_3_2 $Gamma_6_Panel2_1_3_2 -$M1C_Panel2_1_3_2 -$Gamma_1_Panel2_1_3_2 -$M4C_Panel2_1_3_2 -$Gamma_4_Panel2_1_3_2 -$M6C_Panel2_1_3_2 -$Gamma_6_Panel2_1_3_2 0.25 0.75 0 0 0;
element zeroLength          100213200  213209 213210 -mat 100213200 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2132400 $K_s_Beam2_12_2_3 $Alpha_s_BeamComp2_12_2_3 $Alpha_s_Beam2_12_2_3 $My_s_BeamComp2_12_2_3 -$My_s_Beam2_12_2_3  $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_2_3  $Theta_p_s_Beam2_12_2_3  $Theta_pc_s_BeamComp2_12_2_3  $Theta_pc_s_Beam2_12_2_3  $Res_s_BeamComp2_12_2_3  $Res_s_Beam2_12_2_3  $Theta_ult_s_BeamComp2_12_2_3  $Theta_ult_s_Beam2_12_2_3  1.15 1.;
element     zeroLength 2132400 21324 213204 -mat 2132400 -dir 4;
equalDOF                     21324 213204 1 2 3 5 6;

# DirectionDepthFloorAxis = 2142;
# Panel Rigid Link;
element elasticBeamColumn 100214201 214205 014201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214208 014201 214212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214207 214211 214204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214206 214204 214210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214205 214209 014203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214204 014203 214208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214203 214207 214202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214202 214206 214202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 214205 214206 1 2 3 5 6;
equalDOF 214212 214211 1 2 3 5 6;
equalDOF 214210 214209 1 2 3 5 6;
equalDOF 214207 214208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100214200 $M1_Panel2_1_4_2 $Gamma_1_Panel2_1_4_2 $M4_Panel2_1_4_2 $Gamma_4_Panel2_1_4_2 $M6_Panel2_1_4_2 $Gamma_6_Panel2_1_4_2 -$M1C_Panel2_1_4_2 -$Gamma_1_Panel2_1_4_2 -$M4C_Panel2_1_4_2 -$Gamma_4_Panel2_1_4_2 -$M6C_Panel2_1_4_2 -$Gamma_6_Panel2_1_4_2 0.25 0.75 0 0 0;
element zeroLength          100214200  214209 214210 -mat 100214200 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2142400 $K_s_Beam2_12_2_4 $Alpha_s_BeamComp2_12_2_4 $Alpha_s_Beam2_12_2_4 $My_s_BeamComp2_12_2_4 -$My_s_Beam2_12_2_4  $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_2_4  $Theta_p_s_Beam2_12_2_4  $Theta_pc_s_BeamComp2_12_2_4  $Theta_pc_s_Beam2_12_2_4  $Res_s_BeamComp2_12_2_4  $Res_s_Beam2_12_2_4  $Theta_ult_s_BeamComp2_12_2_4  $Theta_ult_s_Beam2_12_2_4  1.15 1.;
element     zeroLength 2142400 21424 214204 -mat 2142400 -dir 4;
equalDOF                     21424 214204 1 2 3 5 6;

# DirectionDepthFloorAxis = 2152;
# Panel Rigid Link;
element elasticBeamColumn 100215201 215205 015201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215208 015201 215212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215207 215211 215204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215206 215204 215210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215205 215209 015203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215204 015203 215208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215203 215207 215202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215202 215206 215202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 215205 215206 1 2 3 5 6;
equalDOF 215212 215211 1 2 3 5 6;
equalDOF 215210 215209 1 2 3 5 6;
equalDOF 215207 215208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100215200 $M1_Panel2_1_5_2 $Gamma_1_Panel2_1_5_2 $M4_Panel2_1_5_2 $Gamma_4_Panel2_1_5_2 $M6_Panel2_1_5_2 $Gamma_6_Panel2_1_5_2 -$M1C_Panel2_1_5_2 -$Gamma_1_Panel2_1_5_2 -$M4C_Panel2_1_5_2 -$Gamma_4_Panel2_1_5_2 -$M6C_Panel2_1_5_2 -$Gamma_6_Panel2_1_5_2 0.25 0.75 0 0 0;
element zeroLength          100215200  215209 215210 -mat 100215200 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2152400 $K_s_Beam2_12_2_5 $Alpha_s_BeamComp2_12_2_5 $Alpha_s_Beam2_12_2_5 $My_s_BeamComp2_12_2_5 -$My_s_Beam2_12_2_5  $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_2_5  $Theta_p_s_Beam2_12_2_5  $Theta_pc_s_BeamComp2_12_2_5  $Theta_pc_s_Beam2_12_2_5  $Res_s_BeamComp2_12_2_5  $Res_s_Beam2_12_2_5  $Theta_ult_s_BeamComp2_12_2_5  $Theta_ult_s_Beam2_12_2_5  1.15 1.;
element     zeroLength 2152400 21524 215204 -mat 2152400 -dir 4;
equalDOF                     21524 215204 1 2 3 5 6;

# DirectionDepthFloorAxis = 2123;
# Panel Rigid Link;
element elasticBeamColumn 100212301 212305 012301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212308 012301 212312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212307 212311 212304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212306 212304 212310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212305 212309 012303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212304 012303 212308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212303 212307 212302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100212302 212306 212302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 212305 212306 1 2 3 5 6;
equalDOF 212312 212311 1 2 3 5 6;
equalDOF 212310 212309 1 2 3 5 6;
equalDOF 212307 212308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100212300 $M1_Panel2_1_2_3 $Gamma_1_Panel2_1_2_3 $M4_Panel2_1_2_3 $Gamma_4_Panel2_1_2_3 $M6_Panel2_1_2_3 $Gamma_6_Panel2_1_2_3 -$M1C_Panel2_1_2_3 -$Gamma_1_Panel2_1_2_3 -$M4C_Panel2_1_2_3 -$Gamma_4_Panel2_1_2_3 -$M6C_Panel2_1_2_3 -$Gamma_6_Panel2_1_2_3 0.25 0.75 0 0 0;
element zeroLength          100212300  212309 212310 -mat 100212300 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2123400 $K_s_Beam2_12_3_2 $Alpha_s_BeamComp2_12_3_2 $Alpha_s_Beam2_12_3_2 $My_s_BeamComp2_12_3_2 -$My_s_Beam2_12_3_2  $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_3_2  $Theta_p_s_Beam2_12_3_2  $Theta_pc_s_BeamComp2_12_3_2  $Theta_pc_s_Beam2_12_3_2  $Res_s_BeamComp2_12_3_2  $Res_s_Beam2_12_3_2  $Theta_ult_s_BeamComp2_12_3_2  $Theta_ult_s_Beam2_12_3_2  1.15 1.;
element     zeroLength 2123400 21234 212304 -mat 2123400 -dir 4;
equalDOF                     21234 212304 1 2 3 5 6;

# DirectionDepthFloorAxis = 2133;
# Panel Rigid Link;
element elasticBeamColumn 100213301 213305 013301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213308 013301 213312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213307 213311 213304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213306 213304 213310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213305 213309 013303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213304 013303 213308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213303 213307 213302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100213302 213306 213302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 213305 213306 1 2 3 5 6;
equalDOF 213312 213311 1 2 3 5 6;
equalDOF 213310 213309 1 2 3 5 6;
equalDOF 213307 213308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100213300 $M1_Panel2_1_3_3 $Gamma_1_Panel2_1_3_3 $M4_Panel2_1_3_3 $Gamma_4_Panel2_1_3_3 $M6_Panel2_1_3_3 $Gamma_6_Panel2_1_3_3 -$M1C_Panel2_1_3_3 -$Gamma_1_Panel2_1_3_3 -$M4C_Panel2_1_3_3 -$Gamma_4_Panel2_1_3_3 -$M6C_Panel2_1_3_3 -$Gamma_6_Panel2_1_3_3 0.25 0.75 0 0 0;
element zeroLength          100213300  213309 213310 -mat 100213300 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2133400 $K_s_Beam2_12_3_3 $Alpha_s_BeamComp2_12_3_3 $Alpha_s_Beam2_12_3_3 $My_s_BeamComp2_12_3_3 -$My_s_Beam2_12_3_3  $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_3_3  $Theta_p_s_Beam2_12_3_3  $Theta_pc_s_BeamComp2_12_3_3  $Theta_pc_s_Beam2_12_3_3  $Res_s_BeamComp2_12_3_3  $Res_s_Beam2_12_3_3  $Theta_ult_s_BeamComp2_12_3_3  $Theta_ult_s_Beam2_12_3_3  1.15 1.;
element     zeroLength 2133400 21334 213304 -mat 2133400 -dir 4;
equalDOF                     21334 213304 1 2 3 5 6;

# DirectionDepthFloorAxis = 2143;
# Panel Rigid Link;
element elasticBeamColumn 100214301 214305 014301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214308 014301 214312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214307 214311 214304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214306 214304 214310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214305 214309 014303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214304 014303 214308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214303 214307 214302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100214302 214306 214302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 214305 214306 1 2 3 5 6;
equalDOF 214312 214311 1 2 3 5 6;
equalDOF 214310 214309 1 2 3 5 6;
equalDOF 214307 214308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100214300 $M1_Panel2_1_4_3 $Gamma_1_Panel2_1_4_3 $M4_Panel2_1_4_3 $Gamma_4_Panel2_1_4_3 $M6_Panel2_1_4_3 $Gamma_6_Panel2_1_4_3 -$M1C_Panel2_1_4_3 -$Gamma_1_Panel2_1_4_3 -$M4C_Panel2_1_4_3 -$Gamma_4_Panel2_1_4_3 -$M6C_Panel2_1_4_3 -$Gamma_6_Panel2_1_4_3 0.25 0.75 0 0 0;
element zeroLength          100214300  214309 214310 -mat 100214300 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2143400 $K_s_Beam2_12_3_4 $Alpha_s_BeamComp2_12_3_4 $Alpha_s_Beam2_12_3_4 $My_s_BeamComp2_12_3_4 -$My_s_Beam2_12_3_4  $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_3_4  $Theta_p_s_Beam2_12_3_4  $Theta_pc_s_BeamComp2_12_3_4  $Theta_pc_s_Beam2_12_3_4  $Res_s_BeamComp2_12_3_4  $Res_s_Beam2_12_3_4  $Theta_ult_s_BeamComp2_12_3_4  $Theta_ult_s_Beam2_12_3_4  1.15 1.;
element     zeroLength 2143400 21434 214304 -mat 2143400 -dir 4;
equalDOF                     21434 214304 1 2 3 5 6;

# DirectionDepthFloorAxis = 2153;
# Panel Rigid Link;
element elasticBeamColumn 100215301 215305 015301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215308 015301 215312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215307 215311 215304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215306 215304 215310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215305 215309 015303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215304 015303 215308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215303 215307 215302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100215302 215306 215302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 215305 215306 1 2 3 5 6;
equalDOF 215312 215311 1 2 3 5 6;
equalDOF 215310 215309 1 2 3 5 6;
equalDOF 215307 215308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100215300 $M1_Panel2_1_5_3 $Gamma_1_Panel2_1_5_3 $M4_Panel2_1_5_3 $Gamma_4_Panel2_1_5_3 $M6_Panel2_1_5_3 $Gamma_6_Panel2_1_5_3 -$M1C_Panel2_1_5_3 -$Gamma_1_Panel2_1_5_3 -$M4C_Panel2_1_5_3 -$Gamma_4_Panel2_1_5_3 -$M6C_Panel2_1_5_3 -$Gamma_6_Panel2_1_5_3 0.25 0.75 0 0 0;
element zeroLength          100215300  215309 215310 -mat 100215300 -dir 4;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 2153400 $K_s_Beam2_12_3_5 $Alpha_s_BeamComp2_12_3_5 $Alpha_s_Beam2_12_3_5 $My_s_BeamComp2_12_3_5 -$My_s_Beam2_12_3_5  $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 1. 1. 1. 1.  $Theta_p_s_BeamComp2_12_3_5  $Theta_p_s_Beam2_12_3_5  $Theta_pc_s_BeamComp2_12_3_5  $Theta_pc_s_Beam2_12_3_5  $Res_s_BeamComp2_12_3_5  $Res_s_Beam2_12_3_5  $Theta_ult_s_BeamComp2_12_3_5  $Theta_ult_s_Beam2_12_3_5  1.15 1.;
element     zeroLength 2153400 21534 215304 -mat 2153400 -dir 4;
equalDOF                     21534 215304 1 2 3 5 6;

# DirectionDepthFloorAxis = 2221;
# Panel Rigid Link;
element elasticBeamColumn 100222101 222105 022101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222108 022101 222112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222107 222111 222104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222106 222104 222110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222105 222109 022103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222104 022103 222108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222103 222107 222102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222102 222106 222102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 222105 222106 1 2 3 5 6;
equalDOF 222112 222111 1 2 3 5 6;
equalDOF 222110 222109 1 2 3 5 6;
equalDOF 222107 222108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100222100 $M1C_Panel2_2_2_1 $Gamma_1_Panel2_2_2_1 $M4C_Panel2_2_2_1 $Gamma_4_Panel2_2_2_1 $M6C_Panel2_2_2_1 $Gamma_6_Panel2_2_2_1 -$M1_Panel2_2_2_1 -$Gamma_1_Panel2_2_2_1 -$M4_Panel2_2_2_1 -$Gamma_4_Panel2_2_2_1 -$M6_Panel2_2_2_1 -$Gamma_6_Panel2_2_2_1 0.25 0.75 0 0 0;
element zeroLength          100222100  222109 222110 -mat 100222100 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2221200 $K_s_Beam2_12_1_2 $Alpha_s_Beam2_12_1_2 $Alpha_s_BeamComp2_12_1_2 $My_s_Beam2_12_1_2 -$My_s_BeamComp2_12_1_2  $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 $Lambda_Beam2_12_1_2 1. 1. 1. 1.  $Theta_p_s_Beam2_12_1_2  $Theta_p_s_BeamComp2_12_1_2  $Theta_pc_s_Beam2_12_1_2  $Theta_pc_s_BeamComp2_12_1_2  $Res_s_Beam2_12_1_2  $Res_s_BeamComp2_12_1_2  $Theta_ult_s_Beam2_12_1_2  $Theta_ult_s_BeamComp2_12_1_2  1. 1.15;
element     zeroLength 2221200 22212 222102 -mat 2221200 -dir 4;
equalDOF                     22212 222102 1 2 3 5 6;

# DirectionDepthFloorAxis = 2231;
# Panel Rigid Link;
element elasticBeamColumn 100223101 223105 023101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223108 023101 223112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223107 223111 223104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223106 223104 223110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223105 223109 023103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223104 023103 223108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223103 223107 223102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223102 223106 223102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 223105 223106 1 2 3 5 6;
equalDOF 223112 223111 1 2 3 5 6;
equalDOF 223110 223109 1 2 3 5 6;
equalDOF 223107 223108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100223100 $M1C_Panel2_2_3_1 $Gamma_1_Panel2_2_3_1 $M4C_Panel2_2_3_1 $Gamma_4_Panel2_2_3_1 $M6C_Panel2_2_3_1 $Gamma_6_Panel2_2_3_1 -$M1_Panel2_2_3_1 -$Gamma_1_Panel2_2_3_1 -$M4_Panel2_2_3_1 -$Gamma_4_Panel2_2_3_1 -$M6_Panel2_2_3_1 -$Gamma_6_Panel2_2_3_1 0.25 0.75 0 0 0;
element zeroLength          100223100  223109 223110 -mat 100223100 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2231200 $K_s_Beam2_12_1_3 $Alpha_s_Beam2_12_1_3 $Alpha_s_BeamComp2_12_1_3 $My_s_Beam2_12_1_3 -$My_s_BeamComp2_12_1_3  $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 $Lambda_Beam2_12_1_3 1. 1. 1. 1.  $Theta_p_s_Beam2_12_1_3  $Theta_p_s_BeamComp2_12_1_3  $Theta_pc_s_Beam2_12_1_3  $Theta_pc_s_BeamComp2_12_1_3  $Res_s_Beam2_12_1_3  $Res_s_BeamComp2_12_1_3  $Theta_ult_s_Beam2_12_1_3  $Theta_ult_s_BeamComp2_12_1_3  1. 1.15;
element     zeroLength 2231200 22312 223102 -mat 2231200 -dir 4;
equalDOF                     22312 223102 1 2 3 5 6;

# DirectionDepthFloorAxis = 2241;
# Panel Rigid Link;
element elasticBeamColumn 100224101 224105 024101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224108 024101 224112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224107 224111 224104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224106 224104 224110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224105 224109 024103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224104 024103 224108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224103 224107 224102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224102 224106 224102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 224105 224106 1 2 3 5 6;
equalDOF 224112 224111 1 2 3 5 6;
equalDOF 224110 224109 1 2 3 5 6;
equalDOF 224107 224108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100224100 $M1C_Panel2_2_4_1 $Gamma_1_Panel2_2_4_1 $M4C_Panel2_2_4_1 $Gamma_4_Panel2_2_4_1 $M6C_Panel2_2_4_1 $Gamma_6_Panel2_2_4_1 -$M1_Panel2_2_4_1 -$Gamma_1_Panel2_2_4_1 -$M4_Panel2_2_4_1 -$Gamma_4_Panel2_2_4_1 -$M6_Panel2_2_4_1 -$Gamma_6_Panel2_2_4_1 0.25 0.75 0 0 0;
element zeroLength          100224100  224109 224110 -mat 100224100 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2241200 $K_s_Beam2_12_1_4 $Alpha_s_Beam2_12_1_4 $Alpha_s_BeamComp2_12_1_4 $My_s_Beam2_12_1_4 -$My_s_BeamComp2_12_1_4  $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 $Lambda_Beam2_12_1_4 1. 1. 1. 1.  $Theta_p_s_Beam2_12_1_4  $Theta_p_s_BeamComp2_12_1_4  $Theta_pc_s_Beam2_12_1_4  $Theta_pc_s_BeamComp2_12_1_4  $Res_s_Beam2_12_1_4  $Res_s_BeamComp2_12_1_4  $Theta_ult_s_Beam2_12_1_4  $Theta_ult_s_BeamComp2_12_1_4  1. 1.15;
element     zeroLength 2241200 22412 224102 -mat 2241200 -dir 4;
equalDOF                     22412 224102 1 2 3 5 6;

# DirectionDepthFloorAxis = 2251;
# Panel Rigid Link;
element elasticBeamColumn 100225101 225105 025101 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225108 025101 225112 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225107 225111 225104 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225106 225104 225110 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225105 225109 025103 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225104 025103 225108 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225103 225107 225102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225102 225106 225102 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 225105 225106 1 2 3 5 6;
equalDOF 225112 225111 1 2 3 5 6;
equalDOF 225110 225109 1 2 3 5 6;
equalDOF 225107 225108 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100225100 $M1C_Panel2_2_5_1 $Gamma_1_Panel2_2_5_1 $M4C_Panel2_2_5_1 $Gamma_4_Panel2_2_5_1 $M6C_Panel2_2_5_1 $Gamma_6_Panel2_2_5_1 -$M1_Panel2_2_5_1 -$Gamma_1_Panel2_2_5_1 -$M4_Panel2_2_5_1 -$Gamma_4_Panel2_2_5_1 -$M6_Panel2_2_5_1 -$Gamma_6_Panel2_2_5_1 0.25 0.75 0 0 0;
element zeroLength          100225100  225109 225110 -mat 100225100 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2251200 $K_s_Beam2_12_1_5 $Alpha_s_Beam2_12_1_5 $Alpha_s_BeamComp2_12_1_5 $My_s_Beam2_12_1_5 -$My_s_BeamComp2_12_1_5  $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 $Lambda_Beam2_12_1_5 1. 1. 1. 1.  $Theta_p_s_Beam2_12_1_5  $Theta_p_s_BeamComp2_12_1_5  $Theta_pc_s_Beam2_12_1_5  $Theta_pc_s_BeamComp2_12_1_5  $Res_s_Beam2_12_1_5  $Res_s_BeamComp2_12_1_5  $Theta_ult_s_Beam2_12_1_5  $Theta_ult_s_BeamComp2_12_1_5  1. 1.15;
element     zeroLength 2251200 22512 225102 -mat 2251200 -dir 4;
equalDOF                     22512 225102 1 2 3 5 6;

# DirectionDepthFloorAxis = 2222;
# Panel Rigid Link;
element elasticBeamColumn 100222201 222205 022201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222208 022201 222212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222207 222211 222204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222206 222204 222210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222205 222209 022203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222204 022203 222208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222203 222207 222202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222202 222206 222202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 222205 222206 1 2 3 5 6;
equalDOF 222212 222211 1 2 3 5 6;
equalDOF 222210 222209 1 2 3 5 6;
equalDOF 222207 222208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100222200 $M1C_Panel2_2_2_2 $Gamma_1_Panel2_2_2_2 $M4C_Panel2_2_2_2 $Gamma_4_Panel2_2_2_2 $M6C_Panel2_2_2_2 $Gamma_6_Panel2_2_2_2 -$M1_Panel2_2_2_2 -$Gamma_1_Panel2_2_2_2 -$M4_Panel2_2_2_2 -$Gamma_4_Panel2_2_2_2 -$M6_Panel2_2_2_2 -$Gamma_6_Panel2_2_2_2 0.25 0.75 0 0 0;
element zeroLength          100222200  222209 222210 -mat 100222200 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2222200 $K_s_Beam2_12_2_2 $Alpha_s_Beam2_12_2_2 $Alpha_s_BeamComp2_12_2_2 $My_s_Beam2_12_2_2 -$My_s_BeamComp2_12_2_2  $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 $Lambda_Beam2_12_2_2 1. 1. 1. 1.  $Theta_p_s_Beam2_12_2_2  $Theta_p_s_BeamComp2_12_2_2  $Theta_pc_s_Beam2_12_2_2  $Theta_pc_s_BeamComp2_12_2_2  $Res_s_Beam2_12_2_2  $Res_s_BeamComp2_12_2_2  $Theta_ult_s_Beam2_12_2_2  $Theta_ult_s_BeamComp2_12_2_2  1. 1.15;
element     zeroLength 2222200 22222 222202 -mat 2222200 -dir 4;
equalDOF                     22222 222202 1 2 3 5 6;

# DirectionDepthFloorAxis = 2232;
# Panel Rigid Link;
element elasticBeamColumn 100223201 223205 023201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223208 023201 223212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223207 223211 223204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223206 223204 223210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223205 223209 023203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223204 023203 223208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223203 223207 223202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223202 223206 223202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 223205 223206 1 2 3 5 6;
equalDOF 223212 223211 1 2 3 5 6;
equalDOF 223210 223209 1 2 3 5 6;
equalDOF 223207 223208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100223200 $M1C_Panel2_2_3_2 $Gamma_1_Panel2_2_3_2 $M4C_Panel2_2_3_2 $Gamma_4_Panel2_2_3_2 $M6C_Panel2_2_3_2 $Gamma_6_Panel2_2_3_2 -$M1_Panel2_2_3_2 -$Gamma_1_Panel2_2_3_2 -$M4_Panel2_2_3_2 -$Gamma_4_Panel2_2_3_2 -$M6_Panel2_2_3_2 -$Gamma_6_Panel2_2_3_2 0.25 0.75 0 0 0;
element zeroLength          100223200  223209 223210 -mat 100223200 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2232200 $K_s_Beam2_12_2_3 $Alpha_s_Beam2_12_2_3 $Alpha_s_BeamComp2_12_2_3 $My_s_Beam2_12_2_3 -$My_s_BeamComp2_12_2_3  $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 $Lambda_Beam2_12_2_3 1. 1. 1. 1.  $Theta_p_s_Beam2_12_2_3  $Theta_p_s_BeamComp2_12_2_3  $Theta_pc_s_Beam2_12_2_3  $Theta_pc_s_BeamComp2_12_2_3  $Res_s_Beam2_12_2_3  $Res_s_BeamComp2_12_2_3  $Theta_ult_s_Beam2_12_2_3  $Theta_ult_s_BeamComp2_12_2_3  1. 1.15;
element     zeroLength 2232200 22322 223202 -mat 2232200 -dir 4;
equalDOF                     22322 223202 1 2 3 5 6;

# DirectionDepthFloorAxis = 2242;
# Panel Rigid Link;
element elasticBeamColumn 100224201 224205 024201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224208 024201 224212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224207 224211 224204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224206 224204 224210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224205 224209 024203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224204 024203 224208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224203 224207 224202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224202 224206 224202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 224205 224206 1 2 3 5 6;
equalDOF 224212 224211 1 2 3 5 6;
equalDOF 224210 224209 1 2 3 5 6;
equalDOF 224207 224208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100224200 $M1C_Panel2_2_4_2 $Gamma_1_Panel2_2_4_2 $M4C_Panel2_2_4_2 $Gamma_4_Panel2_2_4_2 $M6C_Panel2_2_4_2 $Gamma_6_Panel2_2_4_2 -$M1_Panel2_2_4_2 -$Gamma_1_Panel2_2_4_2 -$M4_Panel2_2_4_2 -$Gamma_4_Panel2_2_4_2 -$M6_Panel2_2_4_2 -$Gamma_6_Panel2_2_4_2 0.25 0.75 0 0 0;
element zeroLength          100224200  224209 224210 -mat 100224200 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2242200 $K_s_Beam2_12_2_4 $Alpha_s_Beam2_12_2_4 $Alpha_s_BeamComp2_12_2_4 $My_s_Beam2_12_2_4 -$My_s_BeamComp2_12_2_4  $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 $Lambda_Beam2_12_2_4 1. 1. 1. 1.  $Theta_p_s_Beam2_12_2_4  $Theta_p_s_BeamComp2_12_2_4  $Theta_pc_s_Beam2_12_2_4  $Theta_pc_s_BeamComp2_12_2_4  $Res_s_Beam2_12_2_4  $Res_s_BeamComp2_12_2_4  $Theta_ult_s_Beam2_12_2_4  $Theta_ult_s_BeamComp2_12_2_4  1. 1.15;
element     zeroLength 2242200 22422 224202 -mat 2242200 -dir 4;
equalDOF                     22422 224202 1 2 3 5 6;

# DirectionDepthFloorAxis = 2252;
# Panel Rigid Link;
element elasticBeamColumn 100225201 225205 025201 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225208 025201 225212 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225207 225211 225204 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225206 225204 225210 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225205 225209 025203 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225204 025203 225208 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225203 225207 225202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225202 225206 225202 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 225205 225206 1 2 3 5 6;
equalDOF 225212 225211 1 2 3 5 6;
equalDOF 225210 225209 1 2 3 5 6;
equalDOF 225207 225208 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100225200 $M1C_Panel2_2_5_2 $Gamma_1_Panel2_2_5_2 $M4C_Panel2_2_5_2 $Gamma_4_Panel2_2_5_2 $M6C_Panel2_2_5_2 $Gamma_6_Panel2_2_5_2 -$M1_Panel2_2_5_2 -$Gamma_1_Panel2_2_5_2 -$M4_Panel2_2_5_2 -$Gamma_4_Panel2_2_5_2 -$M6_Panel2_2_5_2 -$Gamma_6_Panel2_2_5_2 0.25 0.75 0 0 0;
element zeroLength          100225200  225209 225210 -mat 100225200 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2252200 $K_s_Beam2_12_2_5 $Alpha_s_Beam2_12_2_5 $Alpha_s_BeamComp2_12_2_5 $My_s_Beam2_12_2_5 -$My_s_BeamComp2_12_2_5  $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 $Lambda_Beam2_12_2_5 1. 1. 1. 1.  $Theta_p_s_Beam2_12_2_5  $Theta_p_s_BeamComp2_12_2_5  $Theta_pc_s_Beam2_12_2_5  $Theta_pc_s_BeamComp2_12_2_5  $Res_s_Beam2_12_2_5  $Res_s_BeamComp2_12_2_5  $Theta_ult_s_Beam2_12_2_5  $Theta_ult_s_BeamComp2_12_2_5  1. 1.15;
element     zeroLength 2252200 22522 225202 -mat 2252200 -dir 4;
equalDOF                     22522 225202 1 2 3 5 6;

# DirectionDepthFloorAxis = 2223;
# Panel Rigid Link;
element elasticBeamColumn 100222301 222305 022301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222308 022301 222312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222307 222311 222304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222306 222304 222310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222305 222309 022303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222304 022303 222308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222303 222307 222302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100222302 222306 222302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 222305 222306 1 2 3 5 6;
equalDOF 222312 222311 1 2 3 5 6;
equalDOF 222310 222309 1 2 3 5 6;
equalDOF 222307 222308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100222300 $M1C_Panel2_2_2_3 $Gamma_1_Panel2_2_2_3 $M4C_Panel2_2_2_3 $Gamma_4_Panel2_2_2_3 $M6C_Panel2_2_2_3 $Gamma_6_Panel2_2_2_3 -$M1_Panel2_2_2_3 -$Gamma_1_Panel2_2_2_3 -$M4_Panel2_2_2_3 -$Gamma_4_Panel2_2_2_3 -$M6_Panel2_2_2_3 -$Gamma_6_Panel2_2_2_3 0.25 0.75 0 0 0;
element zeroLength          100222300  222309 222310 -mat 100222300 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2223200 $K_s_Beam2_12_3_2 $Alpha_s_Beam2_12_3_2 $Alpha_s_BeamComp2_12_3_2 $My_s_Beam2_12_3_2 -$My_s_BeamComp2_12_3_2  $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 $Lambda_Beam2_12_3_2 1. 1. 1. 1.  $Theta_p_s_Beam2_12_3_2  $Theta_p_s_BeamComp2_12_3_2  $Theta_pc_s_Beam2_12_3_2  $Theta_pc_s_BeamComp2_12_3_2  $Res_s_Beam2_12_3_2  $Res_s_BeamComp2_12_3_2  $Theta_ult_s_Beam2_12_3_2  $Theta_ult_s_BeamComp2_12_3_2  1. 1.15;
element     zeroLength 2223200 22232 222302 -mat 2223200 -dir 4;
equalDOF                     22232 222302 1 2 3 5 6;

# DirectionDepthFloorAxis = 2233;
# Panel Rigid Link;
element elasticBeamColumn 100223301 223305 023301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223308 023301 223312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223307 223311 223304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223306 223304 223310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223305 223309 023303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223304 023303 223308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223303 223307 223302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100223302 223306 223302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 223305 223306 1 2 3 5 6;
equalDOF 223312 223311 1 2 3 5 6;
equalDOF 223310 223309 1 2 3 5 6;
equalDOF 223307 223308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100223300 $M1C_Panel2_2_3_3 $Gamma_1_Panel2_2_3_3 $M4C_Panel2_2_3_3 $Gamma_4_Panel2_2_3_3 $M6C_Panel2_2_3_3 $Gamma_6_Panel2_2_3_3 -$M1_Panel2_2_3_3 -$Gamma_1_Panel2_2_3_3 -$M4_Panel2_2_3_3 -$Gamma_4_Panel2_2_3_3 -$M6_Panel2_2_3_3 -$Gamma_6_Panel2_2_3_3 0.25 0.75 0 0 0;
element zeroLength          100223300  223309 223310 -mat 100223300 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2233200 $K_s_Beam2_12_3_3 $Alpha_s_Beam2_12_3_3 $Alpha_s_BeamComp2_12_3_3 $My_s_Beam2_12_3_3 -$My_s_BeamComp2_12_3_3  $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 $Lambda_Beam2_12_3_3 1. 1. 1. 1.  $Theta_p_s_Beam2_12_3_3  $Theta_p_s_BeamComp2_12_3_3  $Theta_pc_s_Beam2_12_3_3  $Theta_pc_s_BeamComp2_12_3_3  $Res_s_Beam2_12_3_3  $Res_s_BeamComp2_12_3_3  $Theta_ult_s_Beam2_12_3_3  $Theta_ult_s_BeamComp2_12_3_3  1. 1.15;
element     zeroLength 2233200 22332 223302 -mat 2233200 -dir 4;
equalDOF                     22332 223302 1 2 3 5 6;

# DirectionDepthFloorAxis = 2243;
# Panel Rigid Link;
element elasticBeamColumn 100224301 224305 024301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224308 024301 224312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224307 224311 224304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224306 224304 224310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224305 224309 024303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224304 024303 224308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224303 224307 224302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100224302 224306 224302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 224305 224306 1 2 3 5 6;
equalDOF 224312 224311 1 2 3 5 6;
equalDOF 224310 224309 1 2 3 5 6;
equalDOF 224307 224308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100224300 $M1C_Panel2_2_4_3 $Gamma_1_Panel2_2_4_3 $M4C_Panel2_2_4_3 $Gamma_4_Panel2_2_4_3 $M6C_Panel2_2_4_3 $Gamma_6_Panel2_2_4_3 -$M1_Panel2_2_4_3 -$Gamma_1_Panel2_2_4_3 -$M4_Panel2_2_4_3 -$Gamma_4_Panel2_2_4_3 -$M6_Panel2_2_4_3 -$Gamma_6_Panel2_2_4_3 0.25 0.75 0 0 0;
element zeroLength          100224300  224309 224310 -mat 100224300 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2243200 $K_s_Beam2_12_3_4 $Alpha_s_Beam2_12_3_4 $Alpha_s_BeamComp2_12_3_4 $My_s_Beam2_12_3_4 -$My_s_BeamComp2_12_3_4  $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 $Lambda_Beam2_12_3_4 1. 1. 1. 1.  $Theta_p_s_Beam2_12_3_4  $Theta_p_s_BeamComp2_12_3_4  $Theta_pc_s_Beam2_12_3_4  $Theta_pc_s_BeamComp2_12_3_4  $Res_s_Beam2_12_3_4  $Res_s_BeamComp2_12_3_4  $Theta_ult_s_Beam2_12_3_4  $Theta_ult_s_BeamComp2_12_3_4  1. 1.15;
element     zeroLength 2243200 22432 224302 -mat 2243200 -dir 4;
equalDOF                     22432 224302 1 2 3 5 6;

# DirectionDepthFloorAxis = 2253;
# Panel Rigid Link;
element elasticBeamColumn 100225301 225305 025301 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225308 025301 225312 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225307 225311 225304 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225306 225304 225310 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225305 225309 025303 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225304 025303 225308 $A_pz_rigid $E $G $J_pz_flexible $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225303 225307 225302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
element elasticBeamColumn 100225302 225306 225302 $A_pz_rigid $E $G $I_pz_rigid $I_pz_rigid $I_pz_rigid $BeamZDirTransfTag;
equalDOF 225305 225306 1 2 3 5 6;
equalDOF 225312 225311 1 2 3 5 6;
equalDOF 225310 225309 1 2 3 5 6;
equalDOF 225307 225308 1 2 3 5 6;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100225300 $M1C_Panel2_2_5_3 $Gamma_1_Panel2_2_5_3 $M4C_Panel2_2_5_3 $Gamma_4_Panel2_2_5_3 $M6C_Panel2_2_5_3 $Gamma_6_Panel2_2_5_3 -$M1_Panel2_2_5_3 -$Gamma_1_Panel2_2_5_3 -$M4_Panel2_2_5_3 -$Gamma_4_Panel2_2_5_3 -$M6_Panel2_2_5_3 -$Gamma_6_Panel2_2_5_3 0.25 0.75 0 0 0;
element zeroLength          100225300  225309 225310 -mat 100225300 -dir 4;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 2253200 $K_s_Beam2_12_3_5 $Alpha_s_Beam2_12_3_5 $Alpha_s_BeamComp2_12_3_5 $My_s_Beam2_12_3_5 -$My_s_BeamComp2_12_3_5  $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 $Lambda_Beam2_12_3_5 1. 1. 1. 1.  $Theta_p_s_Beam2_12_3_5  $Theta_p_s_BeamComp2_12_3_5  $Theta_pc_s_Beam2_12_3_5  $Theta_pc_s_BeamComp2_12_3_5  $Res_s_Beam2_12_3_5  $Res_s_BeamComp2_12_3_5  $Theta_ult_s_Beam2_12_3_5  $Theta_ult_s_BeamComp2_12_3_5  1. 1.15;
element     zeroLength 2253200 22532 225302 -mat 2253200 -dir 4;
equalDOF                     22532 225302 1 2 3 5 6;

# Gradient Element for Columns;

nDMaterial HLBModel 1 205000.0 0.3 318.60 0.89 0.44 0.00 1.00 2 4144.00 113.50 1366.70 5.75 228.00 12.00 387.5104 1.0 web A992Gr50; 

nDMaterial HLBModel 2 205000.0 0.3 477.90 0.89 0.44 0.00 1.00 2 4144.00 113.50 1366.70 5.75 228.00 12.00 550.3036 1.0 web A992Gr50; 

# Fiber section for HSS300x9 columns 
set HSSRotAngle 0.0000 
section NDFiberTestNonlocal 1 -GJ 17486463651923.08 {; 
patch circ 2 2 1 114.0000 114.0000 24.0000 36.0000 [expr 0+$HSSRotAngle] [expr 90+$HSSRotAngle] ; 
patch circ 2 2 1 114.0000 -114.0000 24.0000 36.0000 [expr 270+$HSSRotAngle] [expr 360+$HSSRotAngle]; 
patch circ 2 2 1 -114.0000 -114.0000 24.0000 36.0000 [expr 180+$HSSRotAngle] [expr 270+$HSSRotAngle]; 
patch circ 2 2 1 -114.0000 114.0000 24.0000 36.0000 [expr 90+$HSSRotAngle] [expr 180+$HSSRotAngle]; 

patch quad 1 1 10 138.0000 -114.0000 150.0000 -114.0000 150.0000 114.0000 138.0000 114.0000; 
patch quad 1 1 10 -150.0000 -114.0000 -138.0000 -114.0000 -138.0000 114.0000 -150.0000 114.0000; 

patch quad 1 10 1 -114.0000 -150.0000 114.0000 -150.0000 114.0000 -138.0000 -114.0000 -138.0000; 
patch quad 1 10 1 -114.0000 138.0000 114.0000 138.0000 114.0000 150.0000 -114.0000 150.0000; 
} 

# Depth-1 Story-1, Axis-1 Column;
element testNonlocalElementDH 011103012101 011103 012101 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-1 Story-2, Axis-1 Column;
element testNonlocalElementDH 012103013101 012103 013101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-3, Axis-1 Column;
element testNonlocalElementDH 013103014101 013103 014101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-4, Axis-1 Column;
element testNonlocalElementDH 014103015101 014103 015101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-1, Axis-2 Column;
element testNonlocalElementDH 011203012201 011203 012201 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-1 Story-2, Axis-2 Column;
element testNonlocalElementDH 012203013201 012203 013201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-3, Axis-2 Column;
element testNonlocalElementDH 013203014201 013203 014201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-4, Axis-2 Column;
element testNonlocalElementDH 014203015201 014203 015201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-1, Axis-3 Column;
element testNonlocalElementDH 011303012301 011303 012301 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-1 Story-2, Axis-3 Column;
element testNonlocalElementDH 012303013301 012303 013301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-3, Axis-3 Column;
element testNonlocalElementDH 013303014301 013303 014301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-1 Story-4, Axis-3 Column;
element testNonlocalElementDH 014303015301 014303 015301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-1, Axis-1 Column;
element testNonlocalElementDH 021103022101 021103 022101 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-2 Story-2, Axis-1 Column;
element testNonlocalElementDH 022103023101 022103 023101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-3, Axis-1 Column;
element testNonlocalElementDH 023103024101 023103 024101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-4, Axis-1 Column;
element testNonlocalElementDH 024103025101 024103 025101 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-1, Axis-2 Column;
element testNonlocalElementDH 021203022201 021203 022201 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-2 Story-2, Axis-2 Column;
element testNonlocalElementDH 022203023201 022203 023201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-3, Axis-2 Column;
element testNonlocalElementDH 023203024201 023203 024201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-4, Axis-2 Column;
element testNonlocalElementDH 024203025201 024203 025201 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-1, Axis-3 Column;
element testNonlocalElementDH 021303022301 021303 022301 $ColTransfTag Simpson 1 29  20 0.00000100 300.00 
# Depth-2 Story-2, Axis-3 Column;
element testNonlocalElementDH 022303023301 022303 023301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-3, Axis-3 Column;
element testNonlocalElementDH 023303024301 023303 024301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 
# Depth-2 Story-4, Axis-3 Column;
element testNonlocalElementDH 024303025301 024303 025301 $ColTransfTag Simpson 1 9  20 0.00000100 300.00 

# Beam-column element for Beams G1;
# Direction-1 Depth-1 Span-1 Floor-2 Beam X direction;
element elasticBeamColumn  1121411222 11214 11222 $A_Beam1_1_12_2 $E $G [expr 2.1958*$J_Beam1_1_12_2] [expr 2.1958*$Iy_Beam1_1_12_2] [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_1_12_2] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-3 Beam X direction;
element elasticBeamColumn  1131411322 11314 11322 $A_Beam1_1_12_3 $E $G [expr 2.2013*$J_Beam1_1_12_3] [expr 2.2013*$Iy_Beam1_1_12_3] [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_1_12_3] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-4 Beam X direction;
element elasticBeamColumn  1141411422 11414 11422 $A_Beam1_1_12_4 $E $G [expr 2.7195*$J_Beam1_1_12_4] [expr 2.7195*$Iy_Beam1_1_12_4] [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_1_12_4] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-5 Beam X direction;
element elasticBeamColumn  1151411522 11514 11522 $A_Beam1_1_12_5 $E $G [expr 2.5790*$J_Beam1_1_12_5] [expr 2.5790*$Iy_Beam1_1_12_5] [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_1_12_5] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-2 Beam X direction;
element elasticBeamColumn  1122411232 11224 11232 $A_Beam1_1_23_2 $E $G [expr 2.1958*$J_Beam1_1_23_2] [expr 2.1958*$Iy_Beam1_1_23_2] [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_1_23_2] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-3 Beam X direction;
element elasticBeamColumn  1132411332 11324 11332 $A_Beam1_1_23_3 $E $G [expr 2.2013*$J_Beam1_1_23_3] [expr 2.2013*$Iy_Beam1_1_23_3] [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_1_23_3] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-4 Beam X direction;
element elasticBeamColumn  1142411432 11424 11432 $A_Beam1_1_23_4 $E $G [expr 2.7195*$J_Beam1_1_23_4] [expr 2.7195*$Iy_Beam1_1_23_4] [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_1_23_4] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-5 Beam X direction;
element elasticBeamColumn  1152411532 11524 11532 $A_Beam1_1_23_5 $E $G [expr 2.5790*$J_Beam1_1_23_5] [expr 2.5790*$Iy_Beam1_1_23_5] [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_1_23_5] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-1 Floor-2 Beam X direction;
element elasticBeamColumn  1221412222 12214 12222 $A_Beam1_2_12_2 $E $G [expr 2.1958*$J_Beam1_2_12_2] [expr 2.1958*$Iy_Beam1_2_12_2] [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_2_12_2] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-1 Floor-3 Beam X direction;
element elasticBeamColumn  1231412322 12314 12322 $A_Beam1_2_12_3 $E $G [expr 2.2013*$J_Beam1_2_12_3] [expr 2.2013*$Iy_Beam1_2_12_3] [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_2_12_3] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-1 Floor-4 Beam X direction;
element elasticBeamColumn  1241412422 12414 12422 $A_Beam1_2_12_4 $E $G [expr 2.7195*$J_Beam1_2_12_4] [expr 2.7195*$Iy_Beam1_2_12_4] [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_2_12_4] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-1 Floor-5 Beam X direction;
element elasticBeamColumn  1251412522 12514 12522 $A_Beam1_2_12_5 $E $G [expr 2.5790*$J_Beam1_2_12_5] [expr 2.5790*$Iy_Beam1_2_12_5] [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_2_12_5] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-2 Floor-2 Beam X direction;
element elasticBeamColumn  1222412232 12224 12232 $A_Beam1_2_23_2 $E $G [expr 2.1958*$J_Beam1_2_23_2] [expr 2.1958*$Iy_Beam1_2_23_2] [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_2_23_2] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-2 Floor-3 Beam X direction;
element elasticBeamColumn  1232412332 12324 12332 $A_Beam1_2_23_3 $E $G [expr 2.2013*$J_Beam1_2_23_3] [expr 2.2013*$Iy_Beam1_2_23_3] [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_2_23_3] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-2 Floor-4 Beam X direction;
element elasticBeamColumn  1242412432 12424 12432 $A_Beam1_2_23_4 $E $G [expr 2.7195*$J_Beam1_2_23_4] [expr 2.7195*$Iy_Beam1_2_23_4] [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_2_23_4] $BeamXDirTransfTag;
# Direction-1 Depth-2 Span-2 Floor-5 Beam X direction;
element elasticBeamColumn  1252412532 12524 12532 $A_Beam1_2_23_5 $E $G [expr 2.5790*$J_Beam1_2_23_5] [expr 2.5790*$Iy_Beam1_2_23_5] [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_2_23_5] $BeamXDirTransfTag;


# Beam-column element for Beams G11 and G12;
# Direction-2 Axis-1 Floor-2 Beam Z direction;
element elasticBeamColumn  2121422212 21214 22212 $A_Beam2_12_1_2 $E $G [expr 2.4207*$J_Beam2_12_1_2] [expr 2.4207*$Iy_Beam2_12_1_2] [expr ($n_fac+1)/$n_fac*2.4207*$Ix_Beam2_12_1_2] $BeamZDirTransfTag;
# Direction-2 Axis-1 Floor-3 Beam Z direction;
element elasticBeamColumn  2131422312 21314 22312 $A_Beam2_12_1_3 $E $G [expr 2.3208*$J_Beam2_12_1_3] [expr 2.3208*$Iy_Beam2_12_1_3] [expr ($n_fac+1)/$n_fac*2.3208*$Ix_Beam2_12_1_3] $BeamZDirTransfTag;
# Direction-2 Axis-1 Floor-4 Beam Z direction;
element elasticBeamColumn  2141422412 21414 22412 $A_Beam2_12_1_4 $E $G [expr 3.1262*$J_Beam2_12_1_4] [expr 3.1262*$Iy_Beam2_12_1_4] [expr ($n_fac+1)/$n_fac*3.1262*$Ix_Beam2_12_1_4] $BeamZDirTransfTag;
# Direction-2 Axis-1 Floor-5 Beam Z direction;
element elasticBeamColumn  2151422512 21514 22512 $A_Beam2_12_1_5 $E $G [expr 3.1241*$J_Beam2_12_1_5] [expr 3.1241*$Iy_Beam2_12_1_5] [expr ($n_fac+1)/$n_fac*3.1241*$Ix_Beam2_12_1_5] $BeamZDirTransfTag;
# Direction-2 Axis-2 Floor-2 Beam Z direction;
element elasticBeamColumn  2122422222 21224 22222 $A_Beam2_12_2_2 $E $G [expr 2.5597*$J_Beam2_12_2_2] [expr 2.5597*$Iy_Beam2_12_2_2] [expr ($n_fac+1)/$n_fac*2.5597*$Ix_Beam2_12_2_2] $BeamZDirTransfTag;
# Direction-2 Axis-2 Floor-3 Beam Z direction;
element elasticBeamColumn  2132422322 21324 22322 $A_Beam2_12_2_3 $E $G [expr 2.5039*$J_Beam2_12_2_3] [expr 2.5039*$Iy_Beam2_12_2_3] [expr ($n_fac+1)/$n_fac*2.5039*$Ix_Beam2_12_2_3] $BeamZDirTransfTag;
# Direction-2 Axis-2 Floor-4 Beam Z direction;
element elasticBeamColumn  2142422422 21424 22422 $A_Beam2_12_2_4 $E $G [expr 3.1688*$J_Beam2_12_2_4] [expr 3.1688*$Iy_Beam2_12_2_4] [expr ($n_fac+1)/$n_fac*3.1688*$Ix_Beam2_12_2_4] $BeamZDirTransfTag;
# Direction-2 Axis-2 Floor-5 Beam Z direction;
element elasticBeamColumn  2152422522 21524 22522 $A_Beam2_12_2_5 $E $G [expr 3.5497*$J_Beam2_12_2_5] [expr 3.5497*$Iy_Beam2_12_2_5] [expr ($n_fac+1)/$n_fac*3.5497*$Ix_Beam2_12_2_5] $BeamZDirTransfTag;
# Direction-2 Axis-3 Floor-2 Beam Z direction;
element elasticBeamColumn  2123422232 21234 22232 $A_Beam2_12_3_2 $E $G [expr 2.4207*$J_Beam2_12_3_2] [expr 2.4207*$Iy_Beam2_12_3_2] [expr ($n_fac+1)/$n_fac*2.4207*$Ix_Beam2_12_3_2] $BeamZDirTransfTag;
# Direction-2 Axis-3 Floor-3 Beam Z direction;
element elasticBeamColumn  2133422332 21334 22332 $A_Beam2_12_3_3 $E $G [expr 2.3208*$J_Beam2_12_3_3] [expr 2.3208*$Iy_Beam2_12_3_3] [expr ($n_fac+1)/$n_fac*2.3208*$Ix_Beam2_12_3_3] $BeamZDirTransfTag;
# Direction-2 Axis-3 Floor-4 Beam Z direction;
element elasticBeamColumn  2143422432 21434 22432 $A_Beam2_12_3_4 $E $G [expr 3.1262*$J_Beam2_12_3_4] [expr 3.1262*$Iy_Beam2_12_3_4] [expr ($n_fac+1)/$n_fac*3.1262*$Ix_Beam2_12_3_4] $BeamZDirTransfTag;
# Direction-2 Axis-3 Floor-5 Beam Z direction;
element elasticBeamColumn  2153422532 21534 22532 $A_Beam2_12_3_5 $E $G [expr 3.1241*$J_Beam2_12_3_5] [expr 3.1241*$Iy_Beam2_12_3_5] [expr ($n_fac+1)/$n_fac*3.1241*$Ix_Beam2_12_3_5] $BeamZDirTransfTag;

# Floor movement / Rigid Diaphram
set RigidDiaphragm ON ;
set XMidSlab 5000.000000;
set ZMidSlab 3000.000000;
node 0020 $XMidSlab $Floor2 $ZMidSlab ;
node 0030 $XMidSlab $Floor3 $ZMidSlab ;
node 0040 $XMidSlab $Floor4 $ZMidSlab ;
node 0050 $XMidSlab $Floor5 $ZMidSlab ;
# Constraints for rigid diaphragm master nodes ;
fix  0020 0  1  0  1  0  1;
fix  0030 0  1  0  1  0  1;
fix  0040 0  1  0  1  0  1;
fix  0050 0  1  0  1  0  1;
# ------------------------define Rigid Diaphram, dof 2 is normal to floor ;
set perpDirn 2 ;
rigidDiaphragm $perpDirn 0020 112102 112104  112202 112204  112302 112304  122102 122104  122202 122204  122302 122304  212102 212104  212202 212204  212302 212304  222102 222104  222202 222204  222302 222304  ; #Storey 2 
rigidDiaphragm $perpDirn 0030 113102 113104  113202 113204  113302 113304  123102 123104  123202 123204  123302 123304  213102 213104  213202 213204  213302 213304  223102 223104  223202 223204  223302 223304  ; #Storey 3 
rigidDiaphragm $perpDirn 0040 114102 114104  114202 114204  114302 114304  124102 124104  124202 124204  124302 124304  214102 214104  214202 214204  214302 214304  224102 224104  224202 224204  224302 224304  ; #Storey 4 
rigidDiaphragm $perpDirn 0050 115102 115104  115202 115204  115302 115304  125102 125104  125202 125204  125302 125304  215102 215104  215202 215204  215302 215304  225102 225104  225202 225204  225302 225304  ; #Storey 5 
mass 0020 49.54128440 49.54128440 49.54128440 1.e-10 561467889.90825689 1.e-10; #ton
mass 0030 47.80835882 47.80835882 47.80835882 1.e-10 541828066.59870875 1.e-10; #ton
mass 0040 49.13353721 49.13353721 49.13353721 1.e-10 556846755.01189256 1.e-10; #ton
mass 0050 57.59429154 57.59429154 57.59429154 1.e-10 652735304.11145091 1.e-10; #ton
# Create recorders;
# Floor Lateral Displacement in X direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_FloorDispX.txt  -time  -node 011103  011203  011303  021103  021203  021303  112102  112202  112302  122102  122202  122302  113102  113202  113302  123102  123202  123302  114102  114202  114302  124102  124202  124302  115102  115202  115302  125102  125202  125302  -dof 1 disp;#Left middle of panel zone
# Floor Lateral Displacement in Z direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_FloorDispZ.txt  -time  -node 011103  011203  011303  021103  021203  021303  212102  212202  212302  222102  222202  222302  213102  213202  213302  223102  223202  223302  214102  214202  214302  224102  224202  224302  215102  215202  215302  225102  225202  225302  -dof 3 disp;#Left middle of panel zone
# Column Displacement in Y direction (i.e. axial);
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ColumnStorey1DispY.txt  -time  -node 012101  012201  012301  022101  022201  022301  -dof 2 disp;#Column top node
# Column Displacement in X direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ColumnStorey1DispX.txt  -time  -node 012101  012201  012301  022101  022201  022301  -dof 1 disp;#Column top node
# Column Displacement in Z direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ColumnStorey1DispZ.txt  -time  -node 012101  012201  012301  022101  022201  022301  -dof 3 disp;#Column top node
# Displacement of rigid diaphragm node in x direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_rigidDiaphragmDispX.txt  -time  -node 0020  0030  0040  0050  -dof 1 disp;#Rigid diaphragm node
# Displacement of rigid diaphragm node in z direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_rigidDiaphragmDispZ.txt  -time  -node 0020  0030  0040  0050  -dof 3 disp;#Rigid diaphragm node
# Acceleration of rigid diaphragm node in x direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_rigidDiaphragmAccelX.txt  -time  -node 011103  0020  0030  0040  0050  -dof 1 accel;#Rigid diaphragm node
# Acceleration of rigid diaphragm node in y direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_rigidDiaphragmAccelY.txt  -time  -node 011103  0020  0030  0040  0050  -dof 2 accel;#Rigid diaphragm node
# Acceleration of rigid diaphragm node in z direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_rigidDiaphragmAccelZ.txt  -time  -node 011103  0020  0030  0040  0050  -dof 3 accel;#Rigid diaphragm node
# Reaction Forces  in X direction ;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ReactionX.txt -time  -node 011103  011203  011303  021103  021203  021303  -dof 1 reaction;
# Reaction Forces  in Z direction ;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ReactionZ.txt -time  -node 011103  011203  011303  021103  021203  021303  -dof 3 reaction;
# Reaction Forces Vertical (Y) direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ReactionY.txt -time  -node 011103  011203  011303  021103  021203  021303  -dof 2 reaction;
# Reaction Forces Moment (X) direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ReactionMX.txt -time  -node 011103  011203  011303  021103  021203  021303  -dof 4 reaction;
# Reaction Forces Moment (Z) direction;
recorder Node -file $Result/3dModel3dFiber_lc10DIP29_ReactionMZ.txt -time  -node 011103  011203  011303  021103  021203  021303  -dof 6 reaction;
# Beam spring 1121400;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1121400_force.txt -time  -ele 1121400 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1121400_deformation.txt -time  -ele 1121400 deformation;
# Beam spring 1122200;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1122200_force.txt -time  -ele 1122200 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1122200_deformation.txt -time  -ele 1122200 deformation;
# Beam spring 1122400;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1122400_force.txt -time  -ele 1122400 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring1122400_deformation.txt -time  -ele 1122400 deformation;
# Beam spring 2121400;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring2121400_force.txt -time  -ele 2121400 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring2121400_deformation.txt -time  -ele 2121400 deformation;
# Beam spring 2122400;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring2122400_force.txt -time  -ele 2122400 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_BeamSpring2122400_deformation.txt -time  -ele 2122400 deformation;
# Panel zone spring 100112100;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112100_force.txt -time  -ele 100112100 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112100_deformation.txt -time  -ele 100112100 deformation;
# Panel zone spring 100112200;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112200_force.txt -time  -ele 100112200 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112200_deformation.txt -time  -ele 100112200 deformation;
# Panel zone spring 100112300;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112300_force.txt -time  -ele 100112300 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100112300_deformation.txt -time  -ele 100112300 deformation;
# Panel zone spring 100122100;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122100_force.txt -time  -ele 100122100 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122100_deformation.txt -time  -ele 100122100 deformation;
# Panel zone spring 100122200;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122200_force.txt -time  -ele 100122200 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122200_deformation.txt -time  -ele 100122200 deformation;
# Panel zone spring 100122300;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122300_force.txt -time  -ele 100122300 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100122300_deformation.txt -time  -ele 100122300 deformation;
# Panel zone spring 100212100;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100212100_force.txt -time  -ele 100212100 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100212100_deformation.txt -time  -ele 100212100 deformation;
# Panel zone spring 100212200;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100212200_force.txt -time  -ele 100212200 force;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_PZSpring100212200_deformation.txt -time  -ele 100212200 deformation;
# Column first storey global forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011103012101_globalForce.txt  -time  -ele 011103012101 forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011203012201_globalForce.txt  -time  -ele 011203012201 forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011303012301_globalForce.txt  -time  -ele 011303012301 forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021103022101_globalForce.txt  -time  -ele 021103022101 forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021203022201_globalForce.txt  -time  -ele 021203022201 forces;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021303022301_globalForce.txt  -time  -ele 021303022301 forces;
# Column first storey moment distribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011103012101_momentDistribution.txt  -time  -ele 011103012101 momentDistribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011203012201_momentDistribution.txt  -time  -ele 011203012201 momentDistribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011303012301_momentDistribution.txt  -time  -ele 011303012301 momentDistribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021103022101_momentDistribution.txt  -time  -ele 021103022101 momentDistribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021203022201_momentDistribution.txt  -time  -ele 021203022201 momentDistribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021303022301_momentDistribution.txt  -time  -ele 021303022301 momentDistribution;
# Column first storey local curvature distribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011103012101_localCurvatureDistribution.txt  -time  -ele 011103012101 LocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011203012201_localCurvatureDistribution.txt  -time  -ele 011203012201 LocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011303012301_localCurvatureDistribution.txt  -time  -ele 011303012301 LocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021103022101_localCurvatureDistribution.txt  -time  -ele 021103022101 LocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021203022201_localCurvatureDistribution.txt  -time  -ele 021203022201 LocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021303022301_localCurvatureDistribution.txt  -time  -ele 021303022301 LocalSectionCurvature;
# Column first storey nonlocal curvature distribution;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011103012101_nonlocalCurvatureDistribution.txt  -time  -ele 011103012101 NonlocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011203012201_nonlocalCurvatureDistribution.txt  -time  -ele 011203012201 NonlocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011303012301_nonlocalCurvatureDistribution.txt  -time  -ele 011303012301 NonlocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021103022101_nonlocalCurvatureDistribution.txt  -time  -ele 021103022101 NonlocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021203022201_nonlocalCurvatureDistribution.txt  -time  -ele 021203022201 NonlocalSectionCurvature;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021303022301_nonlocalCurvatureDistribution.txt  -time  -ele 021303022301 NonlocalSectionCurvature;
# Column first storey basic deformations;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011103012101_basicDeformations.txt  -time  -ele 011103012101 basicDeformation;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011203012201_basicDeformations.txt  -time  -ele 011203012201 basicDeformation;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column011303012301_basicDeformations.txt  -time  -ele 011303012301 basicDeformation;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021103022101_basicDeformations.txt  -time  -ele 021103022101 basicDeformation;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021203022201_basicDeformations.txt  -time  -ele 021203022201 basicDeformation;
recorder Element -file $Result/3dModel3dFiber_lc10DIP29_Column021303022301_basicDeformations.txt  -time  -ele 021303022301 basicDeformation;
# Eigen value analysis;
# Mode Shapes;
set numModes 4;
set pi [expr 2.0*asin(1.0)];
set nEigen 5;
set lambdaNTot [eigen [expr $nEigen]];
set lambdaI [lindex $lambdaNTot 0];
set lambdaJ [lindex $lambdaNTot 1];
set lambdaK [lindex $lambdaNTot 2];
set lambdaL [lindex $lambdaNTot 3];
set lambdaM [lindex $lambdaNTot 4];
set lambdaN [lindex $lambdaNTot 5];
set w1 [expr pow($lambdaI,0.5)];
set w2 [expr pow($lambdaJ,0.5)];
set w3 [expr pow($lambdaK,0.5)];
set w4 [expr pow($lambdaL,0.5)];
set w5 [expr pow($lambdaM,0.5)];
set T1 [expr 2.0*$pi/$w1];
set T2 [expr 2.0*$pi/$w2];
set T3 [expr 2.0*$pi/$w3];
set T4 [expr 2.0*$pi/$w4];
set T5 [expr 2.0*$pi/$w5];
puts "";
puts "T1 = [expr {double(round($T1*1000))/1000}] s";
puts "T2 = [expr {double(round($T2*1000))/1000}] s";
puts "T3 = [expr {double(round($T3*1000))/1000}] s";
puts "T4 = [expr {double(round($T4*1000))/1000}] s";
puts "T5 = [expr {double(round($T5*1000))/1000}] s";
puts "w1 = [expr $w1]";
puts "w2 = [expr $w2]";
puts "w3 = [expr $w3]";
puts "w4 = [expr $w4]";
puts "w5 = [expr $w5]";
puts "Eigen Analysis Done";

#Store Eigen vector of 1st mode;
set eigenvector2Depth1 [nodeEigenvector 112102 2 1];
set eigenvector2Depth2 [nodeEigenvector 122102 2 1];
set eigenvector3Depth1 [nodeEigenvector 113102 2 1];
set eigenvector3Depth2 [nodeEigenvector 123102 2 1];
set eigenvector4Depth1 [nodeEigenvector 114102 2 1];
set eigenvector4Depth2 [nodeEigenvector 124102 2 1];
set eigenvector5Depth1 [nodeEigenvector 115102 2 1];
set eigenvector5Depth2 [nodeEigenvector 125102 2 1];

# Assign Loads, Analysis Type And Conversion Procedure;
# GRAVITY LOADS;
pattern Plain 100 Linear {
load 012101 0. [expr -1.0*60750.0000] 0. 0. 0. 0.;
load 012201 0. [expr -1.0*121500.0000] 0. 0. 0. 0.;
load 012301 0. [expr -1.0*60750.0000] 0. 0. 0. 0.;
load 013101 0. [expr -1.0*58625.0000] 0. 0. 0. 0.;
load 013201 0. [expr -1.0*117250.0000] 0. 0. 0. 0.;
load 013301 0. [expr -1.0*58625.0000] 0. 0. 0. 0.;
load 014101 0. [expr -1.0*60250.0000] 0. 0. 0. 0.;
load 014201 0. [expr -1.0*120500.0000] 0. 0. 0. 0.;
load 014301 0. [expr -1.0*60250.0000] 0. 0. 0. 0.;
load 015101 0. [expr -1.0*70625.0000] 0. 0. 0. 0.;
load 015201 0. [expr -1.0*141250.0000] 0. 0. 0. 0.;
load 015301 0. [expr -1.0*70625.0000] 0. 0. 0. 0.;
load 022101 0. [expr -1.0*60750.0000] 0. 0. 0. 0.;
load 022201 0. [expr -1.0*121500.0000] 0. 0. 0. 0.;
load 022301 0. [expr -1.0*60750.0000] 0. 0. 0. 0.;
load 023101 0. [expr -1.0*58625.0000] 0. 0. 0. 0.;
load 023201 0. [expr -1.0*117250.0000] 0. 0. 0. 0.;
load 023301 0. [expr -1.0*58625.0000] 0. 0. 0. 0.;
load 024101 0. [expr -1.0*60250.0000] 0. 0. 0. 0.;
load 024201 0. [expr -1.0*120500.0000] 0. 0. 0. 0.;
load 024301 0. [expr -1.0*60250.0000] 0. 0. 0. 0.;
load 025101 0. [expr -1.0*70625.0000] 0. 0. 0. 0.;
load 025201 0. [expr -1.0*141250.0000] 0. 0. 0. 0.;
load 025301 0. [expr -1.0*70625.0000] 0. 0. 0. 0.;
};
# CONVERSION PARAMETERS;
variable constraintsTypeGravity Plain;		# default;
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
set zeta_EQ 0.03;		# percentage of critical damping
set zeta_FV 0.5;		# percentage of critical damping
set a0_EQ [expr 0.3625];	# mass damping coefficient based on least square approach
set a1_EQ [expr 0.0018];	# stiffness damping coefficient based on least square approach
set a0_FV [expr 6.0410];	# mass damping coefficient based on least square approach
set a1_FV [expr 0.0306];	# stiffness damping coefficient based on least square approach
set a1_EQ_mod_two [expr $a1_EQ*(1.0+10.0000)/10.0000]; # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_EQ_mod_one [expr (1.0+1.0/(2*10.0000))*$a1_EQ];    # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_FV_mod_two [expr $a1_FV*(1.0+10.0000)/10.0000]; # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.
set a1_FV_mod_one [expr (1.0+1.0/(2*10.0000))*$a1_FV];    # modified stiffness damping coefficient used for n modified elements. See Zareian & Medina 2010.

# 100% level earthquake

# Damping for 100% level earthquake
# assign damping to frame columns
region 1 -ele  011103012101  012103013101  013103014101  014103015101  011203012201  012203013201  013203014201  014203015201  011303012301  012303013301  013303014301  014303015301  021103022101  022103023101  023103024101  024103025101  021203022201  022203023201  023203024201  024203025201  021303022301  022303023301  023303024301  024303025301  -rayleigh 0.0 0.0 $a1_EQ 0.0;# assign stiffness proportional damping to columns without splices
region 3 -ele  1121411222  1131411322  1141411422  1151411522  1122411232  1132411332  1142411432  1152411532  1221412222  1231412322  1241412422  1251412522  1222412232  1232412332  1242412432  1252412532  -rayleigh 0.0 0.0 $a1_EQ_mod_two 0.0;# assign stiffness proportional damping to beams G1
region 4 -ele  2121422212  2131422312  2141422412  2151422512  2122422222  2132422322  2142422422  2152422522  2123422232  2133422332  2143422432  2153422532  -rayleigh 0.0 0.0 $a1_EQ_mod_two 0.0;# assign stiffness proportional damping to beams G11 and G12
region 7 -node 0020  0030  0040  0050 -rayleigh $a0_EQ 0.0 0.0 0.0;# assign mass proportional damping to structure (assign to nodes with mass)

# Define level 100% ground motion parameters

set pattern1ID 1;              # Pattern ID
set pattern2ID 2;              # Pattern ID
set GMXdirection 1;				# ground motion direction (1 = x)
set GMYdirection 2;				# ground motion direction (2 = y)
set GMZdirection 3;				# ground motion direction (3 = z)
set GMEQYfile "ath.KOBE.TAK_YDIR.th";      # ground motion filename
set GMEQXfile "ath.KOBE.TAK_XDIR.th";      # ground motion filename
set dt 0.0100;					# timestep of input GM file
set Scalefact 1.2000;				# ground motion scaling factor
set TotalNumberOfSteps 4096;	# number of steps in ground motion
set GMtime [expr $dt*$TotalNumberOfSteps + 0.0];	# total time of ground motion + free vibration

# define the acceleration series for the ground motion
# syntax:  "Series -dt $timestep_of_record -filePath $filename_with_acc_history -factor $scale_record_by_this_amount
set g 9810;
set accelSeries1 "Series -dt $dt -filePath $GMEQYfile -factor [expr $Scalefact*$g]";
set accelSeries2 "Series -dt $dt -filePath $GMEQXfile -factor [expr $Scalefact*$g]";

# create load pattern: apply acceleration to all fixed nodes with UniformExcitation
# command: pattern UniformExcitation $patternID $GMdir -accel $timeSeriesID 
pattern UniformExcitation $pattern1ID $GMXdirection -accel $accelSeries1;
pattern UniformExcitation $pattern2ID $GMZdirection -accel $accelSeries2;

puts "Running Level 100% Dynamic Analysis..."
# define dynamic analysis parameters
set dt_analysis 0.0100;			# timestep of analysis
set FloorNodes [list  011103 021103 112102 122102 113102 123102 114102 124102 115102 125102 ]; 
set FloorElevation [list 0 3450.0 6950.0 10450.0 13975.0 ]; 
set tStart [clock seconds];

# proc DynamicAnalysis {dt  dt_anal_Step   GMtime  numStories numBays DriftLimit FloorNodes  FloorElevation   h1       htyp};
set nbNodesTot 590 ; 
DynamicAnalysis_V04        $dt  $dt_analysis  $GMtime    4       0.20    $FloorNodes     3450.0000      3500.0000 $nbNodesTot;

# output time at end of analysis	
set currentTimeLevel100 [getTime];	# get current analysis time	(after dynamic analysis)
puts "Level 100% ground motion time: $currentTimeLevel100";
set tFinish [clock seconds];
set tFinishEQ [expr $tFinish - $tStart];
puts "Level 100% ground motion analysis duration: $tFinishEQ] s";
wipeAnalysis;
puts "Level 100% ground motion Done";

wipe;
wipe all;
