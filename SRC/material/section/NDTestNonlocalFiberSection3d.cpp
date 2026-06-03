//Added by Diego Heredia 20.06.2023 for test nonlocal formulation

#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <Channel.h>
#include <Vector.h>
#include <Matrix.h>
#include <MatrixUtil.h>
#include <Fiber.h>
#include <classTags.h>
#include <NDTestNonlocalFiberSection3d.h>
#include <ID.h>
#include <FEM_ObjectBroker.h>
#include <Information.h>
#include <MaterialResponse.h>
#include <NDMaterial.h>
#include <SectionIntegration.h>
#include <Parameter.h>
#include <elementAPI.h>

ID NDTestNonlocalFiberSection3d::code(6);

void* OPS_NDTestNonlocalFiberSection3d()
{
    int numData = OPS_GetNumRemainingInputArgs();
    if(numData < 1) {
	opserr<<"insufficient arguments for NDTestNonlocalFiberSection3d\n";
	return 0;
    }

    numData = 1;
    int tag;
    if (OPS_GetIntInput(&numData,&tag) < 0) return 0;

    bool computeCentroid = true;
    if (OPS_GetNumRemainingInputArgs() > 0) {
      const char* opt = OPS_GetString();
      if (strcmp(opt, "-noCentroid") == 0)
	computeCentroid = false;
    }
    
    int num = 30;
    return new NDTestNonlocalFiberSection3d(tag, num, computeCentroid);
}

// constructors:
NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d(int tag, int num, Fiber** fibers, double a, bool compCentroid) :
    SectionForceDeformation(tag, SEC_TAG_NDTestNonlocalFiberSection3d),
    numFibers(num), sizeFibers(num), theMaterials(0), matData(0),
    Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
    alpha(a), sectionIntegr(0), e(6), s(0), ks(0),
    parameterID(0), dedh(6)
{
  if (numFibers != 0) {
    theMaterials = new NDMaterial *[numFibers];

    if (theMaterials == 0) {
      opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate Material pointers";
      exit(-1);
    }

    matData = new double [numFibers*3];

    if (matData == 0) {
      opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate double array for material data\n";
      exit(-1);
    }


    for (int i = 0; i < numFibers; i++) {
      Fiber *theFiber = fibers[i];
      double yLoc, zLoc, Area;
      theFiber->getFiberLocation(yLoc, zLoc);
      Area = theFiber->getArea();
      Abar  += Area;
      QzBar += yLoc*Area;
      QyBar += zLoc*Area;
      matData[i*3] = yLoc;
      matData[i*3+1] = zLoc;
      matData[i*3+2] = Area;
      NDMaterial *theMat = theFiber->getNDMaterial();
      theMaterials[i] = theMat->getCopy("BeamFiber");

      if (theMaterials[i] == 0) {
	opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to get copy of a Material\n";
	exit(-1);
      }
    }    

    if (computeCentroid) {
      yBar = QzBar/Abar;  
      zBar = QyBar/Abar;
    }
  }

  s = new Vector(sData, 6);
  ks = new Matrix(kData, 6, 6);

  for (int i = 0; i < 6; i++)
    sData[i] = 0.0;

  for (int i = 0; i < 6*6; i++)
    kData[i] = 0.0;

  code(0) = SECTION_RESPONSE_P;
  code(1) = SECTION_RESPONSE_MZ;
  code(2) = SECTION_RESPONSE_MY;
  code(3) = SECTION_RESPONSE_VY;
  code(4) = SECTION_RESPONSE_VZ;
  code(5) = SECTION_RESPONSE_T;
}

NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d(int tag, int num, double a, bool compCentroid): 
    SectionForceDeformation(tag, SEC_TAG_NDTestNonlocalFiberSection3d),
    numFibers(0), sizeFibers(num), theMaterials(0), matData(0),
    Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
    alpha(a), sectionIntegr(0), e(6), s(0), ks(0), 
    parameterID(0), dedh(6)
{
    if (sizeFibers != 0) {
	theMaterials = new NDMaterial *[sizeFibers];

	if (theMaterials == 0) {
	    opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate Material pointers";
	    exit(-1);
	}

	matData = new double [sizeFibers*3];

	if (matData == 0) {
	    opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate double array for material data\n";
	    exit(-1);
	}


	for (int i = 0; i < sizeFibers; i++) {
	    matData[i*3] = 0.0;
	    matData[i*3+1] = 0.0;
	    matData[i*3+2] = 0.0;
	    theMaterials[i] = 0;
	}    
    }

    s = new Vector(sData, 6);
    ks = new Matrix(kData, 6, 6);

    for (int i = 0; i < 6; i++)
	sData[i] = 0.0;

    for (int i = 0; i < 6*6; i++)
	kData[i] = 0.0;

    code(0) = SECTION_RESPONSE_P;
    code(1) = SECTION_RESPONSE_MZ;
    code(2) = SECTION_RESPONSE_MY;
    code(3) = SECTION_RESPONSE_VY;
    code(4) = SECTION_RESPONSE_VZ;
    code(5) = SECTION_RESPONSE_T;
}

NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d(int tag, int num, NDMaterial **mats,
				   SectionIntegration &si, double a, bool compCentroid):
  SectionForceDeformation(tag, SEC_TAG_NDTestNonlocalFiberSection3d),
  numFibers(num), sizeFibers(num), theMaterials(0), matData(0),
  Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
  alpha(a), sectionIntegr(0), e(6), s(0), ks(0), 
  parameterID(0), dedh(6)
{
  if (numFibers != 0) {
    theMaterials = new NDMaterial *[numFibers];

    if (theMaterials == 0) {
      opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate Material pointers";
      exit(-1);
    }
    matData = new double [numFibers*3];

    if (matData == 0) {
      opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to allocate double array for material data\n";
      exit(-1);
    }
  }

  sectionIntegr = si.getCopy();
  if (sectionIntegr == 0) {
    opserr << "Error: NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d: could not create copy of section integration object" << endln;
    exit(-1);
  }

  static double yLocs[10000];
  static double zLocs[10000];
  sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
  
  static double fiberArea[10000];
  sectionIntegr->getFiberWeights(numFibers, fiberArea);

  for (int i = 0; i < numFibers; i++) {

    Abar  += fiberArea[i];
    QzBar += yLocs[i]*fiberArea[i];
    QyBar += zLocs[i]*fiberArea[i];

    theMaterials[i] = mats[i]->getCopy("BeamFiber");
    
    if (theMaterials[i] == 0) {
      opserr << "NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d -- failed to get copy of a Material\n";
      exit(-1);
    }
  }    

  if (computeCentroid) {
    yBar = QzBar/Abar;  
    zBar = QyBar/Abar;
  }

  s = new Vector(sData, 6);
  ks = new Matrix(kData, 6, 6);
  
  for (int i = 0; i < 6; i++)
    sData[i] = 0.0;

  for (int i = 0; i < 6*6; i++)
    kData[i] = 0.0;
  
  code(0) = SECTION_RESPONSE_P;
  code(1) = SECTION_RESPONSE_MZ;
  code(2) = SECTION_RESPONSE_MY;
  code(3) = SECTION_RESPONSE_VY;
  code(4) = SECTION_RESPONSE_VZ;
  code(5) = SECTION_RESPONSE_T;
}

