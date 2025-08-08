###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	# set dataDir results_C6_Elkady2018_vuIllCondTol1e8ElasticOnly_resize12;			# name of output folder
	set dataDir results_C6_Elkady2018_vuIllCondTol1e8ElasticOnly_resize12;			# name of output folder
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
	
	set sigmaC0_Web [expr 1.15*370.5703];
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
	node 2 0.0 0.0 0.0; #Node for spring
	node 3 0.0 $L 0.0;
	
# Pin constraints for same nodes
	#equalDOF 3 2 1 2 6; 
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	fix 3 0 0 1 1 1 0;
	
#Constraints for zero length
	equalDOF 1 2 1 2 3 4 5 
	
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
	nDMaterial HLBModel 1 205903.0 0.3 368.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange flange A992Gr50;
	nDMaterial HLBModel 2 202923.0 0.3 378.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web web A992Gr50;

	
	# set NFlange_LoadingDir 1;
	# set NFlange_TranverseDir 4;
	# set NWeb_LoadingDir 10;
	# set NWeb_TranverseDir 1;	
	
	# section NDFiberTestNonlocal 1 -GJ $GJ {;	
	# #			 matTag  umSubdivY  numSubdivZ  yI  	zI  	yJ    zJ
	# patch rect 1 $NFlange_LoadingDir $NFlange_TranverseDir [expr -$d/2]               [expr -$bf/2]                    [expr -($d/2-$tf)]             [expr $bf/2];	#Bottom flange
	# patch rect 2 $NWeb_LoadingDir $NWeb_TranverseDir            [expr -($d/2-$tf)] [expr -$tw/2] [expr ($d/2-$tf)] [expr $tw/2];									#Web
	# patch rect 1 $NFlange_LoadingDir $NFlange_TranverseDir [expr ($d/2-$tf)]             [expr -$bf/2]                    [expr $d/2]             [expr $bf/2];		#Top flange

	# }
	
	set NFlange_yDir 1;
	set NFlange_zDir 4;
	set NWeb_yDir 10;
	set NWeb_zDir 1;
	set NIntersection_yDir [expr $NFlange_yDir]
	set NIntersection_zDir [expr $NWeb_zDir]
	
	section NDFiberShear 1 -GJ $GJ {;	
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr -$d/2]               [expr -$bf/2]                    [expr -($d/2-$tf)]             [expr -$tw/2];	#left part bottom flange
		patch rect 1 $NIntersection_yDir $NIntersection_zDir [expr -$d/2]               [expr -$tw/2]                    [expr -($d/2-$tf)]             [expr $tw/2];	#intersection bottom flange/web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr -$d/2]               [expr $tw/2]                    [expr -($d/2-$tf)]             [expr $bf/2];	#right part bottom flange
		patch rect 2 $NWeb_yDir $NWeb_zDir            [expr -($d/2-$tf)] [expr -$tw/2] [expr ($d/2-$tf)] [expr $tw/2];									#web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr ($d/2-$tf)]             [expr -$bf/2]                    [expr $d/2]             [expr -$tw/2];		#left part top flange
		patch rect 1 $NIntersection_yDir $NIntersection_zDir [expr ($d/2-$tf)]             [expr -$tw/2]                    [expr $d/2]             [expr $tw/2];		#intersection top flange/web
		patch rect 1 $NFlange_yDir $NFlange_zDir [expr ($d/2-$tf)]             [expr $tw/2]                    [expr $d/2]             [expr $bf/2];		#right part top flange
	}
	
	
	set lc [expr 1.0*$d];
	
	# set integration "Simpson 1 21"
	# element testNonlocalElementDH 23 2 3 $ColTransfTag $integration 20 1e-5 $lc
	
	set Lp1 [expr 2.0*$d/$L];
	set nIPs_Lp1 8;
	set Lp2 $Lp1;
	set nIPs_Lp2 $nIPs_Lp1;
	set Le [expr (1-$Lp1-$Lp2)];
	set nIPs_Le 7;
	set integration "SimpsonNonUniformSpacedBeamIntegration 1 $Lp1 $nIPs_Lp1 $Lp2 $nIPs_Lp2 $Le $nIPs_Le"
	# set integration "Simpson 1 21"
	element FBCElemSGINUS 23 2 3 $ColTransfTag $integration 50 1e-8 $lc

# Zero length element definition
	 uniaxialMaterial Elastic 3 976617499682.016
	element zeroLength 12 1 2 -mat 3 -dir 6

############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

set nIPs_Label "${nIPs_Lp1}-${nIPs_Le}-${nIPs_Lp2}"

# Record displacements 
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_Disp.txt -time -node 3 -dof 1 2 3 4 5 6 disp;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_Disp.txt -time -node 3 -dof 1 2 3 4 5 6 disp;
	
# Record reactions
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RBase.txt -time -node 1 -dof 1 2 3 4 5 6 reaction;
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RTop.txt -time -node 3 -dof 1 2 3 4 5 6 reaction;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_RBase.txt -time -node 1 -dof 1 2 3 4 5 6 reaction;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_RTop.txt -time -node 3 -dof 1 2 3 4 5 6 reaction;
	
# Record local section deformations
   # recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_curvatureLoc.txt -ele 12 LocalSectionCurvature;
   
# Record moment distribution
   # recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_momentDistribution.txt -ele 12 momentDistribution;
   
      # Record local section deformations
   # recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_nonlocalCurvatureDistribution.txt -ele 12 NonlocalSectionCurvature;
   
