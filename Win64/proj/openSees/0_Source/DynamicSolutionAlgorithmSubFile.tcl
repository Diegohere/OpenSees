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
 
 if {$ok != 0 && $krylovflag == 0} {
     puts "Trying KrylovNewton Algorithm..."
     eval "test $main_test $currentTolerance $nr_iter_2 $show_iter"
     algorithm KrylovNewton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}
 set krylovflag 0;
 
 if {$ok != 0} {
     puts "Trying KrylovNewton Algorithm, Energy..."
     eval "test $alternative_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm KrylovNewton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}
	 
 if {$ok != 0} {
     puts "That Failed - Trying SecantNewton Algorithm..."
     eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm SecantNewton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 if {$ok != 0} {
     puts "That Failed - Trying SecantNewton Algorithm..."
     eval "test $alternative_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm SecantNewton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (InitialInterpolation) Algorithm..."
     eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm NewtonLineSearch 0.75
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 if {$ok != 0} {
     puts "That Failed - Trying NewtonLineSearch (InitialInterpolation) Algorithm..."
     eval "test $alternative_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm NewtonLineSearch 0.75
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 # if {$ok != 0} {
     # puts "That Failed - Trying NewtonLineSearch (Bisection) Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm NewtonLineSearch Bisection 0.75;
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min2 $dt_anal_max $nr_iter2]
 # }

 # if {$ok != 0} {
     # puts "That Failed - Trying NewtonLineSearch (Secant) Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm NewtonLineSearch Secant 0.75;
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min2 $dt_anal_max $nr_iter2]
 # }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying NewtonLineSearch (RegulaFalsi) Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm NewtonLineSearch RegulaFalsi 0.75;
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min2 $dt_anal_max $nr_iter2]
 # }
 
 if {$ok != 0} {
	 puts "That Failed - Trying Newton Algorithm..."
     eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     algorithm Newton
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 # if {$ok != 0} {
	 # puts "That Failed - Trying Newton Algorithm..."
     # eval "test $alternative_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm Newton
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
# }
    
 if {$ok != 0} {
     puts "That Failed - Trying ModifiedNewton Algorithm..."
     eval "test $main_test $currentTolerance $nr_iter_2 $show_iter"
     algorithm ModifiedNewton 
     set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
}

 # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton Algorithm..."
     # eval "test $alternative_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm ModifiedNewton 
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
# }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying ModifiedNewton (Initial Stiffness) Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm ModifiedNewton -initial
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min1 $dt_anal_max $nr_iter1]
     # set ok [analyze $nr_analyse $currentdt $dt_anal_min2 $dt_anal_max $nr_iter2]
 # }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying BFGS Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm BFGS
     # set ok [analyze 10 $currentdt $dt_anal_min $dt_anal_max $nr_iter]
     # }
 
 # if {$ok != 0} {
     # puts "That Failed - Trying Broyden Algorithm..."
     # eval "test $main_test $currentTolerance $nr_iter_1 $show_iter"
     # algorithm Broyden 50
     # set ok [analyze 5 $currentdt $dt_anal_min $dt_anal_max $nr_iter]
 # }
 