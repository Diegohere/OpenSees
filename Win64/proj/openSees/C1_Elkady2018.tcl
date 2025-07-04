###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_C1_Elkady2018;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;
	
	set Source "0_Source";
	source $Source/DynamicAnalysis_V04.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define section
	set bf  324;										# total flange width
	set bf4MaterialLaw [expr $bf/ 2];
	set tf  27.3;										# flange thickness
	set d 628;										# section depth
	set rKArea 15.0;									# radius of K-Area
	set tw 17.8;										# web thickness
	set h [expr $d-2*$tf-2*$rKArea];					# Web PLATE depth for material law softening
	
	set bSurTFlange [expr $bf/(2*$tf)];
	set bSurTWeb [expr $h/$tw];
	
	set sigmaC0_Web [expr 1.20*370.5703];
	set sigmaC0_Flange [expr 1.0* 511.1520];
	
	set alphaRegularization_Web 1.0;							# Factor for regularization web 
	set alphaRegularization_Flange 1.0;							# Factor for regularization flange
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 3900.0;      # Lenght of the column [mm]
	
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
	
# Pin constraints for same nodes
	#equalDOF 3 2 1 2 6; 
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	fix 2 0 0 1 1 1 1;
	
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
	# nDMaterial LocalBucklingFlangePlate 1 189507.0 0.3 368.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange;
	# nDMaterial LocalBucklingWebPlate 2 191454.0 0.3 378.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web;
	nDMaterial HLBModel 1 189507.0 0.3 368.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange flange A992Gr50;
	nDMaterial HLBModel 2 191454.0 0.3 378.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web web A992Gr50;

	
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
	# element testNonlocalElementDH 12 1 2 $ColTransfTag $integration 20 1e-5 $lc
	
	set Lp1 [expr 2.0*$d/$L];
	set nIPs_Lp1 3;
	set Lp2 $Lp1;
	set nIPs_Lp2 $nIPs_Lp1;
	set Le [expr (1-$Lp1-$Lp2)];
	set nIPs_Le 1;
	set integration "SimpsonNonUniformSpacedBeamIntegration 1 $Lp1 $nIPs_Lp1 $Lp2 $nIPs_Lp2 $Le $nIPs_Le"
	element FBCElemSGINUS 12 1 2 $ColTransfTag $integration 20 1e-8 $lc

############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

set nIPs_Label "${nIPs_Lp1}-${nIPs_Le}-${nIPs_Lp2}"

# Record displacements 
	recorder Node -file $dataDir/C1_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_Disp.txt -node 2 -dof 1 2 3 4 5 6 disp;
	
# Record reactions
	recorder Node -file $dataDir/C1_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RBase.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	recorder Node -file $dataDir/C1_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RTop.txt -node 2 -dof 1 2 3 4 5 6 reaction;
	
# Record local section deformations
   # recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_curvatureLoc.txt -ele 12 LocalSectionCurvature;
   
# Record moment distribution
   # recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_momentDistribution.txt -ele 12 momentDistribution;
   
      # Record local section deformations
   # recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_nonlocalCurvatureDistribution.txt -ele 12 NonlocalSectionCurvature;
   
# Record moment distribution
   #recorder Element -file $dataDir/C1_Elkady2018_momentDistribution.txt -ele 12 momentDistribution;
   
# Record element global forces
   # recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_globalForce.txt -ele 12 forces;
   
   # Record element basic displacements
   # recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_basicDeformations.txt -ele 12 basicDeformation;
	
