###################################################################################################
#          Set Up & Source Definition									  
###################################################################################################
	wipe all;							# clear memory of past model definitions
	model BasicBuilder -ndm 3 -ndf 6;	# Define the model builder, ndm = #dimension, ndf = #dofs
	set dataDir results_testShear_general_HSS;			# name of output folder
	file mkdir $dataDir;						# create output folder
	
	#source DisplayModel2D.tcl;
	#source DisplayPlane.tcl;

###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################
	
# define HSS section
	set D  400.0;										# section depth
	set t  20.00;										# plate thickness
	# no corner sections

	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################

# define structure-geometry parameters
	set L 2000.0;      # Lenght of the column [mm]
	
###################################################################################################
#          Define Subassembly Geometry									  
###################################################################################################
	
# set up geometric transformation of elements
	set ColTransfTag 1; 			# associate a tag to column transformation
	set BeamTransfTag 2; 			# associate a tag to beam transformation
	#geomTransf Linear $ColTransfTag 0 0 -1;		# Linear transformation
	geomTransf Corotational $ColTransfTag 0 0 -1;		# Corotational transformation
	
###################################################################################################
#          Define Nodes & Boundary Conditions							  
###################################################################################################

# define nodes and assign masses to beam-column intersections of frame
	# command:  node nodeID xcoord ycoord 
	node 1 0.0 0.0 0.0;
	node 2 0.0 $L 0.0;
	
# assign boundary conditions 
	# command:  fix nodeID dxFixity dyFixity rzFixity
	# fixity values: 1 = constrained; 0 = unconstrained
	fix 1 1 1 1 1 1 1;
	
###################################################################################################
#          Define Beam-Column Elements							  
###################################################################################################

# define fiber beam-column elements
	set E 200000.;
	set nu 0.3; 
	
	#Torsion part
	set G 	[expr $E/2.0/(1+$nu)]; # shear modulus
	set do 	[expr $D-$t]; 			# median depth
	set J   [expr 1.0/3.0*(2*$D*$t**3.0 + $do*$t**3.0)]; 		# torsional constant   
	set GJ 	[expr $G*$J];  			# torsional stiffness 
	
	nDMaterial ElasticIsotropic 1 $E $nu
	#nDMaterial LocalBucklingWebPlate 1 200000.0 0.3 37300000000.72 141.47 15.2 135.95 211.16 2 25621 235.12 942.18 3.16 $h $b 800000000000.0 1.0;
	
	set NFlat_widthDir 40;
	set NFlat_thickDir 10;
	set NCorner [expr $NFlat_thickDir];
	
	section NDFiberShear 1 -GJ $GJ {;	
		patch rect 1 $NCorner $NCorner [expr -$D/2]	[expr -$D/2]	[expr -($D/2-$t)]	[expr -($D/2-$t)];	#bottom left corner
		patch rect 1 $NFlat_widthDir $NFlat_thickDir [expr -($D/2-$t)]	[expr -($D/2)]	[expr ($D/2-$t)]	[expr -($D/2-$t)];	#left flat
		patch rect 1 $NCorner $NCorner [expr ($D/2-$t)]	[expr -$D/2]	[expr ($D/2)]	[expr -($D/2-$t)];	#top left corner
		patch rect 1 $NFlat_thickDir $NFlat_widthDir  [expr ($D/2-$t)]	[expr -($D/2-$t)]	[expr ($D/2)]	[expr ($D/2-$t)];	#top flat
		patch rect 1 $NCorner $NCorner [expr ($D/2-$t)]	[expr ($D/2-$t)]	[expr ($D/2)]	[expr ($D/2)];	#top right corner
		patch rect 1 $NFlat_widthDir $NFlat_thickDir [expr -($D/2-$t)]	[expr ($D/2-$t)]	[expr ($D/2-$t)]	[expr ($D/2)];	#right flat
		patch rect 1 $NCorner $NCorner [expr -($D/2)]	[expr ($D/2-$t)]	[expr -($D/2-$t)]	[expr ($D/2)];	#bottom right corner
		patch rect 1 $NFlat_thickDir $NFlat_widthDir  [expr -($D/2)]	[expr -($D/2-$t)]	[expr -($D/2-$t)]	[expr ($D/2-$t)];	#bottom flat
	}

	
	#set integration "NewtonCotes 1 5"
	#element  forceBeamColumn 12 1 2 $ColTransfTag $integration -iter 30 1e-5
	#set lc [expr 0.0*$bf];
	#element gradientForceBeamColumn 12 1 2 $ColTransfTag Simpson 1 9  20 1e-6 $lc
	
	set lc [expr 0.0*$D];
	element testNonlocalElementDH 12 1 2 $ColTransfTag Simpson 1 5  20 1e-6 $lc 
	
############################################################################
#              Recorders					                			   
############################################################################

puts "Recorders ..."

#lc20bfLcSurDx4
# Record displacements 
	#recorder Node -file $dataDir/testShear4Rectangle_Disp.txt -node 2 -dof 1 2 disp;
	
# Record reactions
	recorder Node -file $dataDir/testShear4HSS_strongAxis_RBase.txt -node 1 -dof 1 2 3 4 5 6 reaction;
	
# Record stress and strains for fibers
# recorder Element -file $dataDir/testShear4WF_stressFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 stress; 
# recorder Element -file $dataDir/testShear4WF_strainFiberY202Z33.txt -ele 12 section 1 fiber 202.40 33.00 strain; 

# Record section connectivity and coordinate matrices
recorder Element -file $dataDir/testShear4HSS_strongAxis_connectivityMatrix.txt -ele 12 section 1 connectivity; 
recorder Element -file $dataDir/testShear4HSS_strongAxis_coordinateMatrix.txt -ele 12 section 1 coordinate; 

# Record all fiber stresses
recorder Element -file $dataDir/testShear4HSS_strongAxis_allFiberStresses.txt -ele 12 section 1 allFiberStresses; 



# Define display;	
#DisplayModel2D NodeNumbers 2.8 10 10  1200 800 -wipe;
#DisplayPlane "DeformedShape" 2.8 XY 0;

	
#######################################################################################
#                                                                                     #
#                              Analysis Section			                          #
#                                                                                     #
#######################################################################################

# Start timer
set tStart [clock seconds]


# define LATERAL LOAD -------------------------------------------------------------
pattern Plain 1 Linear {
   load 2 -500000 0 0 0 0 0

}

# Gravity-analysis parameters -- load-controlled static analysis
set Tol 1.0e-6;			# convergence tolerance for test
constraints Plain;     		# how it handles boundary conditions
numberer Plain;			# renumber dof's to minimize band-width (optimization), if you want to
system  BandGeneral;		# how to store and solve the system of equations in the analysis
test RelativeNormUnbalance $Tol 20 0; 		# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;			# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 10;  		# apply gravity in 1 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;	# determine the next time step for an analysis
analysis Static;			# define type of analysis static or transient
analyze $NstepGravity;		# apply gravity
# ------------------------------------------------- maintain constant gravity loads and reset time to zero



set tFinish [clock seconds];

puts "Duration Process: [expr $tFinish - $tStart]"; 

	

wipe all;