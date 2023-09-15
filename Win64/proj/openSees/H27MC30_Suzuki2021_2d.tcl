###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 2 -ndf 3;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_H27MC30_Suzuki2021_2dSL;			# name of output folder
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
	set bPlate [expr $DHSS - 2 * $rExtHSS];
	set bSurTPlate [expr $bPlate / $tPlate];				# b/t HSS plate	
	set DSurTHSS [expr $DHSS /$tPlate];
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
	geomTransf Corotational $ColTransfTag;		# Corotational transformation
	geomTransf Linear $BeamTransfTag;		# Linear transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0;
	node 2 0.0 $L;
	node 3 0.0 $L;
	node 4  -791.0 $L;
	node 5 0.0 [expr $L+306.0];
	
# Pin constraints for same nodes
	equalDOF 3 2 1 2 3; 
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 ;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000.;
	
	#A500 Gr.B steel material parameters from Suzuki and Lignos 2020
	uniaxialMaterial SLModel 1 $DSurTHSS 200000. 315. 2500. 19.	22.4 7.2 382.8466982 0.008812135 -2822.487499 -516.0389276 234.4971188 0.061026586 0.027610273 0.665413237	1.; # Updated model
	#uniaxialMaterial LocalBucklingWebPlateUniaxial 1 200000.0 0.3 324.09 228.02 0.11 50.41 270.40 2 17707 207.18 1526.2 6.22 $bPlate $tPlate $sigmaC0 $alphaRegularization;
	
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
	
	
	section Fiber 1 {;
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
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 9  1000 1e-8 $lc
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	
	element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] 44500000 $BeamTransfTag 
	element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_RBase.txt -node 1 -dof 1 2 3 reaction;
	
# Record stress and strains for the external fibers in the flanges
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 strain; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 stress; 
#recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 strain; 
recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 stress; 
recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 strain; 
recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_stressFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 stress; 
recorder Element -file $dataDir/H27MC30_Suzuki2021_lc0DIP9_2d_strainFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 strain; 
	
	
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
	load 5 0 -1005500 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-6;			# convergence tolerance for test
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
  set CtrlNode 4
  set CtrlDOF 1;
  pattern Plain 200 Linear {			
	 load 4 1.0 0.0 0.0;
  }
  
# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test EnergyIncr 1.0e-8 2000;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	#algorithm NewtonLineSearch;

#monotonic run
set disp [list  0. 0	6.92E-07	1.39E-06	2.10E-06	2.81E-06	3.52E-06	4.25E-06	4.98E-06	5.71E-06	6.46E-06	7.21E-06	7.21E-06	1.249472618	2.497869492	3.745201826	4.991491318	6.236748695	7.481184959	8.724986076	9.968033791	11.21030808	12.45179558	13.69248676	14.93233967	16.17137337	17.40960121	18.64703369	19.88366127	21.11951828	22.35461235	23.58897591	24.8226738	26.05581093	27.28843689	28.52049828	29.75199509	30.98299789	32.21356964	33.4437561	34.67350769	35.90277863	37.13152695	38.35973358	39.58738327	40.81446457	42.04098892	43.26695251	44.49235916	45.71718979	46.94143677	48.16510391	49.38816834	50.61062622	51.83246231	53.05367661	54.27426529	55.49422073	56.71354294	57.9322319	59.15028381	60.36770248	61.58448792	62.80063629	64.01615143	65.23103333	66.44527435	67.65888214	68.87185669	70.08419037	71.29589081	72.50696564	73.71740723	74.92721558	76.13638306	77.34492493	78.55282593	79.76010132	80.96674347	82.17275238	83.37812805	84.58287048	85.7869873	86.99047089	88.19333649	89.39556885	90.5971756	91.79815674	92.99850464	94.19823456	95.39733887	96.5958252	97.79367828	98.99091339	100.1875305	101.383522	102.5788879	103.7736359	104.9677658	106.1612778	107.3541641	108.5464325	109.7380829	110.9291153	112.1195297	113.3093262	114.4985046	115.6870728	116.8750229	118.062355	119.2490768	120.4351883	121.6206818	122.8055573	123.98983	125.1734848	126.3565292	127.5389633	128.7207947	129.9020081	131.0826111	132.2626038	133.4419861	134.6207733	135.7989349	136.9765015	138.1534576	139.3298035	140.5055542	141.6806946	142.8552246	144.0291443	145.2024689	146.3751831	147.547287	148.7187958	149.8897095	151.0600128	152.2297058	153.3988037	154.5672913	155.7351837	156.9024658	158.0691528	159.2352448	160.4007263	161.5656128	162.7299042	163.8935852	165.0566711	166.219162	167.3810425	168.5423431	169.7030334	170.8631287	172.0226288	173.1815338	174.3398438	175.4975586	176.6546783	177.811203	178.9671478	180.1224823	181.2772217	182.4313812	183.5849457	184.7378998	185.8902893	187.0420685	188.1932678	189.3438721	190.4938965	191.6433258	192.79216	193.9404144	195.0880737	196.2351532	197.3816376	198.5275421	199.6728516	200.8175812	201.9617157	203.1052704	204.2482452	205.390625	206.5324249	207.673645	208.8142853	209.9543304	211.0937958	212.2326813	213.3709869	214.5086975	215.6458435	216.7823944	217.9183655	219.0537567	220.1885681	221.3227997	222.4564514	223.5895233	224.7220154]

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