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

#include <SimpsonIrregularlySpacedBeamIntegration.h>
#include <elementAPI.h>
#include <ID.h>

void* OPS_SimpsonIrregularlySpacedBeamIntegration(int& integrationTag, ID& secTags)
{
  int nArgs = OPS_GetNumRemainingInputArgs();

  if (nArgs < 3+6) {
    opserr<<"insufficient arguments:integrationTag,secTag,N -or- N,*secTagList\n";
    return 0;
  }
  
  // Get input of type int
  int intData[2+3];
  int numIntData = 2+3;
  if (OPS_GetIntInput(&numIntData,&intData[0]) < 0) {
    opserr << "SimpsonIrregularlySpacedBeamIntegration - unable to read int data" << endln;
    return 0;
  }
  integrationTag = intData[0];

  // Get input of type double
  int numDoubleData = 3;
  double doubleData[3];
  if (OPS_GetDoubleInput(&numDoubleData, &doubleData[0]) < 0) {
      opserr << "SimpsonIrregularlySpacedBeamIntegration - unable to read double data\n";
      return 0;
  }
  double Lp1 = doubleData[0];
  double Lp2 = doubleData[1];
  double Le = doubleData[2];
  
  if (nArgs == 3+6) {
    // inputs: integrationTag,secTag,N, nIPs_Lp1, nIPs_Lp2, nIPs_Le
    numIntData = 1;
    int Nsections;
    if (OPS_GetIntInput(&numIntData,&Nsections) < 0) {
      opserr << "SimpsonIrregularlySpacedBeamIntegration - Unable to read number of sections" << endln;
      return 0;
    }
    if (Nsections < 0)
      return 0;
    
    if (Nsections > 0) {
      secTags.resize(Nsections);
    } else {
      secTags = ID();
    }
    for (int i=0; i<secTags.Size(); i++) {
      secTags(i) = intData[1];
    }
  }
  else {
    // inputs: integrationTag,N,*secTagList
    int Nsections = intData[1];
    if (Nsections < 0)
      return 0;
    int *sections = new int[Nsections];
    if (OPS_GetIntInput(&Nsections,sections) < 0) {
      opserr << "SimpsonIrregularlySpacedBeamIntegration - Unable to read section tags" << endln;
      return 0;
    }
    if (Nsections > 0) {
      secTags.resize(Nsections);
    } else {
      secTags = ID();
    }
    for (int i=0; i<secTags.Size(); i++) {
      secTags(i) = sections[i];
    }      
    delete [] sections;
  }

  int nIPs_Lp1 = intData[2];
  int nIPs_Lp2 = intData[3];
  int nIPs_Le = intData[4];

  return new SimpsonIrregularlySpacedBeamIntegration(Lp1, nIPs_Lp1, Lp2, nIPs_Lp2, Le, nIPs_Le);
}

SimpsonIrregularlySpacedBeamIntegration::SimpsonIrregularlySpacedBeamIntegration(double the_Lp1, int the_nIPs_Lp1, double the_Lp2, int the_nIPs_Lp2, double the_Le, int the_nIPs_Le) :
BeamIntegration(BEAM_INTEGRATION_TAG_Simpson), Lp1(the_Lp1), nIPs_Lp1(the_nIPs_Lp1), Lp2(the_Lp2), nIPs_Lp2(std::max(1,the_nIPs_Lp2)), Le(the_Le), nIPs_Le(the_nIPs_Le),
wAll(Vector(nIPs_Lp1+nIPs_Lp2+nIPs_Le)), xAll(Vector(nIPs_Lp1 + nIPs_Lp2 + nIPs_Le))
{
	// Compute locations and weights of integrations points
    computeSectionLocations();
    computeSectionWeights();
}

SimpsonIrregularlySpacedBeamIntegration::~SimpsonIrregularlySpacedBeamIntegration()
{
  
}

