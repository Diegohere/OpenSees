 # DynamicSolutionAlgorithmSubFile
 # Developed by: Seong-Hoon Hwang of McGill University
 # Date: January 2015
 # Updated for Transient Analysis by: Hammad El Jisr 
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

 # I added these solution algorithm (date: 20/Jan/2015)
 if {$ok != 0} {
     puts "Initial Test Failed - Trying KrylovNewton Algorithm..."
     algorithm KrylovNewton
     eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
	 #set ok [analyze 10 $currentdt]
	 set ok [analyze 10 [expr $currentdt/10]]
 }
 
 if {$ok != 0} {
     puts "That Failed - Trying SecantNewton Algorithm..."
     eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     algorithm SecantNewton
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
     algorithm NewtonLineSearch Bisection 0.75;
     set ok [analyze 10 [expr $currentdt/10]]
 }

 # if {$ok != 0} {
     # puts "That Failed - Trying NewtonLineSearch (Secant) Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm NewtonLineSearch Secant 0.75;
     # set ok [analyze 100 $currentdt]
 # }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying NewtonLineSearch (RegulaFalsi) Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm NewtonLineSearch RegulaFalsi 0.75;
     # set ok [analyze 100 $currentdt]
     # }
 
 # if {$ok != 0} {
	 # puts "That Failed - Trying Newton Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm Newton
     # set ok [analyze 100 $currentdt/2]
 # }
    
 # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm ModifiedNewton 
     # set ok [analyze 100 $currentdt/10]
 # }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton (Initial Stiffness) Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm ModifiedNewton -initial
     # set ok [analyze 100 $currentdt/100]
 # }
 
 # if {$ok != 0 && $CollapseState != 1} {
     # puts "That Failed - Trying BFGS Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm BFGS
     # set ok [analyze 100 $currentdt]
     # }
 
 # if {$ok != 0 && $CollapseState != 1} {
     # puts "That Failed - Trying Broyden Algorithm..."
     # eval "test $main_test $currentTolerance [expr $nr_iter_100] 0"
     # algorithm Broyden 10
     # set ok [analyze 100 $currentdt]
 # }
 
 
 # if {$ok != 0 && $i > 14} {
     # puts "That Failed - Trying Newton with Fixed Number of Iterations..."
	 # # Fixed iterations once all algorithms fail
	 # set fixed 1;									
     # integrator NewmarkHSFixedNumIter 0.5 0.25
	 # test FixedNumIter 50
	 # algorithm Newton
	 # set ok [analyze 10 [expr $currentdt/10.0]]
 # }