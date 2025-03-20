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

#ifndef SimpsonIrregularlySpacedBeamIntegration_h
#define SimpsonIrregularlySpacedBeamIntegration_h

#include <BeamIntegration.h>
#include <Vector.h>
#include <cmath>

class Matrix;
class ElementalLoad;
class Channel;
class FEM_ObjectBroker;

class SimpsonIrregularlySpacedBeamIntegration : public BeamIntegration
{
 public:
	 SimpsonIrregularlySpacedBeamIntegration(double Lp1, int nIPs_Lp1, double Lp2, int nIPs_Lp2, double Le, int nIPs_Le);
	 virtual ~SimpsonIrregularlySpacedBeamIntegration();

  void getSectionLocations(int nIP, double L, double *xi);
  void getSectionWeights(int nIP, double L, double *wt);

  BeamIntegration *getCopy(void);

  // These two methods do nothing
  int sendSelf(int cTag, Channel &theChannel) {return 0;}
  int recvSelf(int cTag, Channel &theChannel,
	       FEM_ObjectBroker &theBroker) {return 0;}

  void Print(OPS_Stream &s, int flag = 0);  

private:
	void computeSectionLocations();
	void computeSectionWeights();


	/* ----------------------------------------------------------------------------- */
/* Members                                                                       */
/* ----------------------------------------------------------------------------- */
private:
	double Lp1;
	int nIPs_Lp1;
	double   Lp2;
	int  nIPs_Lp2;
	double  Le;
	int  nIPs_Le ;

	Vector xAll;
	Vector wAll;


};

#endif
