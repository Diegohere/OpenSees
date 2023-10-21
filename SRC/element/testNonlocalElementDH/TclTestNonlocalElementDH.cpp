//
// Created by Diego Heredia on 19.09.23
// Contains the source code for the Tcl commands of gradient force-based beam column element
//

/* -------------------------------------------------------------------------- */

#include <stdlib.h>
#include <string.h>
#include <Domain.h>

#include <TclModelBuilder.h>

#include "TestNonlocalElement3dDH.h"
#include "TestNonlocalElement2dDH.h"

#include <LobattoBeamIntegration.h>
#include <NewtonCotesBeamIntegration.h>
#include <TrapezoidalBeamIntegration.h>
#include <CompositeSimpsonBeamIntegration.h>
#include <SimpsonBeamIntegration.h>
#include <LegendreBeamIntegration.h>
#include <RadauBeamIntegration.h>

#include <NewtonCotesBeamIntegrationUpdated.h>

extern void printCommand(int argc, TCL_Char** argv);

int
TclModelBuilder_addTestNonlocalElementDH(ClientData clientData, Tcl_Interp* interp,
	int argc,
	TCL_Char** argv,
	Domain* theTclDomain,
	TclModelBuilder* theTclBuilder)
{
	// ensure the destructor has not been called
	if (theTclBuilder == 0) {
		opserr << "WARNING builder has been destroyed - testNonlocalElementDH\n";
		return TCL_ERROR;
	}

	int ndm = theTclBuilder->getNDM();
	int ndf = theTclBuilder->getNDF();

	// Check the dimension of the simulation (2d or 3d)
	if (ndm == 2) {
		// 2d simulation --> check if 3 DOF per node
		if (ndf != 3) {
			opserr << "WARNING invalid number of DOF: " << ndf;
			opserr << ", for 2d simulation nDOF must be 3 - testNonlocalElementDH\n";
			return TCL_ERROR;
		}

	}
	else if (ndm == 3) {
		// 3d simulation --> check if 6 DOF per node
		if (ndf != 6) {
			opserr << "WARNING invalid number of DOF: " << ndf;
			opserr << ", for 3d simulation nDOF must be 6 - testNonlocalElementDH\n";
			return TCL_ERROR;
		}

	}
	// Works for 2d and 3d simulations
	else {
		opserr << "WARNING invalid dimension, works only for 2d and 3d \n";
		return TCL_ERROR;
	}

	// Check if the number of input arguments is correct
	if (argc < 10) {
		opserr << "WARNING insufficient arguments\n";
		printCommand(argc, argv);
		opserr << "Want: element " << argv[1] << " eleTag,  nodeI,  nodeJ, coordTransf, beamIntegr, sec, numSec, maxNumiters, tolerance, lc\n";
		return TCL_ERROR;
	}

	// Get the id and end nodes
	int eleTag, iNode, jNode;
	// Get the coordinate transformation
	int coordTransfTag;
	// Get the section integration
	BeamIntegration* beamIntegr = 0;
	SectionForceDeformation** IntegrSections;
	int numIntegrPts, integrSecTag;
	// Get the maximum number of iterations and the tolerance
	int maxNumIter;
	double tolerance;
	//Get the element tag
	Element* theElement = 0;
	//Get the characteristic length
	double lc;

	// Check element tag
	if (Tcl_GetInt(interp, argv[2], &eleTag) != TCL_OK) {
		opserr << "WARNING invalid " << argv[1] << " eleTag" << endln;
		return TCL_ERROR;
	}

	// Check iNode
	if (Tcl_GetInt(interp, argv[3], &iNode) != TCL_OK) {
		opserr << "WARNING invalid iNode\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check jNode
	if (Tcl_GetInt(interp, argv[4], &jNode) != TCL_OK) {
		opserr << "WARNING invalid jNode\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check coordinate transformation
	if (Tcl_GetInt(interp, argv[5], &coordTransfTag) != TCL_OK) {
		opserr << "WARNING invalid transfTag\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check 2d or 3d transformation cases
	CrdTransf* theCoordTransf2d = 0;
	CrdTransf* theCoordTransf3d = 0;
	if (ndm == 2)
	{ // Check 2d transformation case
		theCoordTransf2d = OPS_getCrdTransf(coordTransfTag);
		if (!theCoordTransf2d) {
			opserr << "WARNING transformation not found\n";
			opserr << " - transformation: " << coordTransfTag;
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}
	}
	else
	{ // Check 3d transformation case
		theCoordTransf3d = OPS_getCrdTransf(coordTransfTag);
		if (!theCoordTransf3d) {
			opserr << "WARNING transformation not found\n";
			opserr << " - transformation: " << coordTransfTag;
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}
	}

	// Check integration type - for now only works for Gauss-Lobatto and Newton-Cotes
	if (strcmp(argv[6], "Lobatto") == 0 || strcmp(argv[6], "NewtonCotes") == 0
		|| strcmp(argv[6], "NewtonCotesUpdated") == 0 || strcmp(argv[6], "Trapezoidal") == 0
		|| strcmp(argv[6], "Simpson") == 0 || strcmp(argv[6], "Legendre") == 0
		|| strcmp(argv[6], "Radau") == 0 || strcmp(argv[6], "CompositeSimpson") == 0) {

		if (Tcl_GetInt(interp, argv[7], &integrSecTag) != TCL_OK) {
			opserr << "WARNING invalid integrSecTag\n";
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		if (Tcl_GetInt(interp, argv[8], &numIntegrPts) != TCL_OK) {
			opserr << "WARNING invalid numIntegrPts\n";
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		SectionForceDeformation* theIntegrSection = theTclBuilder->getSection(integrSecTag);
		if (theIntegrSection == 0) {
			opserr << "WARNING integration section not found\n";
			opserr << "Section: " << integrSecTag;
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		IntegrSections = new SectionForceDeformation * [numIntegrPts];
		for (int i = 0; i < numIntegrPts; i++)
			IntegrSections[i] = theIntegrSection;

		if (strcmp(argv[6], "Lobatto") == 0) {
			beamIntegr = new LobattoBeamIntegration();
		}
		else if (strcmp(argv[6], "NewtonCotes") == 0) {
			beamIntegr = new NewtonCotesBeamIntegration();
		}
		else if (strcmp(argv[6], "NewtonCotesUpdated") == 0) {
			beamIntegr = new NewtonCotesBeamIntegrationUpdated();
		}
		else if (strcmp(argv[6], "Trapezoidal") == 0) {
			beamIntegr = new TrapezoidalBeamIntegration();
		}
		else if (strcmp(argv[6], "Simpson") == 0) {
			beamIntegr = new SimpsonBeamIntegration();
		}
		else if (strcmp(argv[6], "Legendre") == 0) {
			beamIntegr = new LegendreBeamIntegration();
		}
		else if (strcmp(argv[6], "Radau") == 0) {
			beamIntegr = new RadauBeamIntegration();
		}
		else if (strcmp(argv[6], "CompositeSimpson") == 0) {
			beamIntegr = new CompositeSimpsonBeamIntegration();
		}
		else {
			opserr << "ERROR: invalid integration type: " << argv[6] << endln;
			return TCL_ERROR;
		}

	}

	else {
		opserr << "Unknown integration type: " << argv[6] << endln;
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check maximum number of iteration
	if (Tcl_GetInt(interp, argv[9], &maxNumIter) != TCL_OK) {
		opserr << "WARNING invalid maxNumIter\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check tolerance
	if (Tcl_GetDouble(interp, argv[10], &tolerance) != TCL_OK) {
		opserr << "WARNING invalid tolerance\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	//Check characteristic length lc
	if (Tcl_GetDouble(interp, argv[11], &lc) != TCL_OK) {
		opserr << "WARNING invalid characteristic length lc\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Create the 2d or 3d beam element
	if (ndm == 2) {
		theElement = new TestNonlocalElement2dDH(eleTag, iNode, jNode, *theCoordTransf2d, *beamIntegr, IntegrSections, numIntegrPts, maxNumIter, tolerance, lc);
	}
	else if (ndm == 3) {
		theElement = new TestNonlocalElement3dDH(eleTag, iNode, jNode, *theCoordTransf3d, *beamIntegr, IntegrSections, numIntegrPts, maxNumIter, tolerance, lc);
	}

	if (beamIntegr != 0)
		delete beamIntegr;
	if (IntegrSections != 0)
		delete[] IntegrSections;

	// Check if the element was created 
	if (!theElement) {
		opserr << "WARNING ran out of memory creating element";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Add the beam element to the domain
	if (theTclDomain->addElement(theElement) == false) {
		opserr << "WARNING could not add element to the domain\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		delete theElement;
		return TCL_ERROR;
	}

	// If get here we have successfully created the element and added it to the domain
	return TCL_OK;
}
