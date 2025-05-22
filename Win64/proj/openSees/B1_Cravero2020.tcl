###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsB1_Cravero2020_testSimpsonNonUniform;			# name of output folder
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
	
	set sigmaC0_Web [expr 1.20*385.0];
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
	node 3 0.0 $L 0.0;
	node 4  -791.0 $L 0.0;
	node 5 0.0 [expr $L+306.0] 0.0;
	
# Pin constraints for same nodes
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
	set E 191020.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $d-$tf]; 			# median depth
	set J   [expr 1.0/3.0*(2*$bf*$tf**3.0 + $do*$tw**3.0)]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	#nDMaterial ElasticIsotropic 1 $E $nu
	# nDMaterial LocalBucklingFlangePlate 1 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange;
	# nDMaterial LocalBucklingWebPlate 2 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web;
	nDMaterial HLBModel 1 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange flange A992Gr50;
	nDMaterial HLBModel 2 191020.0 0.3 373.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web web A992Gr50;	
	
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

	
	set lc [expr 1.0*$d];
	# set integration "Simpson 1 21"
	set Lp1 [expr 2.0*$d/$L];
	set nIPs_Lp1 8;
	# set Lp2 [expr 1.5*$d/$L];
	# set nIPs_Lp2 $nIPs_Lp1;
	set Lp2 [expr 0*$d/$L];
	set nIPs_Lp2 1;
	set Le [expr (1-$Lp1-$Lp2)];
	set nIPs_Le 14;
	set integration "SimpsonNonUniformSpacedBeamIntegration 1 $Lp1 $nIPs_Lp1 $Lp2 $nIPs_Lp2 $Le $nIPs_Le"
	element FBCElemSGINUS 12 1 2 $ColTransfTag $integration 20 1e-6 $lc
	
	element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $BeamTransfTag 
	element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# Record stress and strains for fibers
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY172Z0.txt -ele 12 section 1 fiber 172.17 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY172Z0.txt -ele 12 section 1 fiber 172.17 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY134Z0.txt -ele 12 section 1 fiber 133.91 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY134Z0.txt -ele 12 section 1 fiber 133.91 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY96Z0.txt -ele 12 section 1 fiber 95.65 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY96Z0.txt -ele 12 section 1 fiber 95.65 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY57Z0.txt -ele 12 section 1 fiber 57.39 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY57Z0.txt -ele 12 section 1 fiber 57.39 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY19Z0.txt -ele 12 section 1 fiber 19.13 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY19Z0.txt -ele 12 section 1 fiber 19.13 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-19Z0.txt -ele 12 section 1 fiber -19.13 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-19Z0.txt -ele 12 section 1 fiber -19.13 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-57Z0.txt -ele 12 section 1 fiber -57.39 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-57Z0.txt -ele 12 section 1 fiber -57.39 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-96Z0.txt -ele 12 section 1 fiber -95.65 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-96Z0.txt -ele 12 section 1 fiber -95.65 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-134Z0.txt -ele 12 section 1 fiber -133.91 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-134Z0.txt -ele 12 section 1 fiber -133.91 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-172Z0.txt -ele 12 section 1 fiber -172.17 0.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-172Z0.txt -ele 12 section 1 fiber -172.17 0.00 strain; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_stressFiberY-202Z33.txt -ele 12 section 1 fiber -202.40 33.00 stress; 
# recorder Element -file $dataDir/B1_Cravero2020_testSimpsonNonUniform_8-14-1_strainFiberY-202Z33.txt -ele 12 section 1 fiber -202.40 33.00 strain; 


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
   load 5 0 -1800000 0 0 0 0

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
loadConst -time 0.0

puts "Model Built"




# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

puts "Running Analysis..."

# assign lateral loads and create load pattern
  set CtrlNode 4
  set CtrlDOF 1;
  pattern Plain 200 Linear {			
	 load 4 1.0 0.0 0.0 0.0 0.0 0.0;
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
  set disp [list 0. 0	1.139800549	2.279201984	3.418204308	4.556807518	5.695011616	6.832817078	7.970224857	9.107236862	10.2438612	11.38014126	12.51619148	13.65220833	14.78798103	15.9234848	17.0587101	18.1936512	19.32829857	20.46264458	21.59669685	22.73044395	23.86388016	24.997015	26.12983894	27.26235008	28.39454842	29.52643204	30.65800285	31.78926277	32.92021179	34.0508461	35.18116379	36.31116486	37.44085312	38.57022858	39.6992836	40.82802963	41.95645905	43.08457947	44.2123909	45.33988571	46.4670639	47.59393311	48.72048569	49.84672546	50.97265244	52.09825897	53.2235527	54.34852982	55.47319031	56.59754181	57.72157669	58.84529114	59.96869278	61.0917778	62.2145462	63.33699799	64.45913696	65.58095551	66.70246124	67.82365417	68.94452667	70.06509399	71.18535614	72.30530548	73.42494202	74.54426575	75.66327667	76.78197479	77.90035248	79.01842499	80.13618469	81.25363159	82.37076569	83.48757935	84.60408783	85.72028351	86.83616638	87.95173645	89.06700134	90.1819458	91.29658508	92.41091156	93.52493286	94.63864136	95.75204468	96.86514282	97.97793579	99.09042358	100.2026062	101.3144836	102.4260635	103.5373383	104.6483078	105.7589798	106.8693466	107.9794235	109.0891953	110.1986771	111.3078766	112.4167862	113.5254059	114.6337357	115.7417831	116.849556	117.9570465	119.0642624	120.1712036	121.2778931	122.3843231	123.490509	124.5964508	125.7021637	126.807663	127.912941	129.0180206	130.122879	131.2275085	132.3318787	133.4359894	134.5398254	135.6434174	136.7467194	137.8497772	138.9525757	140.0550995	141.1573792	142.2594147	143.3611908	144.4627075	145.5639801	146.6650085	147.7657623	148.8662567	149.9664917	151.066452	152.1661224	153.2655182	154.364624	155.4634552	156.5619965	157.6602478	158.7582092	159.855896	160.9532776	162.0503845	163.1472168	164.2437286	165.3399658	166.4359131	167.5315552	168.6269226	169.7219849	170.8167725	171.9112549	173.0054474	174.09935	175.1929474	176.2862549	177.3792725	178.4720001	179.5644226	180.6565552	181.7484131	182.8399658	183.9312286	185.0222015	186.1128845	187.2032776	188.2933807	189.383194	190.4727173	191.5619507	192.6508942	193.7395325	194.8278961	195.9159698	197.0037537	198.0912323	199.1784363	200.2653503	201.3519592	202.4382935	203.5243378	204.6100922	205.6955414	206.7807159	207.8656006	208.9501953	210.0345001	211.118515	212.20224	213.2856903	214.3688354	215.4516907	216.534256	217.6165466	218.6985474	219.7802429	220.8616638	221.9427948 ]

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