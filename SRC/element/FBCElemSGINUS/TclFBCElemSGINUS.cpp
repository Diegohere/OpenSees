//
// Created by Diego Heredia on 22.05.25
// Contains the source code for the Tcl commands of force-based beam column element with selective gradient inelasticity for non-uniform integration point spacing
//

/* -------------------------------------------------------------------------- */

#include <stdlib.h>
#include <string.h>
#include <Domain.h>

#include <TclModelBuilder.h>

#include "FBCElemSGINUS3d.h"
#include "FBCElemSGINUS2d.h"

#include <LobattoBeamIntegration.h>
#include <NewtonCotesBeamIntegration.h>
#include <TrapezoidalBeamIntegration.h>
#include <CompositeSimpsonBeamIntegration.h>
#include <SimpsonBeamIntegration.h>
#include <LegendreBeamIntegration.h>
#include <RadauBeamIntegration.h>

#include <NewtonCotesBeamIntegrationUpdated.h>
#include <SimpsonNonUniformSpacedBeamIntegration.h>

extern void printCommand(int argc, TCL_Char** argv);


static int
TclFBCElemSGINUS_computeNumIPs(int nSegments, const int* nIPs)
{
	if (nSegments == 3) {
		// Original 3-segment convention:
		// Lp1 and Lp2 include their end points, while Le uses interior points only.
		return nIPs[0] + nIPs[1] + nIPs[2];
	}

	// General/RBS convention:
	// each segment includes its two end points and adjacent segments share one point.
	int n = 0;
	for (int i = 0; i < nSegments; i++)
		n += nIPs[i];

	return n - (nSegments - 1);
}

static int
TclFBCElemSGINUS_parseSimpsonSegments(Tcl_Interp* interp, TCL_Char** argv,
	int firstIntegrationArg, int nSegments, double* Lseg, int* nIPs)
{
	for (int i = 0; i < nSegments; i++) {
		if (Tcl_GetDouble(interp, argv[firstIntegrationArg + 2 * i], &Lseg[i]) != TCL_OK)
			return TCL_ERROR;

		if (Tcl_GetInt(interp, argv[firstIntegrationArg + 2 * i + 1], &nIPs[i]) != TCL_OK)
			return TCL_ERROR;
	}

	return TCL_OK;
}


static int
TclFBCElemSGINUS_isValidSimpsonCandidate(int nSegments, const double* Lseg, const int* nIPs, int numSectionTags)
{
	if (TclFBCElemSGINUS_computeNumIPs(nSegments, nIPs) != numSectionTags)
		return 0;

	double Lsum = 0.0;
	for (int i = 0; i < nSegments; i++) {
		if (Lseg[i] <= 0.0)
			return 0;
		Lsum += Lseg[i];
	}

	// The rule is normalized by the element length. This check also prevents
	// a section tag from being accidentally interpreted as a segment length
	// when both the 3- and 5-segment layouts are being tested.
	if (fabs(Lsum - 1.0) > 1.0e-8)
		return 0;

	if (nSegments == 3) {
		if (nIPs[0] < 3 || nIPs[0] % 2 == 0 || nIPs[1] < 3 || nIPs[1] % 2 == 0)
			return 0;
		if (nIPs[2] < 1 || nIPs[2] % 2 == 0)
			return 0;
		return 1;
	}

	if (nSegments == 5) {
		for (int i = 0; i < nSegments; i++) {
			if (nIPs[i] < 3 || nIPs[i] % 2 == 0)
				return 0;
		}
		return 1;
	}

	return 0;
}

