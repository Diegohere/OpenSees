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

#include <SimpsonNonUniformSpacedBeamIntegration.h>
#include <elementAPI.h>
#include <ID.h>


void* OPS_SimpsonNonUniformSpacedBeamIntegration(int& integrationTag, ID& secTags)
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
    opserr << "SimpsonNonUniformSpacedBeamIntegration - unable to read int data" << endln;
    return 0;
  }
  integrationTag = intData[0];

  // Get input of type double
  int numDoubleData = 3;
  double doubleData[3];
  if (OPS_GetDoubleInput(&numDoubleData, &doubleData[0]) < 0) {
      opserr << "SimpsonNonUniformSpacedBeamIntegration - unable to read double data\n";
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
      opserr << "SimpsonNonUniformSpacedBeamIntegration - Unable to read number of sections" << endln;
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
      opserr << "SimpsonNonUniformSpacedBeamIntegration - Unable to read section tags" << endln;
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

  return new SimpsonNonUniformSpacedBeamIntegration(Lp1, nIPs_Lp1, Lp2, nIPs_Lp2, Le, nIPs_Le);
}

SimpsonNonUniformSpacedBeamIntegration::SimpsonNonUniformSpacedBeamIntegration(
    double the_Lp1, int the_nIPs_Lp1,
    double the_Lp2, int the_nIPs_Lp2,
    double the_Le, int the_nIPs_Le) :
    BeamIntegration(BEAM_INTEGRATION_TAG_SimpsonNonUniformSpacedBeamIntegration),
    nSegments(0), segLengths(0), segNIPs(0), xAll(0), wAll(0)
{
    // Preserve the original 3-segment input convention:
    // input order is Lp1, Lp2, Le, but the physical order is
    // Lp1 | Le | Lp2.
    // nIPs_Lp1 and nIPs_Lp2 include segment endpoints.
    // nIPs_Le is the number of interior points in Le.
    Vector lengths(3);
    lengths(0) = the_Lp1;
    lengths(1) = the_Le;
    lengths(2) = the_Lp2;

    Vector nIPs(3);
    nIPs(0) = the_nIPs_Lp1;
    nIPs(1) = the_nIPs_Le + 2; // convert interior points to Simpson points including endpoints
    nIPs(2) = the_nIPs_Lp2;

    setSegments(lengths, nIPs);
}

SimpsonNonUniformSpacedBeamIntegration::SimpsonNonUniformSpacedBeamIntegration(
    double the_L1, int the_nIPs_L1,
    double the_L2, int the_nIPs_L2,
    double the_L3, int the_nIPs_L3,
    double the_L4, int the_nIPs_L4,
    double the_L5, int the_nIPs_L5) :
    BeamIntegration(BEAM_INTEGRATION_TAG_SimpsonNonUniformSpacedBeamIntegration),
    nSegments(0), segLengths(0), segNIPs(0), xAll(0), wAll(0)
{
    // New 5-segment convention:
    // physical order is L1 | L2 | L3 | L4 | L5.
    // All nIPs include the segment endpoints; shared interface points
    // are merged internally.
    Vector lengths(5);
    lengths(0) = the_L1;
    lengths(1) = the_L2;
    lengths(2) = the_L3;
    lengths(3) = the_L4;
    lengths(4) = the_L5;

    Vector nIPs(5);
    nIPs(0) = the_nIPs_L1;
    nIPs(1) = the_nIPs_L2;
    nIPs(2) = the_nIPs_L3;
    nIPs(3) = the_nIPs_L4;
    nIPs(4) = the_nIPs_L5;

    setSegments(lengths, nIPs);
}

SimpsonNonUniformSpacedBeamIntegration::SimpsonNonUniformSpacedBeamIntegration(
    const Vector& lengths, const Vector& nIPs) :
    BeamIntegration(BEAM_INTEGRATION_TAG_SimpsonNonUniformSpacedBeamIntegration),
    nSegments(0), segLengths(0), segNIPs(0), xAll(0), wAll(0)
{
    setSegments(lengths, nIPs);
}

SimpsonNonUniformSpacedBeamIntegration::~SimpsonNonUniformSpacedBeamIntegration()
{
  
}

