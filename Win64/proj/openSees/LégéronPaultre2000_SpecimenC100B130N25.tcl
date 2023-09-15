###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 2 -ndf 3;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_LegeronPaultre2000_SpecimenC100B130N25;			# name of output folder
	file mkdir $dataDir;						# create output folder

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define HSS column element section HSS300x20
	set width    305.
	set depth   305.
	set cover 19.;			# Column cover to reinforcing steel NA.
	set As20 300. ;		# area of longitudinal-reinforcement bars 20
	set As15 200. ;		# area of longitudinal-reinforcement bars phi20
 
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 2150.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	#geomTransf Linear $ColTransfTag;		# Linear transformation
	geomTransf Corotational $ColTransfTag;		# Corotational transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0;
	node 2 0.0 $L;
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	#fix 1 1 1 1; #cantiliver
	fix 1 1 1 1
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	# Core concrete (confined)
	uniaxialMaterial Concrete01 1  -105.6184   -0.0038  -21.1237   -0.0352
	# Cover concrete (unconfined)
	uniaxialMaterial Concrete01 2 -97.7000   -0.0035  -19.5400   -0.0051
	#Steel reinforcement
	#uniaxialMaterial ReinforcingSteel 3 430.0 661.0 200000.0 5000.0 0.0106 0.142 -DMBuck 6.5 1.0; #LegeronPaultre2000_SpecimenC100B130N25 phi20
	#uniaxialMaterial ReinforcingSteel 4 494.0 729.0 200000.0 5000.0 0.01265 0.132 -DMBuck 8.67 1.0; #LegeronPaultre2000_SpecimenC100B130N25 phi15
	#uniaxialMaterial Steel02 3 430.9 200000.0 0.025 15.0 0.925 0.15
	#uniaxialMaterial Steel02 4 494.0 200000.0 0.025 15.0 0.925 0.15
	uniaxialMaterial Steel01 3 430.9 200000.0 0.025 
	uniaxialMaterial Steel01 4 494.0 200000.0 0.025 

	
# some variables derived from the parameters
set y1 [expr $depth/2.0]
set z1 [expr $width/2.0]

	
section Fiber 1 {

    # Create the concrete core fibers
    patch rect 1 10 1 [expr $cover-$y1] [expr $cover-$z1] [expr $y1-$cover] [expr $z1-$cover]

    # Create the concrete cover fibers (top, bottom, left, right)
    patch rect 2 10 1  [expr -$y1] [expr $z1-$cover] $y1 $z1
    patch rect 2 10 1  [expr -$y1] [expr -$z1] $y1 [expr $cover-$z1]
    patch rect 2  1 1  [expr -$y1] [expr $cover-$z1] [expr $cover-$y1] [expr $z1-$cover]
    patch rect 2  1 1  [expr $y1-$cover] [expr $cover-$z1] $y1 [expr $z1-$cover]

    # Create the reinforcing fibers (left, middle, right)
    layer straight 3 2 $As20 [expr $y1-$cover] [expr $z1-$cover] [expr $y1-$cover] [expr $cover-$z1]
    layer straight 4 2 $As15 0.0 [expr $z1-$cover] 0.0 [expr $cover-$z1]
	layer straight 4 2 $As15 [expr $cover-$y1] 0.0 [expr $y1-$cover] 0.0
    layer straight 3 2 $As20 [expr $cover-$y1] [expr $z1-$cover] [expr $cover-$y1] [expr $cover-$z1]

}

	
	#set integration "NewtonCotes 1 9"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 10 1e-6
	
	set lc [expr 0.0*$depth];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 9  10000 1e-8 $lc
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/LegeronPaultre2000_SpecimenC100B130N25_lc0DIP9_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/LegeronPaultre2000_SpecimenC100B130N25_lc0DIP9_RBase.txt -node 1 -dof 1 2 3 reaction;
	
# Record stress and strains for fibers
	#recorder Element -file $dataDir/Soesianawati_Specimen2_backboneTension_steel_stress.txt -ele 12 section 1 fiber 150. 150. 1 stress;
	#recorder Element -file $dataDir/Soesianawati_Specimen2_backboneTension_steel_strain.txt -ele 12 section 1 fiber 150. 150. 1 strain;
	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# Start timer
set startT [clock seconds]

# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
	load 2 0 -2400000 0

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
  set CtrlNode 2
  set CtrlDOF 1;
  pattern Plain 200 Linear {			
	 load $CtrlNode 1.0 0.0 0.0;
  }
  