static int
TclFBCElemSGINUS_checkSimpsonSegments(int nSegments, const double* Lseg, const int* nIPs)
{
	double Lsum = 0.0;
	for (int i = 0; i < nSegments; i++) {
		if (Lseg[i] <= 0.0) {
			opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration segment "
				<< i + 1 << " has non-positive length\n";
			return TCL_ERROR;
		}
		Lsum += Lseg[i];
	}

	if (fabs(Lsum - 1.0) > 1.0e-10) {
		opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration segment lengths sum to "
			<< Lsum << ", not 1.0\n";
		return TCL_ERROR;
	}

	if (nSegments == 3) {
		// Original convention: Lp1 and Lp2 are full Simpson segments; Le has interior points.
		if (nIPs[0] < 3 || nIPs[0] % 2 == 0 || nIPs[1] < 3 || nIPs[1] % 2 == 0) {
			opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration: nIPs_Lp1 and nIPs_Lp2 must be odd and >= 3\n";
			return TCL_ERROR;
		}
		if (nIPs[2] < 1 || nIPs[2] % 2 == 0) {
			opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration: nIPs_Le must be odd and >= 1\n";
			return TCL_ERROR;
		}
	}
	else if (nSegments == 5) {
		// RBS/general segment convention: every segment is a Simpson segment including endpoints.
		for (int i = 0; i < nSegments; i++) {
			if (nIPs[i] < 3 || nIPs[i] % 2 == 0) {
				opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration: all 5-segment nIPs must be odd and >= 3\n";
				return TCL_ERROR;
			}
		}
	}
	else {
		opserr << "WARNING SimpsonNonUniformSpacedBeamIntegration supports only 3 or 5 segments\n";
		return TCL_ERROR;
	}

	return TCL_OK;
}


