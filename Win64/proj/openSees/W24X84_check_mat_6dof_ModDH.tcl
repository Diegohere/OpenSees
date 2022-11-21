# --------------------------------------------------------------------------------------------------
# Example 2. 2D cantilever column, static pushover
# fiber section, nonlinearBeamColumn element
#			Silvia Mazzoni & Frank McKenna, 2006
#
#    ^Y
#    |
#    2       __ 
#    |          | 
#    |          |
#    |          |
#  (1)       LCol
#    |          |
#    |          |
#    |          |
#  =1=      _|_  -------->X
#

# SET UP ----------------------------------------------------------------------------
# units: kip, inch, sec
wipe;					# clear memory of all past model definitions
file mkdir Data; 				# create data directory
model BasicBuilder -ndm 3 -ndf 6;		# Define the model builder, ndm=#dimension, ndf=#dofs


# define GEOMETRY -------------------------------------------------------------
set LCol 360.0; 		# column length
set Weight 2000; 		# superstructure weight
# define section geometry


# calculated parameters
set PCol $Weight; 		# nodal dead-load weight per column
set g 386.4;			# g.
set Mass [expr $PCol/$g];		# nodal mass
# calculated geometry parameters




# nodal coordinates:
node 1 0 0 0;			# node#, X, Y
node 2 15 0 0;   #imperfect element should be 1.5b_f
node 3 20 0 -0.0187;
node 4 25 0 -0.0373;
node 5 30 0 -0.056;
node 6 35 0 -0.153;
node 7 40 0 -0.250;
node 8 45 0 -0.311;
node 9 50 0 -0.373;
node 10 55 0 -0.434;
node 11 60 0 -0.528;
node 12 65 0 -0.622;  
node 13 70 0 -0.681;
node 14 75 0 -0.739;
node 15 80 0 -0.798;
node 16 85 0 -0.862;
node 17 90 0 -0.926;
node 18 95 0 -0.959;
node 19 100 0 -0.992;
node 20 108 0 -1.000;
node 21 116 0 -0.992;
node 22 121 0 -0.959;
node 23 126 0 -0.926;
node 24 131 0 -0.862;
node 25 136 0 -0.798;
node 26 141 0 -0.739;
node 27 146 0 -0.681;
node 28 151 0 -0.622;
node 29 156 0 -0.528;
node 30 161 0 -0.434;
node 31 166 0 -0.373;
node 32 171 0 -0.311;
node 33 176 0 -0.250;
node 34 181 0 -0.153;
node 35 186 0 -0.056;
node 36 191 0 -0.0373;
node 37 196 0 -0.0187;
node 38 201 0 0;
node 39 216 0 0;
#node 39 216 0 0;  #imperfection

		

# Single point constraints -- Boundary Conditions
fix 1 1 1 1 1 1 1 ; 			# node DX DY RZ
fix 39 0 0 1 1 1 1 ; #warping fixed, and fixed-fixed type


# nodal masses:
mass 39 1e-9 $Mass 1e-9 1e-9 1e-9 1e-9;		# node#, Mx My Mz, Mass=Weight/g, neglect rotational inertia at nodes



# Define ELEMENTS & SECTIONS -------------------------------------------------------------
set ColSecTag 1;			# assign a tag number to the column section	
set ImperfectColSecTag 2;
set ImperfectColSecTag_L 3;
set ImperfectColSecTag_R 4;
# define section geometry



# MATERIAL parameters -------------------------------------------------------------------
set IDsteel 1; 			# material ID tag 
set IDsteel_tension 2;
set IDsteelWeb 3; 
set IDsteelFlange 4; 

# nominal concrete compressive strength


#nDMaterial J2Plasticity $IDsteel 24166.7 11153 50 66.159 85.727 -490.11; #based on ABAQUS predicted critical strain  #used for fixed-fixed condition
#nDMaterial J2Plasticity $IDsteel_tension 24166.7 11153 50 65 12 1450; #hardening steel

#nDMaterial LocalBucklingWebPlate $IDsteelWeb 29000.0 0.3 50.0 13.0 12.0 0.0 1.0 1 490.0 20.0 20.75 0.625 58.0 1;
#nDMaterial LocalBucklingFlangePlate $IDsteelFlange 29000.0 0.3 50.0 13.0 12.0 0.0 1.0 1 490.0 20.0 5.325 0.9375 58.0 1;

