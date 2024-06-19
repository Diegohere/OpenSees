//Added by Diego Heredia 07.06.2024 for shear stress distribution

#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <Channel.h>
#include <Vector.h>
#include <Matrix.h>
#include <MatrixUtil.h>
#include <Fiber.h>
#include <classTags.h>
#include <NDShearFiberSection3d.h>
#include <ID.h>
#include <FEM_ObjectBroker.h>
#include <Information.h>
#include <MaterialResponse.h>
#include <NDMaterial.h>
#include <SectionIntegration.h>
#include <Parameter.h>
#include <elementAPI.h>

ID NDShearFiberSection3d::code(6);

void* OPS_NDShearFiberSection3d()
{
    int numData = OPS_GetNumRemainingInputArgs();
    if(numData < 1) {
	opserr<<"insufficient arguments for NDShearFiberSection3d\n";
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

    //To be modified
    MatrixContainer allCellsVertices;

    return new NDShearFiberSection3d(tag, allCellsVertices, num, computeCentroid);
}

// constructors:
NDShearFiberSection3d::NDShearFiberSection3d(int tag, MatrixContainer allCellsVert, int num,  Fiber** fibers, double a, bool compCentroid) :
    SectionForceDeformation(tag, SEC_TAG_NDShearFiberSection3d),
    allCellsVertices(allCellsVert),
    numFibers(num), sizeFibers(num), theMaterials(0), matData(0),
    Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
    sectionIntegr(0), e(6), s(0), ks(0),
    parameterID(0), dedh(6),
    Iy(0.), Iz(0.), connectivity_matrix(num, 4), coordinate_matrix(4, 2), points(2), weights(0.),
    gradPsi_sy_globalCentroid(num,2), gradPsi_sz_globalCentroid(num,2)
{
  if (numFibers != 0) {
    theMaterials = new NDMaterial *[numFibers];

    if (theMaterials == 0) {
      opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate Material pointers";
      exit(-1);
    }

    matData = new double [numFibers*3];

    if (matData == 0) {
      opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate double array for material data\n";
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
	opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to get copy of a Material\n";
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

  // Compute section properties
  computeSectionProperties();

  //Initialize the quadrilateral mesh
  determineQuadMesh();

  //Initialize the quadrature for quad fiber elements
  compute_quadrature();

  //Compute the elastic shear stress distribution functions
  compute_gradPsi_FiberCenter();

  // Test function for SVD decomposition
 /* Matrix A = Matrix(4, 4);
  A(0, 0) = 5;  A(0, 1) = 2;  A(0, 2) = 1;  A(0, 3) = 1;
  A(1, 0) = 0;  A(1, 1) = 4;  A(1, 2) = 3;  A(1, 3) = 1;
  A(2, 0) = 0;  A(2, 1) = 0;  A(2, 2) = 3;  A(2, 3) = 2;
  A(3, 0) = 0;  A(3, 1) = 0;  A(3, 2) = 0;  A(3, 3) = 1;*/
  /*Vector b = Vector(4);
  b(0) = 1; b(1) = 2; b(2) = 3; b(3) = 4;*/
  //ctor x = Vector(4);

  /*Matrix A = Matrix(6, 6);
  A(0, 0) = 6; A(0, 1) = 2; A(0, 2) = 1; A(0, 3) = 0; A(0, 4) = 0; A(0, 5) = 0;
  A(1, 0) = 2; A(1, 1) = 7; A(1, 2) = 2; A(1, 3) = 0; A(1, 4) = 0; A(1, 5) = 0;
  A(2, 0) = 1; A(2, 1) = 2; A(2, 2) = 8; A(2, 3) = 3; A(2, 4) = 0; A(2, 5) = 0;
  A(3, 0) = 0; A(3, 1) = 0; A(3, 2) = 3; A(3, 3) = 9; A(3, 4) = 4; A(3, 5) = 0;
  A(4, 0) = 0; A(4, 1) = 0; A(4, 2) = 0; A(4, 3) = 4; A(4, 4) = 10; A(4, 5) = 5;
  A(5, 0) = 0; A(5, 1) = 0; A(5, 2) = 0; A(5, 3) = 0; A(5, 4) = 5; A(5, 5) = 11;*/
  /*Matrix A = Matrix(6, 6);
  A(0, 0) = 1; A(0, 1) = 0; A(0, 2) = 0; A(0, 3) = 0; A(0, 4) = 0; A(0, 5) = 1;
  A(1, 0) = 0; A(1, 1) = 2; A(1, 2) = 0; A(1, 3) = 0; A(1, 4) = 0; A(1, 5) = 2;
  A(2, 0) = 0; A(2, 1) = 0; A(2, 2) = 3; A(2, 3) = 0; A(2, 4) = 0; A(2, 5) = 3;
  A(3, 0) = 0; A(3, 1) = 0; A(3, 2) = 0; A(3, 3) = 4; A(3, 4) = 0; A(3, 5) = 4;
  A(4, 0) = 0; A(4, 1) = 0; A(4, 2) = 0; A(4, 3) = 0; A(4, 4) = 5; A(4, 5) = 5;
  A(5, 0) = 1; A(5, 1) = 1; A(5, 2) = 1; A(5, 3) = 1; A(5, 4) = 1; A(5, 5) = 5;
  Vector b = Vector(6);
  b(0) = 1; b(1) = 2; b(2) = 3; b(3) = 4; b(4) = 5; b(5) = 6;
  Vector x = Vector(6);

  double tol = 1e-8;
  A.solve_truncatedEigen(b, x, tol);*/
  //opserr << "This is x:" << x << endln;

}

NDShearFiberSection3d::NDShearFiberSection3d(int tag, MatrixContainer allCellsVert, int num, double a, bool compCentroid) :
    SectionForceDeformation(tag, SEC_TAG_NDShearFiberSection3d),
    allCellsVertices(allCellsVert),
    numFibers(0), sizeFibers(num), theMaterials(0), matData(0),
    Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
    sectionIntegr(0), e(6), s(0), ks(0),
    parameterID(0), dedh(6),
    Iy(0.), Iz(0.), connectivity_matrix(num, 4), coordinate_matrix(4, 2), points(2), weights(0.),
    gradPsi_sy_globalCentroid(num, 2), gradPsi_sz_globalCentroid(num, 2)
{
    if (sizeFibers != 0) {
	theMaterials = new NDMaterial *[sizeFibers];

	if (theMaterials == 0) {
	    opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate Material pointers";
	    exit(-1);
	}

	matData = new double [sizeFibers*3];

	if (matData == 0) {
	    opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate double array for material data\n";
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

    // Compute section properties
    computeSectionProperties();

    //Initialize the quadrilateral mesh
    determineQuadMesh();

    //Initialize the quadrature for quad fiber elements
    compute_quadrature();

    //Compute the elastic shear stress distribution functions
    compute_gradPsi_FiberCenter();
}

NDShearFiberSection3d::NDShearFiberSection3d(int tag, MatrixContainer allCellsVert, int num, NDMaterial **mats,
				   SectionIntegration &si, double a, bool compCentroid):
  SectionForceDeformation(tag, SEC_TAG_NDShearFiberSection3d),
  allCellsVertices(allCellsVert),
  numFibers(num), sizeFibers(num), theMaterials(0), matData(0),
  Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(compCentroid),
  sectionIntegr(0), e(6), s(0), ks(0), 
  parameterID(0), dedh(6),
    Iy(0.), Iz(0.), connectivity_matrix(num, 4), coordinate_matrix(4, 2), points(2), weights(0.),
    gradPsi_sy_globalCentroid(num, 2), gradPsi_sz_globalCentroid(num, 2)
{
  if (numFibers != 0) {
    theMaterials = new NDMaterial *[numFibers];

    if (theMaterials == 0) {
      opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate Material pointers";
      exit(-1);
    }
    matData = new double [numFibers*3];

    if (matData == 0) {
      opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to allocate double array for material data\n";
      exit(-1);
    }
  }

  sectionIntegr = si.getCopy();
  if (sectionIntegr == 0) {
    opserr << "Error: NDShearFiberSection3d::NDShearFiberSection3d: could not create copy of section integration object" << endln;
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
      opserr << "NDShearFiberSection3d::NDShearFiberSection3d -- failed to get copy of a Material\n";
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

  // Compute section properties
  computeSectionProperties();

  //Initialize the quadrilateral mesh
  determineQuadMesh();

  //Initialize the quadrature for quad fiber elements
  compute_quadrature();

  //Compute the elastic shear stress distribution functions
  compute_gradPsi_FiberCenter();
}

// constructor for blank object that recvSelf needs to be invoked upon
NDShearFiberSection3d::NDShearFiberSection3d():
  SectionForceDeformation(0, SEC_TAG_NDShearFiberSection3d),
  allCellsVertices(0.),
  numFibers(0), sizeFibers(0), theMaterials(0), matData(0),
  Abar(0.0), QyBar(0.0), QzBar(0.0), yBar(0.0), zBar(0.0), computeCentroid(true),
  sectionIntegr(0), e(6), s(0), ks(0),
  parameterID(0), dedh(6),
    Iy(0.), Iz(0.), connectivity_matrix(numFibers, 4), coordinate_matrix(4, 2), points(2), weights(0.),
    gradPsi_sy_globalCentroid(numFibers, 2), gradPsi_sz_globalCentroid(numFibers, 2)
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
}

int
NDShearFiberSection3d::addFiber(Fiber &newFiber)
{
  // need to create larger arrays
  if(numFibers == sizeFibers) {
      int newSize = 2*sizeFibers;
      NDMaterial **newArray = new NDMaterial *[newSize]; 
      double *newMatData = new double [3 * newSize];
      if (newArray == 0 || newMatData == 0) {
	  opserr <<"NDShearFiberSection3d::addFiber -- failed to allocate Fiber pointers\n";
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
    opserr <<"NDShearFiberSection3d::addFiber -- failed to get copy of a Material\n";
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
NDShearFiberSection3d::~NDShearFiberSection3d()
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
//      0  0 0 (1+dPsiSYdy)       dPsiSZdy -z
//      0  0 0       dPsiSYdz (1+dPsiSZdz)  y]
int
NDShearFiberSection3d::setTrialSectionDeformation (const Vector &deforms)
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

 /* opserr << "This is coord fibers:"<< endln;
  for (int i = 0; i < numFibers; i++) {
      opserr << yLocs[i] << " and " << zLocs[i] << endln;
  }*/
  
  static Vector eps(3);

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    double y2 = y*y;
    double z2 = z*z;
    double yz = y*z;
    double tmp;

    // Get derivatives of shear warping function
    double dPsiSYdy = gradPsi_sy_globalCentroid(i, 0);
    double dPsiSYdz = gradPsi_sy_globalCentroid(i, 1);
    double dPsiSZdy = gradPsi_sz_globalCentroid(i, 0);
    double dPsiSZdz = gradPsi_sz_globalCentroid(i, 1);

    // determine material strain and set it
    eps(0) = d0 - y*d1 + z*d2;
    eps(1) = (1. + dPsiSYdy) * d3 + dPsiSZdy * d4 - z * d5;
    eps(2) = dPsiSYdz * d3 + (1. + dPsiSZdz) * d4 + y * d5;

    res += theMat->setTrialStrain(eps);
    if (res==-1)
    {
        opserr << "This fiber did not converge!" << endln;
        opserr << "This is coordY: " << y << "      This is coordZ: " << z << endln;
        //opserr << "This is coordZ: " << z << endln;
    }
    const Vector &stress = theMat->getStress();
    const Matrix &tangent = theMat->getTangent();
    
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
    ksi(3, 3) += (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1));
    ksi(4, 4) += (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(3, 4) += (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 3) += (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1));

    // Torsion term
    ksi(5, 5) += y * (d22 * y - d12 * z) - z * (d21 * y - d11 * z);
    
    // Bending-torsion coupling terms
    tmp = -z*d01 + y*d02;
    ksi(0,5) += tmp;
    ksi(1,5) -= y*tmp;
    ksi(2,5) += z*tmp;
    tmp = -z*d10 + y*d20;
    ksi(5,0) += tmp;
    ksi(5,1) -= y*tmp;
    ksi(5,2) += z*tmp;
    
    // Bending-shear coupling terms
    ksi(0, 3) += d02 * dPsiSYdz + d01 * (dPsiSYdy + 1);
    ksi(0, 4) += d01 * dPsiSZdy + d02 * (dPsiSZdz + 1);
    ksi(1, 3) += -d01 * y * (dPsiSYdy + 1) - d02 * dPsiSYdz * y;
    ksi(1, 4) += -d02 * y * (dPsiSZdz + 1) - d01 * dPsiSZdy * y;
    ksi(2, 3) += d01 * z * (dPsiSYdy + 1) + d02 * dPsiSYdz * z;
    ksi(2, 4) += d02 * z * (dPsiSZdz + 1) + d01 * dPsiSZdy * z;
    ksi(3, 0) += d20 * dPsiSYdz + d10 * (dPsiSYdy + 1);
    ksi(3, 1) += -y * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(3, 2) += z * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(4, 0) += d10 * dPsiSZdy + d20 * (dPsiSZdz + 1);
    ksi(4, 1) += -y * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));
    ksi(4, 2) += z * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));
    
    // Torsion-shear coupling terms
    ksi(3, 5) += y * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) - z * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 5) += y * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) - z * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(5, 3) += dPsiSYdz * (d22 * y - d12 * z) + (dPsiSYdy + 1) * (d21 * y - d11 * z);
    ksi(5, 4) += dPsiSZdy * (d21 * y - d11 * z) + (dPsiSZdz + 1) * (d22 * y - d12 * z);



    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y*sig0;
    si(2) += z*sig0;
    si(3) += dPsiSYdz * sig2 + sig1 * (dPsiSYdy + 1);
    si(4) += dPsiSZdy * sig1 + sig2 * (dPsiSZdz + 1);
    si(5) += -z*sig1 + y*sig2;
  }

  //opserr << "This is ks" << *ks << endln;

  return res;
}

