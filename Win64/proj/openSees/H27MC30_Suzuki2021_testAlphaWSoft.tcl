###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_H27MC30_Suzuki2021_testAlphaWSoft;			# name of output folder
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
	
	set lc [expr 1.0*$DHSS];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 19  20 1e-6 $lc
	#element testNonlocalElementDH 12 1 2 $ColTransfTag NewtonCotes 1 5  20 1e-6 $lc
	
	element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $BeamTransfTag 
	element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# # Record stress and strains for the external fibers in the flanges
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-117Z117.txt -ele 12 section 1 fiber -116.69 116.69 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-93Z122.txt -ele 12 section 1 fiber -92.92 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-72Z122.txt -ele 12 section 1 fiber -72.28 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-52Z122.txt -ele 12 section 1 fiber -51.63 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-31Z122.txt -ele 12 section 1 fiber -30.98 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-10Z122.txt -ele 12 section 1 fiber -10.33 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY10Z122.txt -ele 12 section 1 fiber 10.33 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY31Z122.txt -ele 12 section 1 fiber 30.97 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY52Z122.txt -ele 12 section 1 fiber 51.62 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY72Z122.txt -ele 12 section 1 fiber 72.27 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY93Z122.txt -ele 12 section 1 fiber 92.92 122.25 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY117Z117.txt -ele 12 section 1 fiber 116.69 116.69 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY122Z77.txt -ele 12 section 1 fiber 122.25 77.44 strain; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_stressFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 stress; 
# recorder Element -file $dataDir/H27MC30_Suzuki2021_lc10DLcSurDx2_alphaWSoft1e3_strainFiberY-122Z77.txt -ele 12 section 1 fiber -122.25 77.44 strain; 
	
	
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
	#algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	algorithm NewtonLineSearch;