nDMaterial LocalBucklingWebPlate $IDsteelWeb 29000.0 0.3 55.0 17.8 19.74 20.81 248.14 2 4589.0 277.32 224.6 9.04 20.75 0.5 60.0 1;
nDMaterial LocalBucklingFlangePlate $IDsteelFlange 29000.0 0.3 54.0 20.45 15.20 19.72 211.16 2 3716.0 235.12 136.62 3.16 2.8125 0.75 75.0 1;

# FIBER SECTION properties -------------------------------------------------------------

#
#  section: 

	set E 29000.0;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set J   [expr 3700.]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
    
	
    section NDFiber $ColSecTag -GJ $GJ {;	# Define the fiber section, G value must be passed instead of GJ in the same command
	patch rect $IDsteelWeb 20 6 -11.3125 -0.25 11.3125 0.25 ; 	# Define the web patch
	patch rect $IDsteelFlange 6 20 11.3125 -4.50 12.0625 4.50 ; 	# Define the top flange patch
	patch rect $IDsteelFlange 6 20 -12.0625 -4.50 -11.3125 4.50 ; 	# Define the bottom flange patch
	
	};	# end of fibersection definition
	
	section NDFiber $ImperfectColSecTag -GJ $GJ {;	# Define the fiber section, G value must be passed instead of GJ in the same command
	patch rect $IDsteelWeb 20 6 -11.35 -0.25 11.35 0.25 ; 	# Define the web patch
	patch rect $IDsteelFlange 6 20 11.35 -4.50 12.0625 4.50 ; 	# Define the top flange patch (imperfect)
	patch rect $IDsteelFlange 6 20 -12.0625 -4.50 -11.35 4.50 ; 	# Define the bottom flange patch
	
	};	# end of fibersection definition


	
	
# define geometric transformation: performs a linear geometric transformation of beam stiffness and resisting force from the basic system to the global-coordinate system
set ColTransfTag 1; 			# associate a tag to column transformation
#geomTransf Linear $ColTransfTag 0 0 1 ; #UL geometric nonlinearity included in Linear transformation
geomTransf Corotational $ColTransfTag 0 0 1 ; #UL geometric nonlinearity included in Linear transformation
 	

# element connectivity:
set numIntgrPts 5;								# number of integration points for force-based element
set numIntgrPtsNew 3;

element dispBeamColumn 1 1 2 $numIntgrPts $ImperfectColSecTag $ColTransfTag; #imperfect ele
element dispBeamColumn 2 2 3 $numIntgrPts $ColSecTag $ColTransfTag; 
element dispBeamColumn 3 3 4 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 4 4 5 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 5 5 6 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 6 6 7 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 7 7 8 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 8 8 9 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 9 9 10 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 10 10 11 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 11 11 12 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 12 12 13 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 13 13 14 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 14 14 15 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 15 15 16 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 16 16 17 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 17 17 18 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 18 18 19 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 19 19 20 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 20 20 21 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 21 21 22 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 22 22 23 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 23 23 24 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 24 24 25 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 25 25 26 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 26 26 27 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 27 27 28 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 28 28 29 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 29 29 30 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 30 30 31 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 31 31 32 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 32 32 33 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 33 33 34 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 34 34 35 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 35 35 36 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 36 36 37 $numIntgrPts $ColSecTag $ColTransfTag;
element dispBeamColumn 37 37 38 $numIntgrPts $ColSecTag $ColTransfTag;
#element dispBeamColumn 38 38 39 $numIntgrPts $ImperfectColSecTag $ColTransfTag; 
element dispBeamColumn 38 38 39 $numIntgrPts $ImperfectColSecTag $ColTransfTag;  # keep it one material (IDSteel) section if fixed-free condition
#element dispBeamColumn 38 38 39 $numIntgrPts $ColSecTag $ColTransfTag;




# Define RECORDERS -------------------------------------------------------------
recorder Node -file Data/DFree.out -time -node 39 -dof 2 disp;		# displacements of free nodes
recorder Node -file Data/RBase.out -time -node 1 -dof 2 reaction;
recorder Node -file Data/RBase_axial.out -time -node 1 -dof 1 reaction;

recorder Node -file Data/DFree_axial.out -time -node 39 -dof 1 disp;

recorder Node -file Data/disp_u_y.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 2 disp;
recorder Node -file Data/disp_u_x.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 1 disp;
recorder Node -file Data/disp_u_z.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 3 disp;
recorder Node -file Data/disp_theta_x.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 4 disp;
recorder Node -file Data/disp_theta_y.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 5 disp;
recorder Node -file Data/disp_theta_z.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 6 disp;
#recorder Node -file Data/disp_theta_x_prime.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 7 disp;
#recorder Node -file Data/rot_Zaxis.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 6 disp;


