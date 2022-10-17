###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsHSS300x8p3;			# name of output folder
	file mkdir $dataDir;						# create output folder

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define HSS column element section HSS300x20
	set bPlate  300.0;										# HSS depth
	set tPlate 8.3003;										# plate width
	set rExtHSS [expr 3.0 * $tPlate];						# HSS corner external radius
	set rIntHSS [expr 2.0 * $tPlate];						# HSS corner internal radius
	set bSurTPlate [expr $bPlate / $tPlate];				# b/t HSS plate
	set bHSS4MaterialLaw [expr $bPlate - 2 * $rExtHSS]
	#set sigmaC0 354.0285;									    # Initial capping stress sigmaC0
	set sigmaC0 380;									    # sigmaC0 taken from Abaqus plate simulations
	set alphaRegularization 1.0;							# Factor for regularization
	
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
	#eomTransf Linear $ColTransfTag 0 1 0;		# Linear transformation
	geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
	#geomTransf PDelta $ColTransfTag 0 0 1;		# Pdelta transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0 0.0;
	node 2 $L 0.0 0.0;
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	fix 2 0 0 0 0 0 0;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $bPlate-$tPlate]; 			# median depth
	set J   [expr $do**3*$tPlate]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	#nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 370.0 0.0 1.0 0.0 1.0 1 3512.0 30.0 $bHSS4MaterialLaw $tPlate $sigmaC0 $alphaRegularization;
	nDMaterial LocalBucklingWebPlate 1 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bHSS4MaterialLaw $tPlate $sigmaC0 $alphaRegularization;

	
	set NWeb_LoadDir 10;
	set NWeb_TranverseDir 1;
	set NFlange_LoadDir 1;
	set NFlange_TranverseDir 4;
	set NCorner_Circ 1; 
	set NCorner_Rad 1; 
	
	set absCoordCenterCorner [expr $bPlate/2 - $rExtHSS];
	set zC1 [expr $absCoordCenterCorner];
	set yC1 [expr $absCoordCenterCorner];
	set zC2 [expr -$absCoordCenterCorner];
	set yC2 [expr $absCoordCenterCorner];
	set zC3 [expr -$absCoordCenterCorner];
	set yC3 [expr -$absCoordCenterCorner];
	set zC4 [expr $absCoordCenterCorner];
	set yC4 [expr -$absCoordCenterCorner];
	
	set yIW1 [expr -($bPlate/2 - $rExtHSS)];
	set zIW1 [expr -$bPlate/2];
	set yJW1 [expr ($bPlate/2 - $rExtHSS)];
	set zJW1 [expr -($bPlate/2 - $tPlate)];
	
	set yIW2 [expr -($bPlate/2 - $rExtHSS)];
	set zIW2 [expr ($bPlate/2 - $tPlate)];
	set yJW2 [expr ($bPlate/2 - $rExtHSS)];
	set zJW2 [expr $bPlate/2];
	
	set yIF1 [expr $bPlate/2 - $tPlate];
	set zIF1 [expr -($bPlate/2 - $rExtHSS)];
	set yJF1 [expr $bPlate/2];
	set zJF1 [expr ($bPlate/2 - $rExtHSS)];
	
	set yIF2 [expr -$bPlate/2];
	set zIF2 [expr -($bPlate/2 - $rExtHSS)];
	set yJF2 [expr -($bPlate/2 - $tPlate)];
	set zJF2 [expr ($bPlate/2 - $rExtHSS)];
	
	
	section NDFiber 1 -GJ $GJ {;
	#			matID  numSubdivCirc  numSubdivRad  yCenter  zCenter  intRad  extRad  startAng  endAng
	patch circ 1 1 1 $yC1 $zC1 $rIntHSS $rExtHSS 0 90;
	patch circ 1 1 1 $yC2 $zC2 $rIntHSS $rExtHSS 270 360;
	patch circ 1 1 1 $yC3 $zC3 $rIntHSS $rExtHSS 180 270;
	patch circ 1 1 1 $yC4 $zC4 $rIntHSS $rExtHSS 90 180;
	
	#			 matTag  umSubdivY  numSubdivZ  yI  	zI  	yJ    zJ
	patch rect 1 1 4 $yIF1 $zIF1 $yJF1 $zJF1;
	patch rect 1 1 4 $yIF2 $zIF2 $yJF2 $zJF2;
	
	patch rect 1 10 1 $yIW1 $zIW1 $yJW1 $zJW1;
	patch rect 1 10 1 $yIW2 $zIW2 $yJW2 $zJW2;
	}

	set lc [expr 1.0*$bPlate];
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 20 1e-6
	element gradientForceBeamColumn 12 1 2 $ColTransfTag NewtonCotesUpdated 1 5  20 1e-6 $lc
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# Record stress and strains for the external fibers in the flanges
	recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos7.txt -ele 12 section 1 fiber 144 -85.5 1 stress;
	recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos7.txt -ele 12 section 1 fiber 144 -85.5 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos6.txt -ele 12 section 1 fiber 135.2 -135.2 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos6.txt -ele 12 section 1 fiber 135.2 -135.2 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos5.txt -ele 12 section 1 fiber 102.6 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos5.txt -ele 12 section 1 fiber 102.6 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos4.txt -ele 12 section 1 fiber 79.8 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos4.txt -ele 12 section 1 fiber 79.8 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos3.txt -ele 12 section 1 fiber 57 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos3.txt -ele 12 section 1 fiber 57 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos2.txt -ele 12 section 1 fiber 34.2 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos2.txt -ele 12 section 1 fiber 34.2 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerPos1.txt -ele 12 section 1 fiber 11.4 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerPos1.txt -ele 12 section 1 fiber 11.4 -144 1 strain;
	
	
	recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg7.txt -ele 12 section 1 fiber -144 -85.5 1 stress;
	recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg7.txt -ele 12 section 1 fiber -144 -85.5 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg6.txt -ele 12 section 1 fiber -135.2 -135.2 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg6.txt -ele 12 section 1 fiber -135.2 -135.2 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg5.txt -ele 12 section 1 fiber -102.6 144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg5.txt -ele 12 section 1 fiber -102.6 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg4.txt -ele 12 section 1 fiber -79.8 144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg4.txt -ele 12 section 1 fiber -79.8 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg3.txt -ele 12 section 1 fiber -57 144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg3.txt -ele 12 section 1 fiber -57 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg2.txt -ele 12 section 1 fiber -34.2 144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg2.txt -ele 12 section 1 fiber -34.2 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_stressFiberLayerNeg1.txt -ele 12 section 1 fiber -11.4 144 1 stress;
	#recorder Element -file $dataDir/HSS300x8p3_sigmaC0Plate_Monotonic_NoAxialLoad_nonlocal5IpLc1D_strainFiberLayerNeg1.txt -ele 12 section 1 fiber -11.4 144 1 strain;

	
	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# Start timer
