# DynamicAnalysis
# Developed by: Diego Heredia, EPFL
# Date: 18.02.2025

proc DynamicAnalysis_V04 {dt dt_anal_Step GMtime numStories DriftLimit FloorNodes h1 htyp} {

global CollapseFlag;                                     # global variable to monitor collapse
global Result;
source DriftTester.tcl;                                  # For Collapse Studies
set CollapseFlag "NO";
wipeAnalysis;

# ------- PLAY WITH THESE PARAMETERS -----------------------------------------------------------------------------------------------------------------------------------------------------------

set show_iter 0; # Convergence information: 0 - no information / 2 - last iteration step

#set tol_0 1.0e-8;  
#set tol_1 1.0e-7;  
#set tol_2 1.0e-6; 
#set tol_3 1.0e-5;   
#set tol_4 1.0e-4;   
#set tol_5 1.0e-3;  
#set tol_6 5.0e-3;    

# set tol_0 1.0e-7;  
# set tol_1 [expr 10*$tol_0];  
# set tol_2 [expr 10*$tol_1];  
# set tol_3 [expr 10*$tol_2];  
# set tol_4 [expr 10*$tol_3];  
# set tol_5 [expr 10*$tol_4];  
# set tol_6 [expr 10*$tol_5];  

set tol 1.0e0;  
# set tol_1 [expr 5*$tol_0];  
# set tol_2 [expr 5*$tol_1];  
# set tol_3 [expr 5*$tol_2];  
# set tol_4 [expr 2*$tol_3];  
# set tol_5 [expr 2*$tol_4];  
# set tol_6 [expr 2*$tol_5]; 
  
 
# set nr_iter_1 100;
# set nr_iter_2 200;
set nr_iter_1 200;
set nr_analyse 1; # 1/20/50/100 This is the number of steps to do in a current solver

#set main_test EnergyIncr; # RelativeNormDispIncr/NormDispIncr/EnergyIncr/RelativeEnergyIncr
 #set main_test NormDispIncr; # RelativeNormDispIncr/NormDispIncr/EnergyIncr/RelativeEnergyIncr
#set alt_test RelativeNormDispIncr; # RelativeNormDispIncr/NormDispIncr/EnergyIncr/RelativeEnergyIncr
set main_test NormUnbalance

constraints Transformation; # Plain/Transformation (Lu)
numberer RCM;
system UmfPack; # UmfPack/SparseSYM/Cusp
test $main_test $tol $nr_iter_1 $show_iter
algorithm KrylovNewton

integrator Newmark 0.50 0.25; # Newmark 0.50 0.25/Newmark 0.55 0.2765625 (Lu)/GeneralizedAlpha 1.0 0.6
analysis VariableTransient

# ------- SET VARIABLES BEFORE ENTERING THE LOOP --------------------------------------------------------------------------------------------------------------------------------------------

set dt_analysis $dt_anal_Step; # timestep of analysis
#set dt_anal_min1 [expr $dt_anal_Step/200]; # minimum time step for Variable Transient Analysis
# set dt_anal_min2 [expr $dt_anal_Step/60]; # minimum time step for Variable Transient Analysis
# set dt_anal_min3 [expr $dt_anal_Step/200]; # minimum time step for Variable Transient Analysis
set dt_anal_min [expr $dt_anal_Step/1]; # minimum time step for Variable Transient Analysis

set dt_anal_max [expr $dt_anal_Step*1]; # maximum time step for Variable Transient Analysis

#set nr_iter1 15; # Number of maximum iterations for Variable Transient Analysis
# set nr_iter2 20; # Number of maximum iterations for Variable Transient Analysis
# set nr_iter3 20; # Number of maximum iterations for Variable Transient Analysis
set nr_iter1 1; # Number of maximum iterations for Variable Transient Analysis


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
	# test $main_test $tol_0 $nr_iter_2 $show_iter
	test $main_test $tol $nr_iter_1 $show_iter
	algorithm KrylovNewton
	set ok [analyze $nr_analyse $dt_analysis $dt_anal_min $dt_anal_max $nr_iter1];
	# if {$ok != 0} {
		# set ok [analyze $nr_analyse $dt_analysis $dt_anal_min2 $dt_anal_max $nr_iter2];
	# }
	# if {$ok != 0} {
		# set ok [analyze $nr_analyse $dt_analysis $dt_anal_min3 $dt_anal_max $nr_iter3];
	# }
	set controlTime [getTime];
	set krylovflag 1; # do not check again the 1st iteration unconverged Krylov

	
	if {$ok != 0} {
		set fileID [open $Result/ConvergenceState.txt w];   # Create/Open ConvergenceState.txt file (writing permission)
		puts -nonewline $fileID 1;               # Write value of 1 in case the analysis does not converge
		close $fileID;                           # Close ConvergenceState.txt file
		break
	}
}
}