const Vector&
NDShearFiberSection3d::getSectionDeformation(void)
{
  return e;
}

const Matrix&
NDShearFiberSection3d::getInitialTangent(void)
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

  /*double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);*/

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    // Get derivatives of shear warping function
    double dPsiSYdy = gradPsi_sy_globalCentroid(i, 0);
    double dPsiSYdz = gradPsi_sy_globalCentroid(i, 1);
    double dPsiSZdy = gradPsi_sz_globalCentroid(i, 0);
    double dPsiSZdz = gradPsi_sz_globalCentroid(i, 1);

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
    ki(0, 0) += d00;
    ki(1, 1) += y2 * d00;
    ki(2, 2) += z2 * d00;
    tmp = -y * d00;
    ki(0, 1) += tmp;
    ki(1, 0) += tmp;
    tmp = z * d00;
    ki(0, 2) += tmp;
    ki(2, 0) += tmp;
    tmp = -yz * d00;
    ki(1, 2) += tmp;
    ki(2, 1) += tmp;

    // Shear terms
    ki(3, 3) += (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1));
    ki(4, 4) += (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ki(3, 4) += (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ki(4, 3) += (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1));

    // Torsion term
    ki(5, 5) += y * (d22 * y - d12 * z) - z * (d21 * y - d11 * z);

    // Bending-torsion coupling terms
    tmp = -z * d01 + y * d02;
    ki(0, 5) += tmp;
    ki(1, 5) -= y * tmp;
    ki(2, 5) += z * tmp;
    tmp = -z * d10 + y * d20;
    ki(5, 0) += tmp;
    ki(5, 1) -= y * tmp;
    ki(5, 2) += z * tmp;

    // Bending-shear coupling terms
    ki(0, 3) += d02 * dPsiSYdz + d01 * (dPsiSYdy + 1);
    ki(0, 4) += d01 * dPsiSZdy + d02 * (dPsiSZdz + 1);
    ki(1, 3) += -d01 * y * (dPsiSYdy + 1) - d02 * dPsiSYdz * y;
    ki(1, 4) += -d02 * y * (dPsiSZdz + 1) - d01 * dPsiSZdy * y;
    ki(2, 3) += d01 * z * (dPsiSYdy + 1) + d02 * dPsiSYdz * z;
    ki(2, 4) += d02 * z * (dPsiSZdz + 1) + d01 * dPsiSZdy * z;
    ki(3, 0) += d20 * dPsiSYdz + d10 * (dPsiSYdy + 1);
    ki(3, 1) += -y * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ki(3, 2) += z * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ki(4, 0) += d10 * dPsiSZdy + d20 * (dPsiSZdz + 1);
    ki(4, 1) += -y * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));
    ki(4, 2) += z * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));

    // Torsion-shear coupling terms
    ki(3, 5) += y * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) - z * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ki(4, 5) += y * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) - z * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ki(5, 3) += dPsiSYdz * (d22 * y - d12 * z) + (dPsiSYdy + 1) * (d21 * y - d11 * z);
    ki(5, 4) += dPsiSZdy * (d21 * y - d11 * z) + (dPsiSZdz + 1) * (d22 * y - d12 * z);
  }

  return ki;
}

