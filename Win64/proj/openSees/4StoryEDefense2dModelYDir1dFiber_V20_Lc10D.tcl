wipe;
wipe all;

model BasicBuilder -ndm 2 -ndf 3;

set ColTransfTag 1 
set BeamXDirTransfTag 2 
geomTransf Corotational $ColTransfTag;
geomTransf Linear $BeamXDirTransfTag;

set Source "0_Source";
source $Source/DisplayModel2D.tcl;
source $Source/DisplayPlane.tcl;
source $Source/DynamicAnalysis_V03.tcl;

file mkdir 4StoryEDefense2dModelYDir1dFiber_V20_result;
global Result;
set Result "4StoryEDefense2dModelYDir1dFiber_V20_result";

set E 205000.00;

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
set H_offset 0.0;

# Column at DEPTH-1 and STORY-1 and AXIS-1 (Bottom);
set            d_Col1_12_1_b 300.00;#Depth
set           bf_Col1_12_1_b 300.00;#Flange width
set           tw_Col1_12_1_b 9.00;#Web thickness
set           tf_Col1_12_1_b 9.00;#Flange thickness
set            r_Col1_12_1_b 0.00;#Radius at the k-area
set            A_Col1_12_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-1 (Bottom);
set            d_Col1_12_1_t 300.00;#Depth
set           bf_Col1_12_1_t 300.00;#Flange width
set           tw_Col1_12_1_t 9.00;#Web thickness
set           tf_Col1_12_1_t 9.00;#Flange thickness
set            r_Col1_12_1_t 0.00;#Radius at the k-area
set            A_Col1_12_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-1 and AXIS-2 (Bottom);
set            d_Col1_12_2_b 300.00;#Depth
set           bf_Col1_12_2_b 300.00;#Flange width
set           tw_Col1_12_2_b 9.00;#Web thickness
set           tf_Col1_12_2_b 9.00;#Flange thickness
set            r_Col1_12_2_b 0.00;#Radius at the k-area
set            A_Col1_12_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-2 (Bottom);
set            d_Col1_12_2_t 300.00;#Depth
set           bf_Col1_12_2_t 300.00;#Flange width
set           tw_Col1_12_2_t 9.00;#Web thickness
set           tf_Col1_12_2_t 9.00;#Flange thickness
set            r_Col1_12_2_t 0.00;#Radius at the k-area
set            A_Col1_12_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-1 and AXIS-3 (Bottom);
set            d_Col1_12_3_b 300.00;#Depth
set           bf_Col1_12_3_b 300.00;#Flange width
set           tw_Col1_12_3_b 9.00;#Web thickness
set           tf_Col1_12_3_b 9.00;#Flange thickness
set            r_Col1_12_3_b 0.00;#Radius at the k-area
set            A_Col1_12_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_12_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_12_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-1 and AXIS-3 (Bottom);
set            d_Col1_12_3_t 300.00;#Depth
set           bf_Col1_12_3_t 300.00;#Flange width
set           tw_Col1_12_3_t 9.00;#Web thickness
set           tf_Col1_12_3_t 9.00;#Flange thickness
set            r_Col1_12_3_t 0.00;#Radius at the k-area
set            A_Col1_12_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_12_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_12_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_12_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_12_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_12_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-1 (Bottom);
set            d_Col1_23_1_b 300.00;#Depth
set           bf_Col1_23_1_b 300.00;#Flange width
set           tw_Col1_23_1_b 9.00;#Web thickness
set           tf_Col1_23_1_b 9.00;#Flange thickness
set            r_Col1_23_1_b 0.00;#Radius at the k-area
set            A_Col1_23_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-1 (Bottom);
set            d_Col1_23_1_t 300.00;#Depth
set           bf_Col1_23_1_t 300.00;#Flange width
set           tw_Col1_23_1_t 9.00;#Web thickness
set           tf_Col1_23_1_t 9.00;#Flange thickness
set            r_Col1_23_1_t 0.00;#Radius at the k-area
set            A_Col1_23_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-2 (Bottom);
set            d_Col1_23_2_b 300.00;#Depth
set           bf_Col1_23_2_b 300.00;#Flange width
set           tw_Col1_23_2_b 9.00;#Web thickness
set           tf_Col1_23_2_b 9.00;#Flange thickness
set            r_Col1_23_2_b 0.00;#Radius at the k-area
set            A_Col1_23_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-2 (Bottom);
set            d_Col1_23_2_t 300.00;#Depth
set           bf_Col1_23_2_t 300.00;#Flange width
set           tw_Col1_23_2_t 9.00;#Web thickness
set           tf_Col1_23_2_t 9.00;#Flange thickness
set            r_Col1_23_2_t 0.00;#Radius at the k-area
set            A_Col1_23_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-2 and AXIS-3 (Bottom);
set            d_Col1_23_3_b 300.00;#Depth
set           bf_Col1_23_3_b 300.00;#Flange width
set           tw_Col1_23_3_b 9.00;#Web thickness
set           tf_Col1_23_3_b 9.00;#Flange thickness
set            r_Col1_23_3_b 0.00;#Radius at the k-area
set            A_Col1_23_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_23_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_23_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-2 and AXIS-3 (Bottom);
set            d_Col1_23_3_t 300.00;#Depth
set           bf_Col1_23_3_t 300.00;#Flange width
set           tw_Col1_23_3_t 9.00;#Web thickness
set           tf_Col1_23_3_t 9.00;#Flange thickness
set            r_Col1_23_3_t 0.00;#Radius at the k-area
set            A_Col1_23_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_23_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_23_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_23_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_23_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_23_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-1 (Bottom);
set            d_Col1_34_1_b 300.00;#Depth
set           bf_Col1_34_1_b 300.00;#Flange width
set           tw_Col1_34_1_b 9.00;#Web thickness
set           tf_Col1_34_1_b 9.00;#Flange thickness
set            r_Col1_34_1_b 0.00;#Radius at the k-area
set            A_Col1_34_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-1 (Bottom);
set            d_Col1_34_1_t 300.00;#Depth
set           bf_Col1_34_1_t 300.00;#Flange width
set           tw_Col1_34_1_t 9.00;#Web thickness
set           tf_Col1_34_1_t 9.00;#Flange thickness
set            r_Col1_34_1_t 0.00;#Radius at the k-area
set            A_Col1_34_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-2 (Bottom);
set            d_Col1_34_2_b 300.00;#Depth
set           bf_Col1_34_2_b 300.00;#Flange width
set           tw_Col1_34_2_b 9.00;#Web thickness
set           tf_Col1_34_2_b 9.00;#Flange thickness
set            r_Col1_34_2_b 0.00;#Radius at the k-area
set            A_Col1_34_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-2 (Bottom);
set            d_Col1_34_2_t 300.00;#Depth
set           bf_Col1_34_2_t 300.00;#Flange width
set           tw_Col1_34_2_t 9.00;#Web thickness
set           tf_Col1_34_2_t 9.00;#Flange thickness
set            r_Col1_34_2_t 0.00;#Radius at the k-area
set            A_Col1_34_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-3 and AXIS-3 (Bottom);
set            d_Col1_34_3_b 300.00;#Depth
set           bf_Col1_34_3_b 300.00;#Flange width
set           tw_Col1_34_3_b 9.00;#Web thickness
set           tf_Col1_34_3_b 9.00;#Flange thickness
set            r_Col1_34_3_b 0.00;#Radius at the k-area
set            A_Col1_34_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_34_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_34_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-3 and AXIS-3 (Bottom);
set            d_Col1_34_3_t 300.00;#Depth
set           bf_Col1_34_3_t 300.00;#Flange width
set           tw_Col1_34_3_t 9.00;#Web thickness
set           tf_Col1_34_3_t 9.00;#Flange thickness
set            r_Col1_34_3_t 0.00;#Radius at the k-area
set            A_Col1_34_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_34_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_34_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_34_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_34_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_34_3_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-1 (Bottom);
set            d_Col1_45_1_b 300.00;#Depth
set           bf_Col1_45_1_b 300.00;#Flange width
set           tw_Col1_45_1_b 9.00;#Web thickness
set           tf_Col1_45_1_b 9.00;#Flange thickness
set            r_Col1_45_1_b 0.00;#Radius at the k-area
set            A_Col1_45_1_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_1_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_1_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_1_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_1_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_1_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-1 (Bottom);
set            d_Col1_45_1_t 300.00;#Depth
set           bf_Col1_45_1_t 300.00;#Flange width
set           tw_Col1_45_1_t 9.00;#Web thickness
set           tf_Col1_45_1_t 9.00;#Flange thickness
set            r_Col1_45_1_t 0.00;#Radius at the k-area
set            A_Col1_45_1_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_1_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_1_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_1_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_1_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_1_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-2 (Bottom);
set            d_Col1_45_2_b 300.00;#Depth
set           bf_Col1_45_2_b 300.00;#Flange width
set           tw_Col1_45_2_b 9.00;#Web thickness
set           tf_Col1_45_2_b 9.00;#Flange thickness
set            r_Col1_45_2_b 0.00;#Radius at the k-area
set            A_Col1_45_2_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_2_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_2_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_2_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_2_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_2_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-2 (Bottom);
set            d_Col1_45_2_t 300.00;#Depth
set           bf_Col1_45_2_t 300.00;#Flange width
set           tw_Col1_45_2_t 9.00;#Web thickness
set           tf_Col1_45_2_t 9.00;#Flange thickness
set            r_Col1_45_2_t 0.00;#Radius at the k-area
set            A_Col1_45_2_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_2_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_2_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_2_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_2_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_2_t 221779539.00;#Torsion constant


# Column at DEPTH-1 and STORY-4 and AXIS-3 (Bottom);
set            d_Col1_45_3_b 300.00;#Depth
set           bf_Col1_45_3_b 300.00;#Flange width
set           tw_Col1_45_3_b 9.00;#Web thickness
set           tf_Col1_45_3_b 9.00;#Flange thickness
set            r_Col1_45_3_b 0.00;#Radius at the k-area
set            A_Col1_45_3_b 10270.00;#Cross-sectional area
set           Ix_Col1_45_3_b 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_3_b 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_3_b 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_3_b 118.00;#Radius of gyration about weak axis
set            J_Col1_45_3_b 221779539.00;#Torsion constant