#recorder Element -file Data/ele1_local_disp.out -time -ele 1 basicDeformation;
#recorder Element -file Data/ele2_local_disp.out -time -ele 2 basicDeformation;
#recorder Element -file Data/ele3_local_disp.out -time -ele 3 basicDeformation;
#recorder Element -file Data/ele4_local_disp.out -time -ele 4 basicDeformation;
#recorder Element -file Data/ele5_local_disp.out -time -ele 5 basicDeformation;
#recorder Element -file Data/ele6_local_disp.out -time -ele 6 basicDeformation;
#recorder Element -file Data/ele7_local_disp.out -time -ele 7 basicDeformation;
#recorder Element -file Data/ele8_local_disp.out -time -ele 8 basicDeformation;
#recorder Element -file Data/ele9_local_disp.out -time -ele 9 basicDeformation;
#recorder Element -file Data/ele10_local_disp.out -time -ele 10 basicDeformation;
#recorder Element -file Data/ele11_local_disp.out -time -ele 11 basicDeformation;
#recorder Element -file Data/ele12_local_disp.out -time -ele 12 basicDeformation;
#recorder Element -file Data/ele13_local_disp.out -time -ele 13 basicDeformation;
#recorder Element -file Data/ele14_local_disp.out -time -ele 14 basicDeformation;
#recorder Element -file Data/ele15_local_disp.out -time -ele 15 basicDeformation;
#recorder Element -file Data/ele16_local_disp.out -time -ele 16 basicDeformation;
#recorder Element -file Data/ele17_local_disp.out -time -ele 17 basicDeformation;



#recorder Element -file Data/ele1_for_local.out -time -ele 17 localForce;
#recorder Element -file Data/ele1_for_global.out -time -ele 17 globalForce;

recorder Element -file Data/StressRMerr1.out -time -ele 38 section 5 fiber -7.3775 0.208333 stress; # stress of elements along length
recorder Element -file Data/StrainRMerr1.out -time -ele 38 section 5 fiber -7.3775 0.208333 strain; # strain of elements along length

#recorder Element -file Data/StressRMerr2.out -time -ele 37 section 5 fiber -7.3775 0.208333 stress; # stress of elements along length
#recorder Element -file Data/StrainRMerr2.out -time -ele 37 section 5 fiber -7.3775 0.208333 strain; # strain of elements along length


#recorder Element -file Data/StressCF2.out -time -ele 1 section 1 fiber 12.1758 5.4825 stress; # stress of elements along length
#recorder Element -file Data/StrainCF2.out -time -ele 1 section 1 fiber 12.1758 5.4825 strain; # strain of elements along length


# strains at the middle layer of the tip of the flange (modified)



# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
  load 39 -247 0 0 0 0 0  
  #load 39 -370 0 0 0 0 0   
  #load 39 -1 0 0 0 0 0 
}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-2;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system BandGeneral;		# how to store and solve the system of equations in the analysis
#test NormDispIncr $Tol 20 2 ; 		# determine if convergence has been achieved at the end of an iteration step
#test NormUnbalance $Tol 20 2 ;
test RelativeNormUnbalance $Tol 25 2 ;
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 30;  		# apply gravity in 10 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero
loadConst -time 0.0

puts "Model Built"

# STATIC PUSHOVER ANALYSIS --------------------------------------------------------------------------------------------------
#
# we need to set up parameters that are particular to the model.
set IDctrlNode 39;			# node where displacement is read for displacement control
set IDctrlDOF 2;			# degree of freedom of displacement read for displacement contro
set Dmax 12.0;
#set Dmax 0.20;
set Dincr 0.1;
set Dincr_min 0.001;
#set Dmax [expr 0.04*$LCol];		# maximum displacement of pushover. push to 10% drift.
#set Dincr [expr 0.001*$LCol];		# displacement increment for pushover. you want this to be very small, but not too small to slow down the analysis

# create load pattern for lateral pushover load
set Hload [expr $Weight];				# define the lateral load as a proportion of the weight so that the pseudo time equals the lateral-load coefficient when using linear load pattern
pattern Plain 200 Linear {;			# define load pattern -- generalized
	#load 39 0.0 -$Hload 0.0 0.0 0.0 0.0;	# define lateral load in static lateral analysis
	load 39 0.0 5.0 0.0 0.0 0.0 0.0;	# define torsional load in static torsional analysis
	#sp 39 2 1;	# define torsional load in static torsional analysis
}

