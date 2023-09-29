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
	# set DHSS  254;										# HSS depth
	# set tHSS 9.5;										# plate width
	set DHSS  300.;										# HSS depth
	set tHSS 15.;										# plate width
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
	
	set NWeb_LoadDir 20;
	set NWeb_TranverseDir 1;
	set NFlange_LoadDir 1;
	set NFlange_TranverseDir 18;
	set NCorner_Circ 1; 
	set NCorner_Rad 1; 
	
	
	
	# #WITH ROUNDED CORNERS
	# set absCoordCenterCorner [expr $DHSS/2 - $rExtHSS];
	# set zC1 [expr $absCoordCenterCorner];
	# set yC1 [expr $absCoordCenterCorner];
	# set zC2 [expr -$absCoordCenterCorner];
	# set yC2 [expr $absCoordCenterCorner];
	# set zC3 [expr -$absCoordCenterCorner];
	# set yC3 [expr -$absCoordCenterCorner];
	# set zC4 [expr $absCoordCenterCorner];
	# set yC4 [expr -$absCoordCenterCorner];
	
	# set yIW1 [expr -($DHSS/2 - $rExtHSS)];
	# set zIW1 [expr -$DHSS/2];
	# set yJW1 [expr ($DHSS/2 - $rExtHSS)];
	# set zJW1 [expr -($DHSS/2 - $tHSS)];
	
	# set yIW2 [expr -($DHSS/2 - $rExtHSS)];
	# set zIW2 [expr ($DHSS/2 - $tHSS)];
	# set yJW2 [expr ($DHSS/2 - $rExtHSS)];
	# set zJW2 [expr $DHSS/2];
	
	# set yIF1 [expr $DHSS/2 - $tHSS];
	# set zIF1 [expr -($DHSS/2 - $rExtHSS)];
	# set yJF1 [expr $DHSS/2];
	# set zJF1 [expr ($DHSS/2 - $rExtHSS)];
	
	# set yIF2 [expr -$DHSS/2];
	# set zIF2 [expr -($DHSS/2 - $rExtHSS)];
	# set yJF2 [expr -($DHSS/2 - $tHSS)];
	# set zJF2 [expr ($DHSS/2 - $rExtHSS)];
	
	# #section NDFiberTestNonlocal 1 -GJ $GJ {;
	# section NDFiberTestShear4HSS 1 -GJ $GJ -Geom $DHSS $tHSS $rIntHSS {;		
		# patch circ 1 1 1 $yC1 $zC1 $rIntHSS $rExtHSS 0 90;
	# patch circ 1 1 1 $yC2 $zC2 $rIntHSS $rExtHSS 270 360;
	# patch circ 1 1 1 $yC3 $zC3 $rIntHSS $rExtHSS 180 270;
	# patch circ 1 1 1 $yC4 $zC4 $rIntHSS $rExtHSS 90 180;
	
	# #			 matTag  umSubdivY  numSubdivZ  yI  	zI  	yJ    zJ
	# patch rect 1 1 $NFlange_TranverseDir $yIF1 $zIF1 $yJF1 $zJF1;
	# patch rect 1 1 $NFlange_TranverseDir $yIF2 $zIF2 $yJF2 $zJF2;
	
	# patch rect 1 $NWeb_LoadDir 1 $yIW1 $zIW1 $yJW1 $zJW1;
	# patch rect 1 $NWeb_LoadDir 1 $yIW2 $zIW2 $yJW2 $zJW2;
	# }
	
	
	#NO ROUNDED CORNERS	
	set yIW1 [expr -($DHSS/2)];
	set zIW1 [expr -$DHSS/2];
	set yJW1 [expr ($DHSS/2)];
	set zJW1 [expr -($DHSS/2 - $tHSS)];
	
	set yIW2 [expr -($DHSS/2)];
	set zIW2 [expr ($DHSS/2 - $tHSS)];
	set yJW2 [expr ($DHSS/2)];
	set zJW2 [expr $DHSS/2];
	
	set yIF1 [expr $DHSS/2 - $tHSS];
	set zIF1 [expr -($DHSS/2 - $tHSS)];
	set yJF1 [expr $DHSS/2];
	set zJF1 [expr ($DHSS/2 - $tHSS)];
	
	set yIF2 [expr -$DHSS/2];
	set zIF2 [expr -($DHSS/2 - $tHSS)];
	set yJF2 [expr -($DHSS/2 - $tHSS)];
	set zJF2 [expr ($DHSS/2 - $tHSS)];
	
	#section NDFiberTestNonlocal 1 -GJ $GJ {;
	section NDFiberTestShear4HSS 1 -GJ $GJ -Geom $DHSS $tHSS 0. {;
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
	recorder Node -file $dataDir/testShearDistribution_HSSWeak_Disp.txt -node 2 -dof 1 2 3 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShearDistribution_HSSWeak_RBase.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record stress and strains for fibers
# Top flange;
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-143.txt -ele 12 section 1 fiber 142.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-143.txt -ele 12 section 1 fiber 142.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-128.txt -ele 12 section 1 fiber 142.50 -127.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-128.txt -ele 12 section 1 fiber 142.50 -127.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-113.txt -ele 12 section 1 fiber 142.50 -112.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-113.txt -ele 12 section 1 fiber 142.50 -112.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-98.txt -ele 12 section 1 fiber 142.50 -97.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-98.txt -ele 12 section 1 fiber 142.50 -97.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-83.txt -ele 12 section 1 fiber 142.50 -82.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-83.txt -ele 12 section 1 fiber 142.50 -82.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-68.txt -ele 12 section 1 fiber 142.50 -67.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-68.txt -ele 12 section 1 fiber 142.50 -67.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-53.txt -ele 12 section 1 fiber 142.50 -52.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-53.txt -ele 12 section 1 fiber 142.50 -52.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-38.txt -ele 12 section 1 fiber 142.50 -37.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-38.txt -ele 12 section 1 fiber 142.50 -37.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-23.txt -ele 12 section 1 fiber 142.50 -22.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-23.txt -ele 12 section 1 fiber 142.50 -22.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z-8.txt -ele 12 section 1 fiber 142.50 -7.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z-8.txt -ele 12 section 1 fiber 142.50 -7.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z8.txt -ele 12 section 1 fiber 142.50 7.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z8.txt -ele 12 section 1 fiber 142.50 7.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z23.txt -ele 12 section 1 fiber 142.50 22.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z23.txt -ele 12 section 1 fiber 142.50 22.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z38.txt -ele 12 section 1 fiber 142.50 37.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z38.txt -ele 12 section 1 fiber 142.50 37.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z53.txt -ele 12 section 1 fiber 142.50 52.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z53.txt -ele 12 section 1 fiber 142.50 52.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z68.txt -ele 12 section 1 fiber 142.50 67.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z68.txt -ele 12 section 1 fiber 142.50 67.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z83.txt -ele 12 section 1 fiber 142.50 82.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z83.txt -ele 12 section 1 fiber 142.50 82.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z98.txt -ele 12 section 1 fiber 142.50 97.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z98.txt -ele 12 section 1 fiber 142.50 97.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z113.txt -ele 12 section 1 fiber 142.50 112.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z113.txt -ele 12 section 1 fiber 142.50 112.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z128.txt -ele 12 section 1 fiber 142.50 127.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z128.txt -ele 12 section 1 fiber 142.50 127.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_stressFiberY143Z143.txt -ele 12 section 1 fiber 142.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_topFlange_strainFiberY143Z143.txt -ele 12 section 1 fiber 142.50 142.50 strain; 
# Bottom flange;
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z143.txt -ele 12 section 1 fiber -142.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z143.txt -ele 12 section 1 fiber -142.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z128.txt -ele 12 section 1 fiber -142.50 127.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z128.txt -ele 12 section 1 fiber -142.50 127.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z113.txt -ele 12 section 1 fiber -142.50 112.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z113.txt -ele 12 section 1 fiber -142.50 112.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z98.txt -ele 12 section 1 fiber -142.50 97.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z98.txt -ele 12 section 1 fiber -142.50 97.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z83.txt -ele 12 section 1 fiber -142.50 82.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z83.txt -ele 12 section 1 fiber -142.50 82.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z68.txt -ele 12 section 1 fiber -142.50 67.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z68.txt -ele 12 section 1 fiber -142.50 67.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z53.txt -ele 12 section 1 fiber -142.50 52.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z53.txt -ele 12 section 1 fiber -142.50 52.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z38.txt -ele 12 section 1 fiber -142.50 37.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z38.txt -ele 12 section 1 fiber -142.50 37.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z23.txt -ele 12 section 1 fiber -142.50 22.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z23.txt -ele 12 section 1 fiber -142.50 22.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z8.txt -ele 12 section 1 fiber -142.50 7.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z8.txt -ele 12 section 1 fiber -142.50 7.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-8.txt -ele 12 section 1 fiber -142.50 -7.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-8.txt -ele 12 section 1 fiber -142.50 -7.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-23.txt -ele 12 section 1 fiber -142.50 -22.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-23.txt -ele 12 section 1 fiber -142.50 -22.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-38.txt -ele 12 section 1 fiber -142.50 -37.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-38.txt -ele 12 section 1 fiber -142.50 -37.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-53.txt -ele 12 section 1 fiber -142.50 -52.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-53.txt -ele 12 section 1 fiber -142.50 -52.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-68.txt -ele 12 section 1 fiber -142.50 -67.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-68.txt -ele 12 section 1 fiber -142.50 -67.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-83.txt -ele 12 section 1 fiber -142.50 -82.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-83.txt -ele 12 section 1 fiber -142.50 -82.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-98.txt -ele 12 section 1 fiber -142.50 -97.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-98.txt -ele 12 section 1 fiber -142.50 -97.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-113.txt -ele 12 section 1 fiber -142.50 -112.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-113.txt -ele 12 section 1 fiber -142.50 -112.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-128.txt -ele 12 section 1 fiber -142.50 -127.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-128.txt -ele 12 section 1 fiber -142.50 -127.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_stressFiberY-143Z-143.txt -ele 12 section 1 fiber -142.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_botFlange_strainFiberY-143Z-143.txt -ele 12 section 1 fiber -142.50 -142.50 strain; 
# Left web;
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY143Z-143.txt -ele 12 section 1 fiber 142.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY143Z-143.txt -ele 12 section 1 fiber 142.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-143Z-143.txt -ele 12 section 1 fiber -142.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-143Z-143.txt -ele 12 section 1 fiber -142.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-128Z-143.txt -ele 12 section 1 fiber -127.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-128Z-143.txt -ele 12 section 1 fiber -127.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-113Z-143.txt -ele 12 section 1 fiber -112.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-113Z-143.txt -ele 12 section 1 fiber -112.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-98Z-143.txt -ele 12 section 1 fiber -97.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-98Z-143.txt -ele 12 section 1 fiber -97.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-83Z-143.txt -ele 12 section 1 fiber -82.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-83Z-143.txt -ele 12 section 1 fiber -82.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-68Z-143.txt -ele 12 section 1 fiber -67.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-68Z-143.txt -ele 12 section 1 fiber -67.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-53Z-143.txt -ele 12 section 1 fiber -52.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-53Z-143.txt -ele 12 section 1 fiber -52.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-38Z-143.txt -ele 12 section 1 fiber -37.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-38Z-143.txt -ele 12 section 1 fiber -37.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-23Z-143.txt -ele 12 section 1 fiber -22.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-23Z-143.txt -ele 12 section 1 fiber -22.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY-8Z-143.txt -ele 12 section 1 fiber -7.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY-8Z-143.txt -ele 12 section 1 fiber -7.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY8Z-143.txt -ele 12 section 1 fiber 7.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY8Z-143.txt -ele 12 section 1 fiber 7.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY23Z-143.txt -ele 12 section 1 fiber 22.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY23Z-143.txt -ele 12 section 1 fiber 22.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY38Z-143.txt -ele 12 section 1 fiber 37.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY38Z-143.txt -ele 12 section 1 fiber 37.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY53Z-143.txt -ele 12 section 1 fiber 52.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY53Z-143.txt -ele 12 section 1 fiber 52.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY68Z-143.txt -ele 12 section 1 fiber 67.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY68Z-143.txt -ele 12 section 1 fiber 67.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY83Z-143.txt -ele 12 section 1 fiber 82.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY83Z-143.txt -ele 12 section 1 fiber 82.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY98Z-143.txt -ele 12 section 1 fiber 97.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY98Z-143.txt -ele 12 section 1 fiber 97.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY113Z-143.txt -ele 12 section 1 fiber 112.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY113Z-143.txt -ele 12 section 1 fiber 112.50 -142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_stressFiberY128Z-143.txt -ele 12 section 1 fiber 127.50 -142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_leftWeb_strainFiberY128Z-143.txt -ele 12 section 1 fiber 127.50 -142.50 strain; 
# Right web;
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY143Z143.txt -ele 12 section 1 fiber 142.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY143Z143.txt -ele 12 section 1 fiber 142.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY128Z143.txt -ele 12 section 1 fiber 127.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY128Z143.txt -ele 12 section 1 fiber 127.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY113Z143.txt -ele 12 section 1 fiber 112.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY113Z143.txt -ele 12 section 1 fiber 112.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY98Z143.txt -ele 12 section 1 fiber 97.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY98Z143.txt -ele 12 section 1 fiber 97.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY83Z143.txt -ele 12 section 1 fiber 82.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY83Z143.txt -ele 12 section 1 fiber 82.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY68Z143.txt -ele 12 section 1 fiber 67.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY68Z143.txt -ele 12 section 1 fiber 67.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY53Z143.txt -ele 12 section 1 fiber 52.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY53Z143.txt -ele 12 section 1 fiber 52.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY38Z143.txt -ele 12 section 1 fiber 37.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY38Z143.txt -ele 12 section 1 fiber 37.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY23Z143.txt -ele 12 section 1 fiber 22.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY23Z143.txt -ele 12 section 1 fiber 22.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY8Z143.txt -ele 12 section 1 fiber 7.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY8Z143.txt -ele 12 section 1 fiber 7.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-8Z143.txt -ele 12 section 1 fiber -7.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-8Z143.txt -ele 12 section 1 fiber -7.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-23Z143.txt -ele 12 section 1 fiber -22.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-23Z143.txt -ele 12 section 1 fiber -22.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-38Z143.txt -ele 12 section 1 fiber -37.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-38Z143.txt -ele 12 section 1 fiber -37.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-53Z143.txt -ele 12 section 1 fiber -52.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-53Z143.txt -ele 12 section 1 fiber -52.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-68Z143.txt -ele 12 section 1 fiber -67.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-68Z143.txt -ele 12 section 1 fiber -67.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-83Z143.txt -ele 12 section 1 fiber -82.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-83Z143.txt -ele 12 section 1 fiber -82.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-98Z143.txt -ele 12 section 1 fiber -97.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-98Z143.txt -ele 12 section 1 fiber -97.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-113Z143.txt -ele 12 section 1 fiber -112.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-113Z143.txt -ele 12 section 1 fiber -112.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-128Z143.txt -ele 12 section 1 fiber -127.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-128Z143.txt -ele 12 section 1 fiber -127.50 142.50 strain; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_stressFiberY-143Z143.txt -ele 12 section 1 fiber -142.50 142.50 stress; 
recorder Element -file $dataDir/testShearDistribution_HSSWeak_rightWeb_strainFiberY-143Z143.txt -ele 12 section 1 fiber -142.50 142.50 strain; 


 



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
   load 2 0 0 100000 0 0 0

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