# analysis commands
	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test EnergyIncr 1.0e-8 10000;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	#algorithm NewtonLineSearch;

#cyclic run
set disp [list 0. -1.2203	-0.589	1.7042	5.0601	6.3962	7.1852	8.1214	9.4785	11.12	13.213	13.182	10.73	8.3844	6.312	4.5131	2.6931	0.663	-0.989	-3.3348	-3.966	-4.7024	-6.6486	-8.5528	-10.467	-13.034	-14.139	-16.159	-16.853	-15.517	-12.698	-10.11	-8.0373	-6.1752	-4.3868	-2.8194	-2.3144	-1.5149	0.505	2.4091	3.7977	5.2179	7.7638	9.731	12.834	16.19	18.505	22.523	27.71	28.762	30.35	30.592	27.541	24.185	20.693	16.948	14.391	12.203	10.331	8.0268	5.7439	3.5347	1.4833	-1.9041	-7.5113	-11.93	-16.39	-19.525	-24.838	-29.098	-33.085	-33.496	-32.528	-28.036	-23.533	-18.894	-15.054	-12.845	-10.268	-7.7953	-6.2384	-5.1232	-3.177	-0.936	1.7253	4.7656	8.1951	12.34	16.106	20.556	23.744	27.731	30.834	29.256	25.027	21.103	17.39	13.96	11.341	8.9315	6.5119	3.8293	0.968	-2.1987	-5.1653	-8.6685	-12.95	-17.421	-21.913	-26.311	-29.666	-32.349	-33.222	-33.517	-32.612	-28.12	-23.659	-19.241	-15.896	-12.508	-8.5212	-7.7427	-4.6814	-2.8194	-0.968	2.4196	6.049	10.972	16.632	21.156	25.522	30.098	33.485	38.009	41.449	45.646	46.93	44.836	39.271	34.8	30.371	25.9	21.461	17.011	12.561	8.2792	4.8918	1.9988	-2.083	-6.5329	-10.983	-16.548	-21.019	-25.448	-29.94	-35.473	-37.714	-43.963	-48.266	-46.825	-42.375	-37.883	-33.359	-28.825	-24.406	-19.956	-15.422	-12.066	-7.9005	-3.6925	-0.558	4.492	10.005	15.622	21.24	26.994	32.528	38.177	42.901	47.54	47.045	42.617	38.156	33.706	29.235	24.974	20.903	16.054	10.509	6.0385	0.147	-6.554	-13.224	-19.904	-28.793	-35.505	-42.143	-47.761	-47.529	-42.837	-37.23	-31.602	-27.131	-22.576	-18.158	-13.708	-8.1425	-2.5774	3.0718	8.8263	14.465	20.041	26.7	32.496	38.093	41.565	47.13	51.054	52.137	52.137	52.137	56.587	62.342	62.236	57.839	52.284	46.719	41.102	35.579	30.024	24.459	18.894	13.318	7.7532	1.0836	-4.4815	-11.151	-17.831	-23.396	-31.192	-37.872	-44.563	-50.149	-55.609	-61.153	-65.624	-64.172	-59.764	-55.114	-50.696	-46.151	-41.554	-37.146	-32.717	-26.942	-22.355	-15.675	-10.089	-4.5446	1.1256	7.869	14.56	21.314	28.078	34.853	40.491	46.057	52.905	57.439	59.996	62.92	63.173	59.806	55.714	50.149	44.584	39.019	33.433	27.889	22.323	16.737	11.172	5.6072	-1.052	-7.7427	-14.412	-21.082	-26.689	-35.568	-44.458	-52.253	-56.703	-64.582	-63.551	-63.551	-59.028	-53.505	-47.866	-42.08	-37.63	-29.635	-29.635	-20.503	-8.1951	0.884	12.34	21.45	31.434	46.256	58.554	60.848	68.675	75.449	84.854	90.44	92.471	87.495	82.151	75.523	70.011	60.785	52.358	36.788	16.758	0.0631	-14.423	-26.647	-38.924	-48.907	-62.015	-73.672	-83.687	-85.896	-91.629	-95.869	-90.072	-84.339	-76.449	-66.002	-59.08	-51.222	-42.196	-33.222	-24.133	-14.044	-3.9134	5.0601	17.505	25.248	33.212	41.091	49.002	55.693	59.017	69.706	74.261	77.764	82.266	86.359	91.924	93.775	89.431	84.118	78.553	73.009	68.559	64.098]

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