# Column at DEPTH-1 and STORY-4 and AXIS-3 (Bottom);
set            d_Col1_45_3_t 300.00;#Depth
set           bf_Col1_45_3_t 300.00;#Flange width
set           tw_Col1_45_3_t 9.00;#Web thickness
set           tf_Col1_45_3_t 9.00;#Flange thickness
set            r_Col1_45_3_t 0.00;#Radius at the k-area
set            A_Col1_45_3_t 10270.00;#Cross-sectional area
set           Ix_Col1_45_3_t 143000000.00;#Second moment of inertia about strong axis
set           Zx_Col1_45_3_t 784888.53;#Plastic section modulus abotu strong axis
set           Iy_Col1_45_3_t 143000000.00;#Second moment of inertia about weak axis
set           ry_Col1_45_3_t 118.00;#Radius of gyration about weak axis
set            J_Col1_45_3_t 221779539.00;#Torsion constant


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

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-1;
set             KfKe1_1_2_1 0.00161;#Kf/Ke
set    Gamma_1_Panel1_1_2_1 0.00227;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_1 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_1 0.01362;#3rd distorsion angle
set         M1_Panel1_1_2_1 305539424.18;#Yield moment of the panel
set         M4_Panel1_1_2_1 381752628.87;#Ultimate moment of the panel
set         M6_Panel1_1_2_1 404067305.91;#3rd moment of the panel
set         M1C_Panel1_1_2_1 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_1 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_1 541366661.80;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-2;
set             KfKe1_1_2_2 0.00161;#Kf/Ke
set    Gamma_1_Panel1_1_2_2 0.00227;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_2 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_2 0.01362;#3rd distorsion angle
set         M1_Panel1_1_2_2 305539424.18;#Yield moment of the panel
set         M4_Panel1_1_2_2 381752628.87;#Ultimate moment of the panel
set         M6_Panel1_1_2_2 404067305.91;#3rd moment of the panel
set         M1C_Panel1_1_2_2 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_2 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_2 541366661.80;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-2 and AXIS-3;
set             KfKe1_1_2_3 0.00161;#Kf/Ke
set    Gamma_1_Panel1_1_2_3 0.00227;#Yield distorsion angle
set    Gamma_4_Panel1_1_2_3 0.00908;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_2_3 0.01362;#3rd distorsion angle
set         M1_Panel1_1_2_3 305539424.18;#Yield moment of the panel
set         M4_Panel1_1_2_3 381752628.87;#Ultimate moment of the panel
set         M6_Panel1_1_2_3 404067305.91;#3rd moment of the panel
set         M1C_Panel1_1_2_3 409359667.80;#Composite Yield moment of the panel
set         M4C_Panel1_1_2_3 511469607.41;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_2_3 541366661.80;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-1;
set             KfKe1_1_3_1 0.00164;#Kf/Ke
set    Gamma_1_Panel1_1_3_1 0.00228;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_1 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_1 0.01366;#3rd distorsion angle
set         M1_Panel1_1_3_1 305802593.37;#Yield moment of the panel
set         M4_Panel1_1_3_1 382081442.50;#Ultimate moment of the panel
set         M6_Panel1_1_3_1 404415339.77;#3rd moment of the panel
set         M1C_Panel1_1_3_1 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_1 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_1 541496383.51;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-2;
set             KfKe1_1_3_2 0.00164;#Kf/Ke
set    Gamma_1_Panel1_1_3_2 0.00228;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_2 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_2 0.01366;#3rd distorsion angle
set         M1_Panel1_1_3_2 305802593.37;#Yield moment of the panel
set         M4_Panel1_1_3_2 382081442.50;#Ultimate moment of the panel
set         M6_Panel1_1_3_2 404415339.77;#3rd moment of the panel
set         M1C_Panel1_1_3_2 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_2 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_2 541496383.51;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-3 and AXIS-3;
set             KfKe1_1_3_3 0.00164;#Kf/Ke
set    Gamma_1_Panel1_1_3_3 0.00228;#Yield distorsion angle
set    Gamma_4_Panel1_1_3_3 0.00911;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_3_3 0.01366;#3rd distorsion angle
set         M1_Panel1_1_3_3 305802593.37;#Yield moment of the panel
set         M4_Panel1_1_3_3 382081442.50;#Ultimate moment of the panel
set         M6_Panel1_1_3_3 404415339.77;#3rd moment of the panel
set         M1C_Panel1_1_3_3 409457758.13;#Composite Yield moment of the panel
set         M4C_Panel1_1_3_3 511592165.22;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_3_3 541496383.51;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-1;
set             KfKe1_1_4_1 0.00202;#Kf/Ke
set    Gamma_1_Panel1_1_4_1 0.00220;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_1 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_1 0.01320;#3rd distorsion angle
set         M1_Panel1_1_4_1 269265140.65;#Yield moment of the panel
set         M4_Panel1_1_4_1 336430153.27;#Ultimate moment of the panel
set         M6_Panel1_1_4_1 356095584.89;#3rd moment of the panel
set         M1C_Panel1_1_4_1 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_1 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_1 493176628.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-2;
set             KfKe1_1_4_2 0.00202;#Kf/Ke
set    Gamma_1_Panel1_1_4_2 0.00220;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_2 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_2 0.01320;#3rd distorsion angle
set         M1_Panel1_1_4_2 269265140.65;#Yield moment of the panel
set         M4_Panel1_1_4_2 336430153.27;#Ultimate moment of the panel
set         M6_Panel1_1_4_2 356095584.89;#3rd moment of the panel
set         M1C_Panel1_1_4_2 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_2 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_2 493176628.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-4 and AXIS-3;
set             KfKe1_1_4_3 0.00202;#Kf/Ke
set    Gamma_1_Panel1_1_4_3 0.00220;#Yield distorsion angle
set    Gamma_4_Panel1_1_4_3 0.00880;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_4_3 0.01320;#3rd distorsion angle
set         M1_Panel1_1_4_3 269265140.65;#Yield moment of the panel
set         M4_Panel1_1_4_3 336430153.27;#Ultimate moment of the panel
set         M6_Panel1_1_4_3 356095584.89;#3rd moment of the panel
set         M1C_Panel1_1_4_3 372920305.42;#Composite Yield moment of the panel
set         M4C_Panel1_1_4_3 465940875.98;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_4_3 493176628.63;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-1;
set             KfKe1_1_5_1 0.00206;#Kf/Ke
set    Gamma_1_Panel1_1_5_1 0.00219;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_1 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_1 0.01316;#3rd distorsion angle
set         M1_Panel1_1_5_1 267676555.75;#Yield moment of the panel
set         M4_Panel1_1_5_1 334445314.60;#Ultimate moment of the panel
set         M6_Panel1_1_5_1 353994725.98;#3rd moment of the panel
set         M1C_Panel1_1_5_1 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_1 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_1 490025340.27;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-2;
set             KfKe1_1_5_2 0.00206;#Kf/Ke
set    Gamma_1_Panel1_1_5_2 0.00219;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_2 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_2 0.01316;#3rd distorsion angle
set         M1_Panel1_1_5_2 267676555.75;#Yield moment of the panel
set         M4_Panel1_1_5_2 334445314.60;#Ultimate moment of the panel
set         M6_Panel1_1_5_2 353994725.98;#3rd moment of the panel
set         M1C_Panel1_1_5_2 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_2 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_2 490025340.27;#Composite 3rd moment of the panel

# Panel zone G1 at Direction-1 and Depth-1 FLOOR-5 and AXIS-3;
set             KfKe1_1_5_3 0.00206;#Kf/Ke
set    Gamma_1_Panel1_1_5_3 0.00219;#Yield distorsion angle
set    Gamma_4_Panel1_1_5_3 0.00877;#Ultimate distorsion angle
set    Gamma_6_Panel1_1_5_3 0.01316;#3rd distorsion angle
set         M1_Panel1_1_5_3 267676555.75;#Yield moment of the panel
set         M4_Panel1_1_5_3 334445314.60;#Ultimate moment of the panel
set         M6_Panel1_1_5_3 353994725.98;#3rd moment of the panel
set         M1C_Panel1_1_5_3 370537428.07;#Composite Yield moment of the panel
set         M4C_Panel1_1_5_3 462963617.99;#Composite Ultimate moment of the panel
set         M6C_Panel1_1_5_3 490025340.27;#Composite 3rd moment of the panel

# Floor 1 Depth-1 MRF Column Bases;
node 011103 [expr $Axis1] [expr $Floor1]  ;
fix  011103 1 1 1;

node 011203 [expr $Axis2] [expr $Floor1]  ;
fix  011203 1 1 1;

node 011303 [expr $Axis3] [expr $Floor1]  ;
fix  011303 1 1 1;


# Panel zone G1;
# Direction-1, Depth-1 AXIS-1, FLOOR-2;
node 012101  [expr $Axis1                               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom middle ;
node 112105  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom left ;
node 112106  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom left ;
node 112112  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom right ;
node 112111  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom right;
node 112102  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2               ]  ;# middle left  ;
node 112104  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2               ] ;# middle right ;
node 112107  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top left  ;
node 112108  [expr $Axis1-$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top left;
node 112109  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top right;
node 112110  [expr $Axis1+$d_Col1_12_1_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top right;
node 012103  [expr $Axis1                               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top middle;
node 11214   [expr $Axis1+$d_Col1_12_1_t/2.+$H_offset               ] [expr $Floor2               ]  ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-3;
node 013101  [expr $Axis1                               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom middle ;
node 113105  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom left ;
node 113106  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom left ;
node 113112  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom right ;
node 113111  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom right;
node 113102  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3               ]  ;# middle left  ;
node 113104  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3               ] ;# middle right ;
node 113107  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top left  ;
node 113108  [expr $Axis1-$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top left;
node 113109  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top right;
node 113110  [expr $Axis1+$d_Col1_23_1_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top right;
node 013103  [expr $Axis1                               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top middle;
node 11314   [expr $Axis1+$d_Col1_23_1_t/2.+$H_offset               ] [expr $Floor3               ]  ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-4;
node 014101  [expr $Axis1                               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom middle ;
node 114105  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom left ;
node 114106  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom left ;
node 114112  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom right ;
node 114111  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom right;
node 114102  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4               ]  ;# middle left  ;
node 114104  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4               ] ;# middle right ;
node 114107  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top left  ;
node 114108  [expr $Axis1-$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top left;
node 114109  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top right;
node 114110  [expr $Axis1+$d_Col1_34_1_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top right;
node 014103  [expr $Axis1                               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top middle;
node 11414   [expr $Axis1+$d_Col1_34_1_t/2.+$H_offset               ] [expr $Floor4               ]  ;# WUF-Wright;


# Direction-1, Depth-1 AXIS-1, FLOOR-5;
node 015101  [expr $Axis1                               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom middle ;
node 115105  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom left ;
node 115106  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom left ;
node 115112  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom right ;
node 115111  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom right;
node 115102  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5               ]  ;# middle left  ;
node 115104  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5               ] ;# middle right ;
node 115107  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top left  ;
node 115108  [expr $Axis1-$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top left;
node 115109  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top right;
node 115110  [expr $Axis1+$d_Col1_45_1_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top right;
node 015103  [expr $Axis1                               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top middle;
node 11514   [expr $Axis1+$d_Col1_45_1_t/2.+$H_offset               ] [expr $Floor5               ]  ;# WUF-Wright;


#Direction-1, Depth-1 AXIS-2, FLOOR-2;
node 012201  [expr $Axis2                               ] [expr $Floor2-$d_Beam1_1_12_2/2.] ;# bottom middle  ;
node 112205  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom left    ;
node 112206  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom left    ;
node 112212  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.] ;# bottom right   ;
node 112211  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2-$d_Beam1_1_12_2/2.]  ;# bottom right   ;
node 112202  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2               ]  ;# middle left    ;
node 112204  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2               ] ;# middle right   ;
node 112207  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.] ;# top left       ;
node 112208  [expr $Axis2-$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top left       ;
node 112209  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top right      ;
node 112210  [expr $Axis2+$d_Col1_12_2_t/2.               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top right      ;
node 012203  [expr $Axis2                               ] [expr $Floor2+$d_Beam1_1_12_2/2.]  ;# top middle     ;
node 11222   [expr $Axis2-$d_Col1_12_2_t/2.-$H_offset               ] [expr $Floor2               ]  ;# WUF-Wleft ;
node 11224   [expr $Axis2+$d_Col1_12_2_t/2.+$H_offset               ] [expr $Floor2               ] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-3;
node 013201  [expr $Axis2                               ] [expr $Floor3-$d_Beam1_1_12_3/2.] ;# bottom middle  ;
node 113205  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom left    ;
node 113206  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom left    ;
node 113212  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.] ;# bottom right   ;
node 113211  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3-$d_Beam1_1_12_3/2.]  ;# bottom right   ;
node 113202  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3               ]  ;# middle left    ;
node 113204  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3               ] ;# middle right   ;
node 113207  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.] ;# top left       ;
node 113208  [expr $Axis2-$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top left       ;
node 113209  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top right      ;
node 113210  [expr $Axis2+$d_Col1_23_2_t/2.               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top right      ;
node 013203  [expr $Axis2                               ] [expr $Floor3+$d_Beam1_1_12_3/2.]  ;# top middle     ;
node 11322   [expr $Axis2-$d_Col1_23_2_t/2.-$H_offset               ] [expr $Floor3               ]  ;# WUF-Wleft ;
node 11324   [expr $Axis2+$d_Col1_23_2_t/2.+$H_offset               ] [expr $Floor3               ] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-4;
node 014201  [expr $Axis2                               ] [expr $Floor4-$d_Beam1_1_12_4/2.] ;# bottom middle  ;
node 114205  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom left    ;
node 114206  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom left    ;
node 114212  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.] ;# bottom right   ;
node 114211  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4-$d_Beam1_1_12_4/2.]  ;# bottom right   ;
node 114202  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4               ]  ;# middle left    ;
node 114204  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4               ] ;# middle right   ;
node 114207  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.] ;# top left       ;
node 114208  [expr $Axis2-$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top left       ;
node 114209  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top right      ;
node 114210  [expr $Axis2+$d_Col1_34_2_t/2.               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top right      ;
node 014203  [expr $Axis2                               ] [expr $Floor4+$d_Beam1_1_12_4/2.]  ;# top middle     ;
node 11422   [expr $Axis2-$d_Col1_34_2_t/2.-$H_offset               ] [expr $Floor4               ]  ;# WUF-Wleft ;
node 11424   [expr $Axis2+$d_Col1_34_2_t/2.+$H_offset               ] [expr $Floor4               ] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-2, FLOOR-5;
node 015201  [expr $Axis2                               ] [expr $Floor5-$d_Beam1_1_12_5/2.] ;# bottom middle  ;
node 115205  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom left    ;
node 115206  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom left    ;
node 115212  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.] ;# bottom right   ;
node 115211  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5-$d_Beam1_1_12_5/2.]  ;# bottom right   ;
node 115202  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5               ]  ;# middle left    ;
node 115204  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5               ] ;# middle right   ;
node 115207  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.] ;# top left       ;
node 115208  [expr $Axis2-$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top left       ;
node 115209  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top right      ;
node 115210  [expr $Axis2+$d_Col1_45_2_t/2.               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top right      ;
node 015203  [expr $Axis2                               ] [expr $Floor5+$d_Beam1_1_12_5/2.]  ;# top middle     ;
node 11522   [expr $Axis2-$d_Col1_45_2_t/2.-$H_offset               ] [expr $Floor5               ]  ;# WUF-Wleft ;
node 11524   [expr $Axis2+$d_Col1_45_2_t/2.+$H_offset               ] [expr $Floor5               ] ;# WUF-Wright;

#Direction-1, Depth-1 AXIS-3, FLOOR-2;
node 012301  [expr $Axis3                               ] [expr $Floor2-$d_Beam1_1_23_2/2.] ;# bottom middle  ;
node 112305  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.]  ;# bottom left    ;
node 112306  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.]  ;# bottom left    ;
node 112312  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.] ;# bottom right   ;
node 112311  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2-$d_Beam1_1_23_2/2.]  ;# bottom right   ;
node 112302  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2               ]  ;# middle left    ;
node 112304  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2               ] ;# middle right   ;
node 112307  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.] ;# top left       ;
node 112308  [expr $Axis3-$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.]  ;# top left       ;
node 112309  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.]  ;# top right      ;
node 112310  [expr $Axis3+$d_Col1_12_3_t/2.               ] [expr $Floor2+$d_Beam1_1_23_2/2.]  ;# top right      ;
node 012303  [expr $Axis3                               ] [expr $Floor2+$d_Beam1_1_23_2/2.]  ;# top middle     ;
node 11232   [expr $Axis3-$d_Col1_12_3_t/2.-$H_offset               ] [expr $Floor2               ]  ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-3;
node 013301  [expr $Axis3                               ] [expr $Floor3-$d_Beam1_1_23_3/2.] ;# bottom middle  ;
node 113305  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.]  ;# bottom left    ;
node 113306  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.]  ;# bottom left    ;
node 113312  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.] ;# bottom right   ;
node 113311  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3-$d_Beam1_1_23_3/2.]  ;# bottom right   ;
node 113302  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3               ]  ;# middle left    ;
node 113304  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3               ] ;# middle right   ;
node 113307  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.] ;# top left       ;
node 113308  [expr $Axis3-$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.]  ;# top left       ;
node 113309  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.]  ;# top right      ;
node 113310  [expr $Axis3+$d_Col1_23_3_t/2.               ] [expr $Floor3+$d_Beam1_1_23_3/2.]  ;# top right      ;
node 013303  [expr $Axis3                               ] [expr $Floor3+$d_Beam1_1_23_3/2.]  ;# top middle     ;
node 11332   [expr $Axis3-$d_Col1_23_3_t/2.-$H_offset               ] [expr $Floor3               ]  ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-4;
node 014301  [expr $Axis3                               ] [expr $Floor4-$d_Beam1_1_23_4/2.] ;# bottom middle  ;
node 114305  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.]  ;# bottom left    ;
node 114306  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.]  ;# bottom left    ;
node 114312  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.] ;# bottom right   ;
node 114311  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4-$d_Beam1_1_23_4/2.]  ;# bottom right   ;
node 114302  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4               ]  ;# middle left    ;
node 114304  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4               ] ;# middle right   ;
node 114307  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.] ;# top left       ;
node 114308  [expr $Axis3-$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.]  ;# top left       ;
node 114309  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.]  ;# top right      ;
node 114310  [expr $Axis3+$d_Col1_34_3_t/2.               ] [expr $Floor4+$d_Beam1_1_23_4/2.]  ;# top right      ;
node 014303  [expr $Axis3                               ] [expr $Floor4+$d_Beam1_1_23_4/2.]  ;# top middle     ;
node 11432   [expr $Axis3-$d_Col1_34_3_t/2.-$H_offset               ] [expr $Floor4               ]  ;# WUF-Wleft ;

