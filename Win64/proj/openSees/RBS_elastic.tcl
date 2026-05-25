###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_RBS_elastic;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;
	
	set Source "0_Source";

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
	# set sigmaC0_Web [expr 1000000*370.5703];
	# set sigmaC0_Flange [expr 1000000* 511.1520];
	
	set alphaRegularization_Web 1.0;							# Factor for regularization web 
	set alphaRegularization_Flange 1.0;							# Factor for regularization flange
	
	# RBS geometry
	set a_RBS 200;
	set b_RBS 450;
	set c_RBS 50;
	
	
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
	geomTransf Linear $ColTransfTag 0 0 -1;		# Linear transformation
	# geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
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

	
#Constraints for zero length
	# equalDOF 1 2 1 2 3 4 5 
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $d-$tf]; 			# median depth
	set J   [expr 1.0/3.0*(2*$bf*$tf**3.0 + $do*$tw**3.0)]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	# nDMaterial HLBModel 1 205903.0 0.3 368.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bf4MaterialLaw $tf $sigmaC0_Flange $alphaRegularization_Flange flange A992Gr50;
	# nDMaterial HLBModel 2 202923.0 0.3 378.0 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_Web $alphaRegularization_Web web A992Gr50;
	# Elastic material tags. Use two tags because the section definition uses
	# separate tags for flange and web patches.
	set matFlange 1
	set matWeb 2
	nDMaterial ElasticIsotropic $matFlange $E $nu
	nDMaterial ElasticIsotropic $matWeb    $E $nu
	
	set NFlange_yDir 1;
	set NFlange_zDir 4;
	set NWeb_yDir 10;
	set NWeb_zDir 1;
	set NIntersection_yDir [expr $NFlange_yDir]
	set NIntersection_zDir [expr $NWeb_zDir]
	
	# Define a wide-flange section with a specified effective flange width.
	# bfSec = bf - 2*c_cut at the current integration point.
	proc DefineWFSectionForRBS {secTag bfSec} {
		global d tf tw GJ
		global matFlange matWeb
		global NFlange_yDir NFlange_zDir NWeb_yDir NWeb_zDir NIntersection_yDir NIntersection_zDir

		if {$bfSec <= $tw} {
			error "RBS effective flange width bfSec = $bfSec is not larger than tw = $tw"
		}

		set yBot       [expr {-$d/2.0}]
		set yBotFlTop  [expr {-($d/2.0-$tf)}]
		set yTopFlBot  [expr { ($d/2.0-$tf)}]
		set yTop       [expr { $d/2.0}]

		set zLeft      [expr {-$bfSec/2.0}]
		set zWebLeft   [expr {-$tw/2.0}]
		set zWebRight  [expr { $tw/2.0}]
		set zRight     [expr { $bfSec/2.0}]

		section NDFiberShear $secTag -GJ $GJ [subst {
			patch rect $matFlange $NFlange_yDir $NFlange_zDir $yBot      $zLeft     $yBotFlTop $zWebLeft
			patch rect $matFlange $NIntersection_yDir $NIntersection_zDir $yBot    $zWebLeft  $yBotFlTop $zWebRight
			patch rect $matFlange $NFlange_yDir $NFlange_zDir $yBot      $zWebRight $yBotFlTop $zRight

			patch rect $matWeb    $NWeb_yDir $NWeb_zDir       $yBotFlTop $zWebLeft  $yTopFlBot $zWebRight

			patch rect $matFlange $NFlange_yDir $NFlange_zDir $yTopFlBot $zLeft     $yTop      $zWebLeft
			patch rect $matFlange $NIntersection_yDir $NIntersection_zDir $yTopFlBot $zWebLeft $yTop      $zWebRight
			patch rect $matFlange $NFlange_yDir $NFlange_zDir $yTopFlBot $zWebRight $yTop      $zRight
		}]
	}

	# RBS circular cut depth at dimensional location x along the member.
	# x = 0 and x = L are the member ends. The RBS regions are:
	# [a_RBS, a_RBS+b_RBS] and [L-a_RBS-b_RBS, L-a_RBS].
	proc RBSCutDepthAtX {x L a_RBS b_RBS c_RBS} {
		set cut 0.0

		if {$x >= $a_RBS && $x <= [expr {$a_RBS+$b_RBS}]} {
			set s [expr {$x-$a_RBS}]
		} elseif {$x >= [expr {$L-$a_RBS-$b_RBS}] && $x <= [expr {$L-$a_RBS}]} {
			set s [expr {$x-($L-$a_RBS-$b_RBS)}]
		} else {
			return 0.0
		}

		set R [expr {$b_RBS*$b_RBS/(8.0*$c_RBS) + $c_RBS/2.0}]
		set arg [expr {$R*$R - ($s-$b_RBS/2.0)*($s-$b_RBS/2.0)}]
		if {$arg < 0.0 && $arg > -1.0e-8} {
			set arg 0.0
		}
		if {$arg < 0.0} {
			error "Negative argument in RBS cut-depth computation: $arg"
		}

		set cut [expr {$c_RBS - $R + sqrt($arg)}]
		return $cut
	}

	# Locations for the 5-segment SimpsonNonUniformSpacedBeamIntegration.
	# All nIPs include segment endpoints; shared interface points are listed once.
	proc SimpsonFiveSegmentLocations {Lsegs nIPsSeg} {
		set xiList {}
		set xStart 0.0

		for {set s 0} {$s < 5} {incr s} {
			set H [lindex $Lsegs $s]
			set n [lindex $nIPsSeg $s]
			set dx [expr {$H/double($n-1)}]

			if {$s == 0} {
				set jStart 0
			} else {
				set jStart 1
			}

			for {set j $jStart} {$j < $n} {incr j} {
				lappend xiList [expr {$xStart + $j*$dx}]
			}

			set xStart [expr {$xStart + $H}]
		}

		return $xiList
	}


	set lc [expr {1.0*$d}];

	# -------------------------------------------------------------------------
	# 5-segment RBS integration:
	#   a | b | Lmid | b | a
	# Segment lengths are normalized by the total element length L.
	# -------------------------------------------------------------------------
	set L_a   [expr {$a_RBS/$L}]
	set L_b   [expr {$b_RBS/$L}]
	set L_mid [expr {1.0 - 2.0*$L_a - 2.0*$L_b}]

	if {$L_mid <= 0.0} {
		error "Invalid RBS geometry: L_mid = $L_mid. Check L, a_RBS, and b_RBS."
	}

	# Choose the number of integration points per segment.
	# For the 5-segment rule, each value must be odd and >= 3.
	set nIPs_a   3
	set nIPs_b   9
	set nIPs_mid 3

	set Lsegs   [list $L_a $L_b $L_mid $L_b $L_a]
	set nIPsSeg [list $nIPs_a $nIPs_b $nIPs_mid $nIPs_b $nIPs_a]

	set xiList [SimpsonFiveSegmentLocations $Lsegs $nIPsSeg]

	# Create one section at each unique integration point.
	# The section width is reduced only inside the two RBS regions.
	set secTags {}
	set firstRBSSecTag 1000
	set iSec 0

	foreach xi $xiList {
		set xDim [expr {$xi*$L}]
		set cCut [RBSCutDepthAtX $xDim $L $a_RBS $b_RBS $c_RBS]
		set bfLocal [expr {$bf - 2.0*$cCut}]

		set secTag [expr {$firstRBSSecTag + $iSec}]
		DefineWFSectionForRBS $secTag $bfLocal
		lappend secTags $secTag

		# puts "RBS IP $iSec: xi = $xi, x = $xDim, cCut = $cCut, bfLocal = $bfLocal, secTag = $secTag"

		incr iSec
	}

	set nIPs_Label "${nIPs_a}-${nIPs_b}-${nIPs_mid}-${nIPs_b}-${nIPs_a}"

	set integration "SimpsonNonUniformSpacedBeamIntegration -sections $secTags $L_a $nIPs_a $L_b $nIPs_b $L_mid $nIPs_mid $L_b $nIPs_b $L_a $nIPs_a"

	element FBCElemSGINUS 12 1 2 $ColTransfTag $integration 50 1e-6 $lc

