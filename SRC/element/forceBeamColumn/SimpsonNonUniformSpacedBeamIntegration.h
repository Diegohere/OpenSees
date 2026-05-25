/* ****************************************************************** **
**    OpenSees - Open System for Earthquake Engineering Simulation    **
**          Pacific Earthquake Engineering Research Center            **
**                                                                    **
**                                                                    **
** (C) Copyright 1999, The Regents of the University of California    **
** All Rights Reserved.                                               **
**                                                                    **
** Commercial use of this program without express permission of the   **
** University of California, Berkeley, is strictly prohibited.  See   **
** file 'COPYRIGHT'  in main directory for information on usage and   **
** redistribution,  and for a DISCLAIMER OF ALL WARRANTIES.           **
**                                                                    **
** Developed by:                                                      **
**   Frank McKenna (fmckenna@ce.berkeley.edu)                         **
**   Gregory L. Fenves (fenves@ce.berkeley.edu)                       **
**   Filip C. Filippou (filippou@ce.berkeley.edu)                     **
**                                                                    **
** ****************************************************************** */

/* Created: 20.03.2025
** Written by: Diego Heredia
*/

#ifndef SimpsonNonUniformSpacedBeamIntegration_h
#define SimpsonNonUniformSpacedBeamIntegration_h

#include <BeamIntegration.h>
#include <Vector.h>
#include <cmath>
#include <iostream>

class Matrix;
class ElementalLoad;
class Channel;
class FEM_ObjectBroker;

class SimpsonNonUniformSpacedBeamIntegration : public BeamIntegration
{
 public:
	 // Original 3-segment constructor:
	//   [0,Lp1] | [Lp1,Lp1+Le] | [1-Lp2,1]
	// nIPs_Lp1 and nIPs_Lp2 include the segment end points.
	// nIPs_Le is kept with the original convention: it is the number
	// of interior points in the elastic/middle segment. Therefore,
	// nIPs_Le = 1 gives Simpson over the middle segment.
	 SimpsonNonUniformSpacedBeamIntegration(double Lp1, int nIPs_Lp1,
		 double Lp2, int nIPs_Lp2,
		 double Le, int nIPs_Le);

	 // New 5-segment constructor for RBS-type rules:
	 //   L1 | L2 | L3 | L4 | L5
	 // All nIPs_Li include the segment end points.
	 // Shared points at segment interfaces are merged automatically.
	 SimpsonNonUniformSpacedBeamIntegration(double L1, int nIPs_L1,
		 double L2, int nIPs_L2,
		 double L3, int nIPs_L3,
		 double L4, int nIPs_L4,
		 double L5, int nIPs_L5);

	 virtual ~SimpsonNonUniformSpacedBeamIntegration();

  void getSectionLocations(int nIP, double L, double *xi);
  void getSectionWeights(int nIP, double L, double *wt);

  BeamIntegration *getCopy(void);

  // These two methods do nothing
  int sendSelf(int cTag, Channel &theChannel) {return 0;}
  int recvSelf(int cTag, Channel &theChannel,
	       FEM_ObjectBroker &theBroker) {return 0;}

  void Print(OPS_Stream &s, int flag = 0);  

private:
	// Internal constructor used by getCopy. The input is already in
	// physical segment order and all nIPs include segment end points.
	SimpsonNonUniformSpacedBeamIntegration(const Vector& lengths,
		const Vector& nIPs);

	void setSegments(const Vector& lengths, const Vector& nIPs);
	void computeSectionLocationsAndWeights();
	int getNumUniqueIPs(void) const;


	/* ----------------------------------------------------------------------------- */
/* Members                                                                       */
/* ----------------------------------------------------------------------------- */
private:
	int nSegments;
	Vector segLengths;
	Vector segNIPs;

	Vector xAll;
	Vector wAll;


};

#endif
