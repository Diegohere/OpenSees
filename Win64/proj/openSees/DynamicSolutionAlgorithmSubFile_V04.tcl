 # DynamicSolutionAlgorithmSubFile
 # Developed by: Seong-Hoon Hwang of McGill University
 # Date: January 2015
 # Updated for Transient Analysis by: Hammad El Jisr 
 # Updated for variableTransient Analysis by: Skiadopoulos Andronikos 
 
 # This script is part of the sub-routine DynamicAnalysis. It is called repeatedly in the sub-routine for different tolerances and time steps
 # The script tries the following algorithms for each case:
 # - KrylovNewton Algorithm
 # - SecantNewton Algorithm
 # - NewtonLineSearch Algorithm with Initial Interpolation Line Search
 # - NewtonLineSearch Algorithm with Bisection Line Search
 # - NewtonLineSearch Algorithm with RefulaFalsi Line Search
 # - NewtonLineSearch Algorithm with Secant Line Search
 # - Newton Algorithm 
 # - ModifiedNewton Algorithm 
 # - ModifiedNewton Algorithm with Initial Stiffness Iterations`
 # - BFGS Algorithm
 # - Broyden Algorithm

 # I added these solution algorithm (date: 20/11/2023)
 if {$ok != 0 && $krylovflag == 0} {
     puts "Initial Test Failed - Trying KrylovNewton Algorithm..."
	 eval "test $main_test $currentTolerance [expr $nr_iter_1] 0"
     algorithm KrylovNewton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]

 }
 set krylovflag 0;

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (InitialInterpolation) Algorithm..."
     eval "test $main_test $currentTolerance [expr $nr_iter_1] 0"
     algorithm NewtonLineSearch 0.75
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]

 }

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (Bisection) Algorithm..."
     eval "test $main_test $currentTolerance [expr $nr_iter_1] 0"
     algorithm NewtonLineSearch -type Bisection 0.75;
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
 }
 
 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (Secant) Algorithm..."
     eval "test $main_test $currentTolerance [expr $nr_iter_1] 0"
     algorithm NewtonLineSearch -type Secant 0.75;
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]

 }
 