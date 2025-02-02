###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_testShear_IPE300_Lin;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define wide flange section
	set bf  150.0;										# total flange width
	set tf  10.7;										# flange thickness
	set d 300.0;										# section depth
	set tw 7.1;										# web thickness
	
	set alphaRegularization 1.0;
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 500.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	set BeamTransfTag 2; 			# associate a tag to beam transformation
	geomTransf Linear $ColTransfTag 0 0 -1;		# Linear transformation
	#geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
	
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
	
	
	set NFlange_yDir 3;
	set NFlange_zDir 20;
	set NWeb_yDir 78;
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
	set nIP 5
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 $nIP  20 1e-6 $lc 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/testShear_IPE300_strongAxis_Disp_IP5.txt -node 2 -dof 1 2 3 4 5 6 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShear_IPE300_strongAxis_RBase_IP5.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record section connectivity and coordinate matrices
recorder Element -file $dataDir/testShear_IPE300_strongAxis_connectivityMatrix.txt -ele 12 section 1 connectivity; 
recorder Element -file $dataDir/testShear_IPE300_strongAxis_coordinateMatrix.txt -ele 12 section 1 coordinate; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear_IPE300_strongAxis_allFiberStresses_IP5.txt -ele 12 section [expr {int($nIP / 2) + 1}] allFiberStresses; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear_IPE300_strongAxis_allFiberStrains_IP5.txt -ele 12 section [expr {int($nIP / 2) + 1}] allFiberStrains; 


# Record all fiber gradPsiShear
#recorder Element -file $dataDir/testShear_IPE300_strongAxis_gradPsiShear_sec1_IP5.txt -ele 12 section 1 gradPsiShear; 

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
set disp [list 0. 0	1	1.25	1.34375	1.378906	1.39209	1.405273	1.418457	1.431641	1.444824	1.44812	1.451416	1.45636	1.461304	1.46254	1.463776	1.46563	1.46841	1.472582	1.478839	1.485096	1.491353	1.49761	1.503867	1.510124	1.516381	1.522638	1.532024	1.546102	1.560181	1.574259	1.588337	1.602416	1.616494	1.630573	1.644651	1.665769	1.686886	1.708004	1.729121	1.750239	1.771356	1.792474	1.813591	1.845268	1.876944	1.908621	1.940297	1.971973	2.00365	2.035326	2.067002	2.098679	2.130355	2.162031	2.209546	2.280818	2.352089	2.423361	2.494633	2.565905	2.637177	2.744084	2.850992	2.9579	3.064807	3.225169	3.38553	3.545892	3.706254	3.866615	4.026977	4.187338	4.3477	4.508061	4.668423	4.828784	4.989146	5.149508	5.309869	5.470231	5.630592	5.871134	6.111677	6.352219	6.713032	7.254252	8.066083	9.066083	10.066083	11.066083	12.066083	13.066083	14.066083	15.066083	16.066082	17.066082	18.066082	19.066082	20.066082	21.066082	22.066082	23.066082	24.066082	25.066082	26.066082	27.066082	28.066082	29.066082	30.066082	31.066082	32.066082	33.066082	34.066082	35.066082	36.066082	37.066082	38.066082	39.066082	40.066082	41.066082	42.066082	43.066082	44.066082	45.066082	46.066082	47.066082	48.066082	49.066082	50]

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