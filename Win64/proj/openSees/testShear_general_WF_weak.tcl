###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_testShear_general_WF;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define wide flange section
	set bf  200.0;										# total flange width
	set tf  20.00;										# flange thickness
	set d 400.0;										# section depth
	set tw 10.0;										# web thickness

	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	# set L 2000.0;      # Lenght of the column [mm]
	set L 500.0;      # Lenght of the column [mm]
	
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
	set do 	[expr $d-$tf]; 			# median depth
	set J   [expr 1.0/3.0*(2*$bf*$tf**3.0 + $do*$tw**3.0)]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	set plateType web;
	set steelMaterial A992Gr50;
	set bPlate $d
	set tPlate $tw
	set sigmaC0 [expr 9999999999];
	set alphaRegularization 1.0;
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	#nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 37300000000.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bPlate $tPlate 800000000000.0 1.0;
	nDMaterial HLBModel 1 191020.0 0.3 37300000000.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bPlate $tPlate $sigmaC0 $alphaRegularization $plateType $steelMaterial;

	
	set NFlange_yDir 3;
	set NFlange_zDir 14;
	set NWeb_yDir 54;
	set NWeb_zDir 2;
	set NIntersection_yDir [expr $NFlange_yDir]
	set NIntersection_zDir [expr $NWeb_zDir]
	
	#section NDFiberTestNonlocal 1 -GJ $GJ {;	
	# section NDFiberTestShear4WF 1 -GJ $GJ -Geom $bf $tf $d $tw {;	
		# patch rect 1 $nflange_yDir $nflange_zDir [expr -$d/2]               [expr -$bf/2]                    [expr -($d/2-$tf)]             [expr $bf/2];	#bottom flange
		# patch rect 1 $nweb_yDir $nweb_zDir            [expr -($d/2-$tf)] [expr -$tw/2] [expr ($d/2-$tf)] [expr $tw/2];									#web
		# patch rect 1 $nflange_yDir $nflange_zDir [expr ($d/2-$tf)]             [expr -$bf/2]                    [expr $d/2]             [expr $bf/2];		#top flange
	# }
	section NDFiberShear 1 -GJ $GJ {;	
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr -$d/2]               [expr -$bf/2]                    [expr -($d/2-$tf)]             [expr -$tw/2];	#left part bottom flange
		patch rect 1 $NIntersection_yDir $NIntersection_zDir [expr -$d/2]               [expr -$tw/2]                    [expr -($d/2-$tf)]             [expr $tw/2];	#intersection bottom flange/web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr -$d/2]               [expr $tw/2]                    [expr -($d/2-$tf)]             [expr $bf/2];	#right part bottom flange
		patch rect 1 $NWeb_yDir $NWeb_zDir            [expr -($d/2-$tf)] [expr -$tw/2] [expr ($d/2-$tf)] [expr $tw/2];									#web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr ($d/2-$tf)]             [expr -$bf/2]                    [expr $d/2]             [expr -$tw/2];		#left part top flange
		patch rect 1 $NIntersection_yDir $NIntersection_zDir [expr ($d/2-$tf)]             [expr -$tw/2]                    [expr $d/2]             [expr $tw/2];		#intersection top flange/web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr ($d/2-$tf)]             [expr $tw/2]                    [expr $d/2]             [expr $bf/2];		#right part top flange
	}

	
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 30 1e-5
	#set lc [expr 0.0*$bf];
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	
	set lc [expr 0.0*$bf];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 5  20 1e-6 $lc 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

#lc20bfLcSurDx4
# Record displacements 
	#recorder Node -file $dataDir/testShear4Rectangle_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShear4WF_weakAxis_RBase.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record stress and strains for fibers
# recorder Element -file $dataDir/testShear4WF_stressFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 stress; 
# recorder Element -file $dataDir/testShear4WF_strainFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 strain; 

# Record section connectivity and coordinate matrices
recorder Element -file $dataDir/testShear4WF_weakAxis_connectivityMatrix.txt -ele 12 section 1 connectivity; 
recorder Element -file $dataDir/testShear4WF_weakAxis_coordinateMatrix.txt -ele 12 section 1 coordinate; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear4WF_weakAxis_allFiberStresses.txt -ele 12 section 1 allFiberStresses; 

#Record section deformations for all sections along element length
	recorder Element -file $dataDir/testShear4WF_weakAxis_5IP_eNL.txt -ele 12 NonlocalSectionDeformations;



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
   load 2 0 0 -200000 0 0 0

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