// constructor for blank object that recvSelf needs to be invoked upon
NDTestNonlocalFiberSection3d::NDTestNonlocalFiberSection3d():
  SectionForceDeformation(0, SEC_TAG_NDTestNonlocalFiberSection3d),
  numFibers(0), sizeFibers(0), theMaterials(0), matData(0),
  Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(true),
  alpha(1.0), sectionIntegr(0), e(6), s(0), ks(0),
  parameterID(0), dedh(6)
{
  s = new Vector(sData, 6);
  ks = new Matrix(kData, 6, 6);

  for (int i = 0; i < 6; i++)
    sData[i] = 0.0;

  for (int i = 0; i < 6*6; i++)
    kData[i] = 0.0;

  code(0) = SECTION_RESPONSE_P;
  code(1) = SECTION_RESPONSE_MZ;
  code(2) = SECTION_RESPONSE_MY;
  code(3) = SECTION_RESPONSE_VY;
  code(4) = SECTION_RESPONSE_VZ;
  code(5) = SECTION_RESPONSE_T;

  //getIndexExtremeFibers();
}

int
NDTestNonlocalFiberSection3d::addFiber(Fiber &newFiber)
{
  // need to create larger arrays
  if(numFibers == sizeFibers) {
      int newSize = 2*sizeFibers;
      NDMaterial **newArray = new NDMaterial *[newSize]; 
      double *newMatData = new double [3 * newSize];
      if (newArray == 0 || newMatData == 0) {
	  opserr <<"NDTestNonlocalFiberSection3d::addFiber -- failed to allocate Fiber pointers\n";
	  return -1;
      }
      
      // copy the old pointers and data
      for (int i = 0; i < numFibers; i++) {
	  newArray[i] = theMaterials[i];
	  newMatData[3*i] = matData[3*i];
	  newMatData[3*i+1] = matData[3*i+1];
	  newMatData[3*i+2] = matData[3*i+2];
      }

      // initialize new memory
      for (int i = numFibers; i < newSize; i++) {
	  newArray[i] = 0;
	  newMatData[3*i] = 0.0;
	  newMatData[3*i+1] = 0.0;
	  newMatData[3*i+2] = 0.0;
      }

      sizeFibers = newSize;

      // set new memory
      if (theMaterials != 0) {
	  delete [] theMaterials;
	  delete [] matData;
      }

      theMaterials = newArray;
      matData = newMatData;
  }

  // set the new pointers and data
  double yLoc, zLoc, Area;
  newFiber.getFiberLocation(yLoc, zLoc);
  Area = newFiber.getArea();
  matData[numFibers*3] = yLoc;
  matData[numFibers*3+1] = zLoc;
  matData[numFibers*3+2] = Area;
  NDMaterial *theMat = newFiber.getNDMaterial();
  theMaterials[numFibers] = theMat->getCopy("BeamFiber");

  if (theMaterials[numFibers] == 0) {
    opserr <<"NDTestNonlocalFiberSection3d::addFiber -- failed to get copy of a Material\n";
    return -1;
  }

  numFibers++;

  // Recompute centroid
  if (computeCentroid) {
    Abar  += Area;
    QzBar += yLoc*Area;
    QyBar += zLoc*Area;
    
    yBar = QzBar/Abar;
    zBar = QyBar/Abar;
  }
  
  return 0;
}


// destructor:
NDTestNonlocalFiberSection3d::~NDTestNonlocalFiberSection3d()
{
  if (theMaterials != 0) {
    for (int i = 0; i < numFibers; i++)
      if (theMaterials[i] != 0)
	delete theMaterials[i];
      
    delete [] theMaterials;
  }

  if (matData != 0)
    delete [] matData;

  if (s != 0)
    delete s;

  if (ks != 0)
    delete ks;

  if (sectionIntegr != 0)
    delete sectionIntegr;
}

// a = [1 -y z       0       0  0
//      0  0 0 sqrt(a)       0 -z
//      0  0 0       0 sqrt(a)  y]
int
NDTestNonlocalFiberSection3d::setTrialSectionDeformation (const Vector &deforms)
{
  int res = 0;

  //opserr << "This is AInvMat4SecDef125" << AInvMat4SecDef125 << endln;

  e = deforms;

  s->Zero();
  ks->Zero();

  double d0 = deforms(0);
  double d1 = deforms(1);
  double d2 = deforms(2);
  double d3 = deforms(3);
  double d4 = deforms(4);
  double d5 = deforms(5);


  // ------------------------------------------------------------
// DEBUG: capture two section states across tangent jump
// ------------------------------------------------------------
  /*const int debugSectionTag = 131;

  const double d1A_target = -6.96028e-05;
  const double d1B_target = -6.95522e-05;
  const double d1Tol = 1.0e-09;

  bool captureA = (this->getTag() == debugSectionTag &&
      fabs(d1 - d1A_target) < d1Tol);

  bool captureB = (this->getTag() == debugSectionTag &&
      fabs(d1 - d1B_target) < d1Tol);

  bool debugFiberFD = captureA || captureB;

  static bool haveA = false;
  static int haveATag = -1;

  static double A_eps0[10000];
  static double A_eps1[10000];
  static double A_eps2[10000];
  static double A_sig0[10000];
  static double A_C00[10000];
  static double A_C01[10000];
  static double A_C02[10000];
  static double A_y[10000];
  static double A_z[10000];
  static double A_area[10000];

  double sum_dK11 = 0.0;
  double sum_K11A = 0.0;
  double sum_K11B = 0.0;

  double topAbsDK[10];
  int    topFiber[10];
  double topY[10];
  double topZ[10];
  double topArea[10];
  double topK11A[10];
  double topK11B[10];
  double topDK11[10];
  double topC00A[10];
  double topC00B[10];
  double topSigA[10];
  double topSigB[10];
  double topEpsA[10];
  double topEpsB[10];

  for (int kk = 0; kk < 10; kk++)
  {
      topAbsDK[kk] = 0.0;
      topFiber[kk] = -1;
      topY[kk] = 0.0;
      topZ[kk] = 0.0;
      topArea[kk] = 0.0;
      topK11A[kk] = 0.0;
      topK11B[kk] = 0.0;
      topDK11[kk] = 0.0;
      topC00A[kk] = 0.0;
      topC00B[kk] = 0.0;
      topSigA[kk] = 0.0;
      topSigB[kk] = 0.0;
      topEpsA[kk] = 0.0;
      topEpsB[kk] = 0.0;
  }

  if (debugFiberFD)
  {
      opserr.precision(17);
      opserr << "\n================ SECTION DEBUG STATE ================" << endln;
      opserr << "section tag = " << this->getTag() << endln;
      opserr << "captureA = " << captureA << endln;
      opserr << "captureB = " << captureB << endln;
      opserr << "d1 = " << d1 << endln;
      opserr << "deforms = " << deforms << endln;
      opserr << "=====================================================" << endln;
  }*/

  static double yLocs[10000];
  static double zLocs[10000];
  static double fiberArea[10000];

  //double testI = 0.;
  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
      fiberArea[i] = matData[3*i+2];
      //testI += pow(yLocs[i], 2) * fiberArea[i];
    }
  }

 /* opserr << "This is coord fibers:"<< endln;
  for (int i = 0; i < numFibers; i++) {
      opserr << yLocs[i] << " and " << zLocs[i] << endln;
  }*/
  
  static Vector eps(3);

  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    double y2 = y*y;
    double z2 = z*z;
    double yz = y*z;
    double tmp;

    // determine material strain and set it
    eps(0) = d0 - y*d1 + z*d2;
    eps(1) = rootAlpha*d3 - z*d5;
    eps(2) = rootAlpha*d4 + y*d5;

    res += theMat->setTrialStrain(eps);
    if (res==-1)
    {
        opserr << "This fiber did not converge!" << endln;
        opserr << "This is coordY: " << y << "      This is coordZ: " << z << endln;
        //opserr << "This is coordZ: " << z << endln;
        return -1;
    }
    const Vector &stress = theMat->getStress();
    const Matrix &tangent = theMat->getTangent();
    //const Matrix& strainIncrementDecomposition = theMat->getStrainIncrementDecomposition();
    //opserr << "This is strainIncrementDecomposition" << strainIncrementDecomposition << endln;


    // Diagnostics 06/02/2026
    // ------------------------------------------------------------