#monotonic run
#set disp [list  0. 0	6.92E-07	1.39E-06	2.10E-06	2.81E-06	3.52E-06	4.25E-06	4.98E-06	5.71E-06	6.46E-06	7.21E-06	7.21E-06	1.249472618	2.497869492	3.745201826	4.991491318	6.236748695	7.481184959	8.724986076	9.968033791	11.21030808	12.45179558	13.69248676	14.93233967	16.17137337	17.40960121	18.64703369	19.88366127	21.11951828	22.35461235	23.58897591	24.8226738	26.05581093	27.28843689	28.52049828	29.75199509	30.98299789	32.21356964	33.4437561	34.67350769	35.90277863	37.13152695	38.35973358	39.58738327	40.81446457	42.04098892	43.26695251	44.49235916	45.71718979	46.94143677	48.16510391	49.38816834	50.61062622	51.83246231	53.05367661	54.27426529	55.49422073	56.71354294	57.9322319	59.15028381	60.36770248	61.58448792	62.80063629	64.01615143	65.23103333	66.44527435	67.65888214	68.87185669	70.08419037	71.29589081	72.50696564	73.71740723	74.92721558	76.13638306	77.34492493	78.55282593	79.76010132	80.96674347	82.17275238	83.37812805	84.58287048	85.7869873	86.99047089	88.19333649	89.39556885	90.5971756	91.79815674	92.99850464	94.19823456	95.39733887	96.5958252	97.79367828	98.99091339	100.1875305	101.383522	102.5788879	103.7736359	104.9677658	106.1612778	107.3541641	108.5464325	109.7380829	110.9291153	112.1195297	113.3093262	114.4985046	115.6870728	116.8750229	118.062355	119.2490768	120.4351883	121.6206818	122.8055573	123.98983	125.1734848	126.3565292	127.5389633	128.7207947	129.9020081	131.0826111	132.2626038	133.4419861	134.6207733	135.7989349	136.9765015	138.1534576	139.3298035	140.5055542	141.6806946	142.8552246	144.0291443	145.2024689	146.3751831	147.547287	148.7187958	149.8897095	151.0600128	152.2297058	153.3988037	154.5672913	155.7351837	156.9024658	158.0691528	159.2352448	160.4007263	161.5656128	162.7299042	163.8935852	165.0566711	166.219162	167.3810425	168.5423431	169.7030334	170.8631287	172.0226288	173.1815338	174.3398438	175.4975586	176.6546783	177.811203	178.9671478	180.1224823	181.2772217	182.4313812	183.5849457	184.7378998	185.8902893	187.0420685	188.1932678	189.3438721	190.4938965	191.6433258	192.79216	193.9404144	195.0880737	196.2351532	197.3816376	198.5275421	199.6728516	200.8175812	201.9617157	203.1052704	204.2482452	205.390625	206.5324249	207.673645	208.8142853	209.9543304	211.0937958	212.2326813	213.3709869	214.5086975	215.6458435	216.7823944	217.9183655	219.0537567	220.1885681	221.3227997	222.4564514	223.5895233	224.7220154]
set disp [list 0	6.92000000000000e-07	1.39000000000000e-06	2.10000000000000e-06	2.81000000000000e-06	3.52000000000000e-06	4.25000000000000e-06	4.98000000000000e-06	5.71000000000000e-06	6.46000000000000e-06	7.21000000000000e-06	7.21000000000000e-06	1.24947261800000	2.49786949200000	3.74520182600000	4.99149131800000	6.23674869500000	7.48118495900000	8.72498607600000	9.96803379100000	11.2103080800000	12.4517955800000	13.6924867600000	14.9323396700000	16.1713733700000	17.4096012100000	18.6470336900000	19.8836612700000	21.1195182800000	22.3546123500000	23.5889759100000	24.8226738000000	26.0558109300000	27.2884368900000	28.5204982800000	29.7519950900000	30.9829978900000	32.2135696400000	33.4437561000000	34.6735076900000	35.9027786300000	37.1315269500000	38.3597335800000	39.5873832700000	40.8144645700000	42.0409889200000	43.2669525100000	44.4923591600000	45.7171897900000	46.9414367700000	48.1651039100000	49.3881683400000	50.6106262200000	51.8324623100000	53.0536766100000	54.2742652900000	55.4942207300000	56.7135429400000	57.9322319000000	59.1502838100000	60.3677024800000	61.5844879200000	62.8006362900000	64.0161514300000	65.2310333300000	66.4452743500000	67.6588821400000	68.8718566900000	70.0841903700000	71.2958908100000	72.5069656400000	73.7174072300000	74.9272155800000	76.1363830600000	77.3449249300000	78.5528259300000	79.7601013200000	80.9667434700000	82.1727523800000	83.3781280500000	84.5828704800000	85.7869873000000	86.9904708900000	88.1933364900000	89.3955688500000	90.5971756000000	91.7981567400000	92.9985046400000	94.1982345600000	95.3973388700000	96.5958252000000	97.7936782800000	98.9909133900000	100.187530500000	101.383522000000	102.578887900000	103.773635900000	104.967765800000	106.161277800000	107.354164100000	108.546432500000	109.738082900000	110.929115300000	112.119529700000	113.309326200000	114.498504600000	115.687072800000	116.875022900000	118.062355000000	119.249076800000	120.435188300000	121.620681800000	122.805557300000	123.989830000000	125.173484800000	126.356529200000	127.538963300000	128.720794700000	129.902008100000	131.082611100000	132.262603800000	133.441986100000	134.620773300000	135.798934900000	136.976501500000	138.153457600000	139.329803500000	140.505554200000	141.680694600000	142.855224600000	144.029144300000	145.202468900000	146.375183100000	147.547287000000	148.718795800000	149.889709500000	151.060012800000	152.229705800000	153.398803700000	154.567291300000	155.735183700000	156.902465800000	158.069152800000	159.235244800000	160.400726300000	161.565612800000	162.729904200000	163.893585200000	165.056671100000	166.219162000000	167.381042500000	168.542343100000	169.703033400000	170.863128700000	172.022628800000	173.181533800000	174.339843800000	175.497558600000	176.654678300000	177.811203000000	178.967147800000	180.122482300000	181.277221700000	182.431381200000	183.584945700000	184.737899800000	185.890289300000	187.042068500000	188.193267800000	189.343872100000	190.493896500000	191.643325800000	192.792160000000	193.940414400000	195.088073700000	196.235153200000	197.381637600000	198.527542100000	199.672851600000	200.817581200000	201.961715700000	203.105270400000	204.248245200000	205.390625000000	206.532424900000	207.673645000000	208.814285300000	209.954330400000	211.093795800000	212.232681300000	213.370986900000	214.508697500000	215.645843500000	216.782394400000	217.918365500000	219.053756700000	220.188568100000	221.322799700000	222.456451400000	223.589523300000	224.722015400000	224.722015400000	223.589523300000	222.456451400000	221.322799700000	220.188568100000]

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