set startT [clock seconds]

# define GRAVITY -------------------------------------------------------------
#No gravity loading

puts "Model Built"




# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

puts "Running Analysis..."

# assign lateral loads and create load pattern
  set CtrlNode 2
  set CtrlDOF 2;
  pattern Plain 200 Linear {			
	 load $CtrlNode 0.0 1.0 0.0 0.0 0.0 0.0;
  }
  
# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system UmfPack;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test EnergyIncr 1.0e-8 5000;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration

  #Monotonic Run
  set disp [list 0. 0	1.25	2.5	3.75	5	6.25	7.5	8.75	10	11.25	12.5	13.75	15	16.25	17.5	18.75	20	21.25	22.5	23.75	25	26.25	27.5	28.75	30	31.25	32.5	33.75	35	36.25	37.5	38.75	40	41.25	42.5	43.75	45	46.25	47.5	48.75	50	51.25	52.5	53.75	55	56.25	57.5	58.75	60	61.25	62.5	63.75	65	66.25	67.5	68.75	70	71.25	72.5	73.75	75	76.25	77.5	78.75	80	81.25	82.5	83.75	85	86.25	87.5	88.75	90	91.25	92.5	93.75	95	96.25	97.5	98.75	100	101.25	102.5	103.75	105	106.25	107.5	108.75	110	111.25	112.5	113.75	115	116.25	117.5	118.75	120	121.25	122.5	123.75	125	126.25	127.5	128.75	130	131.25	132.5	133.75	135	136.25	137.5	138.75	140	141.25	142.5	143.75	145	146.25	147.5	148.75	150	151.25	152.5	153.75	155	156.25	157.5	158.75	160	161.25	162.5	163.75	165	166.25	167.5	168.75	170	171.25	172.5	173.75	175	176.25	177.5	178.75	180	181.25	182.5	183.75	185	186.25	187.5	188.75	190	191.25	192.5	193.75	195	196.25	197.5	198.75	200	201.25	202.5	203.75	205	206.25	207.5	208.75	210	211.25	212.5	213.75	215	216.25	217.5	218.75	220	221.25	222.5	223.75	225	226.25	227.5	228.75	230	231.25	232.5	233.75	235	236.25	237.5	238.75	240	241.25	242.5	243.75	245	246.25	247.5	248.75	250  ]

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
	set h [expr $h + 1 ]
} 	
set tFinish [clock seconds];
puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;