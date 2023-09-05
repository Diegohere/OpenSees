###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsB1_Cravero2020_testVariableAxial;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define section
	set bf  264.0;										# total flange width
	set bf4MaterialLaw [expr $bf/ 2];
	set tf  22.20;										# flange thickness
	set d 427.0;										# section depth
	set rKArea 15.0;									# radius of K-Area
	set tw 13.30;										# web thickness
	set h [expr $d-2*$tf-2*$rKArea];					# Web PLATE depth for material law softening
	
	set bSurTFlange [expr $bf/(2*$tf)];
	set bSurTWeb [expr $h/$tw];
	
	set sigmaC0_Web [expr 1.2*385.0];
	set sigmaC0_Flange [expr 1.0*510.0];
	
	set alphaRegularization_Web 1.0;							# Factor for regularization web 
	set alphaRegularization_Flange 1.0;							# Factor for regularization flange
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 1825.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	set BeamTransfTag 2; 			# associate a tag to beam transformation
	#geomTransf Linear $ColTransfTag 0 0 -1;		# Linear transformation
	geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
	geomTransf Linear $BeamTransfTag 0 0 1;		# Linear transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0 0.0;
	node 2 0.0 $L 0.0;
	#node 3 0.0 $L 0.0;
	#node 4  -791.0 $L 0.0;
	#node 5 0.0 [expr $L+306.0] 0.0;
	
# Pin constraints for same nodes
	#equalDOF 3 2 1 2 6; 
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	#fix 2 0 0 1 1 1 0;
	#fix 3 0 0 1 1 1 0;
	#fix 4 0 0 1 1 1 0;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 191020.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $d-$tf]; 			# median depth
	set J   [expr 1.0/3.0*(2*$bf*$tf**3.0 + $do*$tw**3.0)]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	nDMaterial LocalBucklingFlangePlate 1 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange;
	nDMaterial LocalBucklingWebPlate 2 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web;
	
	set NFlange_LoadingDir 1;
	set NFlange_TranverseDir 4;
	set NWeb_LoadingDir 10;
	set NWeb_TranverseDir 1;	
	
	section NDFiberTestNonlocal 1 -GJ $GJ {;	
	#			 matTag  umSubdivY  numSubdivZ  yI  	zI  	yJ    zJ
	patch rect 1 $NFlange_LoadingDir $NFlange_TranverseDir [expr -$d/2]               [expr -$bf/2]                    [expr -($d/2-$tf)]             [expr $bf/2];	#Bottom flange
	patch rect 2 $NWeb_LoadingDir $NWeb_TranverseDir            [expr -($d/2-$tf)] [expr -$tw/2] [expr ($d/2-$tf)] [expr $tw/2];									#Web
	patch rect 1 $NFlange_LoadingDir $NFlange_TranverseDir [expr ($d/2-$tf)]             [expr -$bf/2]                    [expr $d/2]             [expr $bf/2];		#Top flange

	}

	
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 30 1e-5
	#set lc [expr 2.5*$bf];
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 11  20 1e-6 $lc
	
	set lc [expr 1.5*$bf];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 11  20 1e-6 $lc
	
	#element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $BeamTransfTag 
	#element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

#lc20bfLcSurDx4
# Record displacements 
	recorder Node -file $dataDir/B1TestVariableAxial_Cravero2020_lc15bfLcSurDx2_Disp.txt -node 2 -dof 1 2 3 disp;
	
# Record reactions
	recorder Node -file $dataDir/B1TestVariableAxial_Cravero2020_lc15bfLcSurDx2_RBase.txt -node 1 -dof 1 2 3 5 6 reaction;
	
# Record stress and strains for fibers
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY172Z0.txt -ele 12 section 1 fiber 172.17 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY172Z0.txt -ele 12 section 1 fiber 172.17 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY134Z0.txt -ele 12 section 1 fiber 133.91 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY134Z0.txt -ele 12 section 1 fiber 133.91 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY96Z0.txt -ele 12 section 1 fiber 95.65 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY96Z0.txt -ele 12 section 1 fiber 95.65 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY57Z0.txt -ele 12 section 1 fiber 57.39 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY57Z0.txt -ele 12 section 1 fiber 57.39 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY19Z0.txt -ele 12 section 1 fiber 19.13 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY19Z0.txt -ele 12 section 1 fiber 19.13 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-19Z0.txt -ele 12 section 1 fiber -19.13 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-19Z0.txt -ele 12 section 1 fiber -19.13 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-57Z0.txt -ele 12 section 1 fiber -57.39 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-57Z0.txt -ele 12 section 1 fiber -57.39 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-96Z0.txt -ele 12 section 1 fiber -95.65 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-96Z0.txt -ele 12 section 1 fiber -95.65 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-134Z0.txt -ele 12 section 1 fiber -133.91 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-134Z0.txt -ele 12 section 1 fiber -133.91 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-172Z0.txt -ele 12 section 1 fiber -172.17 0.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-172Z0.txt -ele 12 section 1 fiber -172.17 0.00 strain; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_stressFiberY-202Z33.txt -ele 12 section 1 fiber -202.40 33.00 stress; 
#recorder Element -file $dataDir/B1TestCyclicLcSurDx_Cravero2020_lc15bfLcSurDx2_strainFiberY-202Z33.txt -ele 12 section 1 fiber -202.40 33.00 strain; 