// DEBUG: store state A, compare state B
// ------------------------------------------------------------
    /*if (captureA)
    {
        A_eps0[i] = eps(0);
        A_eps1[i] = eps(1);
        A_eps2[i] = eps(2);

        A_sig0[i] = stress(0);

        A_C00[i] = tangent(0, 0);
        A_C01[i] = tangent(0, 1);
        A_C02[i] = tangent(0, 2);

        A_y[i] = y;
        A_z[i] = z;
        A_area[i] = A;
    }

    if (captureB && haveA && haveATag == this->getTag())
    {
        double K11A = y * y * A * A_C00[i];
        double K11B = y * y * A * tangent(0, 0);
        double dK11 = K11B - K11A;

        sum_K11A += K11A;
        sum_K11B += K11B;
        sum_dK11 += dK11;

        double absDK = fabs(dK11);

        for (int kk = 0; kk < 10; kk++)
        {
            if (absDK > topAbsDK[kk])
            {
                for (int mm = 9; mm > kk; mm--)
                {
                    topAbsDK[mm] = topAbsDK[mm - 1];
                    topFiber[mm] = topFiber[mm - 1];
                    topY[mm] = topY[mm - 1];
                    topZ[mm] = topZ[mm - 1];
                    topArea[mm] = topArea[mm - 1];
                    topK11A[mm] = topK11A[mm - 1];
                    topK11B[mm] = topK11B[mm - 1];
                    topDK11[mm] = topDK11[mm - 1];
                    topC00A[mm] = topC00A[mm - 1];
                    topC00B[mm] = topC00B[mm - 1];
                    topSigA[mm] = topSigA[mm - 1];
                    topSigB[mm] = topSigB[mm - 1];
                    topEpsA[mm] = topEpsA[mm - 1];
                    topEpsB[mm] = topEpsB[mm - 1];
                }

                topAbsDK[kk] = absDK;
                topFiber[kk] = i;
                topY[kk] = y;
                topZ[kk] = z;
                topArea[kk] = A;
                topK11A[kk] = K11A;
                topK11B[kk] = K11B;
                topDK11[kk] = dK11;
                topC00A[kk] = A_C00[i];
                topC00B[kk] = tangent(0, 0);
                topSigA[kk] = A_sig0[i];
                topSigB[kk] = stress(0);
                topEpsA[kk] = A_eps0[i];
                topEpsB[kk] = eps(0);

                break;
            }
        }
    }*/


    double d00 = tangent(0,0)*A;
    double d01 = tangent(0,1)*A;
    double d02 = tangent(0,2)*A;
    double d10 = tangent(1,0)*A;
    double d11 = tangent(1,1)*A;
    double d12 = tangent(1,2)*A;
    double d20 = tangent(2,0)*A;
    double d21 = tangent(2,1)*A;
    double d22 = tangent(2,2)*A;

    Matrix &ksi = *ks;
    Vector &si = *s;

    // Bending terms
    ksi(0,0) += d00;
    ksi(1,1) += y2*d00;
    ksi(2,2) += z2*d00;
    tmp = -y*d00;
    ksi(0,1) += tmp;
    ksi(1,0) += tmp;
    tmp = z*d00;
    ksi(0,2) += tmp;
    ksi(2,0) += tmp;
    tmp = -yz*d00;
    ksi(1,2) += tmp;
    ksi(2,1) += tmp;
    
    // Shear terms
    ksi(3,3) += alpha*d11;
    ksi(3,4) += alpha*d12;
    ksi(4,3) += alpha*d21;
    ksi(4,4) += alpha*d22;
    
    // Torsion term
    ksi(5,5) += z2*d11 - yz*(d12+d21) + y2*d22;
    
    // Bending-torsion coupling terms
    tmp = -z*d01 + y*d02;
    ksi(0,5) += tmp;
    ksi(1,5) -= y*tmp;
    ksi(2,5) += z*tmp;
    tmp = -z*d10 + y*d20;
    ksi(5,0) += tmp;
    ksi(5,1) -= y*tmp;
    ksi(5,2) += z*tmp;
    
    // Hit tangent terms with rootAlpha
    d01 *= rootAlpha; d02 *= rootAlpha;
    d10 *= rootAlpha; d11 *= rootAlpha; d12 *= rootAlpha;
    d20 *= rootAlpha; d21 *= rootAlpha; d22 *= rootAlpha;
    
    // Bending-shear coupling terms
    ksi(0,3) += d01;
    ksi(0,4) += d02;
    ksi(1,3) -= y*d01;
    ksi(1,4) -= y*d02;
    ksi(2,3) += z*d01;
    ksi(2,4) += z*d02;
    ksi(3,0) += d10;
    ksi(4,0) += d20;
    ksi(3,1) -= y*d10;
    ksi(4,1) -= y*d20;
    ksi(3,2) += z*d10;
    ksi(4,2) += z*d20;
    
    // Torsion-shear coupling terms
    y2 =  y*d22;
    z2 = -z*d11;
    ksi(5,3) +=  z2 + y*d21;
    ksi(5,4) += -z*d12 + y2;
    ksi(3,5) +=  z2 + y*d12;
    ksi(4,5) += -z*d21 + y2;

    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y*sig0;
    si(2) += z*sig0;
    si(3) += rootAlpha*sig1;
    si(4) += rootAlpha*sig2;
    si(5) += -z*sig1 + y*sig2;
  }

  // ------------------------------------------------------------