int
TclModelBuilder_addFBCElemSGINUS(ClientData clientData, Tcl_Interp* interp,
	int inArgc,
	TCL_Char** inArgv,
	Domain* theTclDomain,
	TclModelBuilder* theTclBuilder)
{
	// ensure the destructor has not been called
	if (theTclBuilder == 0) {
		opserr << "WARNING builder has been destroyed - FBCElemSGINUS\n";
		return TCL_ERROR;
	}

	int ndm = theTclBuilder->getNDM();
	int ndf = theTclBuilder->getNDF();

	// Check the dimension of the simulation (2d or 3d)
	if (ndm == 2) {
		// 2d simulation --> check if 3 DOF per node
		if (ndf != 3) {
			opserr << "WARNING invalid number of DOF: " << ndf;
			opserr << ", for 2d simulation nDOF must be 3 - FBCElemSGINUS\n";
			return TCL_ERROR;
		}

	}
	else if (ndm == 3) {
		// 3d simulation --> check if 6 DOF per node
		if (ndf != 6) {
			opserr << "WARNING invalid number of DOF: " << ndf;
			opserr << ", for 3d simulation nDOF must be 6 - FBCElemSGINUS\n";
			return TCL_ERROR;
		}

	}
	// Works for 2d and 3d simulations
	else {
		opserr << "WARNING invalid dimension, works only for 2d and 3d \n";
		return TCL_ERROR;
	}


	// split possible lists present in argv
	char* List;

	List = Tcl_Merge(inArgc, inArgv);
	if (List == 0) {
		opserr << "WARNING - TclModelBuilder_addFBCElemSGINUS - problem merging list\n";
		return TCL_ERROR;
	}

	// remove braces from list
	for (int i = 0; List[i] != '\0'; i++) {
		if ((List[i] == '{') || (List[i] == '}'))
			List[i] = ' ';
	}

	int argc;
	TCL_Char** argv;

	if (Tcl_SplitList(interp, List, &argc, &argv) != TCL_OK) {
		opserr << "WARNING - TclModelBuilder_addFBCElemSGINUS - problem splitting list\n";
		return TCL_ERROR;
	}
	Tcl_Free((char*)List);


	// Check if the number of input arguments is correct.
	// Standard integrations still have argc = 12.
	// SimpsonNonUniformSpacedBeamIntegration is checked more carefully below because
	// it now supports both 3-segment and 5-segment layouts, each with either one
	// repeated section or an explicit list of section tags.
	int isSimpsonNonUniformCommand = 0;
	if (argc > 6 && strcmp(argv[6], "SimpsonNonUniformSpacedBeamIntegration") == 0)
		isSimpsonNonUniformCommand = 1;

	if (argc != 12 && isSimpsonNonUniformCommand == 0) {
		opserr << "WARNING insufficient arguments\n";
		printCommand(argc, argv);
		opserr << "If standard integration - Want: element " << argv[1] << " eleTag, nodeI, nodeJ, coordTransf, beamIntegr, sec, numSec, maxNumiters, tolerance, lc\n";
		opserr << "If SimpsonNonUniformSpacedBeamIntegration 3 segments, one section - Want: element " << argv[1] << " eleTag, nodeI, nodeJ, coordTransf, SimpsonNonUniformSpacedBeamIntegration, sec, Lp1, nIPs_Lp1, Lp2, nIPs_Lp2, Le, nIPs_Le, maxNumiters, tolerance, lc\n";
		opserr << "If SimpsonNonUniformSpacedBeamIntegration 3 segments, multiple sections - Want: element " << argv[1] << " eleTag, nodeI, nodeJ, coordTransf, SimpsonNonUniformSpacedBeamIntegration, -sections, secTag1 ... secTagN, Lp1, nIPs_Lp1, Lp2, nIPs_Lp2, Le, nIPs_Le, maxNumiters, tolerance, lc\n";
		opserr << "If SimpsonNonUniformSpacedBeamIntegration 5 segments, one section - Want: element " << argv[1] << " eleTag, nodeI, nodeJ, coordTransf, SimpsonNonUniformSpacedBeamIntegration, sec, L1, nIPs_L1, L2, nIPs_L2, L3, nIPs_L3, L4, nIPs_L4, L5, nIPs_L5, maxNumiters, tolerance, lc\n";
		opserr << "If SimpsonNonUniformSpacedBeamIntegration 5 segments, multiple sections - Want: element " << argv[1] << " eleTag, nodeI, nodeJ, coordTransf, SimpsonNonUniformSpacedBeamIntegration, -sections, secTag1 ... secTagN, L1, nIPs_L1, L2, nIPs_L2, L3, nIPs_L3, L4, nIPs_L4, L5, nIPs_L5, maxNumiters, tolerance, lc\n";
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
	// Added for SimpsonNonUniformSpacedBeamIntegration
	double Lseg[5];
	int nIPsSeg[5];
	int nSegments = 0;
	int skipInput = 0;

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

	else if (strcmp(argv[6], "SimpsonNonUniformSpacedBeamIntegration") == 0)
	{
		int useMultipleSections = 0;
		int numSectionTags = 0;
		int firstSectionArg = 7;
		int firstIntegrationArg = 8;

		if (argc <= 7) {
			opserr << "WARNING invalid SimpsonNonUniformSpacedBeamIntegration input\n";
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		if (strcmp(argv[7], "-sections") == 0) {
			useMultipleSections = 1;
			firstSectionArg = 8;

			// Try to identify the layout from the number of section tags and the
			// expected number of unique integration points. This is necessary because
			// the section tags appear before the segment lengths.
			int foundLayout = 0;

			// Candidate 5-segment layout:
			// element ... SimpsonNonUniformSpacedBeamIntegration -sections secTags... L1 n1 L2 n2 L3 n3 L4 n4 L5 n5 maxIter tol lc
			if (argc >= 21) {
				int candidateNumSectionTags = argc - 21;
				int candidateFirstIntegrationArg = firstSectionArg + candidateNumSectionTags;
				double candidateLseg[5];
				int candidateNIPs[5];

				if (candidateNumSectionTags > 0 &&
					TclFBCElemSGINUS_parseSimpsonSegments(interp, argv, candidateFirstIntegrationArg, 5, candidateLseg, candidateNIPs) == TCL_OK &&
					TclFBCElemSGINUS_isValidSimpsonCandidate(5, candidateLseg, candidateNIPs, candidateNumSectionTags) == 1) {

					nSegments = 5;
					numSectionTags = candidateNumSectionTags;
					firstIntegrationArg = candidateFirstIntegrationArg;
					for (int i = 0; i < 5; i++) {
						Lseg[i] = candidateLseg[i];
						nIPsSeg[i] = candidateNIPs[i];
					}
					foundLayout = 1;
				}
			}

			// Candidate 3-segment layout:
			// element ... SimpsonNonUniformSpacedBeamIntegration -sections secTags... Lp1 nLp1 Lp2 nLp2 Le nLe maxIter tol lc
			if (foundLayout == 0 && argc >= 17) {
				int candidateNumSectionTags = argc - 17;
				int candidateFirstIntegrationArg = firstSectionArg + candidateNumSectionTags;
				double candidateLseg[5];
				int candidateNIPs[5];

				if (candidateNumSectionTags > 0 &&
					TclFBCElemSGINUS_parseSimpsonSegments(interp, argv, candidateFirstIntegrationArg, 3, candidateLseg, candidateNIPs) == TCL_OK &&
					TclFBCElemSGINUS_isValidSimpsonCandidate(3, candidateLseg, candidateNIPs, candidateNumSectionTags) == 1) {

					nSegments = 3;
					numSectionTags = candidateNumSectionTags;
					firstIntegrationArg = candidateFirstIntegrationArg;
					for (int i = 0; i < 3; i++) {
						Lseg[i] = candidateLseg[i];
						nIPsSeg[i] = candidateNIPs[i];
					}
					foundLayout = 1;
				}
			}

			if (foundLayout == 0) {
				opserr << "WARNING could not identify SimpsonNonUniformSpacedBeamIntegration layout with -sections\n";
				opserr << "For 3 segments, number of section tags must be nIPs_Lp1 + nIPs_Lp2 + nIPs_Le\n";
				opserr << "For 5 segments, number of section tags must be nIPs_L1 + nIPs_L2 + nIPs_L3 + nIPs_L4 + nIPs_L5 - 4\n";
				opserr << argv[1] << " element: " << eleTag << endln;
				return TCL_ERROR;
			}
		}
		else {
			useMultipleSections = 0;

			if (Tcl_GetInt(interp, argv[7], &integrSecTag) != TCL_OK) {
				opserr << "WARNING invalid integrSecTag\n";
				opserr << argv[1] << " element: " << eleTag << endln;
				return TCL_ERROR;
			}

			// One repeated section, 3 segments: argc = 17.
			if (argc == 17) {
				nSegments = 3;
				firstIntegrationArg = 8;
				if (TclFBCElemSGINUS_parseSimpsonSegments(interp, argv, firstIntegrationArg, nSegments, Lseg, nIPsSeg) != TCL_OK) {
					opserr << "WARNING invalid 3-segment SimpsonNonUniformSpacedBeamIntegration input\n";
					opserr << argv[1] << " element: " << eleTag << endln;
					return TCL_ERROR;
				}
			}
			// One repeated section, 5 segments: argc = 21.
			else if (argc == 21) {
				nSegments = 5;
				firstIntegrationArg = 8;
				if (TclFBCElemSGINUS_parseSimpsonSegments(interp, argv, firstIntegrationArg, nSegments, Lseg, nIPsSeg) != TCL_OK) {
					opserr << "WARNING invalid 5-segment SimpsonNonUniformSpacedBeamIntegration input\n";
					opserr << argv[1] << " element: " << eleTag << endln;
					return TCL_ERROR;
				}
			}
			else {
				opserr << "WARNING invalid number of arguments for SimpsonNonUniformSpacedBeamIntegration without -sections\n";
				opserr << "Expected argc = 17 for 3 segments or argc = 21 for 5 segments\n";
				opserr << argv[1] << " element: " << eleTag << endln;
				return TCL_ERROR;
			}
		}

		if (TclFBCElemSGINUS_checkSimpsonSegments(nSegments, Lseg, nIPsSeg) != TCL_OK) {
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		numIntegrPts = TclFBCElemSGINUS_computeNumIPs(nSegments, nIPsSeg);

		if (useMultipleSections == 1 && numSectionTags != numIntegrPts) {
			opserr << "WARNING number of section tags specified after -sections must match total number of integration points\n";
			opserr << "numSectionTags: " << numSectionTags << ", numIntegrPts: " << numIntegrPts << endln;
			opserr << argv[1] << " element: " << eleTag << endln;
			return TCL_ERROR;
		}

		IntegrSections = new SectionForceDeformation * [numIntegrPts];

		if (useMultipleSections == 0) {
			SectionForceDeformation* theIntegrSection = theTclBuilder->getSection(integrSecTag);
			if (theIntegrSection == 0) {
				opserr << "WARNING integration section not found\n";
				opserr << "Section: " << integrSecTag;
				opserr << argv[1] << " element: " << eleTag << endln;
				delete[] IntegrSections;
				return TCL_ERROR;
			}

			for (int i = 0; i < numIntegrPts; i++)
				IntegrSections[i] = theIntegrSection;
		}
		else {
			for (int i = 0; i < numIntegrPts; i++) {
				if (Tcl_GetInt(interp, argv[firstSectionArg + i], &integrSecTag) != TCL_OK) {
					opserr << "WARNING invalid integrSecTag in -sections list\n";
					opserr << argv[1] << " element: " << eleTag << endln;
					delete[] IntegrSections;
					return TCL_ERROR;
				}

				SectionForceDeformation* theIntegrSection = theTclBuilder->getSection(integrSecTag);
				if (theIntegrSection == 0) {
					opserr << "WARNING integration section not found\n";
					opserr << "Section: " << integrSecTag;
					opserr << argv[1] << " element: " << eleTag << endln;
					delete[] IntegrSections;
					return TCL_ERROR;
				}

				IntegrSections[i] = theIntegrSection;
			}
		}

		if (nSegments == 3) {
			beamIntegr = new SimpsonNonUniformSpacedBeamIntegration(
				Lseg[0], nIPsSeg[0],
				Lseg[1], nIPsSeg[1],
				Lseg[2], nIPsSeg[2]);
			skipInput = 5 + numSectionTags;
		}
		else {
			beamIntegr = new SimpsonNonUniformSpacedBeamIntegration(
				Lseg[0], nIPsSeg[0],
				Lseg[1], nIPsSeg[1],
				Lseg[2], nIPsSeg[2],
				Lseg[3], nIPsSeg[3],
				Lseg[4], nIPsSeg[4]);
			skipInput = 9 + numSectionTags;
		}
	}

	else {
		opserr << "Unknown integration type: " << argv[6] << endln;
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check maximum number of iteration
	if (Tcl_GetInt(interp, argv[9+skipInput], &maxNumIter) != TCL_OK) {
		opserr << "WARNING invalid maxNumIter\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Check tolerance
	if (Tcl_GetDouble(interp, argv[10 + skipInput], &tolerance) != TCL_OK) {
		opserr << "WARNING invalid tolerance\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	//Check characteristic length lc
	if (Tcl_GetDouble(interp, argv[11 + skipInput], &lc) != TCL_OK) {
		opserr << "WARNING invalid characteristic length lc\n";
		opserr << argv[1] << " element: " << eleTag << endln;
		return TCL_ERROR;
	}

	// Create the 2d or 3d beam element
	if (ndm == 2) {
		theElement = new FBCElemSGINUS2d(eleTag, iNode, jNode, *theCoordTransf2d, *beamIntegr, IntegrSections, numIntegrPts, maxNumIter, tolerance, lc);
	}
	else if (ndm == 3) {
		theElement = new FBCElemSGINUS3d(eleTag, iNode, jNode, *theCoordTransf3d, *beamIntegr, IntegrSections, numIntegrPts, maxNumIter, tolerance, lc);
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
