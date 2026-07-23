###################################################################################################
# LS4 Yu et al. (2000) RBS beam-only cantilever model
# Units: N, mm, MPa
# Notes:
#   - Beam only: fixed at column face, loaded at actuator/beam tip.
#   - Elastic material for now.
#   - One RBS region near the fixed end.
#   - Rotation-control history is read from LS4_totalRotation_history_rad.txt and imposed as dU = dtheta*L.
###################################################################################################


###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_LS4_Yu2000_BeamOnly_sigmaC0MaityEtAL2025_4Erc;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
# Units and specimen geometry
###################################################################################################

set in 25.4

# W30x99 beam dimensions, mm. Verify against your preferred AISC database if needed.
set d   [expr {29.7*$in}]
set bf  [expr {10.5*$in}]
set tw  [expr {0.52*$in}]
set tf  [expr {0.67*$in}]

# Approximate radius used only to define the web clear depth variable if needed later.
set rKArea [expr {0.65*$in}]
set h [expr {$d - 2.0*$tf - 2.0*$rKArea}]

# RBS geometry from the LS4 connection detail:
# a = 7 in from column face, b = 20 in cut length, c = 2-5/8 in maximum cut.
set a_RBS [expr {7.0*$in}]
set b_RBS [expr {20.0*$in}]
set c_RBS [expr {2.625*$in}]

# Beam-only cantilever length.
# Test drawing gives 149 in from column centerline to actuator.
# For a beam fixed at the column face, subtract half the W14x176 depth.
set dCol [expr {15.22*$in}]
set L_columnCenter_to_actuator [expr {149.0*$in}]
set L [expr {$L_columnCenter_to_actuator - 0.5*$dCol}]
	
	
###################################################################################################
# Transformation, nodes, and constraints
###################################################################################################

set BeamTransfTag 1
geomTransf Corotational $BeamTransfTag 0 0 1

# Beam axis is global X. Vertical/in-plane loading is global Y.
node 1 0.0 0.0 0.0
node 2 $L 0.0 0.0

# Fixed column face.
fix 1 1 1 1 1 1 1

# Beam tip: keep axial DOF free and vertical DOF free; restrain out-of-plane mechanisms.
# Free DOFs: ux, uy, rz. Controlled DOF is uy.
fix 2 0 0 1 1 1 0
	
###################################################################################################
# Materials and section definition
###################################################################################################

set E 200000.0
set nu 0.30

set ksi2MPa 6.894757293

# Yu LS4 / W30x99 beam coupon yield stresses
set sigmaY0_Flange [expr {54.7*$ksi2MPa}] ;# MPa
set sigmaY0_Web    [expr {58.0*$ksi2MPa}] ;# MPa

# # A992 Gr.50 capping-stress regression parameters
# set beta1_Web    1.12
# set beta2_Web   -0.52
# set beta1_Flange 0.54
# set beta2_Flange -0.70

# proc ComputeSigmaC0 {sigmaY0 E bPlate tPlate beta1 beta2 scaleFactor} {
    # set lambdaPlate [expr {($bPlate/$tPlate)*sqrt($sigmaY0/$E)}]
    # return [expr {$scaleFactor*$sigmaY0*$beta1*pow($lambdaPlate,$beta2)}]
# }

# Member-level capping-stress regressions from Maity et al. (2025),
# Eqs. (6) and (7). Units of the returned stresses are MPa.
# Both regressions account for web-flange interaction through
# bf/(2tf) and h/tw.
proc ComputeSigmaC0Flange {bfSec tf h tw sigmaY} {
    set flangeSlenderness [expr {$bfSec/(2.0*$tf)}]
    set webSlenderness    [expr {$h/$tw}]

    set sigmaC0Regression [expr {
        620.31
        - 24.191*$flangeSlenderness
        - 1.503*$webSlenderness
    }]

    # Maity et al. regression was calibrated using sigmaY = 370 MPa
    return [expr {$sigmaC0Regression*($sigmaY/370.0)*1.30}]
}

