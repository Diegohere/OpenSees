###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_testShear_HEM300;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define wide flange section
	set bf  310.0;										# total flange width
	set tf 39.0;										# flange thickness
	set d 340.0;										# section depth
	set tw 21.0;										# web thickness
	
	set alphaRegularization 1.0;
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 1000.0;      # Lenght of the column [mm]
	
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
	fix 2 0 1 1 1 1 1;
	
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
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	#nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 37300000000.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $b 800000000000.0 1.0;
	#nDMaterial HLBModel 1 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bPlate $tPlate $sigmaC0 $alphaRegularization $plateType $steelMaterial;
	nDMaterial HLBModel 1 200000.0 0.3 332.18 120.48 8.14 93.15 261.75 2 21102.0 173.60 2300.60 10.42 $bPlate $tPlate $sigmaC0 $alphaRegularization $plateType $steelMaterial;
	
	
	set NFlange_yDir 4;
	set NFlange_zDir 13;
	set NWeb_yDir 24;
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

# Record displacements 
	recorder Node -file $dataDir/testShear_HEM300_strongAxis_Disp_IP5.txt -node 2 -dof 1 2 3 4 5 6 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShear_HEM300_strongAxis_RBase_IP5.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record section connectivity and coordinate matrices
recorder Element -file $dataDir/testShear_HEM300_strongAxis_connectivityMatrix.txt -ele 12 section 1 connectivity; 
recorder Element -file $dataDir/testShear_HEM300_strongAxis_coordinateMatrix.txt -ele 12 section 1 coordinate; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear_HEM300_strongAxis_allFiberStresses_IP5.txt -ele 12 section 1 allFiberStresses; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear_HEM300_strongAxis_allFiberStrains_IP5.txt -ele 12 section 1 allFiberStrains; 


# Record all fiber gradPsiShear
#recorder Element -file $dataDir/testShear_HEM300_strongAxis_gradPsiShear_sec1_IP5.txt -ele 12 section 1 gradPsiShear; 

# Record PEXX 
set nSections 5
set yLoc1 [expr $d/2]
set zLoc1 [expr -$bf/2]
set yLoc2 [expr $d/2]
set zLoc2 [expr -$tw/4]
set yLoc3 [expr $d/2-3*$tf/4]
set zLoc3 [expr -$tw/4]
set yLoc4 [expr $d/2-3*$tf/4]
set zLoc4 [expr -$bf/2]
set locations [list \
    [list 1 $yLoc1 $zLoc1] \
    [list 2 $yLoc2 $zLoc2] \
    [list 3 $yLoc3 $zLoc3] \
    [list 4 $yLoc4 $zLoc4]]

# Loop over locations
foreach loc $locations {
    set loc_num [lindex $loc 0]
    set y [lindex $loc 1]
    set z [lindex $loc 2]
	
	# puts "Location $loc_num: y=$y, z=$z"
    
    # Loop over sections
    for {set sec 1} {$sec <= $nSections} {incr sec} {
        set filename "$dataDir/testShear4WF_strongAxis_PEXX_sec${sec}_Loc${loc_num}.txt"
        #recorder Element -file $filename -ele 12 section $sec fiber $y $z plasticStrain
    }
}


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


# # define GRAVITY -------------------------------------------------------------
# pattern Plain 1 Linear {
   # load 2 0 0 0 0 0 0

# }

# # Gravity-analysis parameters -- load-controlled static analysis
# set Tol 1.0e-6;			# convergence tolerance for test
# constraints Plain;     		# how it handles boundary conditions
# numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
# system  BandGeneral;		# how to store and solve the system of equations in the analysis
# test RelativeNormUnbalance $Tol 20 0; 		# determine if convergence has been achieved at the end of an iteration step
# algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
# set NstepGravity 10;  		# apply gravity in 1 steps
# set DGravity [expr 1./$NstepGravity]; 	# first load increment;
# integrator LoadControl $DGravity;	# determine the next time step for an analysis
# analysis Static;			# define type of analysis static or transient
# analyze $NstepGravity;		# apply gravity
# # ------------------------------------------------- maintain constant gravity loads and reset time to zero
# loadConst -time 0.0