// DEBUG: finalize two-state comparison
// ------------------------------------------------------------
  /*if (captureA)
  {
      haveA = true;
      haveATag = this->getTag();

      opserr.precision(17);
      opserr << "\n***** STORED SECTION STATE A *****" << endln;
      opserr << "section tag = " << this->getTag() << endln;
      opserr << "d1A = " << d1 << endln;
      opserr << "**********************************" << endln;
  }

  if (captureB)
  {
      opserr.precision(17);
      opserr << "\n##################################################" << endln;
      opserr << "SECTION TANGENT JUMP FIBER DIAGNOSTIC" << endln;
      opserr << "section tag = " << this->getTag() << endln;
      opserr << "d1B = " << d1 << endln;
      opserr << "haveA = " << haveA << endln;
      opserr << "haveATag = " << haveATag << endln;

      if (haveA && haveATag == this->getTag())
      {
          opserr << "sum_K11A = " << sum_K11A << endln;
          opserr << "sum_K11B = " << sum_K11B << endln;
          opserr << "sum_dK11 = " << sum_dK11 << endln;

          opserr << "\nTop fibers contributing to K11 jump:" << endln;

          for (int kk = 0; kk < 10; kk++)
          {
              if (topFiber[kk] >= 0)
              {
                  opserr << "\nrank " << kk
                      << " fiber " << topFiber[kk]
                      << " y = " << topY[kk]
                      << " z = " << topZ[kk]
                      << " A = " << topArea[kk]
                      << endln;

                  opserr << "  K11A = " << topK11A[kk]
                      << " K11B = " << topK11B[kk]
                      << " dK11 = " << topDK11[kk]
                      << endln;

                  opserr << "  C00A = " << topC00A[kk]
                      << " C00B = " << topC00B[kk]
                      << " dC00 = " << topC00B[kk] - topC00A[kk]
                      << endln;

                  opserr << "  sig0A = " << topSigA[kk]
                      << " sig0B = " << topSigB[kk]
                      << " dsig0 = " << topSigB[kk] - topSigA[kk]
                      << endln;

                  opserr << "  eps0A = " << topEpsA[kk]
                      << " eps0B = " << topEpsB[kk]
                      << " deps0 = " << topEpsB[kk] - topEpsA[kk]
                      << endln;
              }
          }
      }
      else
      {
          opserr << "WARNING: state B was reached, but state A was not stored first." << endln;
      }

      opserr << "##################################################" << endln;
  }*/

  if (alpha != 1.0) {

  }

  return res;
}

const Vector&
NDTestNonlocalFiberSection3d::getSectionDeformation(void)
{
  return e;
}

const Matrix&
NDTestNonlocalFiberSection3d::getInitialTangent(void)
{
  static double kInitial[36];
  static Matrix ki(kInitial, 6, 6);
  ki.Zero();

  static double yLocs[10000];
  static double zLocs[10000];
  static double fiberArea[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
      fiberArea[i] = matData[3*i+2];
    }
  }

  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    double y2 = y*y;
    double z2 = z*z;
    double yz = y*z;
    double tmp;

    const Matrix &tangent = theMat->getInitialTangent();

    double d00 = tangent(0,0)*A;
    double d01 = tangent(0,1)*A;
    double d02 = tangent(0,2)*A;
    double d10 = tangent(1,0)*A;
    double d11 = tangent(1,1)*A;
    double d12 = tangent(1,2)*A;
    double d20 = tangent(2,0)*A;
    double d21 = tangent(2,1)*A;
    double d22 = tangent(2,2)*A;

    // Bending terms
    ki(0,0) += d00;
    ki(1,1) += y2*d00;
    ki(2,2) += z2*d00;
    tmp = -y*d00;
    ki(0,1) += tmp;
    ki(1,0) += tmp;
    tmp = z*d00;
    ki(0,2) += tmp;
    ki(2,0) += tmp;
    tmp = -yz*d00;
    ki(1,2) += tmp;
    ki(2,1) += tmp;
    
    // Shear terms
    ki(3,3) += alpha*d11;
    ki(3,4) += alpha*d12;
    ki(4,3) += alpha*d21;
    ki(4,4) += alpha*d22;
    
    // Torsion term
    ki(5,5) += z2*d11 - yz*(d12+d21) + y2*d22;
    
    // Bending-torsion coupling terms
    tmp = -z*d01 + y*d02;
    ki(0,5) += tmp;
    ki(1,5) -= y*tmp;
    ki(2,5) += z*tmp;
    tmp = -z*d10 + y*d20;
    ki(5,0) += tmp;
    ki(5,1) -= y*tmp;
    ki(5,2) += z*tmp;
    
    // Hit tangent terms with rootAlpha
    d01 *= rootAlpha; d02 *= rootAlpha;
    d10 *= rootAlpha; d11 *= rootAlpha; d12 *= rootAlpha;
    d20 *= rootAlpha; d21 *= rootAlpha; d22 *= rootAlpha;
    
    // Bending-shear coupling terms
    ki(0,3) += d01;
    ki(0,4) += d02;
    ki(1,3) -= y*d01;
    ki(1,4) -= y*d02;
    ki(2,3) += z*d01;
    ki(2,4) += z*d02;
    ki(3,0) += d10;
    ki(4,0) += d20;
    ki(3,1) -= y*d10;
    ki(4,1) -= y*d20;
    ki(3,2) += z*d10;
    ki(4,2) += z*d20;
    
    // Torsion-shear coupling terms
    y2 =  y*d22;
    z2 = -z*d11;
    ki(5,3) +=  z2 + y*d21;
    ki(5,4) += -z*d12 + y2;
    ki(3,5) +=  z2 + y*d12;
    ki(4,5) += -z*d21 + y2;
  }

  if (alpha != 1.0) {

  }

  return ki;
}

const Matrix&
NDTestNonlocalFiberSection3d::getSectionTangent(void)
{
  return *ks;
}

const Vector&
NDTestNonlocalFiberSection3d::getStressResultant(void)
{
  return *s;
}

SectionForceDeformation*
NDTestNonlocalFiberSection3d::getCopy(void)
{
  NDTestNonlocalFiberSection3d *theCopy = new NDTestNonlocalFiberSection3d ();
  theCopy->setTag(this->getTag());

  theCopy->numFibers = numFibers;
  theCopy->sizeFibers = numFibers;

  if (numFibers != 0) {
    theCopy->theMaterials = new NDMaterial *[numFibers];

    if (theCopy->theMaterials == 0) {
      opserr <<"NDTestNonlocalFiberSection3d::getCopy -- failed to allocate Material pointers\n";
      exit(-1);
    }
  
    theCopy->matData = new double [numFibers*3];

    if (theCopy->matData == 0) {
      opserr << "NDTestNonlocalFiberSection3d::getCopy -- failed to allocate double array for material data\n";
      exit(-1);
    }
			    
    for (int i = 0; i < numFibers; i++) {
      theCopy->matData[i*3] = matData[i*3];
      theCopy->matData[i*3+1] = matData[i*3+1];
      theCopy->matData[i*3+2] = matData[i*3+2];
      theCopy->theMaterials[i] = theMaterials[i]->getCopy("BeamFiber");

      if (theCopy->theMaterials[i] == 0) {
	opserr <<"NDTestNonlocalFiberSection3d::getCopy -- failed to get copy of a Material";
	exit(-1);
      }
    }  
  }

  theCopy->e = e;
  theCopy->QzBar = QzBar;
  theCopy->QyBar = QyBar;
  theCopy->Abar = Abar;
  theCopy->yBar = yBar;
  theCopy->zBar = zBar;
  theCopy->computeCentroid = computeCentroid;
  theCopy->alpha = alpha;
  theCopy->parameterID = parameterID;

  for (int i = 0; i < 6; i++)
    theCopy->sData[i] = sData[i];

  for (int i = 0; i < 6*6; i++)
    theCopy->kData[i] = kData[i];

  if (sectionIntegr != 0)
    theCopy->sectionIntegr = sectionIntegr->getCopy();
  else
    theCopy->sectionIntegr = 0;

  //theCopy->e4Output = e4Output;

  return theCopy;
}