proc ComputeSigmaC0Web {bfSec tf h tw sigmaY} {
    set flangeSlenderness [expr {$bfSec/(2.0*$tf)}]
    set webSlenderness    [expr {$h/$tw}]

    set sigmaC0Regression [expr {
        470.81
        - 7.2541*$flangeSlenderness
        - 1.1806*$webSlenderness
    }]

    # Maity et al. regression was calibrated using sigmaY = 370 MPa
    return [expr {$sigmaC0Regression*($sigmaY/370.0)*1.30}]

}

set alphaRegularization_Flange 1.0
set alphaRegularization_Web    1.0

set G  [expr {$E/(2.0*(1.0+$nu))}]
set do [expr {$d-$tf}]
set J  [expr {(1.0/3.0)*(2.0*$bf*pow($tf,3.0) + $do*pow($tw,3.0))}]
set GJ [expr {$G*$J}]

# Keep material elastic for now.
set matFlange 1
set matWeb 2
# nDMaterial ElasticIsotropic $matFlange $E $nu
# nDMaterial ElasticIsotropic $matWeb    $E $nu

set NFlange_yDir 1
set NFlange_zDir 4
set NWeb_yDir    12
set NWeb_zDir    1
set NIntersection_yDir $NFlange_yDir
set NIntersection_zDir $NWeb_zDir