#Direction-1, Depth-1 AXIS-3, FLOOR-5;
node 015301  [expr $Axis3                               ] [expr $Floor5-$d_Beam1_1_23_5/2.] ;# bottom middle  ;
node 115305  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.]  ;# bottom left    ;
node 115306  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.]  ;# bottom left    ;
node 115312  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.] ;# bottom right   ;
node 115311  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5-$d_Beam1_1_23_5/2.]  ;# bottom right   ;
node 115302  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5               ]  ;# middle left    ;
node 115304  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5               ] ;# middle right   ;
node 115307  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.] ;# top left       ;
node 115308  [expr $Axis3-$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.]  ;# top left       ;
node 115309  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.]  ;# top right      ;
node 115310  [expr $Axis3+$d_Col1_45_3_t/2.               ] [expr $Floor5+$d_Beam1_1_23_5/2.]  ;# top right      ;
node 015303  [expr $Axis3                               ] [expr $Floor5+$d_Beam1_1_23_5/2.]  ;# top middle     ;
node 11532   [expr $Axis3-$d_Col1_45_3_t/2.-$H_offset               ] [expr $Floor5               ]  ;# WUF-Wleft ;


set K44_two 2.0625;
set K11_two 3.9375;
set K33_two 3.9375;
set K44_one 1.9355;
set K11_one 3.9375;
set K33_one 3.8710;

uniaxialMaterial Elastic 555 [expr 10009999.*$E];
uniaxialMaterial Elastic 556 [expr 999999999999999999.];
uniaxialMaterial Elastic 666 [expr 0.0001];
set A_pz_rigid 10547290000.0000;
set I_pz_rigid 51506823512.8888;

# Spring Elements in X direction;
# DirectionDepthFloorAxis = 1121;
# Panel Rigid Link;
element elasticBeamColumn 100112101 112105 012101 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112108 012101 112112 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112107 112111 112104 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112106 112104 112110 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112105 112109 012103 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112104 012103 112108 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112103 112107 112102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112102 112106 112102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112105 112106 1 2;
equalDOF 112112 112111 1 2;
equalDOF 112110 112109 1 2;
equalDOF 112107 112108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112100 $M1C_Panel1_1_2_1 $Gamma_1_Panel1_1_2_1 $M4C_Panel1_1_2_1 $Gamma_4_Panel1_1_2_1 $M6C_Panel1_1_2_1 $Gamma_6_Panel1_1_2_1 -$M1_Panel1_1_2_1 -$Gamma_1_Panel1_1_2_1 -$M4_Panel1_1_2_1 -$Gamma_4_Panel1_1_2_1 -$M6_Panel1_1_2_1 -$Gamma_6_Panel1_1_2_1 0.25 0.75 0 0 0;
element zeroLength          100112100  112109 112110 -mat 100112100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1121400 $K_s_Beam1_1_12_2 $Alpha_s_Beam1_1_12_2 $Alpha_s_BeamComp1_1_12_2 $My_s_Beam1_1_12_2 -$My_s_BeamComp1_1_12_2  $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_2  $Theta_p_s_BeamComp1_1_12_2  $Theta_pc_s_Beam1_1_12_2  $Theta_pc_s_BeamComp1_1_12_2  $Res_s_Beam1_1_12_2  $Res_s_BeamComp1_1_12_2  $Theta_ult_s_Beam1_1_12_2  $Theta_ult_s_BeamComp1_1_12_2  1. 1.15;
element     zeroLength 1121400 11214 112104 -mat 1121400 -dir 6;
equalDOF                     11214 112104 1 2;

# DirectionDepthFloorAxis = 1131;
# Panel Rigid Link;
element elasticBeamColumn 100113101 113105 013101 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113108 013101 113112 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113107 113111 113104 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113106 113104 113110 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113105 113109 013103 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113104 013103 113108 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113103 113107 113102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113102 113106 113102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113105 113106 1 2;
equalDOF 113112 113111 1 2;
equalDOF 113110 113109 1 2;
equalDOF 113107 113108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113100 $M1C_Panel1_1_3_1 $Gamma_1_Panel1_1_3_1 $M4C_Panel1_1_3_1 $Gamma_4_Panel1_1_3_1 $M6C_Panel1_1_3_1 $Gamma_6_Panel1_1_3_1 -$M1_Panel1_1_3_1 -$Gamma_1_Panel1_1_3_1 -$M4_Panel1_1_3_1 -$Gamma_4_Panel1_1_3_1 -$M6_Panel1_1_3_1 -$Gamma_6_Panel1_1_3_1 0.25 0.75 0 0 0;
element zeroLength          100113100  113109 113110 -mat 100113100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1131400 $K_s_Beam1_1_12_3 $Alpha_s_Beam1_1_12_3 $Alpha_s_BeamComp1_1_12_3 $My_s_Beam1_1_12_3 -$My_s_BeamComp1_1_12_3  $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_3  $Theta_p_s_BeamComp1_1_12_3  $Theta_pc_s_Beam1_1_12_3  $Theta_pc_s_BeamComp1_1_12_3  $Res_s_Beam1_1_12_3  $Res_s_BeamComp1_1_12_3  $Theta_ult_s_Beam1_1_12_3  $Theta_ult_s_BeamComp1_1_12_3  1. 1.15;
element     zeroLength 1131400 11314 113104 -mat 1131400 -dir 6;
equalDOF                     11314 113104 1 2;

# DirectionDepthFloorAxis = 1141;
# Panel Rigid Link;
element elasticBeamColumn 100114101 114105 014101 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114108 014101 114112 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114107 114111 114104 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114106 114104 114110 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114105 114109 014103 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114104 014103 114108 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114103 114107 114102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114102 114106 114102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114105 114106 1 2;
equalDOF 114112 114111 1 2;
equalDOF 114110 114109 1 2;
equalDOF 114107 114108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114100 $M1C_Panel1_1_4_1 $Gamma_1_Panel1_1_4_1 $M4C_Panel1_1_4_1 $Gamma_4_Panel1_1_4_1 $M6C_Panel1_1_4_1 $Gamma_6_Panel1_1_4_1 -$M1_Panel1_1_4_1 -$Gamma_1_Panel1_1_4_1 -$M4_Panel1_1_4_1 -$Gamma_4_Panel1_1_4_1 -$M6_Panel1_1_4_1 -$Gamma_6_Panel1_1_4_1 0.25 0.75 0 0 0;
element zeroLength          100114100  114109 114110 -mat 100114100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1141400 $K_s_Beam1_1_12_4 $Alpha_s_Beam1_1_12_4 $Alpha_s_BeamComp1_1_12_4 $My_s_Beam1_1_12_4 -$My_s_BeamComp1_1_12_4  $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_4  $Theta_p_s_BeamComp1_1_12_4  $Theta_pc_s_Beam1_1_12_4  $Theta_pc_s_BeamComp1_1_12_4  $Res_s_Beam1_1_12_4  $Res_s_BeamComp1_1_12_4  $Theta_ult_s_Beam1_1_12_4  $Theta_ult_s_BeamComp1_1_12_4  1. 1.15;
element     zeroLength 1141400 11414 114104 -mat 1141400 -dir 6;
equalDOF                     11414 114104 1 2;