const ID&
NDTestNonlocalFiberSection3d::getType ()
{
  return code;
}

int
NDTestNonlocalFiberSection3d::getOrder () const
{
  return 6;
}

int
NDTestNonlocalFiberSection3d::commitState(void)
{
  int err = 0;

  for (int i = 0; i < numFibers; i++)
    err += theMaterials[i]->commitState();

  return err;
}

int
NDTestNonlocalFiberSection3d::revertToLastCommit(void)
{
  int err = 0;

  ks->Zero();
  s->Zero();
  
  static double yLocs[10000];
  static double zLocs[10000];
  static double fiberArea[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
      fiberArea[i] = matData[3*i+2];
    }
  }

  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    double y2 = y*y;
    double z2 = z*z;
    double yz = y*z;
    double tmp;

    // invoke revertToLast on the material
    err += theMat->revertToLastCommit();

    // get material stress & tangent for this strain and determine ks and fs
    const Matrix &tangent = theMat->getTangent();
    const Vector &stress = theMat->getStress();

    double d00 = tangent(0,0)*A;
    double d01 = tangent(0,1)*A;
    double d02 = tangent(0,2)*A;
    double d10 = tangent(1,0)*A;
    double d11 = tangent(1,1)*A;
    double d12 = tangent(1,2)*A;
    double d20 = tangent(2,0)*A;
    double d21 = tangent(2,1)*A;
    double d22 = tangent(2,2)*A;

    Matrix &ksi = *ks;
    Vector &si = *s;

    // Bending terms
    ksi(0,0) += d00;
    ksi(1,1) += y2*d00;
    ksi(2,2) += z2*d00;
    tmp = -y*d00;
    ksi(0,1) += tmp;
    ksi(1,0) += tmp;
    tmp = z*d00;
    ksi(0,2) += tmp;
    ksi(2,0) += tmp;
    tmp = -yz*d00;
    ksi(1,2) += tmp;
    ksi(2,1) += tmp;
    
    // Shear terms
    ksi(3,3) += alpha*d11;
    ksi(3,4) += alpha*d12;
    ksi(4,3) += alpha*d21;
    ksi(4,4) += alpha*d22;
    
    // Torsion term
    ksi(5,5) += z2*d11 - yz*(d12+d21) + y2*d22;
    
    // Bending-torsion coupling terms
    tmp = -z*d01 + y*d02;
    ksi(0,5) += tmp;
    ksi(1,5) -= y*tmp;
    ksi(2,5) += z*tmp;
    tmp = -z*d10 + y*d20;
    ksi(5,0) += tmp;
    ksi(5,1) -= y*tmp;
    ksi(5,2) += z*tmp;
    
    // Hit tangent terms with rootAlpha
    d01 *= rootAlpha; d02 *= rootAlpha;
    d10 *= rootAlpha; d11 *= rootAlpha; d12 *= rootAlpha;
    d20 *= rootAlpha; d21 *= rootAlpha; d22 *= rootAlpha;
    
    // Bending-shear coupling terms
    ksi(0,3) += d01;
    ksi(0,4) += d02;
    ksi(1,3) -= y*d01;
    ksi(1,4) -= y*d02;
    ksi(2,3) += z*d01;
    ksi(2,4) += z*d02;
    ksi(3,0) += d10;
    ksi(4,0) += d20;
    ksi(3,1) -= y*d10;
    ksi(4,1) -= y*d20;
    ksi(3,2) += z*d10;
    ksi(4,2) += z*d20;
    
    // Torsion-shear coupling terms
    y2 =  y*d22;
    z2 = -z*d11;
    ksi(5,3) +=  z2 + y*d21;
    ksi(5,4) += -z*d12 + y2;
    ksi(3,5) +=  z2 + y*d12;
    ksi(4,5) += -z*d21 + y2;

    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y*sig0;
    si(2) += z*sig0;
    si(3) += rootAlpha*sig1;
    si(4) += rootAlpha*sig2;
    si(5) += -z*sig1 + y*sig2;
  }

  if (alpha != 1.0) {

  }

  return err;
}

int
NDTestNonlocalFiberSection3d::revertToStart(void)
{
  // revert the fibers to start    
  int err = 0;

  ks->Zero();
  s->Zero();
  
  static double yLocs[10000];
  static double zLocs[10000];
  static double fiberArea[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
      fiberArea[i] = matData[3*i+2];
    }
  }

  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];

    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    double y2 = y*y;
    double z2 = z*z;
    double yz = y*z;
    double tmp;

    // invoke revertToLast on the material
    err += theMat->revertToStart();

    // get material stress & tangent for this strain and determine ks and fs
    const Matrix &tangent = theMat->getTangent();
    const Vector &stress = theMat->getStress();

    double d00 = tangent(0,0)*A;
    double d01 = tangent(0,1)*A;
    double d02 = tangent(0,2)*A;
    double d10 = tangent(1,0)*A;
    double d11 = tangent(1,1)*A;
    double d12 = tangent(1,2)*A;
    double d20 = tangent(2,0)*A;
    double d21 = tangent(2,1)*A;
    double d22 = tangent(2,2)*A;

    Matrix &ksi = *ks;
    Vector &si = *s;

    // Bending terms
    ksi(0,0) += d00;
    ksi(1,1) += y2*d00;
    ksi(2,2) += z2*d00;
    tmp = -y*d00;
    ksi(0,1) += tmp;
    ksi(1,0) += tmp;
    tmp = z*d00;
    ksi(0,2) += tmp;
    ksi(2,0) += tmp;
    tmp = -yz*d00;
    ksi(1,2) += tmp;
    ksi(2,1) += tmp;
    
    // Shear terms
    ksi(3,3) += alpha*d11;
    ksi(3,4) += alpha*d12;
    ksi(4,3) += alpha*d21;
    ksi(4,4) += alpha*d22;
    
    // Torsion term
    ksi(5,5) += z2*d11 - yz*(d12+d21) + y2*d22;
    
    // Bending-torsion coupling terms
    tmp = -z*d01 + y*d02;
    ksi(0,5) += tmp;
    ksi(1,5) -= y*tmp;
    ksi(2,5) += z*tmp;
    tmp = -z*d10 + y*d20;
    ksi(5,0) += tmp;
    ksi(5,1) -= y*tmp;
    ksi(5,2) += z*tmp;
    
    // Hit tangent terms with rootAlpha
    d01 *= rootAlpha; d02 *= rootAlpha;
    d10 *= rootAlpha; d11 *= rootAlpha; d12 *= rootAlpha;
    d20 *= rootAlpha; d21 *= rootAlpha; d22 *= rootAlpha;
    
    // Bending-shear coupling terms
    ksi(0,3) += d01;
    ksi(0,4) += d02;
    ksi(1,3) -= y*d01;
    ksi(1,4) -= y*d02;
    ksi(2,3) += z*d01;
    ksi(2,4) += z*d02;
    ksi(3,0) += d10;
    ksi(4,0) += d20;
    ksi(3,1) -= y*d10;
    ksi(4,1) -= y*d20;
    ksi(3,2) += z*d10;
    ksi(4,2) += z*d20;
    
    // Torsion-shear coupling terms
    y2 =  y*d22;
    z2 = -z*d11;
    ksi(5,3) +=  z2 + y*d21;
    ksi(5,4) += -z*d12 + y2;
    ksi(3,5) +=  z2 + y*d12;
    ksi(4,5) += -z*d21 + y2;

    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y*sig0;
    si(2) += z*sig0;
    si(3) += rootAlpha*sig1;
    si(4) += rootAlpha*sig2;
    si(5) += -z*sig1 + y*sig2;
  }

  if (alpha != 1.0) {

  }

  return err;
}