const Matrix&
NDShearFiberSection3d::getSectionTangent(void)
{
  return *ks;
}

const Vector&
NDShearFiberSection3d::getStressResultant(void)
{
  return *s;
}

SectionForceDeformation*
NDShearFiberSection3d::getCopy(void)
{
  NDShearFiberSection3d *theCopy = new NDShearFiberSection3d ();
  theCopy->setTag(this->getTag());

  theCopy->numFibers = numFibers;
  theCopy->sizeFibers = numFibers;

  if (numFibers != 0) {
    theCopy->theMaterials = new NDMaterial *[numFibers];

    if (theCopy->theMaterials == 0) {
      opserr <<"NDShearFiberSection3d::getCopy -- failed to allocate Material pointers\n";
      exit(-1);
    }
  
    theCopy->matData = new double [numFibers*3];

    if (theCopy->matData == 0) {
      opserr << "NDShearFiberSection3d::getCopy -- failed to allocate double array for material data\n";
      exit(-1);
    }
			    
    for (int i = 0; i < numFibers; i++) {
      theCopy->matData[i*3] = matData[i*3];
      theCopy->matData[i*3+1] = matData[i*3+1];
      theCopy->matData[i*3+2] = matData[i*3+2];
      theCopy->theMaterials[i] = theMaterials[i]->getCopy("BeamFiber");

      if (theCopy->theMaterials[i] == 0) {
	opserr <<"NDShearFiberSection3d::getCopy -- failed to get copy of a Material";
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
  //theCopy->alpha = alpha;
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

  theCopy->Iy = Iy;
  theCopy->Iz = Iz;
  theCopy->allCellsVertices = allCellsVertices;
  theCopy->connectivity_matrix = connectivity_matrix;
  theCopy->coordinate_matrix = coordinate_matrix;
  theCopy->points = points;
  theCopy->weights = weights;
  theCopy->gradPsi_sy_globalCentroid = gradPsi_sy_globalCentroid;
  theCopy->gradPsi_sz_globalCentroid = gradPsi_sz_globalCentroid;

  return theCopy;
}

const ID&
NDShearFiberSection3d::getType ()
{
  return code;
}

int
NDShearFiberSection3d::getOrder () const
{
  return 6;
}

int
NDShearFiberSection3d::commitState(void)
{
  int err = 0;

  for (int i = 0; i < numFibers; i++)
    err += theMaterials[i]->commitState();

  return err;
}

int
NDShearFiberSection3d::revertToLastCommit(void)
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

  /*double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);*/

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];
    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    // Get derivatives of shear warping function
    double dPsiSYdy = gradPsi_sy_globalCentroid(i, 0);
    double dPsiSYdz = gradPsi_sy_globalCentroid(i, 1);
    double dPsiSZdy = gradPsi_sz_globalCentroid(i, 0);
    double dPsiSZdz = gradPsi_sz_globalCentroid(i, 1);

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
    ksi(0, 0) += d00;
    ksi(1, 1) += y2 * d00;
    ksi(2, 2) += z2 * d00;
    tmp = -y * d00;
    ksi(0, 1) += tmp;
    ksi(1, 0) += tmp;
    tmp = z * d00;
    ksi(0, 2) += tmp;
    ksi(2, 0) += tmp;
    tmp = -yz * d00;
    ksi(1, 2) += tmp;
    ksi(2, 1) += tmp;

    // Shear terms
    ksi(3, 3) += (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1));
    ksi(4, 4) += (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(3, 4) += (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 3) += (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1));

    // Torsion term
    ksi(5, 5) += y * (d22 * y - d12 * z) - z * (d21 * y - d11 * z);

    // Bending-torsion coupling terms
    tmp = -z * d01 + y * d02;
    ksi(0, 5) += tmp;
    ksi(1, 5) -= y * tmp;
    ksi(2, 5) += z * tmp;
    tmp = -z * d10 + y * d20;
    ksi(5, 0) += tmp;
    ksi(5, 1) -= y * tmp;
    ksi(5, 2) += z * tmp;

    // Bending-shear coupling terms
    ksi(0, 3) += d02 * dPsiSYdz + d01 * (dPsiSYdy + 1);
    ksi(0, 4) += d01 * dPsiSZdy + d02 * (dPsiSZdz + 1);
    ksi(1, 3) += -d01 * y * (dPsiSYdy + 1) - d02 * dPsiSYdz * y;
    ksi(1, 4) += -d02 * y * (dPsiSZdz + 1) - d01 * dPsiSZdy * y;
    ksi(2, 3) += d01 * z * (dPsiSYdy + 1) + d02 * dPsiSYdz * z;
    ksi(2, 4) += d02 * z * (dPsiSZdz + 1) + d01 * dPsiSZdy * z;
    ksi(3, 0) += d20 * dPsiSYdz + d10 * (dPsiSYdy + 1);
    ksi(3, 1) += -y * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(3, 2) += z * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(4, 0) += d10 * dPsiSZdy + d20 * (dPsiSZdz + 1);
    ksi(4, 1) += -y * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));
    ksi(4, 2) += z * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));

    // Torsion-shear coupling terms
    ksi(3, 5) += y * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) - z * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 5) += y * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) - z * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(5, 3) += dPsiSYdz * (d22 * y - d12 * z) + (dPsiSYdy + 1) * (d21 * y - d11 * z);
    ksi(5, 4) += dPsiSZdy * (d21 * y - d11 * z) + (dPsiSZdz + 1) * (d22 * y - d12 * z);

    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y * sig0;
    si(2) += z * sig0;
    si(3) += dPsiSYdz * sig2 + sig1 * (dPsiSYdy + 1);
    si(4) += dPsiSZdy * sig1 + sig2 * (dPsiSZdz + 1);
    si(5) += -z * sig1 + y * sig2; 
  }

  /*if (alpha != 1.0) {

  }*/

  return err;
}