# DirectionDepthFloorAxis = 1151;
# Panel Rigid Link;
element elasticBeamColumn 100115101 115105 015101 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115108 015101 115112 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115107 115111 115104 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115106 115104 115110 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115105 115109 015103 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115104 015103 115108 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115103 115107 115102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115102 115106 115102 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115105 115106 1 2;
equalDOF 115112 115111 1 2;
equalDOF 115110 115109 1 2;
equalDOF 115107 115108 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115100 $M1C_Panel1_1_5_1 $Gamma_1_Panel1_1_5_1 $M4C_Panel1_1_5_1 $Gamma_4_Panel1_1_5_1 $M6C_Panel1_1_5_1 $Gamma_6_Panel1_1_5_1 -$M1_Panel1_1_5_1 -$Gamma_1_Panel1_1_5_1 -$M4_Panel1_1_5_1 -$Gamma_4_Panel1_1_5_1 -$M6_Panel1_1_5_1 -$Gamma_6_Panel1_1_5_1 0.25 0.75 0 0 0;
element zeroLength          100115100  115109 115110 -mat 100115100 -dir 6;
# IMK Hinges;
# Right WUF-W;
uniaxialMaterial Bilin 1151400 $K_s_Beam1_1_12_5 $Alpha_s_Beam1_1_12_5 $Alpha_s_BeamComp1_1_12_5 $My_s_Beam1_1_12_5 -$My_s_BeamComp1_1_12_5  $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 1. 1. 1. 1.  $Theta_p_s_Beam1_1_12_5  $Theta_p_s_BeamComp1_1_12_5  $Theta_pc_s_Beam1_1_12_5  $Theta_pc_s_BeamComp1_1_12_5  $Res_s_Beam1_1_12_5  $Res_s_BeamComp1_1_12_5  $Theta_ult_s_Beam1_1_12_5  $Theta_ult_s_BeamComp1_1_12_5  1. 1.15;
element     zeroLength 1151400 11514 115104 -mat 1151400 -dir 6;
equalDOF                     11514 115104 1 2;

# DirectionDepthFloorAxis = 1122;
# Panel Rigid Link;
element elasticBeamColumn 100112201 112205 012201 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112208 012201 112212 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112207 112211 112204 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112206 112204 112210 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112205 112209 012203 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112204 012203 112208 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112203 112207 112202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112202 112206 112202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112205 112206 1 2;
equalDOF 112212 112211 1 2;
equalDOF 112210 112209 1 2;
equalDOF 112207 112208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112200 $M1C_Panel1_1_2_2 $Gamma_1_Panel1_1_2_2 $M4C_Panel1_1_2_2 $Gamma_4_Panel1_1_2_2 $M6C_Panel1_1_2_2 $Gamma_6_Panel1_1_2_2 -$M1C_Panel1_1_2_2 -$Gamma_1_Panel1_1_2_2 -$M4C_Panel1_1_2_2 -$Gamma_4_Panel1_1_2_2 -$M6C_Panel1_1_2_2 -$Gamma_6_Panel1_1_2_2 0.25 0.75 0 0 0;
element zeroLength          100112200  112209 112210 -mat 100112200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1122200 $K_s_Beam1_1_12_2 $Alpha_s_BeamComp1_1_12_2 $Alpha_s_Beam1_1_12_2 $My_s_BeamComp1_1_12_2 -$My_s_Beam1_1_12_2  $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 $Lambda_Beam1_1_12_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_2  $Theta_p_s_Beam1_1_12_2  $Theta_pc_s_BeamComp1_1_12_2  $Theta_pc_s_Beam1_1_12_2  $Res_s_BeamComp1_1_12_2  $Res_s_Beam1_1_12_2  $Theta_ult_s_BeamComp1_1_12_2  $Theta_ult_s_Beam1_1_12_2  1.15 1.;
element     zeroLength 1122200 11222 112202 -mat 1122200 -dir 6;
equalDOF                     11222 112202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 1122400 $K_s_Beam1_1_23_2 $Alpha_s_Beam1_1_23_2 $Alpha_s_BeamComp1_1_23_2 $My_s_Beam1_1_23_2 -$My_s_BeamComp1_1_23_2  $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_2  $Theta_p_s_BeamComp1_1_23_2  $Theta_pc_s_Beam1_1_23_2  $Theta_pc_s_BeamComp1_1_23_2  $Res_s_Beam1_1_23_2  $Res_s_BeamComp1_1_23_2  $Theta_ult_s_Beam1_1_23_2  $Theta_ult_s_BeamComp1_1_23_2  1. 1.15;
element     zeroLength 1122400 11224 112204 -mat 1122400 -dir 6;
equalDOF                     11224 112204 1 2;

# DirectionDepthFloorAxis = 1132;
# Panel Rigid Link;
element elasticBeamColumn 100113201 113205 013201 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113208 013201 113212 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113207 113211 113204 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113206 113204 113210 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113205 113209 013203 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113204 013203 113208 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113203 113207 113202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113202 113206 113202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113205 113206 1 2;
equalDOF 113212 113211 1 2;
equalDOF 113210 113209 1 2;
equalDOF 113207 113208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113200 $M1C_Panel1_1_3_2 $Gamma_1_Panel1_1_3_2 $M4C_Panel1_1_3_2 $Gamma_4_Panel1_1_3_2 $M6C_Panel1_1_3_2 $Gamma_6_Panel1_1_3_2 -$M1C_Panel1_1_3_2 -$Gamma_1_Panel1_1_3_2 -$M4C_Panel1_1_3_2 -$Gamma_4_Panel1_1_3_2 -$M6C_Panel1_1_3_2 -$Gamma_6_Panel1_1_3_2 0.25 0.75 0 0 0;
element zeroLength          100113200  113209 113210 -mat 100113200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1132200 $K_s_Beam1_1_12_3 $Alpha_s_BeamComp1_1_12_3 $Alpha_s_Beam1_1_12_3 $My_s_BeamComp1_1_12_3 -$My_s_Beam1_1_12_3  $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 $Lambda_Beam1_1_12_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_3  $Theta_p_s_Beam1_1_12_3  $Theta_pc_s_BeamComp1_1_12_3  $Theta_pc_s_Beam1_1_12_3  $Res_s_BeamComp1_1_12_3  $Res_s_Beam1_1_12_3  $Theta_ult_s_BeamComp1_1_12_3  $Theta_ult_s_Beam1_1_12_3  1.15 1.;
element     zeroLength 1132200 11322 113202 -mat 1132200 -dir 6;
equalDOF                     11322 113202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 1132400 $K_s_Beam1_1_23_3 $Alpha_s_Beam1_1_23_3 $Alpha_s_BeamComp1_1_23_3 $My_s_Beam1_1_23_3 -$My_s_BeamComp1_1_23_3  $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_3  $Theta_p_s_BeamComp1_1_23_3  $Theta_pc_s_Beam1_1_23_3  $Theta_pc_s_BeamComp1_1_23_3  $Res_s_Beam1_1_23_3  $Res_s_BeamComp1_1_23_3  $Theta_ult_s_Beam1_1_23_3  $Theta_ult_s_BeamComp1_1_23_3  1. 1.15;
element     zeroLength 1132400 11324 113204 -mat 1132400 -dir 6;
equalDOF                     11324 113204 1 2;

# DirectionDepthFloorAxis = 1142;
# Panel Rigid Link;
element elasticBeamColumn 100114201 114205 014201 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114208 014201 114212 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114207 114211 114204 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114206 114204 114210 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114205 114209 014203 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114204 014203 114208 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114203 114207 114202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114202 114206 114202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114205 114206 1 2;
equalDOF 114212 114211 1 2;
equalDOF 114210 114209 1 2;
equalDOF 114207 114208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114200 $M1C_Panel1_1_4_2 $Gamma_1_Panel1_1_4_2 $M4C_Panel1_1_4_2 $Gamma_4_Panel1_1_4_2 $M6C_Panel1_1_4_2 $Gamma_6_Panel1_1_4_2 -$M1C_Panel1_1_4_2 -$Gamma_1_Panel1_1_4_2 -$M4C_Panel1_1_4_2 -$Gamma_4_Panel1_1_4_2 -$M6C_Panel1_1_4_2 -$Gamma_6_Panel1_1_4_2 0.25 0.75 0 0 0;
element zeroLength          100114200  114209 114210 -mat 100114200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1142200 $K_s_Beam1_1_12_4 $Alpha_s_BeamComp1_1_12_4 $Alpha_s_Beam1_1_12_4 $My_s_BeamComp1_1_12_4 -$My_s_Beam1_1_12_4  $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 $Lambda_Beam1_1_12_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_4  $Theta_p_s_Beam1_1_12_4  $Theta_pc_s_BeamComp1_1_12_4  $Theta_pc_s_Beam1_1_12_4  $Res_s_BeamComp1_1_12_4  $Res_s_Beam1_1_12_4  $Theta_ult_s_BeamComp1_1_12_4  $Theta_ult_s_Beam1_1_12_4  1.15 1.;
element     zeroLength 1142200 11422 114202 -mat 1142200 -dir 6;
equalDOF                     11422 114202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 1142400 $K_s_Beam1_1_23_4 $Alpha_s_Beam1_1_23_4 $Alpha_s_BeamComp1_1_23_4 $My_s_Beam1_1_23_4 -$My_s_BeamComp1_1_23_4  $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_4  $Theta_p_s_BeamComp1_1_23_4  $Theta_pc_s_Beam1_1_23_4  $Theta_pc_s_BeamComp1_1_23_4  $Res_s_Beam1_1_23_4  $Res_s_BeamComp1_1_23_4  $Theta_ult_s_Beam1_1_23_4  $Theta_ult_s_BeamComp1_1_23_4  1. 1.15;
element     zeroLength 1142400 11424 114204 -mat 1142400 -dir 6;
equalDOF                     11424 114204 1 2;

# DirectionDepthFloorAxis = 1152;
# Panel Rigid Link;
element elasticBeamColumn 100115201 115205 015201 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115208 015201 115212 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115207 115211 115204 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115206 115204 115210 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115205 115209 015203 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115204 015203 115208 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115203 115207 115202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115202 115206 115202 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115205 115206 1 2;
equalDOF 115212 115211 1 2;
equalDOF 115210 115209 1 2;
equalDOF 115207 115208 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115200 $M1C_Panel1_1_5_2 $Gamma_1_Panel1_1_5_2 $M4C_Panel1_1_5_2 $Gamma_4_Panel1_1_5_2 $M6C_Panel1_1_5_2 $Gamma_6_Panel1_1_5_2 -$M1C_Panel1_1_5_2 -$Gamma_1_Panel1_1_5_2 -$M4C_Panel1_1_5_2 -$Gamma_4_Panel1_1_5_2 -$M6C_Panel1_1_5_2 -$Gamma_6_Panel1_1_5_2 0.25 0.75 0 0 0;
element zeroLength          100115200  115209 115210 -mat 100115200 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1152200 $K_s_Beam1_1_12_5 $Alpha_s_BeamComp1_1_12_5 $Alpha_s_Beam1_1_12_5 $My_s_BeamComp1_1_12_5 -$My_s_Beam1_1_12_5  $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 $Lambda_Beam1_1_12_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_12_5  $Theta_p_s_Beam1_1_12_5  $Theta_pc_s_BeamComp1_1_12_5  $Theta_pc_s_Beam1_1_12_5  $Res_s_BeamComp1_1_12_5  $Res_s_Beam1_1_12_5  $Theta_ult_s_BeamComp1_1_12_5  $Theta_ult_s_Beam1_1_12_5  1.15 1.;
element     zeroLength 1152200 11522 115202 -mat 1152200 -dir 6;
equalDOF                     11522 115202 1 2;
# Right WUF-W;
uniaxialMaterial Bilin 1152400 $K_s_Beam1_1_23_5 $Alpha_s_Beam1_1_23_5 $Alpha_s_BeamComp1_1_23_5 $My_s_Beam1_1_23_5 -$My_s_BeamComp1_1_23_5  $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 1. 1. 1. 1.  $Theta_p_s_Beam1_1_23_5  $Theta_p_s_BeamComp1_1_23_5  $Theta_pc_s_Beam1_1_23_5  $Theta_pc_s_BeamComp1_1_23_5  $Res_s_Beam1_1_23_5  $Res_s_BeamComp1_1_23_5  $Theta_ult_s_Beam1_1_23_5  $Theta_ult_s_BeamComp1_1_23_5  1. 1.15;
element     zeroLength 1152400 11524 115204 -mat 1152400 -dir 6;
equalDOF                     11524 115204 1 2;