int
NDTestNonlocalFiberSection3d::sendSelf(int commitTag, Channel &theChannel)
{
  int res = 0;

  // create an id to send objects tag and numFibers, 
  //     size 3 so no conflict with matData below if just 1 fiber
  static ID data(3);
  data(0) = this->getTag();
  data(1) = numFibers;
  data(2) = computeCentroid ? 1 : 0; // Now the ID data is really 3    
  int dbTag = this->getDbTag();
  res += theChannel.sendID(dbTag, commitTag, data);
  if (res < 0) {
    opserr <<  "NDTestNonlocalFiberSection3d::sendSelf - failed to send ID data\n";
    return res;
  }    

  if (numFibers != 0) {
    
    // create an id containingg classTag and dbTag for each material & send it
    ID materialData(2*numFibers);
    for (int i=0; i<numFibers; i++) {
      NDMaterial *theMat = theMaterials[i];
      materialData(2*i) = theMat->getClassTag();
      int matDbTag = theMat->getDbTag();
      if (matDbTag == 0) {
	matDbTag = theChannel.getDbTag();
	if (matDbTag != 0)
	  theMat->setDbTag(matDbTag);
      }
      materialData(2*i+1) = matDbTag;
    }    
    
    res += theChannel.sendID(dbTag, commitTag, materialData);
    if (res < 0) {
      opserr <<  "NDTestNonlocalFiberSection3d::sendSelf - failed to send material data\n";
      return res;
    }    

    // send the fiber data, i.e. area and loc
    Vector fiberData(matData, 3*numFibers);
    res += theChannel.sendVector(dbTag, commitTag, fiberData);
    if (res < 0) {
      opserr <<  "NDTestNonlocalFiberSection3d::sendSelf - failed to send material data\n";
      return res;
    }    

    // now invoke send(0 on all the materials
    for (int j=0; j<numFibers; j++)
      theMaterials[j]->sendSelf(commitTag, theChannel);

  }

  return res;
}

int
NDTestNonlocalFiberSection3d::recvSelf(int commitTag, Channel &theChannel,
			 FEM_ObjectBroker &theBroker)
{
  int res = 0;

  static ID data(3);
  
  int dbTag = this->getDbTag();
  res += theChannel.recvID(dbTag, commitTag, data);
  if (res < 0) {
    opserr <<  "NDTestNonlocalFiberSection3d::recvSelf - failed to recv ID data\n";
    return res;
  }    
  this->setTag(data(0));

  // recv data about materials objects, classTag and dbTag
  if (data(1) != 0) {
    ID materialData(2*data(1));
    res += theChannel.recvID(dbTag, commitTag, materialData);
    if (res < 0) {
      opserr <<  "NDTestNonlocalFiberSection3d::recvSelf - failed to recv material data\n";
      return res;
    }    

    // if current arrays not of correct size, release old and resize
    if (theMaterials == 0 || numFibers != data(1)) {
      // delete old stuff if outa date
      if (theMaterials != 0) {
	for (int i=0; i<numFibers; i++)
	  delete theMaterials[i];
	delete [] theMaterials;
	if (matData != 0)
	  delete [] matData;
	matData = 0;
	theMaterials = 0;
      }

      // create memory to hold material pointers and fiber data
      numFibers = data(1);
      sizeFibers = data(1);
      if (numFibers != 0) {
	theMaterials = new NDMaterial *[numFibers];
	
	if (theMaterials == 0) {
	  opserr <<"NDTestNonlocalFiberSection3d::recvSelf -- failed to allocate Material pointers\n";
	  exit(-1);
	}
	
	for (int j=0; j<numFibers; j++)
	  theMaterials[j] = 0;

	matData = new double [numFibers*2];

	if (matData == 0) {
	  opserr <<"NDTestNonlocalFiberSection3d::recvSelf  -- failed to allocate double array for material data\n";
	  exit(-1);
	}
      }
    }

    Vector fiberData(matData, 3*numFibers);
    res += theChannel.recvVector(dbTag, commitTag, fiberData);
    if (res < 0) {
      opserr <<  "NDTestNonlocalFiberSection3d::recvSelf - failed to recv material data\n";
      return res;
    }    

    int i;
    for (i=0; i<numFibers; i++) {
      int classTag = materialData(2*i);
      int dbTag = materialData(2*i+1);

      // if material pointed to is blank or not of corrcet type, 
      // release old and create a new one
      if (theMaterials[i] == 0)
	theMaterials[i] = theBroker.getNewNDMaterial(classTag);
      else if (theMaterials[i]->getClassTag() != classTag) {
	delete theMaterials[i];
	theMaterials[i] = theBroker.getNewNDMaterial(classTag);      
      }

      if (theMaterials[i] == 0) {
	opserr <<"NDTestNonlocalFiberSection3d::recvSelf -- failed to allocate double array for material data\n";
	exit(-1);
      }

      theMaterials[i]->setDbTag(dbTag);
      res += theMaterials[i]->recvSelf(commitTag, theChannel, theBroker);
    }

    QzBar = 0.0;
    QyBar = 0.0;
    Abar  = 0.0;
    double yLoc, zLoc, Area;

    computeCentroid = data(2) ? true : false;
    
    // Recompute centroid
    for (i = 0; computeCentroid && i < numFibers; i++) {
      yLoc = matData[3*i];
      zLoc = matData[3*i+1];
      Area = matData[3*i+2];
      Abar  += Area;
      QzBar += yLoc*Area;
      QyBar += zLoc*Area;
    }

    if (computeCentroid) {
      yBar = QzBar/Abar;
      zBar = QyBar/Abar;
    } else {
      yBar = 0.0;
      zBar = 0.0;      
    }
  }    

  return res;
}