# Record stress and strains for fibers
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY300Z41.txt -ele 12 section 1 fiber 300.35 40.50 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY300Z41.txt -ele 12 section 1 fiber 300.35 40.50 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY258Z0.txt -ele 12 section 1 fiber 258.03 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY258Z0.txt -ele 12 section 1 fiber 258.03 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY201Z0.txt -ele 12 section 1 fiber 200.69 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY201Z0.txt -ele 12 section 1 fiber 200.69 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY143Z0.txt -ele 12 section 1 fiber 143.35 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY143Z0.txt -ele 12 section 1 fiber 143.35 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY86Z0.txt -ele 12 section 1 fiber 86.01 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY86Z0.txt -ele 12 section 1 fiber 86.01 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY29Z0.txt -ele 12 section 1 fiber 28.67 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY29Z0.txt -ele 12 section 1 fiber 28.67 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-29Z0.txt -ele 12 section 1 fiber -28.67 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-29Z0.txt -ele 12 section 1 fiber -28.67 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-86Z0.txt -ele 12 section 1 fiber -86.01 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-86Z0.txt -ele 12 section 1 fiber -86.01 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-143Z0.txt -ele 12 section 1 fiber -143.35 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-143Z0.txt -ele 12 section 1 fiber -143.35 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-201Z0.txt -ele 12 section 1 fiber -200.69 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-201Z0.txt -ele 12 section 1 fiber -200.69 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-258Z0.txt -ele 12 section 1 fiber -258.03 0.00 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-258Z0.txt -ele 12 section 1 fiber -258.03 0.00 strain; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_stressFiberY-300Z41.txt -ele 12 section 1 fiber -300.35 40.50 stress; 
#recorder Element -file $dataDir/C1_Elkady2018_lc10DIP17_strainFiberY-300Z41.txt -ele 12 section 1 fiber -300.35 40.50 strain; 




# Define display;	
#DisplayModel2D NodeNumbers 2.8 10 10  1200 800 -wipe;
#DisplayPlane "DeformedShape" 2.8 XY 0;

	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

#Add the file paths
set lateralDispXFile "C1_Elkady2018_InPlaneTopDisp_resize25.txt"
set TotalNumberOfSteps 1863;	# number of steps in ground motion for resize 25


# Start timer
set startT [clock seconds]

# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
	load 2 0 [expr -0.2*11411000] 0 0 0 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-10;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20; 		# determine if convergence has been achieved at the end of an iteration step
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
set tStart [clock seconds];

# # analysis commands
	# constraints Plain;					# how it handles boundary conditions
	# numberer RCM;						# renumber dof's to minimize band-width (optimization)
	# system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	# #system UmfPack
	# set maxNumIter 100;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
	# set printFlag 0;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step;
	# set Tol 1.0e-12;                        # Convergence Test: tolerance	
	# #test RelativeNormUnbalance  $Tol $maxNumIter $printFlag;		# type of convergence criteria with tolerance, max iterations
	# test EnergyIncr  $Tol $maxNumIter $printFlag;
	# #algorithm NewtonLineSearch;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	# algorithm KrylovNewton 
	
	  set CtrlNode 2;
  set CtrlDOFLatX 1;
  
    set NSteps 1;
	set ok 0;
	
	set dt 1.0;


#Run the analysis


set lateralDispXSeries "Series -dt $dt -filePath $lateralDispXFile -factor [expr 1]";
set GMtime [expr $dt*$TotalNumberOfSteps + 0.0];	# total time of ground motion + free vibration
set FloorNodes [list  1 2 ]; 


	# pattern UniformExcitation 2 $CtrlDOFLatX -disp $lateralDispXSeries;
	# pattern UniformExcitation 3 $CtrlDOFLatZ -disp $lateralDispZSeries;
	# pattern UniformExcitation 4 $CtrlDOFRotZ -disp $topRotationZSeries;
	pattern MultipleSupport 2  {
		groundMotion 1 Plain -disp  $lateralDispXSeries 
	    imposedMotion $CtrlNode  $CtrlDOFLatX 1	
	};	# end pattern
	
	
	# DynamicAnalysis_V02        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0      3900.0;
	set nbNodesTot 2 ; 
DynamicAnalysis_V04        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0000      3900.0000 $nbNodesTot;

	
		
set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;