# DirectionDepthFloorAxis = 1123;
# Panel Rigid Link;
element elasticBeamColumn 100112301 112305 012301 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112308 012301 112312 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112307 112311 112304 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112306 112304 112310 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112305 112309 012303 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112304 012303 112308 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112303 112307 112302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100112302 112306 112302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 112305 112306 1 2;
equalDOF 112312 112311 1 2;
equalDOF 112310 112309 1 2;
equalDOF 112307 112308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100112300 $M1_Panel1_1_2_3 $Gamma_1_Panel1_1_2_3 $M4_Panel1_1_2_3 $Gamma_4_Panel1_1_2_3 $M6_Panel1_1_2_3 $Gamma_6_Panel1_1_2_3 -$M1C_Panel1_1_2_3 -$Gamma_1_Panel1_1_2_3 -$M4C_Panel1_1_2_3 -$Gamma_4_Panel1_1_2_3 -$M6C_Panel1_1_2_3 -$Gamma_6_Panel1_1_2_3 0.25 0.75 0 0 0;
element zeroLength          100112300  112309 112310 -mat 100112300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1123200 $K_s_Beam1_1_23_2 $Alpha_s_BeamComp1_1_23_2 $Alpha_s_Beam1_1_23_2 $My_s_BeamComp1_1_23_2 -$My_s_Beam1_1_23_2  $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 $Lambda_Beam1_1_23_2 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_2  $Theta_p_s_Beam1_1_23_2  $Theta_pc_s_BeamComp1_1_23_2  $Theta_pc_s_Beam1_1_23_2  $Res_s_BeamComp1_1_23_2  $Res_s_Beam1_1_23_2  $Theta_ult_s_BeamComp1_1_23_2  $Theta_ult_s_Beam1_1_23_2  1.15 1.;
element     zeroLength 1123200 11232 112302 -mat 1123200 -dir 6;
equalDOF                     11232 112302 1 2;

# DirectionDepthFloorAxis = 1133;
# Panel Rigid Link;
element elasticBeamColumn 100113301 113305 013301 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113308 013301 113312 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113307 113311 113304 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113306 113304 113310 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113305 113309 013303 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113304 013303 113308 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113303 113307 113302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100113302 113306 113302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 113305 113306 1 2;
equalDOF 113312 113311 1 2;
equalDOF 113310 113309 1 2;
equalDOF 113307 113308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100113300 $M1_Panel1_1_3_3 $Gamma_1_Panel1_1_3_3 $M4_Panel1_1_3_3 $Gamma_4_Panel1_1_3_3 $M6_Panel1_1_3_3 $Gamma_6_Panel1_1_3_3 -$M1C_Panel1_1_3_3 -$Gamma_1_Panel1_1_3_3 -$M4C_Panel1_1_3_3 -$Gamma_4_Panel1_1_3_3 -$M6C_Panel1_1_3_3 -$Gamma_6_Panel1_1_3_3 0.25 0.75 0 0 0;
element zeroLength          100113300  113309 113310 -mat 100113300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1133200 $K_s_Beam1_1_23_3 $Alpha_s_BeamComp1_1_23_3 $Alpha_s_Beam1_1_23_3 $My_s_BeamComp1_1_23_3 -$My_s_Beam1_1_23_3  $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 $Lambda_Beam1_1_23_3 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_3  $Theta_p_s_Beam1_1_23_3  $Theta_pc_s_BeamComp1_1_23_3  $Theta_pc_s_Beam1_1_23_3  $Res_s_BeamComp1_1_23_3  $Res_s_Beam1_1_23_3  $Theta_ult_s_BeamComp1_1_23_3  $Theta_ult_s_Beam1_1_23_3  1.15 1.;
element     zeroLength 1133200 11332 113302 -mat 1133200 -dir 6;
equalDOF                     11332 113302 1 2;

# DirectionDepthFloorAxis = 1143;
# Panel Rigid Link;
element elasticBeamColumn 100114301 114305 014301 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114308 014301 114312 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114307 114311 114304 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114306 114304 114310 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114305 114309 014303 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114304 014303 114308 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114303 114307 114302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100114302 114306 114302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 114305 114306 1 2;
equalDOF 114312 114311 1 2;
equalDOF 114310 114309 1 2;
equalDOF 114307 114308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100114300 $M1_Panel1_1_4_3 $Gamma_1_Panel1_1_4_3 $M4_Panel1_1_4_3 $Gamma_4_Panel1_1_4_3 $M6_Panel1_1_4_3 $Gamma_6_Panel1_1_4_3 -$M1C_Panel1_1_4_3 -$Gamma_1_Panel1_1_4_3 -$M4C_Panel1_1_4_3 -$Gamma_4_Panel1_1_4_3 -$M6C_Panel1_1_4_3 -$Gamma_6_Panel1_1_4_3 0.25 0.75 0 0 0;
element zeroLength          100114300  114309 114310 -mat 100114300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1143200 $K_s_Beam1_1_23_4 $Alpha_s_BeamComp1_1_23_4 $Alpha_s_Beam1_1_23_4 $My_s_BeamComp1_1_23_4 -$My_s_Beam1_1_23_4  $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 $Lambda_Beam1_1_23_4 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_4  $Theta_p_s_Beam1_1_23_4  $Theta_pc_s_BeamComp1_1_23_4  $Theta_pc_s_Beam1_1_23_4  $Res_s_BeamComp1_1_23_4  $Res_s_Beam1_1_23_4  $Theta_ult_s_BeamComp1_1_23_4  $Theta_ult_s_Beam1_1_23_4  1.15 1.;
element     zeroLength 1143200 11432 114302 -mat 1143200 -dir 6;
equalDOF                     11432 114302 1 2;

# DirectionDepthFloorAxis = 1153;
# Panel Rigid Link;
element elasticBeamColumn 100115301 115305 015301 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115308 015301 115312 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115307 115311 115304 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115306 115304 115310 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115305 115309 015303 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115304 015303 115308 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115303 115307 115302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
element elasticBeamColumn 100115302 115306 115302 $A_pz_rigid $E $I_pz_rigid $BeamXDirTransfTag;
equalDOF 115305 115306 1 2;
equalDOF 115312 115311 1 2;
equalDOF 115310 115309 1 2;
equalDOF 115307 115308 1 2;
# Panel Rotational Spring;
uniaxialMaterial Hysteretic 100115300 $M1_Panel1_1_5_3 $Gamma_1_Panel1_1_5_3 $M4_Panel1_1_5_3 $Gamma_4_Panel1_1_5_3 $M6_Panel1_1_5_3 $Gamma_6_Panel1_1_5_3 -$M1C_Panel1_1_5_3 -$Gamma_1_Panel1_1_5_3 -$M4C_Panel1_1_5_3 -$Gamma_4_Panel1_1_5_3 -$M6C_Panel1_1_5_3 -$Gamma_6_Panel1_1_5_3 0.25 0.75 0 0 0;
element zeroLength          100115300  115309 115310 -mat 100115300 -dir 6;
# IMK Hinges;
# Left WUF-W;
uniaxialMaterial Bilin 1153200 $K_s_Beam1_1_23_5 $Alpha_s_BeamComp1_1_23_5 $Alpha_s_Beam1_1_23_5 $My_s_BeamComp1_1_23_5 -$My_s_Beam1_1_23_5  $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 $Lambda_Beam1_1_23_5 1. 1. 1. 1.  $Theta_p_s_BeamComp1_1_23_5  $Theta_p_s_Beam1_1_23_5  $Theta_pc_s_BeamComp1_1_23_5  $Theta_pc_s_Beam1_1_23_5  $Res_s_BeamComp1_1_23_5  $Res_s_Beam1_1_23_5  $Theta_ult_s_BeamComp1_1_23_5  $Theta_ult_s_Beam1_1_23_5  1.15 1.;
element     zeroLength 1153200 11532 115302 -mat 1153200 -dir 6;
equalDOF                     11532 115302 1 2;

# Gradient Element for Columns;

uniaxialMaterial CFSTsteel 1 205000.0 318.60 0.89 0.44 0.02 -351.27 22.18 -122.49 2.49 11.00 1.63 4.00 1.12 2.24 1.00 1.00 1.00 1.00 1.00 2 4144.00 113.50 1366.70 5.75 ; 

uniaxialMaterial CFSTsteel 2 205000.0 477.90 0.89 0.44 0.02 -498.84 22.18 -138.91 2.49 11.00 1.63 4.00 1.12 2.24 1.00 1.00 1.00 1.00 1.00 2 4144.00 113.50 1366.70 5.75 ; 

# Fiber section for HSS300x9 columns 
section Fiber 1  {; 
patch circ 2 2 1 0.0000 173.9483 18.0000 27.0000 0 90 ; 
patch circ 2 2 1 173.9483 0.0000 18.0000 27.0000 270 360; 
patch circ 2 2 1 0.0000 -173.9483 18.0000 27.0000 180 270; 
patch circ 2 2 1 -173.9483 0.0000 18.0000 27.0000 90 180; 

patch quad 1 1 10 186.6762 12.7279 193.0402 19.0919 19.0919 193.0402 12.7279 186.6762; 
patch quad 1 1 10 -19.0919 -193.0402 -12.7279 -186.6762 -186.6762 -12.7279 -193.0402 -19.0919; 

patch quad 1 10 1 19.0919 -193.0402 193.0402 -19.0919 186.6762 -12.7279 12.7279 -186.6762; 
patch quad 1 10 1 -186.6762 12.7279 -12.7279 186.6762 -19.0919 193.0402 -193.0402 19.0919; 
} 

# Depth-1 Story-1, Axis-1 Column;
element testNonlocalElementDH 011103012101 011103 012101 $ColTransfTag Simpson 1 23  20 0.00000001 300.00 
# Depth-1 Story-2, Axis-1 Column;
element testNonlocalElementDH 012103013101 012103 013101 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-3, Axis-1 Column;
element testNonlocalElementDH 013103014101 013103 014101 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-4, Axis-1 Column;
element testNonlocalElementDH 014103015101 014103 015101 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-1, Axis-2 Column;
element testNonlocalElementDH 011203012201 011203 012201 $ColTransfTag Simpson 1 23  20 0.00000001 300.00 
# Depth-1 Story-2, Axis-2 Column;
element testNonlocalElementDH 012203013201 012203 013201 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-3, Axis-2 Column;
element testNonlocalElementDH 013203014201 013203 014201 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-4, Axis-2 Column;
element testNonlocalElementDH 014203015201 014203 015201 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-1, Axis-3 Column;
element testNonlocalElementDH 011303012301 011303 012301 $ColTransfTag Simpson 1 23  20 0.00000001 300.00 
# Depth-1 Story-2, Axis-3 Column;
element testNonlocalElementDH 012303013301 012303 013301 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-3, Axis-3 Column;
element testNonlocalElementDH 013303014301 013303 014301 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 
# Depth-1 Story-4, Axis-3 Column;
element testNonlocalElementDH 014303015301 014303 015301 $ColTransfTag Simpson 1 9  20 0.00000001 300.00 