############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record displacements 
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_Disp.txt -time -node 2 -dof 1 2 3 4 5 6 disp;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_Disp.txt -time -node 3 -dof 1 2 3 4 5 6 disp;
	
# Record reactions
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RBase.txt -time -node 1 -dof 1 2 3 4 5 6 reaction;
	recorder Node -file $dataDir/C6_Elkady2018_nonUniformSpace_${nIPs_Label}IPs_RTop.txt -time -node 2 -dof 1 2 3 4 5 6 reaction;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_RBase.txt -time -node 1 -dof 1 2 3 4 5 6 reaction;
	# recorder Node -file $dataDir/C6_Elkady2018_equalSpace_21IPs_RTop.txt -time -node 3 -dof 1 2 3 4 5 6 reaction;
	
# # Record section connectivity and coordinate matrices
# recorder Element -file $dataDir/C6_Elkady2018_${nIPs_Label}IPs_connectivityMatrix.txt -ele 23 section 1 connectivity; 
# recorder Element -file $dataDir/C6_Elkady2018_${nIPs_Label}IPs_coordinateMatrix.txt -ele 23 section 1 coordinate; 	
	
# # Record all fiber stresses
# recorder Element -file $dataDir/C6_Elkady2018_${nIPs_Label}IPs_Section1_allFiberStresses.txt -ele 23 section 1 allFiberStresses; 
# recorder Element -file $dataDir/C6_Elkady2018_${nIPs_Label}IPs_Section1_allFiberStrains.txt -ele 23 section 1 allFiberStrains; 
	
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

