###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsHSS300x6p5;			# name of output folder
	file mkdir $dataDir;						# create output folder

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define HSS column element section HSS300x20
	set bPlate  300.0;										# HSS depth
	set tPlate 6.55;										# plate width
	set rExtHSS [expr 3.0 * $tPlate];						# HSS corner external radius
	set rIntHSS [expr 2.0 * $tPlate];						# HSS corner internal radius
	set bSurTPlate [expr $bPlate / $tPlate];				# b/t HSS plate
	set bHSS4MaterialLaw [expr $bPlate - 2 * $rExtHSS]
	set sigmaC0 302.3022;									    # Initial capping stress sigmaC0
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

	set lc [expr 2.5*$bPlate];
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 20 1e-6
	element gradientForceBeamColumn 12 1 2 $ColTransfTag NewtonCotesUpdated 1 9  20 1e-6 $lc
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# Record stress and strains for the external fibers in the flanges
	recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos7.txt -ele 12 section 1 fiber 144 -85.5 1 stress;
	recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos7.txt -ele 12 section 1 fiber 144 -85.5 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos6.txt -ele 12 section 1 fiber 135.2 -135.2 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos6.txt -ele 12 section 1 fiber 135.2 -135.2 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos5.txt -ele 12 section 1 fiber 102.6 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos5.txt -ele 12 section 1 fiber 102.6 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos4.txt -ele 12 section 1 fiber 79.8 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos4.txt -ele 12 section 1 fiber 79.8 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos3.txt -ele 12 section 1 fiber 57 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos3.txt -ele 12 section 1 fiber 57 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos2.txt -ele 12 section 1 fiber 34.2 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos2.txt -ele 12 section 1 fiber 34.2 -144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerPos1.txt -ele 12 section 1 fiber 11.4 -144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerPos1.txt -ele 12 section 1 fiber 11.4 -144 1 strain;
	
	
	recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg7.txt -ele 12 section 1 fiber -144 -85.5 1 stress;
	recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg7.txt -ele 12 section 1 fiber -144 -85.5 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg6.txt -ele 12 section 1 fiber -135.2 -135.2 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg6.txt -ele 12 section 1 fiber -135.2 -135.2 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg5.txt -ele 12 section 1 fiber -102.6 144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg5.txt -ele 12 section 1 fiber -102.6 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg4.txt -ele 12 section 1 fiber -79.8 144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg4.txt -ele 12 section 1 fiber -79.8 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg3.txt -ele 12 section 1 fiber -57 144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg3.txt -ele 12 section 1 fiber -57 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg2.txt -ele 12 section 1 fiber -34.2 144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg2.txt -ele 12 section 1 fiber -34.2 144 1 strain;
	
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_stressFiberLayerNeg1.txt -ele 12 section 1 fiber -11.4 144 1 stress;
	#recorder Element -file $dataDir/HSS300x6p5_Monotonic_NoAxialLoad_nonlocal9IpLc25D_strainFiberLayerNeg1.txt -ele 12 section 1 fiber -11.4 144 1 strain;

	
	
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
set disp [list 0. 0.	1.25	2.5	3.75	5	6.25	7.5	8.75	10	11.25	12.5	12.8125	13.125	13.59375	14.296875	15.3515625	16.6015625	17.8515625	19.1015625	20.3515625	21.6015625	22.8515625	24.1015625	25.3515625	26.6015625	27.8515625	29.1015625	30.3515625	31.6015625	32.8515625	34.1015625	35.3515625	36.6015625	37.8515625	39.1015625	40.3515625	41.6015625	42.8515625	44.1015625	45.3515625	46.6015625	47.8515625	49.1015625	50.3515625	51.6015625	52.8515625	54.1015625	55.3515625	56.6015625	57.8515625	59.1015625	60.3515625	61.6015625	62.8515625	64.1015625	65.3515625	66.6015625	67.8515625	69.1015625	70.3515625	71.6015625	72.8515625	74.1015625	75.3515625	76.6015625	77.8515625	79.1015625	80.3515625	81.6015625	82.8515625	84.1015625	85.3515625	86.6015625	87.8515625	89.1015625	90.3515625	91.6015625	92.8515625	94.1015625	95.3515625	96.6015625	97.8515625	99.1015625	100.3515625	101.6015625	102.8515625	104.1015625	105.3515625	106.6015625	107.8515625	109.1015625	110.3515625	111.6015625	112.8515625	114.1015625	115.3515625	116.6015625	117.8515625	119.1015625	120.3515625	121.6015625	122.8515625	124.1015625	125.3515625	126.6015625	127.8515625	129.1015625	130.3515625	131.6015625	132.8515625	134.1015625	135.3515625	136.6015625	137.8515625	139.1015625	140.3515625	141.6015625	142.8515625	144.1015625	145.3515625	146.6015625	147.8515625	149.1015625	150.3515625	151.6015625	152.8515625	154.1015625	155.3515625	156.6015625	157.8515625	159.1015625	160.3515625	161.6015625	162.8515625	164.1015625	165.3515625	166.6015625	167.8515625	169.1015625	170.3515625	171.6015625	172.8515625	174.1015625	175.3515625	176.6015625	177.8515625	179.1015625	180.3515625	181.6015625	182.8515625	184.1015625	185.3515625	186.6015625	187.8515625	189.1015625	190.3515625	191.6015625	192.8515625	194.1015625	195.3515625	196.6015625	197.8515625	199.1015625	200.3515625	201.6015625	202.8515625	204.1015625	205.3515625	206.6015625	207.8515625	209.1015625	210.3515625	211.6015625	212.8515625	214.1015625	215.3515625	216.6015625	217.8515625	219.1015625	220.3515625	221.6015625	222.8515625	224.1015625	225.3515625	226.6015625	227.8515625	229.1015625	230.3515625	231.6015625	232.8515625	234.1015625	235.3515625	236.6015625	237.8515625	239.1015625	240.3515625	241.6015625	242.8515625	244.1015625	245.3515625	246.6015625	247.8515625	249.1015625	250]

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