# Beam-column element for Beams G1;
# Direction-1 Depth-1 Span-1 Floor-2 Beam X direction;
element elasticBeamColumn  1121411222 11214 11222 $A_Beam1_1_12_2 $E [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_1_12_2] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-3 Beam X direction;
element elasticBeamColumn  1131411322 11314 11322 $A_Beam1_1_12_3 $E [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_1_12_3] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-4 Beam X direction;
element elasticBeamColumn  1141411422 11414 11422 $A_Beam1_1_12_4 $E [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_1_12_4] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-1 Floor-5 Beam X direction;
element elasticBeamColumn  1151411522 11514 11522 $A_Beam1_1_12_5 $E [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_1_12_5] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-2 Beam X direction;
element elasticBeamColumn  1122411232 11224 11232 $A_Beam1_1_23_2 $E [expr ($n_fac+1)/$n_fac*2.1958*$Ix_Beam1_1_23_2] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-3 Beam X direction;
element elasticBeamColumn  1132411332 11324 11332 $A_Beam1_1_23_3 $E [expr ($n_fac+1)/$n_fac*2.2013*$Ix_Beam1_1_23_3] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-4 Beam X direction;
element elasticBeamColumn  1142411432 11424 11432 $A_Beam1_1_23_4 $E [expr ($n_fac+1)/$n_fac*2.7195*$Ix_Beam1_1_23_4] $BeamXDirTransfTag;
# Direction-1 Depth-1 Span-2 Floor-5 Beam X direction;
element elasticBeamColumn  1152411532 11524 11532 $A_Beam1_1_23_5 $E [expr ($n_fac+1)/$n_fac*2.5790*$Ix_Beam1_1_23_5] $BeamXDirTransfTag;

# Floor movement / Rigid Diaphram
set RigidDiaphragm ON ;
set XMidSlab 5000.000000;
node 0020 $XMidSlab $Floor2 ;
node 0030 $XMidSlab $Floor3 ;
node 0040 $XMidSlab $Floor4 ;
node 0050 $XMidSlab $Floor5 ;
# Constraints for rigid diaphragm master nodes ;
fix  0020 0  1  1;
fix  0030 0  1  1;
fix  0040 0  1  1;
fix  0050 0  1  1;
# ------------------------define Rigid Diaphram, dof 2 is normal to floor ;
set motionDir 1 ;
rigidDiaphragm $motionDir 0020 112102 112104  112202 112204  112302 112304  ; #Storey 2 
rigidDiaphragm $motionDir 0030 113102 113104  113202 113204  113302 113304  ; #Storey 3 
rigidDiaphragm $motionDir 0040 114102 114104  114202 114204  114302 114304  ; #Storey 4 
rigidDiaphragm $motionDir 0050 115102 115104  115202 115204  115302 115304  ; #Storey 5 
mass 0020 24.77064220 1.e-10 1.e-10; #ton
mass 0030 23.90417941 1.e-10 1.e-10; #ton
mass 0040 24.56676860 1.e-10 1.e-10; #ton
mass 0050 28.79714577 1.e-10 1.e-10; #ton
# Create recorders;
# Floor Lateral Displacement in X direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_FloorDispX.txt  -time  -node 011103  011203  011303  112102  112202  112302  113102  113202  113302  114102  114202  114302  115102  115202  115302  -dof 1 disp;#Left middle of panel zone
# Column Displacement in Y direction (i.e. axial);
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_ColumnStorey1DispY.txt  -time  -node 012101  012201  012301  -dof 2 disp;#Column top node
# Column Displacement in X direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_ColumnStorey1DispX.txt  -time  -node 012101  012201  012301  -dof 1 disp;#Column top node
# Displacement of rigid diaphragm node in x direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_rigidDiaphragmDispX.txt  -time  -node 0020  0030  0040  0050  -dof 1 disp;#equal DOF master node
# Acceleration of equal DOF master node in x direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_rigidDiaphragmAccelX.txt  -time  -node 011103  0020  0030  0040  0050  -dof 1 accel;#equal DOF master node
# Reaction Forces  in X direction ;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_ReactionX.txt -time  -node 011103  011203  011303  -dof 1 reaction;
# Reaction Forces Vertical (Y) direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_ReactionY.txt -time  -node 011103  011203  011303  -dof 2 reaction;
# Reaction Forces Moment (Z) direction;
recorder Node -file $Result/2dModelYDir1dFiber_lc10D_ReactionMZ.txt -time  -node 011103  011203  011303  -dof 6 reaction;

recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY196Z-01IP.txt -ele 011103012101 section 1 fiber 196.45 -0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY196Z-01IP.txt -ele 011103012101 section 1 fiber 196.45 -0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY196Z-023IP.txt -ele 011103012101 section 23 fiber 196.45 -0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY196Z-023IP.txt -ele 011103012101 section 23 fiber 196.45 -0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY181Z251IP.txt -ele 011103012101 section 1 fiber 181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY181Z251IP.txt -ele 011103012101 section 1 fiber 181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY181Z2523IP.txt -ele 011103012101 section 23 fiber 181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY181Z2523IP.txt -ele 011103012101 section 23 fiber 181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY164Z421IP.txt -ele 011103012101 section 1 fiber 163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY164Z421IP.txt -ele 011103012101 section 1 fiber 163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY164Z4223IP.txt -ele 011103012101 section 23 fiber 163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY164Z4223IP.txt -ele 011103012101 section 23 fiber 163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY146Z591IP.txt -ele 011103012101 section 1 fiber 146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY146Z591IP.txt -ele 011103012101 section 1 fiber 146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY146Z5923IP.txt -ele 011103012101 section 23 fiber 146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY146Z5923IP.txt -ele 011103012101 section 23 fiber 146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY129Z771IP.txt -ele 011103012101 section 1 fiber 128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY129Z771IP.txt -ele 011103012101 section 1 fiber 128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY129Z7723IP.txt -ele 011103012101 section 23 fiber 128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY129Z7723IP.txt -ele 011103012101 section 23 fiber 128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY112Z941IP.txt -ele 011103012101 section 1 fiber 111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY112Z941IP.txt -ele 011103012101 section 1 fiber 111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY112Z9423IP.txt -ele 011103012101 section 23 fiber 111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY112Z9423IP.txt -ele 011103012101 section 23 fiber 111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY94Z1121IP.txt -ele 011103012101 section 1 fiber 94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY94Z1121IP.txt -ele 011103012101 section 1 fiber 94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY94Z11223IP.txt -ele 011103012101 section 23 fiber 94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY94Z11223IP.txt -ele 011103012101 section 23 fiber 94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY77Z1291IP.txt -ele 011103012101 section 1 fiber 76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY77Z1291IP.txt -ele 011103012101 section 1 fiber 76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY77Z12923IP.txt -ele 011103012101 section 23 fiber 76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY77Z12923IP.txt -ele 011103012101 section 23 fiber 76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY59Z1461IP.txt -ele 011103012101 section 1 fiber 59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY59Z1461IP.txt -ele 011103012101 section 1 fiber 59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY59Z14623IP.txt -ele 011103012101 section 23 fiber 59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY59Z14623IP.txt -ele 011103012101 section 23 fiber 59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY42Z1641IP.txt -ele 011103012101 section 1 fiber 42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY42Z1641IP.txt -ele 011103012101 section 1 fiber 42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY42Z16423IP.txt -ele 011103012101 section 23 fiber 42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY42Z16423IP.txt -ele 011103012101 section 23 fiber 42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY25Z1811IP.txt -ele 011103012101 section 1 fiber 24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY25Z1811IP.txt -ele 011103012101 section 1 fiber 24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY25Z18123IP.txt -ele 011103012101 section 23 fiber 24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY25Z18123IP.txt -ele 011103012101 section 23 fiber 24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-0Z1961IP.txt -ele 011103012101 section 1 fiber -0.00 196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-0Z1961IP.txt -ele 011103012101 section 1 fiber -0.00 196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-0Z19623IP.txt -ele 011103012101 section 23 fiber -0.00 196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-0Z19623IP.txt -ele 011103012101 section 23 fiber -0.00 196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-25Z1811IP.txt -ele 011103012101 section 1 fiber -24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-25Z1811IP.txt -ele 011103012101 section 1 fiber -24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-25Z18123IP.txt -ele 011103012101 section 23 fiber -24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-25Z18123IP.txt -ele 011103012101 section 23 fiber -24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-42Z1641IP.txt -ele 011103012101 section 1 fiber -42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-42Z1641IP.txt -ele 011103012101 section 1 fiber -42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-42Z16423IP.txt -ele 011103012101 section 23 fiber -42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-42Z16423IP.txt -ele 011103012101 section 23 fiber -42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-59Z1461IP.txt -ele 011103012101 section 1 fiber -59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-59Z1461IP.txt -ele 011103012101 section 1 fiber -59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-59Z14623IP.txt -ele 011103012101 section 23 fiber -59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-59Z14623IP.txt -ele 011103012101 section 23 fiber -59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-77Z1291IP.txt -ele 011103012101 section 1 fiber -76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-77Z1291IP.txt -ele 011103012101 section 1 fiber -76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-77Z12923IP.txt -ele 011103012101 section 23 fiber -76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-77Z12923IP.txt -ele 011103012101 section 23 fiber -76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-94Z1121IP.txt -ele 011103012101 section 1 fiber -94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-94Z1121IP.txt -ele 011103012101 section 1 fiber -94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-94Z11223IP.txt -ele 011103012101 section 23 fiber -94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-94Z11223IP.txt -ele 011103012101 section 23 fiber -94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-112Z941IP.txt -ele 011103012101 section 1 fiber -111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-112Z941IP.txt -ele 011103012101 section 1 fiber -111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-112Z9423IP.txt -ele 011103012101 section 23 fiber -111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-112Z9423IP.txt -ele 011103012101 section 23 fiber -111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-129Z771IP.txt -ele 011103012101 section 1 fiber -128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-129Z771IP.txt -ele 011103012101 section 1 fiber -128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-129Z7723IP.txt -ele 011103012101 section 23 fiber -128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-129Z7723IP.txt -ele 011103012101 section 23 fiber -128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-146Z591IP.txt -ele 011103012101 section 1 fiber -146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-146Z591IP.txt -ele 011103012101 section 1 fiber -146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-146Z5923IP.txt -ele 011103012101 section 23 fiber -146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-146Z5923IP.txt -ele 011103012101 section 23 fiber -146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-164Z421IP.txt -ele 011103012101 section 1 fiber -163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-164Z421IP.txt -ele 011103012101 section 1 fiber -163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-164Z4223IP.txt -ele 011103012101 section 23 fiber -163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-164Z4223IP.txt -ele 011103012101 section 23 fiber -163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-181Z251IP.txt -ele 011103012101 section 1 fiber -181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-181Z251IP.txt -ele 011103012101 section 1 fiber -181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-181Z2523IP.txt -ele 011103012101 section 23 fiber -181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-181Z2523IP.txt -ele 011103012101 section 23 fiber -181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-196Z01IP.txt -ele 011103012101 section 1 fiber -196.45 0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-196Z01IP.txt -ele 011103012101 section 1 fiber -196.45 0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-196Z023IP.txt -ele 011103012101 section 23 fiber -196.45 0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-196Z023IP.txt -ele 011103012101 section 23 fiber -196.45 0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-181Z-251IP.txt -ele 011103012101 section 1 fiber -181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-181Z-251IP.txt -ele 011103012101 section 1 fiber -181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-181Z-2523IP.txt -ele 011103012101 section 23 fiber -181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-181Z-2523IP.txt -ele 011103012101 section 23 fiber -181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-164Z-421IP.txt -ele 011103012101 section 1 fiber -163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-164Z-421IP.txt -ele 011103012101 section 1 fiber -163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-164Z-4223IP.txt -ele 011103012101 section 23 fiber -163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-164Z-4223IP.txt -ele 011103012101 section 23 fiber -163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-146Z-591IP.txt -ele 011103012101 section 1 fiber -146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-146Z-591IP.txt -ele 011103012101 section 1 fiber -146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-146Z-5923IP.txt -ele 011103012101 section 23 fiber -146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-146Z-5923IP.txt -ele 011103012101 section 23 fiber -146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-129Z-771IP.txt -ele 011103012101 section 1 fiber -128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-129Z-771IP.txt -ele 011103012101 section 1 fiber -128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-129Z-7723IP.txt -ele 011103012101 section 23 fiber -128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-129Z-7723IP.txt -ele 011103012101 section 23 fiber -128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-112Z-941IP.txt -ele 011103012101 section 1 fiber -111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-112Z-941IP.txt -ele 011103012101 section 1 fiber -111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-112Z-9423IP.txt -ele 011103012101 section 23 fiber -111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-112Z-9423IP.txt -ele 011103012101 section 23 fiber -111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-94Z-1121IP.txt -ele 011103012101 section 1 fiber -94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-94Z-1121IP.txt -ele 011103012101 section 1 fiber -94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-94Z-11223IP.txt -ele 011103012101 section 23 fiber -94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-94Z-11223IP.txt -ele 011103012101 section 23 fiber -94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-77Z-1291IP.txt -ele 011103012101 section 1 fiber -76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-77Z-1291IP.txt -ele 011103012101 section 1 fiber -76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-77Z-12923IP.txt -ele 011103012101 section 23 fiber -76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-77Z-12923IP.txt -ele 011103012101 section 23 fiber -76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-59Z-1461IP.txt -ele 011103012101 section 1 fiber -59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-59Z-1461IP.txt -ele 011103012101 section 1 fiber -59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-59Z-14623IP.txt -ele 011103012101 section 23 fiber -59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-59Z-14623IP.txt -ele 011103012101 section 23 fiber -59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-42Z-1641IP.txt -ele 011103012101 section 1 fiber -42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-42Z-1641IP.txt -ele 011103012101 section 1 fiber -42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-42Z-16423IP.txt -ele 011103012101 section 23 fiber -42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-42Z-16423IP.txt -ele 011103012101 section 23 fiber -42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-25Z-1811IP.txt -ele 011103012101 section 1 fiber -24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-25Z-1811IP.txt -ele 011103012101 section 1 fiber -24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY-25Z-18123IP.txt -ele 011103012101 section 23 fiber -24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY-25Z-18123IP.txt -ele 011103012101 section 23 fiber -24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY0Z-1961IP.txt -ele 011103012101 section 1 fiber 0.00 -196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY0Z-1961IP.txt -ele 011103012101 section 1 fiber 0.00 -196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY0Z-19623IP.txt -ele 011103012101 section 23 fiber 0.00 -196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY0Z-19623IP.txt -ele 011103012101 section 23 fiber 0.00 -196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY25Z-1811IP.txt -ele 011103012101 section 1 fiber 24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY25Z-1811IP.txt -ele 011103012101 section 1 fiber 24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY25Z-18123IP.txt -ele 011103012101 section 23 fiber 24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY25Z-18123IP.txt -ele 011103012101 section 23 fiber 24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY42Z-1641IP.txt -ele 011103012101 section 1 fiber 42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY42Z-1641IP.txt -ele 011103012101 section 1 fiber 42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY42Z-16423IP.txt -ele 011103012101 section 23 fiber 42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY42Z-16423IP.txt -ele 011103012101 section 23 fiber 42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY59Z-1461IP.txt -ele 011103012101 section 1 fiber 59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY59Z-1461IP.txt -ele 011103012101 section 1 fiber 59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY59Z-14623IP.txt -ele 011103012101 section 23 fiber 59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY59Z-14623IP.txt -ele 011103012101 section 23 fiber 59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY77Z-1291IP.txt -ele 011103012101 section 1 fiber 76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY77Z-1291IP.txt -ele 011103012101 section 1 fiber 76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY77Z-12923IP.txt -ele 011103012101 section 23 fiber 76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY77Z-12923IP.txt -ele 011103012101 section 23 fiber 76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY94Z-1121IP.txt -ele 011103012101 section 1 fiber 94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY94Z-1121IP.txt -ele 011103012101 section 1 fiber 94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY94Z-11223IP.txt -ele 011103012101 section 23 fiber 94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY94Z-11223IP.txt -ele 011103012101 section 23 fiber 94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY112Z-941IP.txt -ele 011103012101 section 1 fiber 111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY112Z-941IP.txt -ele 011103012101 section 1 fiber 111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY112Z-9423IP.txt -ele 011103012101 section 23 fiber 111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY112Z-9423IP.txt -ele 011103012101 section 23 fiber 111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY129Z-771IP.txt -ele 011103012101 section 1 fiber 128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY129Z-771IP.txt -ele 011103012101 section 1 fiber 128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY129Z-7723IP.txt -ele 011103012101 section 23 fiber 128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY129Z-7723IP.txt -ele 011103012101 section 23 fiber 128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY146Z-591IP.txt -ele 011103012101 section 1 fiber 146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY146Z-591IP.txt -ele 011103012101 section 1 fiber 146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY146Z-5923IP.txt -ele 011103012101 section 23 fiber 146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY146Z-5923IP.txt -ele 011103012101 section 23 fiber 146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY164Z-421IP.txt -ele 011103012101 section 1 fiber 163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY164Z-421IP.txt -ele 011103012101 section 1 fiber 163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY164Z-4223IP.txt -ele 011103012101 section 23 fiber 163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY164Z-4223IP.txt -ele 011103012101 section 23 fiber 163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY181Z-251IP.txt -ele 011103012101 section 1 fiber 181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY181Z-251IP.txt -ele 011103012101 section 1 fiber 181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_stressFiberY181Z-2523IP.txt -ele 011103012101 section 23 fiber 181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011103012101_strainFiberY181Z-2523IP.txt -ele 011103012101 section 23 fiber 181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY196Z-01IP.txt -ele 011203012201 section 1 fiber 196.45 -0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY196Z-01IP.txt -ele 011203012201 section 1 fiber 196.45 -0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY196Z-023IP.txt -ele 011203012201 section 23 fiber 196.45 -0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY196Z-023IP.txt -ele 011203012201 section 23 fiber 196.45 -0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY181Z251IP.txt -ele 011203012201 section 1 fiber 181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY181Z251IP.txt -ele 011203012201 section 1 fiber 181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY181Z2523IP.txt -ele 011203012201 section 23 fiber 181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY181Z2523IP.txt -ele 011203012201 section 23 fiber 181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY164Z421IP.txt -ele 011203012201 section 1 fiber 163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY164Z421IP.txt -ele 011203012201 section 1 fiber 163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY164Z4223IP.txt -ele 011203012201 section 23 fiber 163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY164Z4223IP.txt -ele 011203012201 section 23 fiber 163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY146Z591IP.txt -ele 011203012201 section 1 fiber 146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY146Z591IP.txt -ele 011203012201 section 1 fiber 146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY146Z5923IP.txt -ele 011203012201 section 23 fiber 146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY146Z5923IP.txt -ele 011203012201 section 23 fiber 146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY129Z771IP.txt -ele 011203012201 section 1 fiber 128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY129Z771IP.txt -ele 011203012201 section 1 fiber 128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY129Z7723IP.txt -ele 011203012201 section 23 fiber 128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY129Z7723IP.txt -ele 011203012201 section 23 fiber 128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY112Z941IP.txt -ele 011203012201 section 1 fiber 111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY112Z941IP.txt -ele 011203012201 section 1 fiber 111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY112Z9423IP.txt -ele 011203012201 section 23 fiber 111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY112Z9423IP.txt -ele 011203012201 section 23 fiber 111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY94Z1121IP.txt -ele 011203012201 section 1 fiber 94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY94Z1121IP.txt -ele 011203012201 section 1 fiber 94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY94Z11223IP.txt -ele 011203012201 section 23 fiber 94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY94Z11223IP.txt -ele 011203012201 section 23 fiber 94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY77Z1291IP.txt -ele 011203012201 section 1 fiber 76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY77Z1291IP.txt -ele 011203012201 section 1 fiber 76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY77Z12923IP.txt -ele 011203012201 section 23 fiber 76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY77Z12923IP.txt -ele 011203012201 section 23 fiber 76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY59Z1461IP.txt -ele 011203012201 section 1 fiber 59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY59Z1461IP.txt -ele 011203012201 section 1 fiber 59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY59Z14623IP.txt -ele 011203012201 section 23 fiber 59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY59Z14623IP.txt -ele 011203012201 section 23 fiber 59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY42Z1641IP.txt -ele 011203012201 section 1 fiber 42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY42Z1641IP.txt -ele 011203012201 section 1 fiber 42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY42Z16423IP.txt -ele 011203012201 section 23 fiber 42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY42Z16423IP.txt -ele 011203012201 section 23 fiber 42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY25Z1811IP.txt -ele 011203012201 section 1 fiber 24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY25Z1811IP.txt -ele 011203012201 section 1 fiber 24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY25Z18123IP.txt -ele 011203012201 section 23 fiber 24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY25Z18123IP.txt -ele 011203012201 section 23 fiber 24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-0Z1961IP.txt -ele 011203012201 section 1 fiber -0.00 196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-0Z1961IP.txt -ele 011203012201 section 1 fiber -0.00 196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-0Z19623IP.txt -ele 011203012201 section 23 fiber -0.00 196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-0Z19623IP.txt -ele 011203012201 section 23 fiber -0.00 196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-25Z1811IP.txt -ele 011203012201 section 1 fiber -24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-25Z1811IP.txt -ele 011203012201 section 1 fiber -24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-25Z18123IP.txt -ele 011203012201 section 23 fiber -24.61 181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-25Z18123IP.txt -ele 011203012201 section 23 fiber -24.61 181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-42Z1641IP.txt -ele 011203012201 section 1 fiber -42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-42Z1641IP.txt -ele 011203012201 section 1 fiber -42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-42Z16423IP.txt -ele 011203012201 section 23 fiber -42.00 163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-42Z16423IP.txt -ele 011203012201 section 23 fiber -42.00 163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-59Z1461IP.txt -ele 011203012201 section 1 fiber -59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-59Z1461IP.txt -ele 011203012201 section 1 fiber -59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-59Z14623IP.txt -ele 011203012201 section 23 fiber -59.40 146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-59Z14623IP.txt -ele 011203012201 section 23 fiber -59.40 146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-77Z1291IP.txt -ele 011203012201 section 1 fiber -76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-77Z1291IP.txt -ele 011203012201 section 1 fiber -76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-77Z12923IP.txt -ele 011203012201 section 23 fiber -76.79 128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-77Z12923IP.txt -ele 011203012201 section 23 fiber -76.79 128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-94Z1121IP.txt -ele 011203012201 section 1 fiber -94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-94Z1121IP.txt -ele 011203012201 section 1 fiber -94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-94Z11223IP.txt -ele 011203012201 section 23 fiber -94.19 111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-94Z11223IP.txt -ele 011203012201 section 23 fiber -94.19 111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-112Z941IP.txt -ele 011203012201 section 1 fiber -111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-112Z941IP.txt -ele 011203012201 section 1 fiber -111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-112Z9423IP.txt -ele 011203012201 section 23 fiber -111.58 94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-112Z9423IP.txt -ele 011203012201 section 23 fiber -111.58 94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-129Z771IP.txt -ele 011203012201 section 1 fiber -128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-129Z771IP.txt -ele 011203012201 section 1 fiber -128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-129Z7723IP.txt -ele 011203012201 section 23 fiber -128.98 76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-129Z7723IP.txt -ele 011203012201 section 23 fiber -128.98 76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-146Z591IP.txt -ele 011203012201 section 1 fiber -146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-146Z591IP.txt -ele 011203012201 section 1 fiber -146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-146Z5923IP.txt -ele 011203012201 section 23 fiber -146.37 59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-146Z5923IP.txt -ele 011203012201 section 23 fiber -146.37 59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-164Z421IP.txt -ele 011203012201 section 1 fiber -163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-164Z421IP.txt -ele 011203012201 section 1 fiber -163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-164Z4223IP.txt -ele 011203012201 section 23 fiber -163.77 42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-164Z4223IP.txt -ele 011203012201 section 23 fiber -163.77 42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-181Z251IP.txt -ele 011203012201 section 1 fiber -181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-181Z251IP.txt -ele 011203012201 section 1 fiber -181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-181Z2523IP.txt -ele 011203012201 section 23 fiber -181.16 24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-181Z2523IP.txt -ele 011203012201 section 23 fiber -181.16 24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-196Z01IP.txt -ele 011203012201 section 1 fiber -196.45 0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-196Z01IP.txt -ele 011203012201 section 1 fiber -196.45 0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-196Z023IP.txt -ele 011203012201 section 23 fiber -196.45 0.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-196Z023IP.txt -ele 011203012201 section 23 fiber -196.45 0.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-181Z-251IP.txt -ele 011203012201 section 1 fiber -181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-181Z-251IP.txt -ele 011203012201 section 1 fiber -181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-181Z-2523IP.txt -ele 011203012201 section 23 fiber -181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-181Z-2523IP.txt -ele 011203012201 section 23 fiber -181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-164Z-421IP.txt -ele 011203012201 section 1 fiber -163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-164Z-421IP.txt -ele 011203012201 section 1 fiber -163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-164Z-4223IP.txt -ele 011203012201 section 23 fiber -163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-164Z-4223IP.txt -ele 011203012201 section 23 fiber -163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-146Z-591IP.txt -ele 011203012201 section 1 fiber -146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-146Z-591IP.txt -ele 011203012201 section 1 fiber -146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-146Z-5923IP.txt -ele 011203012201 section 23 fiber -146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-146Z-5923IP.txt -ele 011203012201 section 23 fiber -146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-129Z-771IP.txt -ele 011203012201 section 1 fiber -128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-129Z-771IP.txt -ele 011203012201 section 1 fiber -128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-129Z-7723IP.txt -ele 011203012201 section 23 fiber -128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-129Z-7723IP.txt -ele 011203012201 section 23 fiber -128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-112Z-941IP.txt -ele 011203012201 section 1 fiber -111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-112Z-941IP.txt -ele 011203012201 section 1 fiber -111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-112Z-9423IP.txt -ele 011203012201 section 23 fiber -111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-112Z-9423IP.txt -ele 011203012201 section 23 fiber -111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-94Z-1121IP.txt -ele 011203012201 section 1 fiber -94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-94Z-1121IP.txt -ele 011203012201 section 1 fiber -94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-94Z-11223IP.txt -ele 011203012201 section 23 fiber -94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-94Z-11223IP.txt -ele 011203012201 section 23 fiber -94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-77Z-1291IP.txt -ele 011203012201 section 1 fiber -76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-77Z-1291IP.txt -ele 011203012201 section 1 fiber -76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-77Z-12923IP.txt -ele 011203012201 section 23 fiber -76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-77Z-12923IP.txt -ele 011203012201 section 23 fiber -76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-59Z-1461IP.txt -ele 011203012201 section 1 fiber -59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-59Z-1461IP.txt -ele 011203012201 section 1 fiber -59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-59Z-14623IP.txt -ele 011203012201 section 23 fiber -59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-59Z-14623IP.txt -ele 011203012201 section 23 fiber -59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-42Z-1641IP.txt -ele 011203012201 section 1 fiber -42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-42Z-1641IP.txt -ele 011203012201 section 1 fiber -42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-42Z-16423IP.txt -ele 011203012201 section 23 fiber -42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-42Z-16423IP.txt -ele 011203012201 section 23 fiber -42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-25Z-1811IP.txt -ele 011203012201 section 1 fiber -24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-25Z-1811IP.txt -ele 011203012201 section 1 fiber -24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY-25Z-18123IP.txt -ele 011203012201 section 23 fiber -24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY-25Z-18123IP.txt -ele 011203012201 section 23 fiber -24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY0Z-1961IP.txt -ele 011203012201 section 1 fiber 0.00 -196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY0Z-1961IP.txt -ele 011203012201 section 1 fiber 0.00 -196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY0Z-19623IP.txt -ele 011203012201 section 23 fiber 0.00 -196.45 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY0Z-19623IP.txt -ele 011203012201 section 23 fiber 0.00 -196.45 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY25Z-1811IP.txt -ele 011203012201 section 1 fiber 24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY25Z-1811IP.txt -ele 011203012201 section 1 fiber 24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY25Z-18123IP.txt -ele 011203012201 section 23 fiber 24.61 -181.16 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY25Z-18123IP.txt -ele 011203012201 section 23 fiber 24.61 -181.16 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY42Z-1641IP.txt -ele 011203012201 section 1 fiber 42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY42Z-1641IP.txt -ele 011203012201 section 1 fiber 42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY42Z-16423IP.txt -ele 011203012201 section 23 fiber 42.00 -163.77 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY42Z-16423IP.txt -ele 011203012201 section 23 fiber 42.00 -163.77 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY59Z-1461IP.txt -ele 011203012201 section 1 fiber 59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY59Z-1461IP.txt -ele 011203012201 section 1 fiber 59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY59Z-14623IP.txt -ele 011203012201 section 23 fiber 59.40 -146.37 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY59Z-14623IP.txt -ele 011203012201 section 23 fiber 59.40 -146.37 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY77Z-1291IP.txt -ele 011203012201 section 1 fiber 76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY77Z-1291IP.txt -ele 011203012201 section 1 fiber 76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY77Z-12923IP.txt -ele 011203012201 section 23 fiber 76.79 -128.98 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY77Z-12923IP.txt -ele 011203012201 section 23 fiber 76.79 -128.98 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY94Z-1121IP.txt -ele 011203012201 section 1 fiber 94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY94Z-1121IP.txt -ele 011203012201 section 1 fiber 94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY94Z-11223IP.txt -ele 011203012201 section 23 fiber 94.19 -111.58 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY94Z-11223IP.txt -ele 011203012201 section 23 fiber 94.19 -111.58 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY112Z-941IP.txt -ele 011203012201 section 1 fiber 111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY112Z-941IP.txt -ele 011203012201 section 1 fiber 111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY112Z-9423IP.txt -ele 011203012201 section 23 fiber 111.58 -94.19 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY112Z-9423IP.txt -ele 011203012201 section 23 fiber 111.58 -94.19 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY129Z-771IP.txt -ele 011203012201 section 1 fiber 128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY129Z-771IP.txt -ele 011203012201 section 1 fiber 128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY129Z-7723IP.txt -ele 011203012201 section 23 fiber 128.98 -76.79 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY129Z-7723IP.txt -ele 011203012201 section 23 fiber 128.98 -76.79 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY146Z-591IP.txt -ele 011203012201 section 1 fiber 146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY146Z-591IP.txt -ele 011203012201 section 1 fiber 146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY146Z-5923IP.txt -ele 011203012201 section 23 fiber 146.37 -59.40 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY146Z-5923IP.txt -ele 011203012201 section 23 fiber 146.37 -59.40 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY164Z-421IP.txt -ele 011203012201 section 1 fiber 163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY164Z-421IP.txt -ele 011203012201 section 1 fiber 163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY164Z-4223IP.txt -ele 011203012201 section 23 fiber 163.77 -42.00 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY164Z-4223IP.txt -ele 011203012201 section 23 fiber 163.77 -42.00 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY181Z-251IP.txt -ele 011203012201 section 1 fiber 181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY181Z-251IP.txt -ele 011203012201 section 1 fiber 181.16 -24.61 strain; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_stressFiberY181Z-2523IP.txt -ele 011203012201 section 23 fiber 181.16 -24.61 stress; 
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_011203012201_strainFiberY181Z-2523IP.txt -ele 011203012201 section 23 fiber 181.16 -24.61 strain; 
# Beam spring 1121400;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1121400_force.txt -time  -ele 1121400 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1121400_deformation.txt -time  -ele 1121400 deformation;
# Beam spring 1122200;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1122200_force.txt -time  -ele 1122200 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1122200_deformation.txt -time  -ele 1122200 deformation;
# Beam spring 1122400;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1122400_force.txt -time  -ele 1122400 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_BeamSpring1122400_deformation.txt -time  -ele 1122400 deformation;
# Panel zone spring 100112100;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112100_force.txt -time  -ele 100112100 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112100_deformation.txt -time  -ele 100112100 deformation;
# Panel zone spring 100112200;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112200_force.txt -time  -ele 100112200 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112200_deformation.txt -time  -ele 100112200 deformation;
# Panel zone spring 100112300;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112300_force.txt -time  -ele 100112300 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100112300_deformation.txt -time  -ele 100112300 deformation;
# Panel zone spring 100212100;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100212100_force.txt -time  -ele 100212100 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100212100_deformation.txt -time  -ele 100212100 deformation;
# Panel zone spring 100212200;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100212200_force.txt -time  -ele 100212200 force;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_PZSpring100212200_deformation.txt -time  -ele 100212200 deformation;
# Column first storey global forces;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011103012101_globalForce.txt  -time  -ele 011103012101 forces;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011203012201_globalForce.txt  -time  -ele 011203012201 forces;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011303012301_globalForce.txt  -time  -ele 011303012301 forces;
# Column first storey moment distribution;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011103012101_momentDistribution.txt  -time  -ele 011103012101 momentDistribution;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011203012201_momentDistribution.txt  -time  -ele 011203012201 momentDistribution;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011303012301_momentDistribution.txt  -time  -ele 011303012301 momentDistribution;
# Column first storey local curvature distribution;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011103012101_localCurvatureDistribution.txt  -time  -ele 011103012101 LocalSectionCurvature;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011203012201_localCurvatureDistribution.txt  -time  -ele 011203012201 LocalSectionCurvature;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011303012301_localCurvatureDistribution.txt  -time  -ele 011303012301 LocalSectionCurvature;
# Column first storey nonlocal curvature distribution;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011103012101_nonlocalCurvatureDistribution.txt  -time  -ele 011103012101 NonlocalSectionCurvature;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011203012201_nonlocalCurvatureDistribution.txt  -time  -ele 011203012201 NonlocalSectionCurvature;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011303012301_nonlocalCurvatureDistribution.txt  -time  -ele 011303012301 NonlocalSectionCurvature;
# Column first storey basic deformations;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011103012101_basicDeformations.txt  -time  -ele 011103012101 basicDeformation;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011203012201_basicDeformations.txt  -time  -ele 011203012201 basicDeformation;
recorder Element -file $Result/2dModelYDir1dFiber_lc10D_Column011303012301_basicDeformations.txt  -time  -ele 011303012301 basicDeformation;
# Eigen value analysis;
# Mode Shapes;
set numModes 4;
set pi [expr 2.0*asin(1.0)];
set nEigen 2;
set lambdaNTot [eigen [expr $nEigen]];
set lambdaI [lindex $lambdaNTot 0];
set lambdaJ [lindex $lambdaNTot 1];
DisplayModel2D ModeShape 2000 522  10  512  384  1;
DisplayModel2D ModeShape 2000 1032 10  512  384  2;
set w1 [expr pow($lambdaI,0.5)];
set w2 [expr pow($lambdaJ,0.5)];
set T1 [expr 2.0*$pi/$w1];
set T2 [expr 2.0*$pi/$w2];
puts "";
puts "T1 = [expr {double(round($T1*1000))/1000}] s";
puts "T2 = [expr {double(round($T2*1000))/1000}] s";
puts "w1 = [expr $w1]";
puts "w2 = [expr $w2]";
puts "Eigen Analysis Done";