void
NDTestNonlocalFiberSection3d::Print(OPS_Stream &s, int flag)
{
  s << "\nNDTestNonlocalFiberSection3d, tag: " << this->getTag() << endln;
  s << "\tSection code: " << code;
  s << "\tNumber of Fibers: " << numFibers << endln;
  s << "\tCentroid (y,z): " << yBar << ' ' << zBar << endln;
  s << "\tShape factor, alpha = " << alpha << endln;

  if (flag == 1) {
    for (int i = 0; i < numFibers; i++) {
      s << "\nLocation (y,z) = " << matData[3*i] << ' ' << matData[3*i+1];
      s << "\nArea = " << matData[3*i+2] << endln;
      theMaterials[i]->Print(s, flag);
    }
  }
}

Response*
NDTestNonlocalFiberSection3d::setResponse(const char **argv, int argc,
			      OPS_Stream &output)
{
  Response *theResponse =0;

  if (argc > 2 && strcmp(argv[0],"fiber") == 0) {

    static double yLocs[10000];
    static double zLocs[10000];
    
    if (sectionIntegr != 0) {
      sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    }  
    else {
      for (int i = 0; i < numFibers; i++) {
	yLocs[i] = matData[3*i];
	zLocs[i] = matData[3*i+1];
      }
    }
    
    int key = numFibers;
    int passarg = 2;
    
    if (argc <= 3) {		  // fiber number was input directly
      
      key = atoi(argv[1]);
      
    } else if (argc > 4) {  // find fiber closest to coord. with mat tag
      
      int matTag = atoi(argv[3]);
      double yCoord = atof(argv[1]);
      double zCoord = atof(argv[2]);
      double closestDist = 0;
      double ySearch, zSearch, dy, dz;
      double distance;
      int j;
      // Find first fiber with specified material tag
      for (j = 0; j < numFibers; j++) {
	if (matTag == theMaterials[j]->getTag()) {
	  //ySearch = matData[3*j];
	  //zSearch = matData[3*j+1];
	  ySearch = yLocs[j];
	  zSearch = zLocs[j];	    	  
	  dy = ySearch-yCoord;
	  dz = zSearch-zCoord;
	  closestDist = dy*dy + dz*dz;
	  key = j;
	  break;
	}
      }
      // Search the remaining fibers
      for ( ; j < numFibers; j++) {
	if (matTag == theMaterials[j]->getTag()) {
	  //ySearch = matData[3*j];
	  //zSearch = matData[3*j+1];
	  ySearch = yLocs[j];
	  zSearch = zLocs[j];	    	  	  
	  dy = ySearch-yCoord;
	  dz = zSearch-zCoord;
	  distance = dy*dy + dz*dz;
	  if (distance < closestDist) {
	    closestDist = distance;
	    key = j;
	  }
	}
      }
      passarg = 4;
    }
    
    else {                  // fiber near-to coordinate specified
      
      double yCoord = atof(argv[1]);
      double zCoord = atof(argv[2]);
      double closestDist;
      double ySearch, zSearch, dy, dz;
      double distance;
      
      //ySearch = matData[0];
      //zSearch = matData[1];
      ySearch = yLocs[0];
      zSearch = zLocs[0];	    	  	        
      dy = ySearch-yCoord;
      dz = zSearch-zCoord;
      closestDist = dy*dy + dz*dz;
      key = 0;
      for (int j = 1; j < numFibers; j++) {
	//ySearch = matData[3*j];
	//zSearch = matData[3*j+1];
	ySearch = yLocs[j];
	zSearch = zLocs[j];	    	
	dy = ySearch-yCoord;
	dz = zSearch-zCoord;
	distance = dy*dy + dz*dz;
	if (distance < closestDist) {
	  closestDist = distance;
	  key = j;
	}
      }
      passarg = 3;
    }
    
    if (key < numFibers && key >= 0) {
      output.tag("FiberOutput");
      output.attr("yLoc",matData[3*key]);
      output.attr("zLoc",matData[3*key+1]);
      output.attr("area",matData[3*key+2]);
      
      theResponse = theMaterials[key]->setResponse(&argv[passarg], argc-passarg, output);
      
      output.endTag();
    }

  }

  if (theResponse == 0)
    return SectionForceDeformation::setResponse(argv, argc, output);

  return theResponse;
}


int 
NDTestNonlocalFiberSection3d::getResponse(int responseID, Information &sectInfo)
{
  // Just call the base class method ... don't need to define
  // this function, but keeping it here just for clarity
  return SectionForceDeformation::getResponse(responseID, sectInfo);
}


double 
NDTestNonlocalFiberSection3d::getSectionArea()
{
    return Abar;
}



// AddingSensitivity:BEGIN ////////////////////////////////////
int
NDTestNonlocalFiberSection3d::setParameter(const char **argv, int argc, Parameter &param)
{
  if (argc < 1)
    return -1;

  int result = -1;

  if (strstr(argv[0],"alpha") != 0)
    return param.addObject(1, this);

  // Check if the parameter belongs to the material (only option for now)
  if (strstr(argv[0],"material") != 0) {
    
    if (argc < 3)
      return 0;

    // Get the tag of the material
    int materialTag = atoi(argv[1]);
    
    // Loop over fibers to find the right material
    for (int i = 0; i < numFibers; i++)
      if (materialTag == theMaterials[i]->getTag()) {
	int ok = theMaterials[i]->setParameter(&argv[2], argc-2, param);
	if (ok != -1)
	  result = ok;
      }
    return result;
  }

  // Check if it belongs to the section integration
  else if (strstr(argv[0],"integration") != 0) {
    if (sectionIntegr != 0)
      return sectionIntegr->setParameter(&argv[1], argc-1, param);
    else
      return -1;
  }

  int ok = 0;
  
  for (int i = 0; i < numFibers; i++) {
    ok = theMaterials[i]->setParameter(argv, argc, param);
    if (ok != -1)
      result = ok;
  }

  if (sectionIntegr != 0) {
    ok = sectionIntegr->setParameter(argv, argc, param);
    if (ok != -1)
      result = ok;
  }

  return result;
}

int
NDTestNonlocalFiberSection3d::updateParameter(int paramID, Information &info)
{
  switch(paramID) {
  case 1:
    alpha = info.theDouble;
    return 0;
  default:
    return -1;
  }
}

int
NDTestNonlocalFiberSection3d::activateParameter(int paramID)
{
  parameterID = paramID;

  return 0;
}

const Vector &
NDTestNonlocalFiberSection3d::getSectionDeformationSensitivity(int gradIndex)
{
  return dedh;
}

