 # DynamicSolutionAlgorithmSubFile
 # Developed by: Seong-Hoon Hwang of McGill University
 # Date: January 2015
 # Updated for Transient Analysis by: Diego Heredia 
 # 
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
 if {$ok != 0} {
     puts "Initial Test Failed - Trying KrylovNewton Algorithm..."
     algorithm KrylovNewton
     eval "test $alt_test $currentTolerance [expr $nr_iter_100] 0"
	 #set ok [analyze 10 $currentdt]
	 set ok [analyze 10 [expr $currentdt/10]]
 }
 

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (InitialInterpolation) Algorithm..."
     eval "test $alt_test $currentTolerance [expr $nr_iter_100] 0"
     algorithm NewtonLineSearch 0.75
     #set ok [analyze 10 [expr $currentdt/2]]
	 set ok [analyze 10 [expr $currentdt/10]]
 }

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (Bisection) Algorithm..."
     eval "test $alt_test $currentTolerance [expr $nr_iter_100] 0"
     algorithm NewtonLineSearch -type Bisection 0.75;
     set ok [analyze 10 [expr $currentdt/10]]
 }
 
 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (Secant) Algorithm..."
     eval "test $alt_test $currentTolerance [expr $nr_iter_100] 0"
     algorithm NewtonLineSearch -type Secant 0.75;
     set ok [analyze 10 [expr $currentdt/10]]
 }
 
  # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton Algorithm with Initial Stiffness Iterations Algorithm..."
     # eval "test $alt_test $currentTolerance [expr 10*$nr_iter_100] 0"
     # algorithm ModifiedNewton -initial;
     # #set ok [analyze 10 $currentdt]
	 # set ok [analyze 10 [expr $currentdt/10]]
	 # }
	 
 # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton Algorithm with Initial Stiffness Iterations Algorithm..."
     # eval "test $main_test $currentTolerance [expr 10*$nr_iter_100] 0"
     # algorithm ModifiedNewton -initial;
     # #set ok [analyze 10 $currentdt]
	 # set ok [analyze 10 [expr $currentdt/10]]
	 # }