#Store Eigen vector of 1st mode;
set eigenvector2Depth1 [nodeEigenvector 112102 2 1];
set eigenvector3Depth1 [nodeEigenvector 113102 2 1];
set eigenvector4Depth1 [nodeEigenvector 114102 2 1];
set eigenvector5Depth1 [nodeEigenvector 115102 2 1];

# Assign Loads, Analysis Type And Conversion Procedure;
# GRAVITY LOADS;
pattern Plain 100 Linear {
load 012101 0. [expr -1.0*60750.0000] 0. ;
load 012201 0. [expr -1.0*121500.0000] 0. ;
load 012301 0. [expr -1.0*60750.0000] 0. ;
load 013101 0. [expr -1.0*58625.0000] 0. ;
load 013201 0. [expr -1.0*117250.0000] 0. ;
load 013301 0. [expr -1.0*58625.0000] 0. ;
load 014101 0. [expr -1.0*60250.0000] 0. ;
load 014201 0. [expr -1.0*120500.0000] 0. ;
load 014301 0. [expr -1.0*60250.0000] 0. ;
load 015101 0. [expr -1.0*70625.0000] 0. ;
load 015201 0. [expr -1.0*141250.0000] 0. ;
load 015301 0. [expr -1.0*70625.0000] 0. ;
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