# ----------- set up analysis parameters
# CONSTRAINTS handler -- Determines how the constraint equations are enforced in the analysis (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/617.htm)
#          Plain Constraints -- Removes constrained degrees of freedom from the system of equations (only for homogeneous equations)
#          Lagrange Multipliers -- Uses the method of Lagrange multipliers to enforce constraints 
#          Penalty Method -- Uses penalty numbers to enforce constraints --good for static analysis with non-homogeneous eqns (rigidDiaphragm)
#          Transformation Method -- Performs a condensation of constrained degrees of freedom 
constraints Plain;		

# DOF NUMBERER (number the degrees of freedom in the domain): (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/366.htm)
#   determines the mapping between equation numbers and degrees-of-freedom
#          Plain -- Uses the numbering provided by the user 
#          RCM -- Renumbers the DOF to minimize the matrix band-width using the Reverse Cuthill-McKee algorithm 
numberer Plain

# SYSTEM (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/371.htm)
#   Linear Equation Solvers (how to store and solve the system of equations in the analysis)
#   -- provide the solution of the linear system of equations Ku = P. Each solver is tailored to a specific matrix topology. 
#          ProfileSPD -- Direct profile solver for symmetric positive definite matrices 
#          BandGeneral -- Direct solver for banded unsymmetric matrices 
#          BandSPD -- Direct solver for banded symmetric positive definite matrices 
#          SparseGeneral -- Direct solver for unsymmetric sparse matrices 
#          SparseSPD -- Direct solver for symmetric sparse matrices 
#          UmfPack -- Direct UmfPack solver for unsymmetric matrices 

system BandGeneral
#system BandSPD
#system UmfPack

# TEST: # convergence test to 
# Convergence TEST (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/360.htm)
#   -- Accept the current state of the domain as being on the converged solution path 
#   -- determine if convergence has been achieved at the end of an iteration step
#          NormUnbalance -- Specifies a tolerance on the norm of the unbalanced load at the current iteration 
#          NormDispIncr -- Specifies a tolerance on the norm of the displacement increments at the current iteration 
#          EnergyIncr-- Specifies a tolerance on the inner product of the unbalanced load and displacement increments at the current iteration 
set Tol 1.0e-2;                        # Convergence Test: tolerance
#set Tol 1.0e-8;
set maxNumIter 70;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
set printFlag 2;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step; 
#set TestType EnergyIncr ;	# Convergence-test type
#set TestType NormUnbalance ;
set TestType RelativeNormUnbalance ;

#set TestType RelativeEnergyIncr;
#set TestType RelativeNormDispIncr;
#set TestType NormDispIncr ;
test $TestType $Tol $maxNumIter $printFlag;

#test FixedNumIter 1;

# Solution ALGORITHM: -- Iterate from the last time step to the current (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/682.htm)
#          Linear -- Uses the solution at the first iteration and continues 
#          Newton -- Uses the tangent at the current iteration to iterate to convergence 
#          ModifiedNewton -- Uses the tangent at the first iteration to iterate to convergence 
set algorithmType Newton;
#set algorithmType Linear;
#set algorithmType NewtonLineSearch;
algorithm $algorithmType;        

# Static INTEGRATOR: -- determine the next time step for an analysis  (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/689.htm)
#          LoadControl -- Specifies the incremental load factor to be applied to the loads in the domain 
#          DisplacementControl -- Specifies the incremental displacement at a specified DOF in the domain 
#          Minimum Unbalanced Displacement Norm -- Specifies the incremental load factor such that the residual displacement norm in minimized 
#          Arc Length -- Specifies the incremental arc-length of the load-displacement path 
# Transient INTEGRATOR: -- determine the next time step for an analysis including inertial effects 
#          Newmark -- The two parameter time-stepping method developed by Newmark 
#          HHT -- The three parameter Hilbert-Hughes-Taylor time-stepping method 
#          Central Difference -- Approximates velocity and acceleration by centered finite differences of displacement 
integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr
#integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr 1 $Dincr_min $Dincr 

# ANALYSIS  -- defines what type of analysis is to be performed (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/324.htm)
#          Static Analysis -- solves the KU=R problem, without the mass or damping matrices. 
#          Transient Analysis -- solves the time-dependent analysis. The time step in this type of analysis is constant. The time step in the output is also constant. 
#          variableTransient Analysis -- performs the same analysis type as the Transient Analysis object. The time step, however, is variable. This method is used when 
#                 there are convergence problems with the Transient Analysis object at a peak or when the time step is too small. The time step in the output is also variable.
analysis Static

#  ---------------------------------    perform Static Pushover Analysis
set Nsteps [expr int($Dmax/$Dincr)];        # number of pushover analysis steps
set ok [analyze $Nsteps];                # this will return zero if no convergence problems were encountered


puts "DonePushover"

