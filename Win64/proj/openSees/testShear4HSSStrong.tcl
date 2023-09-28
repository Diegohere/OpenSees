###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_testShear4HSS;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define wide flange section
#Using specimen H27 Suzuki2021
	set DHSS  254;										# HSS depth
	set tHSS 9.5;										# plate width
	set rExtHSS [expr 2.5 * $tHSS];						# HSS corner external radius
	set rIntHSS [expr 1.5 * $tHSS];						# HSS corner internal radius
	set bPlate [expr $DHSS - 2 * $rExtHSS];

	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 2000.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	set BeamTransfTag 2; 			# associate a tag to beam transformation
	#geomTransf Linear $ColTransfTag 0 0 -1;		# Linear transformation
	geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0 0.0;
	node 2 0.0 $L 0.0;
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $DHSS-$tHSS]; 			# median depth
	set J   [expr $do**3*$tHSS]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	nDMaterial ElasticIsotropic 1 $E $nu
	#nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 37300000000.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $b 800000000000.0 1.0;
	
	set NWeb_LoadDir 10;
	set NWeb_TranverseDir 1;
	set NFlange_LoadDir 1;
	set NFlange_TranverseDir 10;
	set NCorner_Circ 1; 
	set NCorner_Rad 1; 
	
	set absCoordCenterCorner [expr $DHSS/2 - $rExtHSS];
	set zC1 [expr $absCoordCenterCorner];
	set yC1 [expr $absCoordCenterCorner];
	set zC2 [expr -$absCoordCenterCorner];
	set yC2 [expr $absCoordCenterCorner];
	set zC3 [expr -$absCoordCenterCorner];
	set yC3 [expr -$absCoordCenterCorner];
	set zC4 [expr $absCoordCenterCorner];
	set yC4 [expr -$absCoordCenterCorner];
	
	set yIW1 [expr -($DHSS/2 - $rExtHSS)];
	set zIW1 [expr -$DHSS/2];
	set yJW1 [expr ($DHSS/2 - $rExtHSS)];
	set zJW1 [expr -($DHSS/2 - $tHSS)];
	
	set yIW2 [expr -($DHSS/2 - $rExtHSS)];
	set zIW2 [expr ($DHSS/2 - $tHSS)];
	set yJW2 [expr ($DHSS/2 - $rExtHSS)];
	set zJW2 [expr $DHSS/2];
	
	set yIF1 [expr $DHSS/2 - $tHSS];
	set zIF1 [expr -($DHSS/2 - $rExtHSS)];
	set yJF1 [expr $DHSS/2];
	set zJF1 [expr ($DHSS/2 - $rExtHSS)];
	
	set yIF2 [expr -$DHSS/2];
	set zIF2 [expr -($DHSS/2 - $rExtHSS)];
	set yJF2 [expr -($DHSS/2 - $tHSS)];
	set zJF2 [expr ($DHSS/2 - $rExtHSS)];
	
	#section NDFiberTestNonlocal 1 -GJ $GJ {;	
	section NDFiberTestShear4HSS 1 -GJ $GJ -Geom $DHSS $tHSS {;	
		patch circ 1 1 1 $yC1 $zC1 $rIntHSS $rExtHSS 0 90;
	patch circ 1 1 1 $yC2 $zC2 $rIntHSS $rExtHSS 270 360;
	patch circ 1 1 1 $yC3 $zC3 $rIntHSS $rExtHSS 180 270;
	patch circ 1 1 1 $yC4 $zC4 $rIntHSS $rExtHSS 90 180;
	
	#			 matTag  umSubdivY  numSubdivZ  yI  	zI  	yJ    zJ
	patch rect 1 1 $NFlange_TranverseDir $yIF1 $zIF1 $yJF1 $zJF1;
	patch rect 1 1 $NFlange_TranverseDir $yIF2 $zIF2 $yJF2 $zJF2;
	
	patch rect 1 $NWeb_LoadDir 1 $yIW1 $zIW1 $yJW1 $zJW1;
	patch rect 1 $NWeb_LoadDir 1 $yIW2 $zIW2 $yJW2 $zJW2;
	}

	
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 30 1e-5
	#set lc [expr 0.0*$bf];
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	
	set lc [expr 0.0*$DHSS];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 5  20 1e-6 $lc 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

#lc20bfLcSurDx4
# Record displacements 
	recorder Node -file $dataDir/testShearDistribution_HSSStrong_Disp.txt -node 2 -dof 1 2 3 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShearDistribution_HSSStrong_RBase.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record stress and strains for fibers