puts "Model Built"




# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

puts "Running Analysis..."

# assign lateral loads and create load pattern
  set CtrlNode 2
  set CtrlDOF 1;
  pattern Plain 200 Linear {			
	 load $CtrlNode 1.0 0.0 0.0 0.0 0.0 0.0;
  }
  
# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	#system UmfPack
	set maxNumIter 25;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
	set printFlag 0;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step;
	#test RelativeNormUnbalance  $Tol $maxNumIter $printFlag;		# type of convergence criteria with tolerance, max iterations
	set currentTolerance 1.0e-8
	test EnergyIncr $currentTolerance 100;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	# algorithm NewtonLineSearch -type Bisection 0.75;
	#algorithm NewtonLineSearch -type Secant 0.75;
	#algorithm SecantNewton
	#algorithm ModifiedNewton -initial

  #Monotonic Run
set disp [list 0. 0	2	2.5	2.6875	2.96875	3.074219	3.076691	3.080399	3.08596	3.094303	3.106817	3.119331	3.131845	3.150617	3.178773	3.221009	3.263244	3.305479	3.347714	3.389949	3.453302	3.548331	3.572088	3.595845	3.631481	3.684935	3.765116	3.845297	3.925478	4.005658	4.085839	4.16602	4.246201	4.326381	4.446652	4.627059	4.897669	5.303584	5.709499	6.115415	6.724288	7.637596	8.550905	9.464214	10.377523	11.747487	13.117451	14.487414	15.857378	17.227341	18.597305	19.967268	21.337233	22.707195	24.707195	26.707195	28.707195	30.707195	32.707195	34.707195	36.707195	38.707195	40.707195	42.707195	44.707195	46.707195	48.707195	50.707195	52.707195	54.707195	56.707195	58.707195	60.707195	62.707195	64.707199	66.707199	68.707199	70.707199	72.707199	74.707199	76.707199	78.707199	80.707199	82.707199	84.707199	86.707199	88.707199	90.707199	92.707199	94.707199	96.707199	98.707199	100]

  set LoopLength [llength $disp]
  set h 1 
  
# Run the static cyclic analysis
  set NSteps 1;
  set dU1 0;
  set ok 0;
  
 puts "Analysis..."
  set tStart [clock seconds];
  while {$ok == 0 && $h < $LoopLength} {
	# List is zero index
	set index [expr $h]
	# We need to relative deformation of the loading protocol
	# Subtract dUi+1 - dUi
	set D1 [lindex $disp $index];
	set D2 [lindex $disp $index-1];
	#set dU1 [expr ($D1-$D2)*$L];
	set dU1 [expr ($D1-$D2)];
	
	# Create Nsteps from Amplitude to Amplitude
	set dU [expr ($dU1)/$NSteps]
	
	# Displacement Control Integrator
	integrator DisplacementControl $CtrlNode $CtrlDOF $dU
	analysis Static
     puts "increment = [expr {$h}] / [expr {$LoopLength}]";

	set ok [ analyze $NSteps]
	
	 if {$ok != 0} {
	 puts "loop 1 to update tol"
     eval "test EnergyIncr [expr $currentTolerance*1000] 100 0"
	 algorithm NewtonLineSearch Bisection 0.75;
	 set ok [analyze [expr $NSteps/1]]
 }
 
 	 if {$ok != 0} {
	 puts "loop 2  to update tol"
     eval "test NormDispIncr [expr $currentTolerance*10000] 100 0"
	 algorithm NewtonLineSearch -type Bisection 0.75;
	 set ok [analyze [expr $NSteps/1]]
 }
 
 if {$ok != 0} {
	 puts "loop 3  to update tol"
     eval "test NormDispIncr [expr $currentTolerance*10000000000] 200 0"
	 algorithm NewtonLineSearch;
	 set ok [analyze [expr $NSteps/1]]
 }
 
 test EnergyIncr $currentTolerance 100;
 algorithm KrylovNewton;
 
	set h [expr $h + 1 ]
}	
set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;