int
NDShearFiberSection3d::revertToStart(void)
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

  /*double rootAlpha = 1.0;
  if (alpha != 1.0)
    rootAlpha = sqrt(alpha);*/

  for (int i = 0; i < numFibers; i++) {
    NDMaterial *theMat = theMaterials[i];

    double y = yLocs[i] - yBar;
    double z = zLocs[i] - zBar;
    double A = fiberArea[i];

    // Get derivatives of shear warping function
    double dPsiSYdy = gradPsi_sy_globalCentroid(i, 0);
    double dPsiSYdz = gradPsi_sy_globalCentroid(i, 1);
    double dPsiSZdy = gradPsi_sz_globalCentroid(i, 0);
    double dPsiSZdz = gradPsi_sz_globalCentroid(i, 1);

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
    ksi(0, 0) += d00;
    ksi(1, 1) += y2 * d00;
    ksi(2, 2) += z2 * d00;
    tmp = -y * d00;
    ksi(0, 1) += tmp;
    ksi(1, 0) += tmp;
    tmp = z * d00;
    ksi(0, 2) += tmp;
    ksi(2, 0) += tmp;
    tmp = -yz * d00;
    ksi(1, 2) += tmp;
    ksi(2, 1) += tmp;

    // Shear terms
    ksi(3, 3) += (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1));
    ksi(4, 4) += (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(3, 4) += (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) * (dPsiSZdz + 1) + dPsiSZdy * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 3) += (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1)) * (dPsiSYdy + 1) + dPsiSYdz * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1));

    // Torsion term
    ksi(5, 5) += y * (d22 * y - d12 * z) - z * (d21 * y - d11 * z);

    // Bending-torsion coupling terms
    tmp = -z * d01 + y * d02;
    ksi(0, 5) += tmp;
    ksi(1, 5) -= y * tmp;
    ksi(2, 5) += z * tmp;
    tmp = -z * d10 + y * d20;
    ksi(5, 0) += tmp;
    ksi(5, 1) -= y * tmp;
    ksi(5, 2) += z * tmp;

    // Bending-shear coupling terms
    ksi(0, 3) += d02 * dPsiSYdz + d01 * (dPsiSYdy + 1);
    ksi(0, 4) += d01 * dPsiSZdy + d02 * (dPsiSZdz + 1);
    ksi(1, 3) += -d01 * y * (dPsiSYdy + 1) - d02 * dPsiSYdz * y;
    ksi(1, 4) += -d02 * y * (dPsiSZdz + 1) - d01 * dPsiSZdy * y;
    ksi(2, 3) += d01 * z * (dPsiSYdy + 1) + d02 * dPsiSYdz * z;
    ksi(2, 4) += d02 * z * (dPsiSZdz + 1) + d01 * dPsiSZdy * z;
    ksi(3, 0) += d20 * dPsiSYdz + d10 * (dPsiSYdy + 1);
    ksi(3, 1) += -y * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(3, 2) += z * (d20 * dPsiSYdz + d10 * (dPsiSYdy + 1));
    ksi(4, 0) += d10 * dPsiSZdy + d20 * (dPsiSZdz + 1);
    ksi(4, 1) += -y * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));
    ksi(4, 2) += z * (d10 * dPsiSZdy + d20 * (dPsiSZdz + 1));

    // Torsion-shear coupling terms
    ksi(3, 5) += y * (d22 * dPsiSYdz + d12 * (dPsiSYdy + 1)) - z * (d21 * dPsiSYdz + d11 * (dPsiSYdy + 1));
    ksi(4, 5) += y * (d12 * dPsiSZdy + d22 * (dPsiSZdz + 1)) - z * (d11 * dPsiSZdy + d21 * (dPsiSZdz + 1));
    ksi(5, 3) += dPsiSYdz * (d22 * y - d12 * z) + (dPsiSYdy + 1) * (d21 * y - d11 * z);
    ksi(5, 4) += dPsiSZdy * (d21 * y - d11 * z) + (dPsiSZdz + 1) * (d22 * y - d12 * z);



    double sig0 = stress(0)*A;
    double sig1 = stress(1)*A;
    double sig2 = stress(2)*A;

    si(0) += sig0;
    si(1) += -y * sig0;
    si(2) += z * sig0;
    si(3) += dPsiSYdz * sig2 + sig1 * (dPsiSYdy + 1);
    si(4) += dPsiSZdy * sig1 + sig2 * (dPsiSZdz + 1);
    si(5) += -z * sig1 + y * sig2;
  }

  /*if (alpha != 1.0) {

  }*/

  return err;
}