const Vector &
NDTestNonlocalFiberSection3d::getStressResultantSensitivity(int gradIndex, bool conditional)
{
  static Vector ds(6);
  
  ds.Zero();
  
  double y, z, A;
  static Vector stress(3);
  static Vector dsigdh(3);
  static Vector sig_dAdh(3);
  static Matrix tangent(3,3);

  static double yLocs[10000];
  static double zLocs[10000];
  static double fiberArea[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
      fiberArea[i] = matData[3*i+2];
    }
  }

  static double dydh[10000];
  static double dzdh[10000];
  static double areaDeriv[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getLocationsDeriv(numFibers, dydh, dzdh);  
    sectionIntegr->getWeightsDeriv(numFibers, areaDeriv);
  }
  else {
    for (int i = 0; i < numFibers; i++) {
      dydh[i] = 0.0;
      dzdh[i] = 0.0;
      areaDeriv[i] = 0.0;
    }
  }
  
  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  double drootAlphadh = 0.0;
  if (parameterID == 1)
    drootAlphadh = 0.5/rootAlpha;

  for (int i = 0; i < numFibers; i++) {
    y = yLocs[i] - yBar;
    z = zLocs[i] - zBar;
    A = fiberArea[i];
    
    dsigdh = theMaterials[i]->getStressSensitivity(gradIndex,true);

    ds(0) += dsigdh(0)*A;
    ds(1) += -y*dsigdh(0)*A;
    ds(2) +=  z*dsigdh(0)*A;
    ds(3) += rootAlpha*dsigdh(1)*A;
    ds(4) += rootAlpha*dsigdh(2)*A;
    ds(5) += (-z*dsigdh(1)+y*dsigdh(2))*A;

    if (areaDeriv[i] != 0.0 || dydh[i] != 0.0 ||  dzdh[i] != 0.0 || parameterID == 1)
      stress = theMaterials[i]->getStress();

    if (dydh[i] != 0.0 || dzdh[i] != 0.0 || parameterID == 1)
      tangent = theMaterials[i]->getTangent();

    if (areaDeriv[i] != 0.0) {
      sig_dAdh(0) = stress(0)*areaDeriv[i];
      sig_dAdh(1) = stress(1)*areaDeriv[i];
      sig_dAdh(2) = stress(2)*areaDeriv[i];
      
      ds(0) += sig_dAdh(0);
      ds(1) += -y*sig_dAdh(0);
      ds(2) +=  z*sig_dAdh(0);
      ds(3) += rootAlpha*sig_dAdh(1);
      ds(4) += rootAlpha*sig_dAdh(2);
      ds(5) += -z*sig_dAdh(1)+y*sig_dAdh(2);
    }

    if (dydh[i] != 0.0) {
      ds(1) += -dydh[i] * (stress(0)*A);
      ds(5) +=  dydh[i] * (stress(2)*A);
    }

    if (dzdh[i] != 0.0) {
      ds(2) +=  dzdh[i] * (stress(0)*A);
      ds(5) += -dzdh[i] * (stress(1)*A);
    }

    if (parameterID == 1) {
      ds(3) += drootAlphadh * (stress(1)*A);
      ds(4) += drootAlphadh * (stress(2)*A);
    }

    static Matrix as(3,6);
    as(0,0) = 1;
    as(0,1) = -y;
    as(0,2) = z;
    as(1,3) = rootAlpha;
    as(2,4) = rootAlpha;
    as(1,5) = -z;
    as(2,5) = y;
    
    static Matrix dasdh(3,6);
    dasdh(0,1) = -dydh[i];
    dasdh(0,2) = dzdh[i];
    dasdh(1,3) = drootAlphadh;
    dasdh(2,4) = drootAlphadh;
    dasdh(1,5) = -dzdh[i];
    dasdh(2,5) = dydh[i];
    
    static Matrix tmpMatrix(6,6);
    tmpMatrix.addMatrixTripleProduct(0.0, as, tangent, dasdh, 1.0);
    
    ds.addMatrixVector(1.0, tmpMatrix, e, A);
  }

  return ds;
}

const Matrix &
NDTestNonlocalFiberSection3d::getInitialTangentSensitivity(int gradIndex)
{
  static Matrix dksdh(6,6);
  
  dksdh.Zero();
  /*
  double y, A, dydh, dAdh, tangent, dtangentdh;

  static double fiberLocs[10000];
  static double fiberArea[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getFiberLocations(numFibers, fiberLocs);
    sectionIntegr->getFiberWeights(numFibers, fiberArea);
  }  
  else {
    for (int i = 0; i < numFibers; i++) {
      fiberLocs[i] = matData[2*i];
      fiberArea[i] = matData[2*i+1];
    }
  }

  static double locsDeriv[10000];
  static double areaDeriv[10000];

  if (sectionIntegr != 0) {
    sectionIntegr->getLocationsDeriv(numFibers, locsDeriv);  
    sectionIntegr->getWeightsDeriv(numFibers, areaDeriv);
  }
  else {
    for (int i = 0; i < numFibers; i++) {
      locsDeriv[i] = 0.0;
      areaDeriv[i] = 0.0;
    }
  }
  
  for (int i = 0; i < numFibers; i++) {
    y = fiberLocs[i] - yBar;
    A = fiberArea[i];
    dydh = locsDeriv[i];
    dAdh = areaDeriv[i];
    
    tangent = theMaterials[i]->getInitialTangent();
    dtangentdh = theMaterials[i]->getInitialTangentSensitivity(gradIndex);

    dksdh(0,0) += dtangentdh*A + tangent*dAdh;

    dksdh(0,1) += -y*(dtangentdh*A+tangent*dAdh) - dydh*(tangent*A);

    dksdh(1,1) += 2*(y*dydh*tangent*A) + y*y*(dtangentdh*A+tangent*dAdh);
  }

  dksdh(1,0) = dksdh(0,1);
  */
  return dksdh;
}

int
NDTestNonlocalFiberSection3d::commitSensitivity(const Vector& defSens,
				    int gradIndex, int numGrads)
{
  double d0 = defSens(0);
  double d1 = defSens(1);
  double d2 = defSens(2);
  double d3 = defSens(3);
  double d4 = defSens(4);
  double d5 = defSens(5);

  dedh = defSens;

  static double yLocs[10000];
  static double zLocs[10000];

  if (sectionIntegr != 0)
    sectionIntegr->getFiberLocations(numFibers, yLocs, zLocs);
  else {
    for (int i = 0; i < numFibers; i++) {
      yLocs[i] = matData[3*i];
      zLocs[i] = matData[3*i+1];
    }
  }

  static double dydh[10000];
  static double dzdh[10000];

  if (sectionIntegr != 0)
    sectionIntegr->getLocationsDeriv(numFibers, dydh, dzdh);  
  else {
    for (int i = 0; i < numFibers; i++) {
      dydh[i] = 0.0;
      dzdh[i] = 0.0;
    }
  }

  double y, z;

  static Vector depsdh(3);

  double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);

  double drootAlphadh = 0.0;
  if (parameterID == 1)
    drootAlphadh = 0.5/rootAlpha;

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    y = yLocs[i] - yBar;
    z = zLocs[i] - zBar;

    // determine material strain and set it
    depsdh(0) = d0 - y*d1 + z*d2 - dydh[i]*e(1) + dzdh[i]*e(2);
    depsdh(1) = rootAlpha*d3 - z*d5 + drootAlphadh*e(3) - dzdh[i]*e(5);
    depsdh(2) = rootAlpha*d4 + y*d5 + drootAlphadh*e(4) + dydh[i]*e(5);

    theMat->commitSensitivity(depsdh,gradIndex,numGrads);
  }

  return 0;
}

// AddingSensitivity:END ///////////////////////////////////