# Record moment distribution
   #recorder Element -file $dataDir/C6_Elkady2018_momentDistribution.txt -ele 12 momentDistribution;
   
# Record element global forces
   # recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_globalForce.txt -ele 12 forces;
   
   # Record element basic displacements
   # recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_basicDeformations.txt -ele 12 basicDeformation;
	
# Record stress and strains for fibers
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY300Z41.txt -ele 12 section 1 fiber 300.35 40.50 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY300Z41.txt -ele 12 section 1 fiber 300.35 40.50 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY258Z0.txt -ele 12 section 1 fiber 258.03 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY258Z0.txt -ele 12 section 1 fiber 258.03 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY201Z0.txt -ele 12 section 1 fiber 200.69 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY201Z0.txt -ele 12 section 1 fiber 200.69 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY143Z0.txt -ele 12 section 1 fiber 143.35 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY143Z0.txt -ele 12 section 1 fiber 143.35 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY86Z0.txt -ele 12 section 1 fiber 86.01 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY86Z0.txt -ele 12 section 1 fiber 86.01 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY29Z0.txt -ele 12 section 1 fiber 28.67 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY29Z0.txt -ele 12 section 1 fiber 28.67 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-29Z0.txt -ele 12 section 1 fiber -28.67 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-29Z0.txt -ele 12 section 1 fiber -28.67 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-86Z0.txt -ele 12 section 1 fiber -86.01 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-86Z0.txt -ele 12 section 1 fiber -86.01 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-143Z0.txt -ele 12 section 1 fiber -143.35 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-143Z0.txt -ele 12 section 1 fiber -143.35 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-201Z0.txt -ele 12 section 1 fiber -200.69 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-201Z0.txt -ele 12 section 1 fiber -200.69 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-258Z0.txt -ele 12 section 1 fiber -258.03 0.00 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-258Z0.txt -ele 12 section 1 fiber -258.03 0.00 strain; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_stressFiberY-300Z41.txt -ele 12 section 1 fiber -300.35 40.50 stress; 
#recorder Element -file $dataDir/C6_Elkady2018_lc10DIP17_strainFiberY-300Z41.txt -ele 12 section 1 fiber -300.35 40.50 strain; 




# Define display;	
#DisplayModel2D NodeNumbers 2.8 10 10  1200 800 -wipe;
#DisplayPlane "DeformedShape" 2.8 XY 0;

	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

#Add the file paths
# set lateralDispXFile "C6_Elkady2018_InPlaneTopDisp_resize50.txt"
# set lateralDispZFile "C6_Elkady2018_OutPlaneTopDisp_resize50.txt"
# set topRotationFile "C6_Elkady2018_InPlaneTopRot_resize50.txt"
# set lateralDispXFile "C6_Elkady2018_InPlaneTopDisp_resize25.txt"
# set lateralDispZFile "C6_Elkady2018_OutPlaneTopDisp_resize25.txt"
# set topRotationFile "C6_Elkady2018_InPlaneTopRot_resize25.txt"
set lateralDispXFile "C6_Elkady2018_InPlaneTopDisp_resize12.txt"
set lateralDispZFile "C6_Elkady2018_OutPlaneTopDisp_resize12.txt"
set topRotationFile "C6_Elkady2018_InPlaneTopRot_resize12.txt"
#set TotalNumberOfSteps 1144;	# number of steps in ground motion for resize 100
# set TotalNumberOfSteps 2265;	# number of steps in ground motion for resize 50
# set TotalNumberOfSteps 4514;	# number of steps in ground motion for resize 25
set TotalNumberOfSteps 9386;	# number of steps in ground motion for resize 12


# Start timer
set startT [clock seconds]

# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
	load 3 0 [expr -0.2*11082000] 0 0 0 0

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
	
	  set CtrlNode 3;
  set CtrlDOFLatX 1;
  set CtrlDOFLatZ 3;
  set CtrlDOFRotZ 6;
  
    set NSteps 1;
	set ok 0;
	
	set dt 1.0;


#Run the analysis


set lateralDispXSeries "Series -dt $dt -filePath $lateralDispXFile -factor [expr 1]";
set lateralDispZSeries "Series -dt $dt -filePath $lateralDispZFile -factor [expr 1]";
set topRotationZSeries "Series -dt $dt -filePath $topRotationFile -factor [expr 1]";
set GMtime [expr $dt*$TotalNumberOfSteps + 0.0];	# total time of ground motion + free vibration
set FloorNodes [list  1 3 ]; 


	# pattern UniformExcitation 2 $CtrlDOFLatX -disp $lateralDispXSeries;
	# pattern UniformExcitation 3 $CtrlDOFLatZ -disp $lateralDispZSeries;
	# pattern UniformExcitation 4 $CtrlDOFRotZ -disp $topRotationZSeries;
	pattern MultipleSupport 2  {
		groundMotion 1 Plain -disp  $lateralDispXSeries 
		groundMotion 2 Plain -disp  $lateralDispZSeries 
		groundMotion 3 Plain -disp  $topRotationZSeries 
	    imposedMotion $CtrlNode  $CtrlDOFLatX 1	
		imposedMotion $CtrlNode  $CtrlDOFLatZ 2	
		imposedMotion $CtrlNode  $CtrlDOFRotZ 3	
	};	# end pattern
	
	
	# DynamicAnalysis_V02        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0      3900.0;
	set nbNodesTot 1 ; 
DynamicAnalysis_V04        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0000      3900.0000 $nbNodesTot;

	
		
set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;