BeamIntegration*
SimpsonIrregularlySpacedBeamIntegration::getCopy(void)
{
	return new SimpsonIrregularlySpacedBeamIntegration(Lp1, nIPs_Lp1, Lp2, nIPs_Lp2, Le, nIPs_Le);
}

void 
SimpsonIrregularlySpacedBeamIntegration::computeSectionLocations()
{
    double start_xLp1 = 0;
    double distance_xLp1 = Lp1 / (nIPs_Lp1 - 1.0);
    for (int i = 0; i < nIPs_Lp1; i++)
    {
        xAll[i] = start_xLp1 + i * distance_xLp1;
    }

    double distance_xLe = Le / (nIPs_Le + 1.0);
    double start_xLe = Lp1;
    for (int i = 0; i < nIPs_Le; i++)
    {
        xAll[i+nIPs_Lp1] = start_xLe + (i+1.0) * distance_xLe;
    }

    double start_xLp2 = 1.0 - Lp2;
    double distance_xLp2 = Lp2 / (nIPs_Lp2 - 1.0 + 1e-12);
    for (int i = 0; i < nIPs_Lp2; i++)
    {
        xAll[i + nIPs_Lp1 + nIPs_Le] = start_xLp2 + i * distance_xLp2;
    }
    //opserr << "This is xAll: " << xAll << endln;
}

void
SimpsonIrregularlySpacedBeamIntegration::computeSectionWeights()
{
    int nIPsTot = nIPs_Lp1+ nIPs_Lp2+nIPs_Le;
    int nSubIntervalTot = nIPsTot - 1;
    //Loop through each tripletand distribute weights
    for (int i = 0; i < nSubIntervalTot / 2; ++i) {
        double h2i = xAll[2 * i + 1] - xAll[2 * i ];
        double h2iPlus1 = xAll[2 * i + 2] - xAll[2 * i + 1];

        wAll[2 * i ] += (h2i + h2iPlus1) / 6.0 * (2.0 - h2iPlus1 / h2i);
        wAll[2 * i + 1] += (h2i + h2iPlus1) / 6.0 * ((h2i + h2iPlus1) * (h2i + h2iPlus1) / (h2i * h2iPlus1));
        wAll[2 * i + 2] += (h2i + h2iPlus1) / 6.0 * (2.0 - h2i / h2iPlus1);
    }

    if (nSubIntervalTot % 2 != 0) // if odd number of subintervals
    {
        double hnMinus1 = xAll[nIPsTot - 1] - xAll[nIPsTot - 2];
        double hnMinus2 = xAll[nIPsTot - 2] - xAll[nIPsTot - 3];
        wAll[nIPsTot - 3] = wAll[nIPsTot - 3] - (pow(hnMinus1,3)) / (6 * hnMinus2 * (hnMinus2 + hnMinus1));
        wAll[nIPsTot - 2] = wAll[nIPsTot - 2] + (pow(hnMinus1,2) + 3 * hnMinus1 * hnMinus2) / (6 * hnMinus2);
        wAll[nIPsTot - 1] = wAll[nIPsTot - 1] + (2 * pow(hnMinus1,2) + 3 * hnMinus1 * hnMinus2) / (6 * (hnMinus2 + hnMinus1));
    }

    //opserr << "This is wAll: " << wAll << endln;
      
}

void
SimpsonIrregularlySpacedBeamIntegration::getSectionLocations(int numSections, double L,
double *xi)
{
    for (int i = 0; i < numSections; i++)
    {
        xi[i] = xAll[i];
        //opserr << "This is xi: " << xi[i] << endln;
    }
}

void
SimpsonIrregularlySpacedBeamIntegration::getSectionWeights(int numSections, double L,
double *wt)
{
    for (int i = 0; i < numSections; i++)
    {
        wt[i] = wAll[i];
        //opserr << "This is wt: " << wt[i] << endln;
    }
}

void
SimpsonIrregularlySpacedBeamIntegration::Print(OPS_Stream &s, int flag)
{
	s << "Simpson" << endln;
}