# Start timer
set startT [clock seconds]

# define Lateral load -------------------------------------------------------------
pattern Plain 1 Linear {
	load 2 [expr 5000000.0] 0 0 0 0 0

}

# Lateral load-analysis parameters -- load-controlled static analysis
set Tol 1.0e-10;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20; 		# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 50;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero
loadConst -time 0.0
  

puts "Model Built"


# # STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

# puts "Running Analysis..."
# set tStart [clock seconds];

# # # analysis commands
	# # constraints Plain;					# how it handles boundary conditions
	# # numberer RCM;						# renumber dof's to minimize band-width (optimization)
	# # system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	# # #system UmfPack
	# # set maxNumIter 100;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
	# # set printFlag 0;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step;
	# # set Tol 1.0e-12;                        # Convergence Test: tolerance	
	# # #test RelativeNormUnbalance  $Tol $maxNumIter $printFlag;		# type of convergence criteria with tolerance, max iterations
	# # test EnergyIncr  $Tol $maxNumIter $printFlag;
	# # #algorithm NewtonLineSearch;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	# # algorithm KrylovNewton 
	
	  # set CtrlNode 3;
  # set CtrlDOFLatX 1;
  # set CtrlDOFLatZ 3;
  # set CtrlDOFRotZ 6;
  
    # set NSteps 1;
	# set ok 0;
	
	# set dt 1.0;


# #Run the analysis


# set lateralDispXSeries "Series -dt $dt -filePath $lateralDispXFile -factor [expr 1]";
# # set lateralDispZSeries "Series -dt $dt -filePath $lateralDispZFile -factor [expr 1]";
# # set topRotationZSeries "Series -dt $dt -filePath $topRotationFile -factor [expr 1]";
# set GMtime [expr $dt*$TotalNumberOfSteps + 0.0];	# total time of ground motion + free vibration
# set FloorNodes [list  1 3 ]; 


	# # pattern UniformExcitation 2 $CtrlDOFLatX -disp $lateralDispXSeries;
	# # pattern UniformExcitation 3 $CtrlDOFLatZ -disp $lateralDispZSeries;
	# # pattern UniformExcitation 4 $CtrlDOFRotZ -disp $topRotationZSeries;
	# pattern MultipleSupport 2  {
		# groundMotion 1 Plain -disp  $lateralDispXSeries 
		# # groundMotion 2 Plain -disp  $lateralDispZSeries 
		# # groundMotion 3 Plain -disp  $topRotationZSeries 
	    # imposedMotion $CtrlNode  $CtrlDOFLatX 1	
		# # imposedMotion $CtrlNode  $CtrlDOFLatZ 2	
		# # imposedMotion $CtrlNode  $CtrlDOFRotZ 3	
	# };	# end pattern
	
	
	# # DynamicAnalysis_V02        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0      3900.0;
	# set nbNodesTot 1 ; 
# DynamicAnalysis_V04        $dt  1.0  $GMtime    1       0.8    $FloorNodes     3900.0000      3900.0000 $nbNodesTot;

	
		
# set tFinish [clock seconds];

# puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;