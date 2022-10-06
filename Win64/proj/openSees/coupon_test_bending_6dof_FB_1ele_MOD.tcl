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
node 2 100 0 0;  



		

# Single point constraints -- Boundary Conditions
fix 1 1 1 1 1 1 1; 			# node DX DY RZ
fix 2 0 0 1 1 1 1; #warping fixed, and fixed-fixed type


# nodal masses:
mass 2 1e-9 $Mass 1e-9 1e-9 1e-9 1e-9;		# node#, Mx My Mz, Mass=Weight/g, neglect rotational inertia at nodes



# Define ELEMENTS & SECTIONS -------------------------------------------------------------
set ColSecTag_W 1;			# assign a tag number to the column section	
set ColSecTag_F 2;

# define section geometry



# MATERIAL parameters -------------------------------------------------------------------
set IDsteelWeb 1; 			# material ID tag 
set IDsteelFlange 2;




# nominal concrete compressive strength


#nDMaterial LocalBucklingWebPlate $IDsteelWeb 29000.0 0.3 50.0 13.0 12.0 0.0 1.0 1 490.0 20.0 20.75 0.5625 58.3 1;
#nDMaterial LocalBucklingFlangePlate $IDsteelFlange 29000.0 0.3 50.0 13.0 12.0 0.0 1.0 1 490.0 20.0 3.375 1.0 58.3 1;

nDMaterial LocalBucklingWebPlate $IDsteelWeb 29000.0 0.3 55.0 17.8 19.74 20.81 248.14 2 4589.0 277.32 224.6 9.04 20.75 0.5625 200.0 1;
nDMaterial LocalBucklingFlangePlate $IDsteelFlange 29000.0 0.3 54.0 20.45 15.20 19.72 211.16 2 3716.0 235.12 136.62 3.16 4.5 1.0 60.0 1.0;


# FIBER SECTION properties -------------------------------------------------------------

set E 29000.0;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	10.; 			# median depth
	set J   500.; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 

#
#  section: 

	section NDFiber $ColSecTag_W -GJ $GJ {;	# Define the fiber section
	patch rect $IDsteelWeb 2 2 -5 -5 5 5 ; 	# Define 4 in X 4 in patch
	
	};	# end of fibersection definition
	
	section NDFiber $ColSecTag_F -GJ $GJ {;	# Define the fiber section
	patch rect $IDsteelFlange 2 2 -5 -5 5 5 ; 	# Define 4 in X 4 in patch
		
	};	# end of fibersection definition
	
	
  
    

# define geometric transformation: performs a linear geometric transformation of beam stiffness and resisting force from the basic system to the global-coordinate system
set ColTransfTag 1; 			# associate a tag to column transformation
geomTransf Corotational $ColTransfTag 0 0 1 ; #UL geometric nonlinearity included in Linear transformation
 	

# element connectivity:
set numIntgrPts 5;								# number of integration points for force-based element


#element dispBeamColumn 1 1 2 $numIntgrPts $ColSecTag_W $ColTransfTag; 
element forceBeamColumn 1 1 2 $numIntgrPts $ColSecTag_F $ColTransfTag -iter 20 1e-6;

#element dispBeamColumn 2 2 3 $numIntgrPts $ColSecTag_W $ColTransfTag; 




# Define RECORDERS -------------------------------------------------------------
recorder Node -file Data/DFree.out -time -node 2 -dof 2 disp;		# displacements of free nodes
recorder Node -file Data/RBase.out -time -node 1 -dof 2 reaction;
recorder Node -file Data/RBase_axial.out -time -node 1 -dof 1 reaction;

recorder Node -file Data/DFree_axial.out -time -node 5 -dof 1 disp;


recorder Node -file Data/disp_u_y.out -time -node 1 2 -dof 2 disp;
recorder Node -file Data/disp_u_x.out -time -node 1 2 -dof 1 disp;
recorder Node -file Data/disp_u_z.out -time -node 1 2 -dof 3 disp;
recorder Node -file Data/disp_theta_x.out -time -node 1 2 -dof 4 disp;
recorder Node -file Data/disp_theta_y.out -time -node 1 2 -dof 5 disp;
recorder Node -file Data/disp_theta_z.out -time -node 1 2 -dof 6 disp;
#recorder Node -file Data/disp_theta_x_prime.out -time -node 1 2 3 4 5 -dof 7 disp;
#recorder Node -file Data/rot_Zaxis.out -time -node 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 -dof 6 disp;








# strains at the middle layer of the tip of the flange (modified)
recorder Element -file Data/StrainC1.out -time -ele 1 section 1 fiber 5 0 strain; # strain of elements along length
recorder Element -file Data/StressC1.out -time -ele 1 section 1 fiber 5 0 stress; # strain of elements along length



# define GRAVITY -------------------------------------------------------------
pattern Plain 1 Linear {
  load 2 -1200 0 0 0 0 0 
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
set IDctrlNode 2;			# node where displacement is read for displacement control
set IDctrlDOF 2;			# degree of freedom of displacement read for displacement contro
set Dmax 12.0;
#set Dmax 0.20;
set Dincr 0.05;
set Dincr_min 0.001;
#set Dmax [expr 0.04*$LCol];		# maximum displacement of pushover. push to 10% drift.
#set Dincr [expr 0.001*$LCol];		# displacement increment for pushover. you want this to be very small, but not too small to slow down the analysis

# create load pattern for lateral pushover load
set Hload [expr $Weight];				# define the lateral load as a proportion of the weight so that the pseudo time equals the lateral-load coefficient when using linear load pattern
pattern Plain 200 Linear {;			# define load pattern -- generalized
	
	load 2 0.0 10.0 0.0 0.0 0.0 0.0;	# define torsional load in static torsional analysis
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
set maxNumIter 50;                # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
set printFlag 0;                # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step; 
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

#integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr
#integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr 1 $Dincr_min $Dincr 
#integrator ArcLength 0.01 1;

# ANALYSIS  -- defines what type of analysis is to be performed (http://opensees.berkeley.edu/OpenSees/manuals/usermanual/324.htm)
#          Static Analysis -- solves the KU=R problem, without the mass or damping matrices. 
#          Transient Analysis -- solves the time-dependent analysis. The time step in this type of analysis is constant. The time step in the output is also constant. 
#          variableTransient Analysis -- performs the same analysis type as the Transient Analysis object. The time step, however, is variable. This method is used when 
#                 there are convergence problems with the Transient Analysis object at a peak or when the time step is too small. The time step in the output is also variable.
analysis Static

#  ---------------------------------    perform Static Pushover Analysis
set Nsteps [expr int($Dmax/$Dincr)];        # number of pushover analysis steps
#set ok [analyze $Nsteps];                # this will return zero if no convergence problems were encountered

set h 0;
  while {$h < $Nsteps} {

	# Displacement Control Integrator
	integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr

	analysis Static
     puts "increment = [expr {$h +1}] / $Nsteps";

	set ok [ analyze 1]
	set h [expr $h + 1 ]
} 


puts "DonePushover"

