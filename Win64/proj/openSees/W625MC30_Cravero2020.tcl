###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir resultsC1_Cravero2020;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define section
	set bf  257.0;										# total flange width
	set bf4MaterialLaw [expr $bf/ 2];
	set tf  21.7;										# flange thickness
	set d 363.0;										# section depth
	set rKArea 15.0;									# radius of K-Area
	set tw 13.0;										# web thickness
	set h [expr $d-2*$tf-2*$rKArea];					# Web PLATE depth for material law softening
	
	set bSurTFlange [expr $bf/(2*$tf)];
	set bSurTWeb [expr $h/$tw];
	
	set sigmaC0_Web [expr 1.2*421.2];
	set sigmaC0_Flange [expr 1.0*511.9];
	
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
	#set lc [expr 0.0*$bf];
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	
	set lc [expr 1.0*$bf];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 15  20 1e-6 $lc
	
	element elasticBeamColumn 34 3 4 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $BeamTransfTag 
	element elasticBeamColumn 35 3 5 11500 [expr $E*1000.0] [expr $G*1000.0] 44500000 44500000 44500000 $ColTransfTag 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

#lc20bfLcSurDx1
# Record displacements 
	recorder Node -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_RBase.txt -node 1 -dof 1 2 6 reaction;
	
# Record stress and strains for fibers
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY171Z32.txt -ele 12 section 1 fiber 170.65 32.13 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY171Z32.txt -ele 12 section 1 fiber 170.65 32.13 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY144Z0.txt -ele 12 section 1 fiber 143.82 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY144Z0.txt -ele 12 section 1 fiber 143.82 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY112Z0.txt -ele 12 section 1 fiber 111.86 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY112Z0.txt -ele 12 section 1 fiber 111.86 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY80Z0.txt -ele 12 section 1 fiber 79.90 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY80Z0.txt -ele 12 section 1 fiber 79.90 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY48Z0.txt -ele 12 section 1 fiber 47.94 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY48Z0.txt -ele 12 section 1 fiber 47.94 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY16Z0.txt -ele 12 section 1 fiber 15.98 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY16Z0.txt -ele 12 section 1 fiber 15.98 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-16Z0.txt -ele 12 section 1 fiber -15.98 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-16Z0.txt -ele 12 section 1 fiber -15.98 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-48Z0.txt -ele 12 section 1 fiber -47.94 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-48Z0.txt -ele 12 section 1 fiber -47.94 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-80Z0.txt -ele 12 section 1 fiber -79.90 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-80Z0.txt -ele 12 section 1 fiber -79.90 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-112Z0.txt -ele 12 section 1 fiber -111.86 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-112Z0.txt -ele 12 section 1 fiber -111.86 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-144Z0.txt -ele 12 section 1 fiber -143.82 0.00 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-144Z0.txt -ele 12 section 1 fiber -143.82 0.00 strain; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_stressFiberY-171Z32.txt -ele 12 section 1 fiber -170.65 32.13 stress; 
recorder Element -file $dataDir/C1_Cravero2020_lc10bfLcSurDx2_strainFiberY-171Z32.txt -ele 12 section 1 fiber -170.65 32.13 strain; 


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
   load 5 0 -1604250 0 0 0 0

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
	set Tol 1.0e-6;                        # Convergence Test: tolerance	
	#test RelativeNormUnbalance  $Tol $maxNumIter $printFlag;		# type of convergence criteria with tolerance, max iterations
	test EnergyIncr  $Tol $maxNumIter $printFlag;
	#algorithm NewtonLineSearch;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	algorithm KrylovNewton 

  #Monotonic Run
  set disp [list 0. 	0	0.475961357	0.951845407	1.427652121	1.903381586	2.379033804	2.854608536	3.33010602	3.805526257	4.280869007	4.75613451	5.231322765	5.70643425	6.18146801	6.656424522	7.131303787	7.606106281	8.080831528	8.555480003	9.030053139	9.504549026	9.978969574	10.45331383	10.92758656	11.40179062	11.87592793	12.35000134	12.82401943	13.29798508	13.77191448	14.24590397	14.71990395	15.19387054	15.66779613	16.14167786	16.61551476	17.08930397	17.56304359	18.03673363	18.51037407	18.98396301	19.45750237	19.93099022	20.40442467	20.8778038	21.35113335	21.82441139	22.29763222	22.77080154	23.24391365	23.71697044	24.18997574	24.66292953	25.13582611	25.60867119	26.08145905	26.55419159	27.02686882	27.49949074	27.97205544	28.44456673	28.91702652	29.38942719	29.86177444	30.33406639	30.80630112	31.27848053	31.75060654	32.22267532	32.6946907	33.16664505	33.6385498	34.11039734	34.58218765	35.05392075	35.52560043	35.99722672	36.46879196	36.9403038	37.41175842	37.88315964	38.35450745	38.82579422	39.2970314	39.76820755	40.23932648	40.71039581	41.18140411	41.65235901	42.12325287	42.59409714	43.06488037	43.53561401	44.00628662	44.47690582	44.9474678	45.41797256	45.88842392	46.35882187	46.82915878	47.29944229	47.76966858	48.23984146	48.70995712	49.18001938	49.65002441	50.11997223	50.58986282	51.05970001	51.52947998	51.99920273	52.46887207	52.93848419	53.40803909	53.87753677	54.34697723	54.81636047	55.28568649	55.75495911	56.2241745	56.69333267	57.16242981	57.63147354	58.10046005	58.56938934	59.03826141	59.50707626	59.97583389	60.44453812	60.91318893	61.38178635	61.85032272	62.31880569	62.78723145	63.25559998	63.72391129	64.19216919	64.66036224	65.12850952	65.59658813	66.06462097	66.53259277	67.00050354	67.4683609	67.93615723	68.40390015	68.87158203	69.33921051	69.80677795	70.27429199	70.741745	71.20914459	71.67648315	72.14376068	72.6109848	73.07814789	73.5452652	74.01231384	74.47930908	74.94624329	75.41311646	75.87993622	76.34670258	76.8134079	77.28005219	77.74664307	78.21317291	78.67964172	79.14605713	79.6124115	80.07870483	80.54494476	81.01112366	81.47724915	81.9433136	82.40931702	82.87526703	83.34114838	83.80698395	84.27275085	84.73847198	85.20412445	85.66972351	86.13526154	86.60073853	87.06616211	87.53151703	87.99682617	88.46206665	88.92725372	89.39237976	89.85745239	90.32245636	90.78740692	91.25229645	91.71713257	92.18190765	92.6466217	93.11128235	93.57588959	94.04043579	94.50492096	94.96935272	95.43372345	95.89803314	96.36228943	96.82648468	97.29062653	97.75470734	98.21872711	98.68268585	99.14658356	99.61042023	100.0742035	100.5379257	101.0015945	101.4652023	101.9287491	102.3922348	102.8556671	103.3190384	103.7823486	104.2455978	104.7087936	105.171936	105.6350098	106.0980301	106.5609818	107.0238876	107.4867249	107.9495087	108.4122314	108.8749008	109.3375092	109.8000641	110.262558	110.7249832	111.1873627	111.6496735	112.1119232	112.5741196	113.0362549	113.4983292	113.96035	114.4223099	114.8842087	115.3460541	115.8078308	116.2695541	116.7312164	117.1928253	117.6543732	118.11586	118.5772934	119.0386658	119.4999847	119.961235	120.4224319	120.8835678	121.3446426	121.8056641	122.2666245	122.7275238	123.1883698	123.6491547	124.1098862	124.5705566	125.0311661	125.4917145	125.9522095	126.4126358	126.8730087	127.3333206	127.7935791	128.2537689	128.713913	129.173996	129.6340179	130.0939789	130.553894	131.0137482	131.473526	131.9332581	132.3929291	132.8525391	133.3121033	133.7715912	134.2310333	134.6904144	135.1497345	135.6089935	136.0682068	136.527359	136.9864349	137.4454651	137.9044495	138.3633575	138.8222198	139.2810211	139.7397614	140.1984558	140.657074	141.1156464	141.5741577	142.0326233	142.4910278	142.9493561	143.4076386	143.8658752	144.3240356	144.7821503	145.2402191	145.6982117	146.1561584	146.6140442	147.0718689	147.5296478	147.9873657	148.4450226	148.9026337	149.3601837	149.817688	150.2751312	150.7325134	151.1898346	151.64711	152.1043243	152.5614777	153.0185852	153.4756317	153.9326324	154.3895721	154.8464508	155.3032837	155.7600555	156.2167816	156.6734467	157.1300659	157.5866241	158.0431213	158.4995728	158.9559784	159.412323	159.8686066	160.3248596	160.7810364	161.2371826	161.6932678	162.1493073	162.6052856	163.0612183	163.5171051	163.9729309	164.4287109	164.8844452	165.3401184	165.7957611	166.2513428	166.7068787	167.1623688	167.6178131	168.0732117	168.5285645	168.9838715	169.4391327	169.8943634	170.3495331	170.8046722	171.2597504	171.714798	172.1698151	172.6247711	173.0796967	173.5345764	173.9894257	174.4442291	174.8990021	175.3537292	175.8084259	176.2630615	176.7176819	177.1722565	177.6267853	178.0812836	178.5357361	178.9901581	179.4445343	179.89888	180.3531799	180.8074341	181.2616577	181.7158508	182.1699829	182.6240845	183.0781555	183.5321808	183.9861603	184.440094	184.8939972	185.3478546	185.8016663	186.2554321	186.7091522	187.1628418	187.6164856	188.0700836	188.5236359	188.9771576	189.4306335	189.8840637	190.3374481	190.7907867	191.2440796	191.6973419	192.1505432	192.603714	193.056839	193.509903	193.9629364	194.4159241	194.868866	195.3217621	195.7746124	196.227417	196.680191	197.1329041	197.5855865	198.0382233	198.4908142	198.9433594	199.3958588	199.8483124	200.3007202	200.7530975	201.2054138	201.6576996	202.1099243	202.5621185	203.014267	203.4663696	203.9184265	204.3704529	204.8224182	205.274353	205.7262421	206.1780853	206.6298828	207.0816345	207.5333405	207.9850006	208.4366302	208.8881989	209.3397369	209.791214	210.2426605	210.694046	211.145401	211.5966949	212.0479431	212.4991455	212.9503021	213.4013977	213.8524475	214.3034515	214.7544098	215.205307	215.6561584	216.1069489	216.5576935	217.0083923	217.4590302	217.9096069	218.3601379	218.8106232	219.2610474	219.7114105	220.1617279	220.6119843	221.0621948	221.5123444	221.9624481	222.4124908	222.8624878	223.3124237	223.7622986	224.2121277	224.661911	225.1116333	225.5612946	226.01091	226.4604645	226.9099731	227.3594208	227.8088074	228.2581482	228.7074432	229.1566772	229.6058655	230.0549927	230.5040588	230.9530792]

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