int
NDShearFiberSection3d::sendSelf(int commitTag, Channel &theChannel)
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
    opserr <<  "NDShearFiberSection3d::sendSelf - failed to send ID data\n";
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
      opserr <<  "NDShearFiberSection3d::sendSelf - failed to send material data\n";
      return res;
    }    

    // send the fiber data, i.e. area and loc
    Vector fiberData(matData, 3*numFibers);
    res += theChannel.sendVector(dbTag, commitTag, fiberData);
    if (res < 0) {
      opserr <<  "NDShearFiberSection3d::sendSelf - failed to send material data\n";
      return res;
    }    

    // now invoke send(0 on all the materials
    for (int j=0; j<numFibers; j++)
      theMaterials[j]->sendSelf(commitTag, theChannel);

  }

  return res;
}

int
NDShearFiberSection3d::recvSelf(int commitTag, Channel &theChannel,
			 FEM_ObjectBroker &theBroker)
{
  int res = 0;

  static ID data(3);
  
  int dbTag = this->getDbTag();
  res += theChannel.recvID(dbTag, commitTag, data);
  if (res < 0) {
    opserr <<  "NDShearFiberSection3d::recvSelf - failed to recv ID data\n";
    return res;
  }    
  this->setTag(data(0));

  // recv data about materials objects, classTag and dbTag
  if (data(1) != 0) {
    ID materialData(2*data(1));
    res += theChannel.recvID(dbTag, commitTag, materialData);
    if (res < 0) {
      opserr <<  "NDShearFiberSection3d::recvSelf - failed to recv material data\n";
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
	  opserr <<"NDShearFiberSection3d::recvSelf -- failed to allocate Material pointers\n";
	  exit(-1);
	}
	
	for (int j=0; j<numFibers; j++)
	  theMaterials[j] = 0;

	matData = new double [numFibers*2];

	if (matData == 0) {
	  opserr <<"NDShearFiberSection3d::recvSelf  -- failed to allocate double array for material data\n";
	  exit(-1);
	}
      }
    }

    Vector fiberData(matData, 3*numFibers);
    res += theChannel.recvVector(dbTag, commitTag, fiberData);
    if (res < 0) {
      opserr <<  "NDShearFiberSection3d::recvSelf - failed to recv material data\n";
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
	opserr <<"NDShearFiberSection3d::recvSelf -- failed to allocate double array for material data\n";
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
NDShearFiberSection3d::Print(OPS_Stream &s, int flag)
{
  s << "\nNDShearFiberSection3d, tag: " << this->getTag() << endln;
  s << "\tSection code: " << code;
  s << "\tNumber of Fibers: " << numFibers << endln;
  s << "\tCentroid (y,z): " << yBar << ' ' << zBar << endln;
  /*s << "\tShape factor, alpha = " << alpha << endln;*/

  if (flag == 1) {
    for (int i = 0; i < numFibers; i++) {
      s << "\nLocation (y,z) = " << matData[3*i] << ' ' << matData[3*i+1];
      s << "\nArea = " << matData[3*i+2] << endln;
      theMaterials[i]->Print(s, flag);
    }
  }
}

Response*
NDShearFiberSection3d::setResponse(const char **argv, int argc,
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
  // Return the connectivity matrix
  else if (strcmp(argv[0], "connectivity") == 0)
    {
    theResponse = new MaterialResponse(this, 1, Matrix(numFibers,4));
    }

    // Return the coordinate matrix
  else if (strcmp(argv[0], "coordinate") == 0)
    {
    theResponse = new MaterialResponse(this, 2, Matrix(coordinate_matrix.noRows(), 2));
    }

    // Return a matrix with all stresses results for all fibers
  else if (strcmp(argv[0], "allFiberStresses") == 0)
    {
    theResponse = new MaterialResponse(this, 3, Matrix(numFibers, 3));
    }

  if (theResponse == 0)
    return SectionForceDeformation::setResponse(argv, argc, output);

  return theResponse;
}


int 
NDShearFiberSection3d::getResponse(int responseID, Information &sectInfo)
{
    switch (responseID)
    {
    case 1: // Return the connectivity matrix
        return sectInfo.setMatrix(connectivity_matrix);

    case 2:// Return the coordinate matrix
        return sectInfo.setMatrix(coordinate_matrix);

    case 3: // Return a matrix with all stresses results for all fibers
    {
        Matrix allFiberStresses = Matrix(numFibers, 3);
        for (size_t iFib = 0; iFib < numFibers; iFib++)
        {
            NDMaterial* theMat = theMaterials[iFib];
            const Vector& stress_iFib = theMat->getStress();
            for (size_t i = 0; i < 3; i++)
            {
                allFiberStresses(iFib, i) = stress_iFib(i);
            }
        }
        return sectInfo.setMatrix(allFiberStresses);
    }

    default:
        return SectionForceDeformation::getResponse(responseID, sectInfo);

    }

  // Just call the base class method ... don't need to define
  // this function, but keeping it here just for clarity
  //return SectionForceDeformation::getResponse(responseID, sectInfo);
}


double 
NDShearFiberSection3d::getSectionArea()
{
    return Abar;
}


void
NDShearFiberSection3d::computeSectionProperties()
{
    Iz = 0.;
    Iy = 0.;
    double y = 0.;
    double z = 0.;
    double A = 0.;
    for (int i = 0; i < numFibers; i++) {
        y = matData[i * 3] - yBar;
        z = matData[i * 3 + 1] - zBar;
        A = matData[i * 3 + 2];

        Iz += pow(y, 2.) * A;
        Iy += pow(z, 2.) * A;

        //opserr << "This is coordY: " << y << "      This is coordZ: " << z << endln;
    }

    /*opserr << "This is coord fibers:" << endln;
    for (int i = 0; i < numFibers; i++) {
        opserr << matData[i * 3] - yBar << " and " << matData[i * 3 + 1] - zBar << endln;
    }

    opserr << "This is area fibers:" << endln;
    for (int i = 0; i < numFibers; i++) {
        opserr << matData[i * 3 + 2] << endln;
    }*/

}


void
NDShearFiberSection3d::determineQuadMesh()
{
    std::vector<std::array<double, 2>> uniqueNodes;

    // Iterate over each element in MatrixContainer
    for (const auto& element : allCellsVertices) {
        // Add nodes to the connectivity_matrix matrix
        for (size_t i = 0; i < 4; ++i) {
            double y = std::round(element(i, 0) / 1e-6) * 1e-6;
            double z = std::round(element(i, 1) / 1e-6) * 1e-6;
            std::array<double, 2> node = { y, z };

            auto it = std::find(uniqueNodes.begin(), uniqueNodes.end(), node);
            if (it == uniqueNodes.end()) {
                // New node, add to uniqueNodes
                uniqueNodes.push_back(node);
            }
        }
    }
    /*for (size_t i = 0; i < uniqueNodes.size(); i++)
    {
        opserr << "This is uniqueNodes:" << uniqueNodes[i][0] << " and " << uniqueNodes[i][1] << endln;
    }*/
    
    // Initialize the coordinate_matrix matrix
    coordinate_matrix.resize(uniqueNodes.size(), 2);
    for (size_t i = 0; i < uniqueNodes.size(); ++i) {
        coordinate_matrix(i, 0) = uniqueNodes[i][0];
        coordinate_matrix(i, 1) = uniqueNodes[i][1];
    }
   //opserr << "This is coordinate_matrix:" << coordinate_matrix  << endln;

    for (size_t elemIndex = 0; elemIndex < allCellsVertices.size(); ++elemIndex) {
        const auto& element = allCellsVertices[elemIndex];
        for (size_t i = 0; i < 4; ++i) {
            double y = std::round(element(i, 0) / 1e-6) * 1e-6;
            double z = std::round(element(i, 1) / 1e-6) * 1e-6;
            std::array<double, 2> node = { y, z };

            auto it = std::find(uniqueNodes.begin(), uniqueNodes.end(), node);
            int nodeIndex = std::distance(uniqueNodes.begin(), it);
            connectivity_matrix(elemIndex, i) = nodeIndex+1; //+1 so that starts at 1
        }
    }
    connectivity_matrix = sort_nodes_in_element(coordinate_matrix, connectivity_matrix);

   //opserr << "This is connectivity_matrix:" << connectivity_matrix << endln;
    
}

// Function to sort nodes in each element based on angles around centroid
Matrix 
NDShearFiberSection3d::sort_nodes_in_element(Matrix coordinate_matrix, Matrix connectivity_matrix) {

    Matrix sorted_connectivity_matrix=Matrix(connectivity_matrix.noRows(),connectivity_matrix.noCols());

    std::array<int, 4> element_nodes;

    // Iterate over each element in connectivity_matrix
    for (int i = 0; i < connectivity_matrix.noRows(); ++i) {
        for (int j = 0; j < 4; j++)
        {
            element_nodes[j] = connectivity_matrix(i, j);
        }

        // Compute centroid of element
        std::array<double, 2> centroid = { 0.0, 0.0 };
        for (int j = 0; j < element_nodes.size(); ++j) {
            centroid[0] += coordinate_matrix(element_nodes[j] - 1, 0);
            centroid[1] += coordinate_matrix(element_nodes[j] - 1, 1);
        }
        centroid[0] /= element_nodes.size();
        centroid[1] /= element_nodes.size();

        // Compute angles relative to centroid
        std::vector<double> centroid_angles;
        for (int j = 0; j < element_nodes.size(); ++j) {
            double angle = std::atan2(coordinate_matrix(element_nodes[j] - 1, 0) - centroid[0],
                coordinate_matrix(element_nodes[j] - 1, 1) - centroid[1]);
            if (angle < 0) angle += 2 * 3.1416;
            centroid_angles.push_back(angle);
        }

        // Sort indices based on angles in counterclockwise order
        std::vector<int> sorted_indices(element_nodes.size());
        std::iota(sorted_indices.begin(), sorted_indices.end(), 0);
        std::sort(sorted_indices.begin(), sorted_indices.end(), [&centroid_angles](int a, int b) {
            double angle_a = centroid_angles[a];
            double angle_b = centroid_angles[b];
            // Compare angles to sort in counterclockwise order
            return angle_a < angle_b;
            });

        // Reorder element nodes based on sorted indices
        std::array<int, 4> sorted_element_nodes;
        for (int j = 0; j < element_nodes.size(); ++j) {
            sorted_element_nodes[j] = element_nodes[sorted_indices[j]];
        }

        // Add sorted element nodes to sorted_connectivity
        for (int j = 0; j < 4; j++)
        {
            sorted_connectivity_matrix(i, j) = sorted_element_nodes[j];
        }
    }
    //opserr << "This is connectivity_matrix:" << sorted_connectivity_matrix << endln;

    return sorted_connectivity_matrix;
}


void
NDShearFiberSection3d::compute_quadrature()
{
    points.Zero(); // for 1 Gauss point which is at the element centroid
    weights = 4.;
}


void
NDShearFiberSection3d::compute_gradPsi_FiberCenter()
{
    int num_nodes = coordinate_matrix.noRows();
    Vector Phi_sy_globalNodal = Vector(num_nodes);
    Vector Phi_sz_globalNodal = Vector(num_nodes);

    // Step 1: Compute shear warping function Phi
    compute_Phi_globalNodal(Phi_sy_globalNodal, Phi_sz_globalNodal);

    // Step 2: Compute gradPhi
    Matrix gradPhi_sy_globalCentroid = Matrix(numFibers, 2);
    Matrix gradPhi_sz_globalCentroid = Matrix(numFibers, 2);
    //Matrix gradf_theory_globalCentroid = Matrix(numFibers, 2);

    for (int e = 0; e < numFibers; ++e) {
        Matrix coordinate_element = Matrix(4, 2);
        for (int i = 0; i < 4; i++)
        {
            coordinate_element(i, 0) = coordinate_matrix(connectivity_matrix(e, i) - 1, 0);  //   - 1 for c++ indexing
            coordinate_element(i, 1) = coordinate_matrix(connectivity_matrix(e, i) - 1, 1);  //   - 1 for c++ indexing
        }
        //opserr << "This is coordinate_element:" << coordinate_element << endln;

        // Compute shape functions for Q4 element
        Vector N = Vector(4);
        Matrix B = Matrix(2, 4);
        double Jdet = 0.;
        compute_NBandJdetQ4(N, B, Jdet, coordinate_element);
        //opserr << "This is B:" << B << endln;

        // Compute derivatives of Phi_sy and Phi_sz at fiber centroid
        Vector Phi_sy_elemE = Vector(4);
        Vector Phi_sz_elemE = Vector(4);
        for (int i = 0; i < 4; i++)
        {
            Phi_sy_elemE(i) = Phi_sy_globalNodal(connectivity_matrix(e, i) - 1);//   - 1 for c++ indexing
            Phi_sz_elemE(i) = Phi_sz_globalNodal(connectivity_matrix(e, i) - 1);//   - 1 for c++ indexing
        }
        //opserr << "This is Phi_sy_elemE:" << Phi_sy_elemE << endln;
        Vector B_mult_Phi_sy_elemE = B * Phi_sy_elemE;
        //opserr << "This is B_mult_Phi_sy_elemE:" << B_mult_Phi_sy_elemE << endln;
        gradPhi_sy_globalCentroid(e, 0) = B_mult_Phi_sy_elemE(0);
        gradPhi_sy_globalCentroid(e, 1) = B_mult_Phi_sy_elemE(1);
        Vector B_mult_Phi_sz_elemE = B * Phi_sz_elemE;
        gradPhi_sz_globalCentroid(e, 0) = B_mult_Phi_sz_elemE(0);
        gradPhi_sz_globalCentroid(e, 1) = B_mult_Phi_sz_elemE(1);

       // // Verification with analytical solution
       // Vector f_theory_globalNodal = Vector(num_nodes);
       //double y = matData[e * 3];
       //double z = matData[e * 3+1];
       //gradf_theory_globalCentroid(e,0) = -1*3.1416/300.*sin(3.1416 / 300. * (y + 300. / 2.));
       //gradf_theory_globalCentroid(e, 1) = -1 * 3.1416 / 300. * sin(3.1416 / 300. * (z + 300. / 2.));
    }
    //opserr << "gradPhi_sy_globalCentroid:  " << gradPhi_sy_globalCentroid << endln;
    //opserr << "gradPhi_sz_globalCentroid:  " << gradPhi_sz_globalCentroid << endln;
    // Verification with analytical solution
    /*Matrix testDiff = (gradf_theory_globalCentroid - gradPhi_sy_globalCentroid);
    opserr << "This is testDiff:" << testDiff << endln;*/

    // Step 3: Compute integral dTilda
    double dTilda_sy = 0.;
    double dTilda_sz = 0.;
    for (int e = 0; e < numFibers; ++e) 
    {
        double A = matData[3 * e + 2];
        dTilda_sy += A * (pow(gradPhi_sy_globalCentroid(e, 0), 2) + pow(gradPhi_sy_globalCentroid(e, 1), 2));
        dTilda_sz += A * (pow(gradPhi_sz_globalCentroid(e, 0), 2) + pow(gradPhi_sz_globalCentroid(e, 1), 2));
    }

    // Step 4: Compute derivatives of shear function Psi
    gradPsi_sy_globalCentroid = -Iz / dTilda_sy * gradPhi_sy_globalCentroid;
    gradPsi_sz_globalCentroid = -Iy / dTilda_sz * gradPhi_sz_globalCentroid;
    for (int e = 0; e < numFibers; e++)
    {
        gradPsi_sy_globalCentroid(e, 0) -= 1.;
        gradPsi_sz_globalCentroid(e, 1) -= 1.;
    }
    //opserr << "This is connectivity_matrix:" << connectivity_matrix << endln;
    //opserr << "This is coordinate_matrix:" << coordinate_matrix << endln;

    //opserr << "gradPsi_sy_globalCentroid:  " << gradPsi_sy_globalCentroid << endln;
    //opserr << "gradPsi_sz_globalCentroid:  " << gradPsi_sz_globalCentroid << endln;

}


void
NDShearFiberSection3d::compute_Phi_globalNodal(Vector& Phi_sy_globalNodal, Vector& Phi_sz_globalNodal)
{
    int num_nodes = coordinate_matrix.noRows();
    Matrix K_global = Matrix(num_nodes, num_nodes);
    Vector f_sy_global = Vector(num_nodes);
    Vector f_sz_global = Vector(num_nodes);

    assemble_global_quantities(K_global, f_sy_global, f_sz_global);

    // Solve for shear function \Psi for all nodes
    double tol = 1e-8;
    K_global.solve_truncatedEigen(f_sy_global, Phi_sy_globalNodal, tol);
    K_global.solve_truncatedEigen(f_sz_global, Phi_sz_globalNodal, tol);
    //opserr << "This is Phi_sy_globalNodal:" << Phi_sy_globalNodal << endln;

    //// Verification with analytical solution
    //Vector f_theory_globalNodal = Vector(num_nodes);
    //for (int i = 0; i < num_nodes; i++)
    //{
    //    double y = coordinate_matrix(i, 0);
    //    double z = coordinate_matrix(i, 1);
    //    f_theory_globalNodal(i) = cos(3.1416 / 300. * (z + 300. / 2.)) + cos(3.1416 / 300. * (y + 300. / 2.));
    //}
   //opserr << "This is f_theory_globalNodal:" << f_theory_globalNodal << endln;
    /*Vector testDiff = Phi_sy_globalNodal - f_theory_globalNodal;
    double testDiffNorm = testDiff.Norm()/f_theory_globalNodal.Norm()*100.;*/
    //opserr << "This is testDiff:" << testDiff<< endln;

}


void
NDShearFiberSection3d::assemble_global_quantities(Matrix& K_global, Vector& f_sy_global, Vector& f_sz_global)
{
    for (int e= 0; e < numFibers; e++)
    {
        //Retrieve degrees of freedom of element e
        Vector dof = Vector(4);
        for (int i = 0; i < 4; i++)
        {
            dof(i) = connectivity_matrix(e, i) - 1;  //   - 1 for c++ indexing
        }
        //opserr << "This is connectivity_matrix:   " << connectivity_matrix << endln;
        //opserr << "This is coordinate_matrix:   " << coordinate_matrix << endln;

        //Retrieve nodes of element e
        Vector connectivity_element = dof + 1;
        Matrix coordinate_element = Matrix(4, 2);
        for (int i = 0; i < 4; i++)
        {
            coordinate_element(i,0) = coordinate_matrix(connectivity_element(i)-1, 0);  //   - 1 for c++ indexing
            coordinate_element(i, 1) = coordinate_matrix(connectivity_element(i) - 1, 1);  //   - 1 for c++ indexing
        }
        //opserr << "This is coordinate_element:" << coordinate_element << endln;

        //Calculate local stiffness matrix and force vector of element e
        Matrix K_element = Matrix(4, 4);
        Vector f_sy_element = Vector(4);
        Vector f_sz_element = Vector(4);
        compute_element_quantities(coordinate_element, connectivity_element, K_element, f_sy_element, f_sz_element);

        // Assemble
        for (int i = 0; i < 4; i++)
        {
            f_sy_global(dof(i)) += f_sy_element(i);
            f_sz_global(dof(i)) += f_sz_element(i);

            for (int j = 0; j < 4; j++)
            {
                K_global(dof(i), dof(j)) += K_element(i, j);
            }
        } 
    } // end loop to go over all elements
    //opserr << "This is K_global" << K_global << endln;
    //opserr << "This is f_sy_global" << f_sy_global << endln;
}


void
NDShearFiberSection3d::compute_element_quantities(Matrix coordinate_element, Vector connectivity_element, Matrix& K_element, Vector& f_sy_element, Vector& f_sz_element)
{
    // No need for loop Integrate numerically using Gauss quadrature because use 1 Gauss quadrature point
    Vector N = Vector(4);
    Matrix B = Matrix(2, 4);
    double Jdet = 0.;
    compute_NBandJdetQ4(N,B,Jdet, coordinate_element);

    // Compute element stiffness matrix
    Matrix BtB = Matrix(4, 4);
    BtB.addMatrixTransposeProduct(1.0, B, B, 1.0);
    /*opserr << "This is B" << B << endln;
    opserr << "This is BtB:" << BtB << endln;*/
    K_element = weights * BtB * Jdet;
    //opserr << "This is K_element" << K_element << endln;

    // Compute element force vector
    Vector yCoords_elements = Vector(4);
    Vector zCoords_elements = Vector(4);
    for (int i = 0; i < 4; i++)
    {
        yCoords_elements(i) = coordinate_element(i, 0);
        zCoords_elements(i) = coordinate_element(i, 1);
    }
    /*double test = N ^ yCoords_elements;
    opserr << "This is N" << N << endln;
    opserr << "This is yCoords_elements:" << yCoords_elements << endln;
    opserr << "This is N ^ yCoords_elements:" << test << endln;*/

//Test for known solution
    //double y = 0.;
    //double z = 0.;
    //for (int i = 0; i < 4; i++)
    //{
    //    y += coordinate_element(i, 0)/4.;
    //    z += coordinate_element(i, 1) / 4.;
    //}
    //f_sy_element = -1 * weights * -1 * (pow(3.1416, 2) / pow(300, 2)) * (cos(3.1416 / 300. * (z + 300. / 2.)) + cos(3.1416 / 300. * (y + 300. / 2.))) * N * Jdet;  //Here - sign because of formulation of weak form
    //f_sz_element = f_sy_element;
    //opserr << "This is f_sy_element" << f_sy_element << endln;

    // Element load vector for shear warping function
    f_sy_element = -weights * (N ^ yCoords_elements) * N * Jdet;
    f_sz_element = -weights * (N ^ zCoords_elements) * N * Jdet;
}


void
NDShearFiberSection3d::compute_NBandJdetQ4(Vector& N, Matrix& B, double& Jdet, Matrix coordinate_element)
{
    // Gauss integration point
    double xi = points(0);
    double eta = points(1);

    // Isoparametric element shape function
    N(0) = 0.25 * (1 + eta) * (1 + xi);
    N(1) = 0.25 * (1 - eta) * (1 + xi);
    N(2) = 0.25 * (1 - eta) * (1 - xi);
    N(3) = 0.25 * (1 + eta) * (1 - xi);

    //Derivatives of isoparametric element
    Matrix DN = Matrix(2, 4);
    DN(0, 0) = 0.25 * (1 + eta);
    DN(0, 1) = 0.25 * (1 - eta);
    DN(0, 2) = -0.25 * (1 - eta);
    DN(0, 3) = -0.25 * (1 + eta);
    DN(1, 0) = 0.25 * (1 + xi);
    DN(1, 1) = -0.25 * (1 + xi);
    DN(1, 2) = -0.25 * (1 - xi);
    DN(1, 3) = 0.25 * (1 - xi);

    // Jacobian matrix
    Matrix J = Matrix(2, 2);
    J = DN * coordinate_element;
    //opserr << "This is Jacobian matrix:" << J << endln;

    //Compute matrix B and Jacobian determinant
    Matrix Jinv = Matrix(2, 2);
    matinv2(J, Jinv, Jdet);
    B = Jinv * DN;
    
}




void
NDShearFiberSection3d::matinv2( Matrix& A, Matrix& Ainv, double& detA)
{
    // Calculate the determinant
    detA = A(0, 0) * A(1, 1) - A(0, 1) * A(1, 0);

    // Calculate the inverse
    Ainv(0, 0) = +1. / detA * A(1, 1);
    Ainv(1, 0) = -1. / detA * A(1, 0);
    Ainv(0, 1) = -1. / detA * A(0, 1);
    Ainv(1, 1) = +1. / detA * A(0, 0);
}



// AddingSensitivity:BEGIN ////////////////////////////////////
int
NDShearFiberSection3d::setParameter(const char **argv, int argc, Parameter &param)
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
NDShearFiberSection3d::updateParameter(int paramID, Information &info)
{
  switch(paramID) {
  case 1:
    //alpha = info.theDouble;
    return 0;
  default:
    return -1;
  }
}

int
NDShearFiberSection3d::activateParameter(int paramID)
{
  parameterID = paramID;

  return 0;
}

const Vector &
NDShearFiberSection3d::getSectionDeformationSensitivity(int gradIndex)
{
  return dedh;
}

const Vector &
NDShearFiberSection3d::getStressResultantSensitivity(int gradIndex, bool conditional)
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
  
  double alpha = 1.0; // Added by DH

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
NDShearFiberSection3d::getInitialTangentSensitivity(int gradIndex)
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
NDShearFiberSection3d::commitSensitivity(const Vector& defSens,
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

  double alpha = 1.0; // Added by DH

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