proc DefineWFSectionForRBS {secTag bfSec matFlange matWeb} {
    global d tf tw GJ
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

# Circular RBS cut depth at distance x from the column face.
# One RBS only: [a_RBS, a_RBS+b_RBS].
proc RBSCutDepthAtX {x a_RBS b_RBS c_RBS} {
    if {$x < $a_RBS || $x > [expr {$a_RBS+$b_RBS}]} {
        return 0.0
    }

    set s [expr {$x-$a_RBS}]
    set R [expr {$b_RBS*$b_RBS/(8.0*$c_RBS) + $c_RBS/2.0}]
    set arg [expr {$R*$R - ($s-$b_RBS/2.0)*($s-$b_RBS/2.0)}]

    if {$arg < 0.0 && $arg > -1.0e-8} {
        set arg 0.0
    }
    if {$arg < 0.0} {
        error "Negative argument in RBS cut-depth computation: $arg"
    }

    return [expr {$c_RBS - $R + sqrt($arg)}]
}

proc SimpsonThreeSegmentLocations {Lsegs nIPsSeg} {
    set xiList {}
    set xStart 0.0

    for {set s 0} {$s < 3} {incr s} {
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

###################################################################################################
# Beam integration and element
###################################################################################################

# set lc [expr {1.0*$d}]
set lc [expr {2.0*$b_RBS/3.0}]

# 3-segment integration:
#   unreduced segment before RBS | RBS segment | remaining unreduced beam
set L_a   [expr {$a_RBS/$L}]
set L_b   [expr {$b_RBS/$L}]
set L_mid [expr {1.0 - $L_a - $L_b}]

if {$L_mid <= 0.0} {
    error "Invalid geometry: L_mid = $L_mid. Check L, a_RBS, and b_RBS."
}

# Odd numbers >= 3.
set nIPs_a   5
set nIPs_b   11
set nIPs_mid 11

set Lsegs   [list $L_a $L_b $L_mid]
set nIPsSeg [list $nIPs_a $nIPs_b $nIPs_mid]
set xiList [SimpsonThreeSegmentLocations $Lsegs $nIPsSeg]

set secTags {}
set firstSecTag 1000
set iSec 0

set secInfoFile [open "$dataDir/LS4_RBS_sectionInfo.txt" "w"]
puts $secInfoFile "iSec xi x_mm cCut_mm bfLocal_mm bFlangeLocal_mm sigmaC0_Flange_MPa sigmaC0_Web_MPa secTag matFlange matWeb"

foreach xi $xiList {
    set xDim [expr {$xi*$L}]
    set cCut [RBSCutDepthAtX $xDim $a_RBS $b_RBS $c_RBS]
    set bfLocal [expr {$bf - 2.0*$cCut}]

    set secTag [expr {$firstSecTag + $iSec}]
    # Local flange plate width for capping-stress regression
# Use bfLocal/2 so the slenderness matches bf/(2tf)
set bFlangeLocal [expr {$bfLocal/2.0}]

# set sigmaC0_FlangeSec [ComputeSigmaC0 $sigmaY0_Flange $E $bFlangeLocal $tf $beta1_Flange $beta2_Flange 1.0]

# Web capping stress is constant along the member, but create a unique material tag per section
# 15% increase applied to web sigmaC0
# set sigmaC0_WebSec [ComputeSigmaC0 $sigmaY0_Web $E $h $tw $beta1_Web $beta2_Web 1.15]

# Maity et al. (2025) member-level regressions, scaled according
# to the ratio between the measured yield stress and the
# 370 MPa yield stress used in the original calibration.
#
# Pass bfLocal, not bFlangeLocal, because the regression functions
# internally calculate bf/(2tf).
set sigmaC0_FlangeSec [ComputeSigmaC0Flange \
    $bfLocal $tf $h $tw $sigmaY0_Flange]

set sigmaC0_WebSec [ComputeSigmaC0Web \
    $bfLocal $tf $h $tw $sigmaY0_Web]

set matFlangeSec [expr {100000 + $iSec}]
set matWebSec    [expr {200000 + $iSec}]

nDMaterial HLBModel $matFlangeSec $E $nu $sigmaY0_Flange 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $bFlangeLocal $tf $sigmaC0_FlangeSec $alphaRegularization_Flange flange A992Gr50

nDMaterial HLBModel $matWebSec $E $nu $sigmaY0_Web 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $tw $sigmaC0_WebSec $alphaRegularization_Web web A992Gr50

DefineWFSectionForRBS $secTag $bfLocal $matFlangeSec $matWebSec
    lappend secTags $secTag

puts $secInfoFile "$iSec $xi $xDim $cCut $bfLocal $bFlangeLocal $sigmaC0_FlangeSec $sigmaC0_WebSec $secTag $matFlangeSec $matWebSec"
    incr iSec
}
close $secInfoFile

set nIPs_Label "${nIPs_a}-${nIPs_b}-${nIPs_mid}"

# Tcl variables use physical total IP counts:
#   L_a   = unreduced segment before RBS
#   L_b   = RBS segment
#   L_mid = remaining unreduced beam
#   nIPs_a, nIPs_b, nIPs_mid are total points including endpoints

# C++ 3-segment convention:
#   input order:    Lp1, Lp2, Le
#   physical order: Lp1 | Le | Lp2
#   nIPs_Le is the number of interior points in Le

set nIPs_b_interior [expr {$nIPs_b - 2}]

if {$nIPs_b_interior < 1} {
    error "nIPs_b must be at least 3 for Simpson integration over the RBS."
}

set nSec_expected [expr {$nIPs_a + $nIPs_b + $nIPs_mid - 2}]
set nSec_actual   [llength $secTags]

if {$nSec_actual != $nSec_expected} {
    error "Mismatch in section tags: expected $nSec_expected, got $nSec_actual"
}

# Pass L_a as Lp1, L_mid as Lp2, and L_b as Le.
# This gives physical order inside C++: L_a | L_b | L_mid.
set integration "SimpsonNonUniformSpacedBeamIntegration -sections $secTags $L_a $nIPs_a $L_mid $nIPs_mid $L_b $nIPs_b_interior"
element FBCElemSGINUS 12 1 2 $BeamTransfTag $integration 50 1.0e-6 $lc
# element FBCElemSGINUS 12 1 2 $BeamTransfTag $integration 500 2.0e-6 $lc

############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

# Record dispacements 
	recorder Node -file $dataDir/LS4_beamOnly_${nIPs_Label}IPs_delta005_tipDisp.txt  -time -node 2 -dof 1 2 3 4 5 6 disp
	# recorder Node -file $dataDir/LS4_beamOnly_${nIPs_Label}IPs_alphaBound4Smoothin005_tipDisp.txt  -time -node 2 -dof 1 2 3 4 5 6 disp

# Record reactions
	recorder Node -file $dataDir/LS4_beamOnly_${nIPs_Label}IPs_delta005_baseReact.txt -time -node 1 -dof 1 2 3 4 5 6 reaction
		# recorder Node -file $dataDir/LS4_beamOnly_${nIPs_Label}IPs_alphaBound4Smoothin005_baseReact.txt -time -node 1 -dof 1 2 3 4 5 6 reaction
	
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

puts "Model Built"
	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
   load 1 0 0 0 0 0 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-3;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20 2; 		# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 1;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero
loadConst -time 0.0

puts "Model Built"




# STATIC PUSHOVER ANALYSIS-----------------------------------------------------------------------------

# ------------------------------------------------------------
# Adaptive displacement-control step with recursive cutback
# Tries the full dU first. If it fails, splits the step into
# two half-steps, then quarters, etc.
# ------------------------------------------------------------
proc doDCStepWithCutback {CtrlNode CtrlDOF dU level maxLevel} {

    integrator DisplacementControl $CtrlNode $CtrlDOF $dU

    set ok [analyze 1]

    if {$ok == 0} {
        return 0
    }

    if {$level >= $maxLevel} {
        puts "  FAILED at max cutback level = $maxLevel, dU = $dU"
        return $ok
    }

    set dUhalf [expr {$dU/2.0}]
    set nextLevel [expr {$level + 1}]

    puts "  Cutback level $nextLevel: dU = $dU -> half step = $dUhalf"

    # First half
    set ok1 [doDCStepWithCutback $CtrlNode $CtrlDOF $dUhalf $nextLevel $maxLevel]
    if {$ok1 != 0} {
        return $ok1
    }

    # Second half
    set ok2 [doDCStepWithCutback $CtrlNode $CtrlDOF $dUhalf $nextLevel $maxLevel]
    return $ok2
}


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
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormUnbalance 1.0 1000;		# type of convergence criteria with tolerance, max iterations
	algorithm KrylovNewton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration

# Loading Protocol
# The LS4 moment-rotation file is treated as moment versus total beam rotation for now.
# D1 and D2 below are rotations [rad]. The imposed displacement increment is:
#     dU = dtheta_total * L
# where L is the column-face-to-actuator distance in mm.
set rotationHistoryFile "LS4_totalRotation_history_rad.txt"

if {![file exists $rotationHistoryFile]} {
    error "Cannot find rotation history file: $rotationHistoryFile"
}

set disp [list]
set rotFileID [open $rotationHistoryFile r]
while {[gets $rotFileID line] >= 0} {
    set line [string trim $line]
    if {$line eq ""} {
        continue
    }
    if {[string index $line 0] eq "#"} {
        continue
    }
    lappend disp [lindex $line 0]
}
close $rotFileID

set LoopLength [llength $disp]
  set stepID 1
  
# Run the static cyclic analysis
puts "Analysis..."
set tStart [clock seconds]

set ok 0

# Maximum subdivision = 2^maxCutLevel
# maxCutLevel = 10 gives up to 1024 substeps only when needed.
set maxCutLevel 10

analysis Static

while {$ok == 0 && $stepID < $LoopLength} {

    set index $stepID

    set D1 [lindex $disp $index]

    if {$index == 0} {
        set D2 0.0
    } else {
        set D2 [lindex $disp [expr {$index - 1}]]
    }

    set dU1 [expr {($D1 - $D2) * $L}]

    puts "increment = $stepID / $LoopLength"
    #puts "  target dU = $dU1"

    # Try the full increment first. If it fails, recursively cut it.
    set ok [doDCStepWithCutback $CtrlNode $CtrlDOF $dU1 0 $maxCutLevel]

    if {$ok == 0} {
        incr stepID
    } else {
        puts "Analysis failed at increment $stepID / $LoopLength"
        #puts "Last attempted target dU = $dU1"
        break
    }
}

set tFinish [clock seconds];
puts "Duration Process: [expr $tFinish - $tStart]"; 


	

wipe all;