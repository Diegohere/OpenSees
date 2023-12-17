# DynamicAnalysis
# Developed by: Skiadopoulos Andronikos, EPFL
#Modified by Diego Heredia, EPFL
# Date: November 2022

proc DynamicAnalysis_V02 {dt dt_anal_Step GMtime numStories DriftLimit FloorNodes h1 htyp} {

global CollapseFlag;                                     # global variable to monitor collapse
global Result;
source DriftTester.tcl;                                  # For Collapse Studies
set CollapseFlag "NO";
wipeAnalysis;

# ------- PLAY WITH THESE PARAMETERS -----------------------------------------------------------------------------------------------------------------------------------------------------------

set show_iter 0; # Convergence information: 0 - no information / 2 - last iteration step

set tol_0 1.0e-8;  
set tol_1 [expr 10*$tol_0];  
set tol_2 [expr 10*$tol_1];  
set tol_3 [expr 10*$tol_2];  
set tol_4 [expr 10*$tol_3];  
set tol_5 [expr 10*$tol_4];  
set tol_6 [expr 10*$tol_5];    
 
set nr_iter_100 100;

set main_test EnergyIncr; # RelativeNormDispIncr/NormDispIncr/EnergyIncr/RelativeEnergyIncr
set alt_test NormDispIncr; # RelativeNormDispIncr/NormDispIncr/EnergyIncr/RelativeEnergyIncr

constraints Transformation; # Plain/Transformation (Lu)
numberer RCM;
system UmfPack; # UmfPack/SparseSYM/Cusp
test $main_test $tol_0 $nr_iter_100 $show_iter
algorithm KrylovNewton

integrator Newmark 0.50 0.25; # Newmark 0.50 0.25/Newmark 0.55 0.2765625 (Lu)/GeneralizedAlpha 1.0 0.6
analysis Transient

# ------- SET VARIABLES BEFORE ENTERING THE LOOP --------------------------------------------------------------------------------------------------------------------------------------------

set dt_analysis [expr $dt_anal_Step/1]; # timestep of analysis
set TmaxAnalysis $GMtime;
set ok 0;
set okcollapse 0;
set controlTime [getTime];

# ------- ENTER CONVERGENCE LOOP ----------------------------------------------------------------------------------------------------------------------------------------------------------------

while {$controlTime < $TmaxAnalysis && $okcollapse == 0 && $ok == 0} {	

	DriftTester $numStories $DriftLimit $FloorNodes $h1 $htyp
	if  {$CollapseFlag == "YES"} {
		set okcollapse 1; break;
	}
	test $main_test $tol_0 $nr_iter_100 $show_iter
	algorithm KrylovNewton
	set ok [analyze 1 $dt_analysis];
	set controlTime [getTime];
	set krylovflag 1; # do not check again the 1st iteration unconverged Krylov

	# ------- TOLERANCE_0 ----------------------------
	if {$ok != 0} {
		puts "0";
		set currentTolerance $tol_0;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}	
	# ------- TOLERANCE_1 ----------------------------
	if {$ok != 0} {
		puts "1";
		set currentTolerance $tol_1;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}
	# ------- TOLERANCE_2 ----------------------------
	if {$ok != 0} {
		puts "2";
		set currentTolerance $tol_2;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}	
	# ------- TOLERANCE_3 ----------------------------
	if {$ok != 0} {
		puts "3";
		set currentTolerance $tol_3;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}	
	# ------- TOLERANCE_4 ----------------------------
	if {$ok != 0} {
		puts "4";
		set currentTolerance $tol_4;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}	
	# ------- TOLERANCE_5 ----------------------------
	if {$ok != 0} {
		puts "5";
		set currentTolerance $tol_5;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}	
	# ------- TOLERANCE_6 ----------------------------
	if {$ok != 0} {
		puts "6";
		set currentTolerance $tol_6;
		set currentdt [expr $dt_analysis];
		source DynamicSolutionAlgorithmSubFile_V03.tcl
		set controlTime [getTime];
	}
	#puts "we go back to checking collapse";
	if {$ok != 0} {
		set fileID [open $Result/ConvergenceState.txt w];   # Create/Open ConvergenceState.txt file (writing permission)
		puts -nonewline $fileID 1;               # Write value of 1 in case the analysis does not converge
		close $fileID;                           # Close ConvergenceState.txt file
		break
	}
}
}