# Top flange;
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z-93.txt -ele 12 section 1 fiber 122.25 -92.92 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z-93.txt -ele 12 section 1 fiber 122.25 -92.92 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z-72.txt -ele 12 section 1 fiber 122.25 -72.28 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z-72.txt -ele 12 section 1 fiber 122.25 -72.28 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z-52.txt -ele 12 section 1 fiber 122.25 -51.63 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z-52.txt -ele 12 section 1 fiber 122.25 -51.63 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z-31.txt -ele 12 section 1 fiber 122.25 -30.98 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z-31.txt -ele 12 section 1 fiber 122.25 -30.98 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z-10.txt -ele 12 section 1 fiber 122.25 -10.33 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z-10.txt -ele 12 section 1 fiber 122.25 -10.33 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z10.txt -ele 12 section 1 fiber 122.25 10.33 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z10.txt -ele 12 section 1 fiber 122.25 10.33 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z31.txt -ele 12 section 1 fiber 122.25 30.97 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z31.txt -ele 12 section 1 fiber 122.25 30.97 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z52.txt -ele 12 section 1 fiber 122.25 51.62 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z52.txt -ele 12 section 1 fiber 122.25 51.62 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z72.txt -ele 12 section 1 fiber 122.25 72.27 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z72.txt -ele 12 section 1 fiber 122.25 72.27 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_stressFiberY122Z93.txt -ele 12 section 1 fiber 122.25 92.92 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_topFlange_strainFiberY122Z93.txt -ele 12 section 1 fiber 122.25 92.92 strain; 
# Bottom flange;
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z93.txt -ele 12 section 1 fiber -122.25 92.92 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z93.txt -ele 12 section 1 fiber -122.25 92.92 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z72.txt -ele 12 section 1 fiber -122.25 72.28 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z72.txt -ele 12 section 1 fiber -122.25 72.28 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z52.txt -ele 12 section 1 fiber -122.25 51.63 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z52.txt -ele 12 section 1 fiber -122.25 51.63 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z31.txt -ele 12 section 1 fiber -122.25 30.98 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z31.txt -ele 12 section 1 fiber -122.25 30.98 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z10.txt -ele 12 section 1 fiber -122.25 10.33 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z10.txt -ele 12 section 1 fiber -122.25 10.33 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z-10.txt -ele 12 section 1 fiber -122.25 -10.33 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z-10.txt -ele 12 section 1 fiber -122.25 -10.33 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z-31.txt -ele 12 section 1 fiber -122.25 -30.97 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z-31.txt -ele 12 section 1 fiber -122.25 -30.97 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z-52.txt -ele 12 section 1 fiber -122.25 -51.62 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z-52.txt -ele 12 section 1 fiber -122.25 -51.62 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z-72.txt -ele 12 section 1 fiber -122.25 -72.27 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z-72.txt -ele 12 section 1 fiber -122.25 -72.27 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_stressFiberY-122Z-93.txt -ele 12 section 1 fiber -122.25 -92.92 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_botFlange_strainFiberY-122Z-93.txt -ele 12 section 1 fiber -122.25 -92.92 strain; 
# Left web;
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY117Z-117.txt -ele 12 section 1 fiber 116.69 -116.69 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY117Z-117.txt -ele 12 section 1 fiber 116.69 -116.69 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-117Z-117.txt -ele 12 section 1 fiber -116.69 -116.69 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-117Z-117.txt -ele 12 section 1 fiber -116.69 -116.69 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-93Z-122.txt -ele 12 section 1 fiber -92.92 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-93Z-122.txt -ele 12 section 1 fiber -92.92 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-72Z-122.txt -ele 12 section 1 fiber -72.28 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-72Z-122.txt -ele 12 section 1 fiber -72.28 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-52Z-122.txt -ele 12 section 1 fiber -51.63 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-52Z-122.txt -ele 12 section 1 fiber -51.63 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-31Z-122.txt -ele 12 section 1 fiber -30.98 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-31Z-122.txt -ele 12 section 1 fiber -30.98 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY-10Z-122.txt -ele 12 section 1 fiber -10.33 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY-10Z-122.txt -ele 12 section 1 fiber -10.33 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY10Z-122.txt -ele 12 section 1 fiber 10.33 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY10Z-122.txt -ele 12 section 1 fiber 10.33 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY31Z-122.txt -ele 12 section 1 fiber 30.97 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY31Z-122.txt -ele 12 section 1 fiber 30.97 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY52Z-122.txt -ele 12 section 1 fiber 51.62 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY52Z-122.txt -ele 12 section 1 fiber 51.62 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY72Z-122.txt -ele 12 section 1 fiber 72.27 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY72Z-122.txt -ele 12 section 1 fiber 72.27 -122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_stressFiberY93Z-122.txt -ele 12 section 1 fiber 92.92 -122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_leftWeb_strainFiberY93Z-122.txt -ele 12 section 1 fiber 92.92 -122.25 strain; 
# Right web;
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY72Z122.txt -ele 12 section 1 fiber 72.28 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY72Z122.txt -ele 12 section 1 fiber 72.28 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY52Z122.txt -ele 12 section 1 fiber 51.63 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY52Z122.txt -ele 12 section 1 fiber 51.63 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY31Z122.txt -ele 12 section 1 fiber 30.98 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY31Z122.txt -ele 12 section 1 fiber 30.98 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-31Z122.txt -ele 12 section 1 fiber -30.97 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-31Z122.txt -ele 12 section 1 fiber -30.97 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-52Z122.txt -ele 12 section 1 fiber -51.62 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-52Z122.txt -ele 12 section 1 fiber -51.62 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-72Z122.txt -ele 12 section 1 fiber -72.27 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-72Z122.txt -ele 12 section 1 fiber -72.27 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_stressFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSStrong_rightWeb_strainFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 strain; 

 



# Define display;	
#DisplayModel2D NodeNumbers 2.8 10 10  1200 800 -wipe;
#DisplayPlane "DeformedShape" 2.8 XY 0;

	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# Start timer
set tStart [clock seconds]


# define LATERAL LOAD -------------------------------------------------------------
pattern Plain 1 Linear {
   load 2 100000 0 0 0 0 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-6;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20 0; 		# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 10;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero



set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;