BeamIntegration*
SimpsonNonUniformSpacedBeamIntegration::getCopy(void)
{
    return new SimpsonNonUniformSpacedBeamIntegration(segLengths, segNIPs);
}

static int
SimpsonNonUniformSpacedBeamIntegration_getInt(const Vector& v, int i)
{
    return (int)(v(i) + 0.5);
}

void
SimpsonNonUniformSpacedBeamIntegration::setSegments(const Vector& lengths,
    const Vector& nIPs)
{
    nSegments = lengths.Size();

    segLengths = Vector(nSegments);
    segNIPs = Vector(nSegments);

    for (int i = 0; i < nSegments; i++) {
        segLengths(i) = lengths(i);
        segNIPs(i) = nIPs(i);
    }

    const int nIP = getNumUniqueIPs();

    xAll = Vector(nIP);
    wAll = Vector(nIP);

    computeSectionLocationsAndWeights();
}

int
SimpsonNonUniformSpacedBeamIntegration::getNumUniqueIPs(void) const
{
    if (nSegments <= 0)
        return 0;

    int nIP = SimpsonNonUniformSpacedBeamIntegration_getInt(segNIPs, 0);

    for (int i = 1; i < nSegments; i++)
        nIP += SimpsonNonUniformSpacedBeamIntegration_getInt(segNIPs, i) - 1;

    return nIP;
}

void
SimpsonNonUniformSpacedBeamIntegration::computeSectionLocationsAndWeights()
{
    double xStart = 0.0;
    int nextGlobal = 0;

    for (int s = 0; s < nSegments; s++) {
        const double H = segLengths(s);
        const int nPts = SimpsonNonUniformSpacedBeamIntegration_getInt(segNIPs, s);

        if (nPts < 2) {
            opserr << "SimpsonNonUniformSpacedBeamIntegration -- segment "
                << s + 1 << " has fewer than 2 points" << endln;
            return;
        }

        const double dx = H / (double)(nPts - 1);

        // For s > 0, local point j = 0 is the same physical point as
        // the last point of the previous segment, so do not insert it again.
        const int baseGlobal = (s == 0) ? 0 : nextGlobal - 1;
        const int firstLocalPointToInsert = (s == 0) ? 0 : 1;

        for (int j = firstLocalPointToInsert; j < nPts; j++) {
            xAll(nextGlobal) = xStart + (double)j * dx;
            nextGlobal++;
        }

        // Composite Simpson over this segment only. The weights are added
        // to shared interface points, which gives the merged/shared-point rule.
        for (int j = 0; j < nPts - 2; j += 2) {
            const double h0 = dx;
            const double h1 = dx;

            const double w0 = (h0 + h1) / 6.0 * (2.0 - h1 / h0);
            const double w1 = (h0 + h1) / 6.0 *
                ((h0 + h1) * (h0 + h1) / (h0 * h1));
            const double w2 = (h0 + h1) / 6.0 * (2.0 - h0 / h1);

            wAll(baseGlobal + j) += w0;
            wAll(baseGlobal + j + 1) += w1;
            wAll(baseGlobal + j + 2) += w2;
        }

        xStart += H;
    }

    // opserr << "This is xAll: " << xAll << endln;
    // opserr << "This is wAll: " << wAll << endln;
}

void
SimpsonNonUniformSpacedBeamIntegration::getSectionLocations(int numSections, double L,
double *xi)
{
    for (int i = 0; i < numSections; i++)
    {
        xi[i] = xAll[i];
        //opserr << "This is xi: " << xi[i] << endln;
    }
}

void
SimpsonNonUniformSpacedBeamIntegration::getSectionWeights(int numSections, double L,
double *wt)
{
    for (int i = 0; i < numSections; i++)
    {
        wt[i] = wAll[i];
        //opserr << "This is wt: " << wt[i] << endln;
    }
}

void
SimpsonNonUniformSpacedBeamIntegration::Print(OPS_Stream &s, int flag)
{
    s << "SimpsonNonUniformSpacedBeamIntegration" << endln;
    s << "  number of segments: " << nSegments << endln;
}
