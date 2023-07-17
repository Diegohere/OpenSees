###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsTestElement_HSS_Monotonic;;			# name of output folder
	file mkdir $dataDir;						# create output folder

	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define HSS column element section HSS300x10
	set DHSS  254;										# HSS depth
	set tPlate 9.5;										# plate width
	set rExtHSS [expr 2.5 * $tPlate];						# HSS corner external radius
	set rIntHSS [expr 1.5 * $tPlate];						# HSS corner internal radius
	set bPlate [expr $DHSS - 2 * $rExtHSS]
	set bSurTPlate [expr $bPlate / $tPlate];				# b/t HSS plate
	set sigmaC0 378.0;									    # Initial capping stress sigmaC0
	#set sigmaC0 3780.0;
	#set alphaRegularization 0.32;							# Factor for regularization
	set alphaRegularization 1.0;	
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 1525.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	set BeamTransfTag 2; 			# associate a tag to beam transformation
	#eomTransf Linear $ColTransfTag 0 1 0;		# Linear transformation
	geomTransf Corotational $ColTransfTag 0 0 1;		# Corotational transformation
	#geomTransf PDelta $ColTransfTag 0 0 1;		# Pdelta transformation
	geomTransf Linear $BeamTransfTag 0 0 1;		# Linear transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0 0.0;
	node 2 0.0 $L 0.0;
	node 3 0.0 $L 0.0;
	node 4  -791.0 $L 0.0;
	node 5 0.0 [expr $L+306.0] 0.0;
	
# Pin constraints for same nodes
	#equalDOF 3 2 1; 
	#equalDOF 5 2 2; 
	#equalDOF 3 5 1; 
	#equalDOF 5 3 2; 
	#rigidLink bar 3 2
	#rigidLink bar 4 2
	#equalDOF 3 2 1
	#equalDOF 4 2 2
	equalDOF 3 2 1 2 6; 
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	fix 2 0 0 1 1 1 0;
	fix 3 0 0 1 1 1 0;
	fix 4 0 0 1 1 1 0;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $DHSS-$tPlate]; 			# median depth
	set J   [expr $do**3*$tPlate]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 324.09 228.02 0.11 50.41 270.40 2 17707 207.18 1526.2 6.22 $bPlate $tPlate $sigmaC0 $alphaRegularization;
	
	set NWeb_LoadDir 10;
	set NWeb_TranverseDir 1;
	set NFlange_LoadDir 1;
	set NFlange_TranverseDir 4;
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
	set zJW1 [expr -($DHSS/2 - $tPlate)];
	
	set yIW2 [expr -($DHSS/2 - $rExtHSS)];
	set zIW2 [expr ($DHSS/2 - $tPlate)];
	set yJW2 [expr ($DHSS/2 - $rExtHSS)];
	set zJW2 [expr $DHSS/2];
	
	set yIF1 [expr $DHSS/2 - $tPlate];
	set zIF1 [expr -($DHSS/2 - $rExtHSS)];
	set yJF1 [expr $DHSS/2];
	set zJF1 [expr ($DHSS/2 - $rExtHSS)];
	
	set yIF2 [expr -$DHSS/2];
	set zIF2 [expr -($DHSS/2 - $rExtHSS)];
	set yJF2 [expr -($DHSS/2 - $tPlate)];
	set zJF2 [expr ($DHSS/2 - $rExtHSS)];
	
	
	section NDFiberTestNonlocal 1 -GJ $GJ {;
	#			matID  numSubdivCirc  numSubdivRad  yCenter  zCenter  intRad  extRad  startAng  endAng
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
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 10 1e-6
	
	set lc [expr 0.0*$DHSS];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	#element testNonlocalElementDH 12 1 2 $ColTransfTag NewtonCotes 1 5  20 1e-6 $lc
	
	element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $BeamTransfTag 
	element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# Record stress and strains for the external fibers in the flanges
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 strain; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_stressFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 stress; 
#recorder Element -file $dataDir/HSS254x9p5_lc0DIP9_Monotonic_strainFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 strain; 
	
	
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

# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
   load 5 0 -1005500 0 0 0 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-3;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20 2; 		# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 10;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero
loadConst -time 0.0

puts "Model Built"




# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

puts "Running Analysis..."

# assign lateral loads and create load pattern
  set CtrlNode 2
  set CtrlDOF 1;
  pattern Plain 200 Linear {			
	 load 4 1.0 0.0 0.0 0.0 0.0 0.0;
  }
  
# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test EnergyIncr 1.0e-6 1000;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	#algorithm NewtonLineSearch Bisection 0.75;

  #set Dmax  [expr 0.1*$L];            # maximum displacement
  set N 200;                           # number of iterations
  #set Dincr [expr 0.15*$L/$N];			# increment in displacement
  set Dincr [expr -250.0/$N];			# increment in displacement
  set h 0  
  
# Run the static cyclic analysis
  set NSteps 1;
  set dU1 0;  
   set ok 0;
  
  while {$ok == 0 && $h < $N} {

	# Displacement Control Integrator
	integrator DisplacementControl $CtrlNode $CtrlDOF $Dincr

	analysis Static
     puts "increment = [expr {$h +1}] / $N";

	set ok [ analyze $NSteps]
	set h [expr $h + 1 ]
} 	


set endT [clock seconds] 

puts "Execution time: [expr $endT-$startT] seconds."

	

wipe all;