# Define display;	
#DisplayModel2D NodeNumbers 2.8 10 10  1200 800 -wipe;
#DisplayPlane "DeformedShape" 2.8 XY 0;

	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# Start timer
set startT [clock seconds]

#Axial load protocol
set gravityLoad [list 0. 0. 600000. 0. -600000. 0. 600000. 0. -600000. 0.]
#set gravityLoad [list 0. 0. 6. 0. -6. 0. 6. 0. -6. 0.]
#Lateral load protocol
set lateralDispX [list 0. 0. 2. 0. -2. 0. 2. 0. -2. 0. ]
#set lateralDisp [list 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. ]
set lateralDispZ [list 0. 0. 1. 0. -1. 0. 1. 0. -1. 0. ]

set LoopLength [llength $gravityLoad]
set i 1
  

puts "Model Built"


# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

puts "Running Analysis..."
set tStart [clock seconds];

# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	#system UmfPack
	set maxNumIter 25;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
	set printFlag 0;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step;
	set Tol 1.0e-6;                        # Convergence Test: tolerance	
	#test RelativeNormUnbalance  $Tol $maxNumIter $printFlag;		# type of convergence criteria with tolerance, max iterations
	test EnergyIncr  $Tol $maxNumIter $printFlag;
	#algorithm NewtonLineSearch;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	algorithm KrylovNewton 
	
	  set CtrlNode 2
  set CtrlDOFLatX 1;
  set CtrlDOFLatZ 3;
  
    set NSteps 1;
	set ok 0;


#Run the analysis
while {$ok == 0 && $i < $LoopLength} {

set index [expr $i]

#Gravity load
set F1 [lindex $gravityLoad $index];
set F2 [lindex $gravityLoad $index-1];
set dF1 [expr ($F1-$F2)];
#set currentGravityLoad [lindex $gravityLoad $index]
#puts "This is F1: $F1"
#puts "This is F2: $F2"
#puts "This is dF1: $dF1"
#puts "This is currentGravityLoad: $currentGravityLoad"
pattern Plain $i Linear {
   #load 2 0 $currentGravityLoad 0 0 0 0
   #load 2 0 $dF1 0 0 0 0; #gravity load
   load 2 $dF1 0 0 0 0 0;  #test shear load

}
#puts "increment = [expr {$i}] / [expr {$LoopLength}] - Gravity load";
set NstepGravity 1;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
set ok [ analyze $NstepGravity];		# apply gravity

loadConst -time 0.0


# Lateral load X
  pattern Plain [expr $LoopLength+$i] Linear {			
	 load 2 1.0 0.0 0.0 0.0 0.0 0.0;
  }
  
	# We need to relative deformation of the loading protocol
	# Subtract dUi+1 - dUi
	set D1X [lindex $lateralDispX $index];
	set D2X [lindex $lateralDispX $index-1];
	#set dU1 [expr ($D1-$D2)*$L];
	set dU1X [expr ($D1X-$D2X)];
	
	# Create Nsteps from Amplitude to Amplitude
	set dUX [expr ($dU1X)/$NSteps]
	
	# Displacement Control Integrator
	integrator DisplacementControl $CtrlNode $CtrlDOFLatX $dUX
     #puts "increment = [expr {$i}] / [expr {$LoopLength}] - Lateral load";

	set ok [ analyze $NSteps]
	
	loadConst -time 0.0
	
	
# Lateral load Z
  pattern Plain [expr 2*$LoopLength+$i] Linear {			
	 load 2 0.0 0.0 1.0 0.0 0.0 0.0;
  }
  
	# We need to relative deformation of the loading protocol
	# Subtract dUi+1 - dUi
	set D1Z [lindex $lateralDispZ $index];
	set D2Z [lindex $lateralDispZ $index-1];
	#set dU1 [expr ($D1-$D2)*$L];
	set dU1Z [expr ($D1Z-$D2Z)];
	
	# Create Nsteps from Amplitude to Amplitude
	set dUZ [expr ($dU1Z)/$NSteps]
	
	# Displacement Control Integrator
	integrator DisplacementControl $CtrlNode $CtrlDOFLatZ $dUZ
     puts "increment = [expr {$i}] / [expr {$LoopLength}]";

	set ok [ analyze $NSteps]
	
	
	
	
	set i [expr $i + 1 ]
	
	loadConst -time 0.0
} 	
set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;