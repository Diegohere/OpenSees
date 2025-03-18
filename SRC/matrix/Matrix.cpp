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

// $Revision: 1.16 $
// $Date: 2009/08/25 21:57:03 $
// $Source: /usr/local/cvs/OpenSees/SRC/matrix/Matrix.cpp,v $


// Written: fmk 
// Created: 11/96
// Revision: A
//
// Description: This file contains the class implementation for Matrix.
//
// What: "@(#) Matrix.h, revA"

#include "Matrix.h"
#include "Vector.h"
#include "ID.h"

#include <stdlib.h>
#include <iostream>
using std::nothrow;

#define MATRIX_WORK_AREA 400
#define INT_WORK_AREA 20

#include <math.h>

int Matrix::sizeDoubleWork = MATRIX_WORK_AREA;
int Matrix::sizeIntWork = INT_WORK_AREA;
double Matrix::MATRIX_NOT_VALID_ENTRY = 0.0;
double* Matrix::matrixWork = 0;
int* Matrix::intWork = 0;

//double *Matrix::matrixWork = (double *)malloc(400*sizeof(double));

//
// CONSTRUCTORS
//

Matrix::Matrix()
	:numRows(0), numCols(0), dataSize(0), data(0), fromFree(0)
{
	// allocate work areas if the first
	if (matrixWork == 0) {
		matrixWork = new (nothrow) double[sizeDoubleWork];
		intWork = new (nothrow) int[sizeIntWork];
		if (matrixWork == 0 || intWork == 0) {
			opserr << "WARNING: Matrix::Matrix() - out of memory creating work area's\n";
			exit(-1);
		}
	}
}


Matrix::Matrix(int nRows, int nCols)
	:numRows(nRows), numCols(nCols), dataSize(0), data(0), fromFree(0)
{

	// allocate work areas if the first matrix
	if (matrixWork == 0) {
		matrixWork = new (nothrow) double[sizeDoubleWork];
		intWork = new (nothrow) int[sizeIntWork];
		if (matrixWork == 0 || intWork == 0) {
			opserr << "WARNING: Matrix::Matrix() - out of memory creating work area's\n";
			exit(-1);
		}
	}

#ifdef _G3DEBUG
	if (nRows < 0) {
		opserr << "WARNING: Matrix::Matrix(int,int): tried to init matrix ";
		opserr << "with num rows: " << nRows << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
	}
	if (nCols < 0) {
		opserr << "WARNING: Matrix::Matrix(int,int): tried to init matrix";
		opserr << "with num cols: " << nCols << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
	}
#endif
	dataSize = numRows * numCols;
	data = 0;

	if (dataSize > 0) {
		data = new (nothrow) double[dataSize];
		//data = (double *)malloc(dataSize*sizeof(double));
		if (data == 0) {
			opserr << "WARNING:Matrix::Matrix(int,int): Ran out of memory on init ";
			opserr << "of size " << dataSize << endln;
			numRows = 0; numCols = 0; dataSize = 0;
		}
		else {
			// zero the data
			double* dataPtr = data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ = 0.0;
		}
	}
}

Matrix::Matrix(double* theData, int row, int col)
	:numRows(row), numCols(col), dataSize(row* col), data(theData), fromFree(1)
{
	// allocate work areas if the first matrix
	if (matrixWork == 0) {
		matrixWork = new (nothrow) double[sizeDoubleWork];
		intWork = new (nothrow) int[sizeIntWork];
		if (matrixWork == 0 || intWork == 0) {
			opserr << "WARNING: Matrix::Matrix() - out of memory creating work area's\n";
			exit(-1);
		}
	}

#ifdef _G3DEBUG
	if (row < 0) {
		opserr << "WARNING: Matrix::Matrix(int,int): tried to init matrix with numRows: ";
		opserr << row << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
	}
	if (col < 0) {
		opserr << "WARNING: Matrix::Matrix(int,int): tried to init matrix with numCols: ";
		opserr << col << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
	}
#endif

	// does nothing
}

Matrix::Matrix(const Matrix& other)
	:numRows(0), numCols(0), dataSize(0), data(0), fromFree(0)
{
	// allocate work areas if the first matrix
	if (matrixWork == 0) {
		matrixWork = new (nothrow) double[sizeDoubleWork];
		intWork = new (nothrow) int[sizeIntWork];
		if (matrixWork == 0 || intWork == 0) {
			opserr << "WARNING: Matrix::Matrix() - out of memory creating work area's\n";
			exit(-1);
		}
	}

	numRows = other.numRows;
	numCols = other.numCols;
	dataSize = other.dataSize;

	if (dataSize != 0) {
		data = new (nothrow) double[dataSize];
		// data = (double *)malloc(dataSize*sizeof(double));
		if (data == 0) {
			opserr << "WARNING:Matrix::Matrix(Matrix &): ";
			opserr << "Ran out of memory on init of size " << dataSize << endln;
			numRows = 0; numCols = 0; dataSize = 0;
		}
		else {
			// copy the data
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ = *otherDataPtr++;
		}
	}
}

// Move ctor
#ifdef USE_CXX11
Matrix::Matrix(Matrix&& other)
	:numRows(other.numRows), numCols(other.numCols), dataSize(other.dataSize), data(other.data), fromFree(other.fromFree)
{
	other.numRows = 0;
	other.numCols = 0;
	other.dataSize = 0;
	other.data = 0;
	other.fromFree = 1;
}
#endif

//
// DESTRUCTOR
//

Matrix::~Matrix()
{
	if (data != 0) {
		if (fromFree == 0 && dataSize > 0) {
			delete[] data;
			data = 0;
		}
	}
	//  if (data != 0) free((void *) data);
}


//
// METHODS - Zero, Assemble, Solve
//

int
Matrix::setData(double* theData, int row, int col)
{
	// delete the old if allocated
	if (data != 0)
		if (fromFree == 0)
		{
			delete[] data;
			data = 0;
		}
	numRows = row;
	numCols = col;
	dataSize = row * col;
	data = theData;
	fromFree = 1;

#ifdef _G3DEBUG
	if (row < 0) {
		opserr << "WARNING: Matrix::setSize(): tried to init matrix with numRows: ";
		opserr << row << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
		return -1;
	}
	if (col < 0) {
		opserr << "WARNING: Matrix::setSize(): tried to init matrix with numCols: ";
		opserr << col << " <0\n";
		numRows = 0; numCols = 0; dataSize = 0; data = 0;
		return -1;
	}
#endif

	return 0;
}

void
Matrix::Zero(void)
{
	double* dataPtr = data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ = 0;
}


int
Matrix::resize(int rows, int cols) {

	int newSize = rows * cols;

	if (newSize < 0) {
		opserr << "Matrix::resize) - rows " << rows << " or cols " << cols << " specified <= 0\n";
		return -1;
	}

	else if (newSize > dataSize) {

		// free the old space
		if (data != 0)
			if (fromFree == 0) {
				delete[] data;
				data = 0;
			}
		//  if (data != 0) free((void *) data);

		fromFree = 0;
		// create new space
		data = new (nothrow) double[newSize];
		// data = (double *)malloc(dataSize*sizeof(double));
		if (data == 0) {
			opserr << "Matrix::resize(" << rows << "," << cols << ") - out of memory\n";
			numRows = 0; numCols = 0; dataSize = 0;
			return -2;
		}
		dataSize = newSize;
		numRows = rows;
		numCols = cols;
	}

	// just reset the cols and rows - save two memory calls at expense of holding 
	// onto extra memory
	else {
		numRows = rows;
		numCols = cols;
	}

	return 0;
}





int
Matrix::Assemble(const Matrix& V, const ID& rows, const ID& cols, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	for (int i = 0; i < cols.Size(); i++) {
		pos_Cols = cols(i);
		for (int j = 0; j < rows.Size(); j++) {
			pos_Rows = rows(j);

			if ((pos_Cols >= 0) && (pos_Rows >= 0) && (pos_Rows < numRows) &&
				(pos_Cols < numCols) && (i < V.numCols) && (j < V.numRows))
				(*this)(pos_Rows, pos_Cols) += V(j, i) * fact;
			else {
				opserr << "WARNING: Matrix::Assemble(const Matrix &V, const ID &l): ";
				opserr << " - position (" << pos_Rows << "," << pos_Cols << ") outside bounds \n";
				res = -1;
			}
		}
	}

	return res;
}

#ifdef _WIN32

extern "C" int  DGESV(int* N, int* NRHS, double* A, int* LDA,
	int* iPiv, double* B, int* LDB, int* INFO);

extern "C" int  DGETRF(int* M, int* N, double* A, int* LDA,
	int* iPiv, int* INFO);

extern "C" int  DGETRS(char* TRANS, unsigned int sizeT,
	int* N, int* NRHS, double* A, int* LDA,
	int* iPiv, double* B, int* LDB, int* INFO);

extern "C" int  DGETRI(int* N, double* A, int* LDA,
	int* iPiv, double* Work, int* WORKL, int* INFO);

//Added by Diego Heredia 13.06.2024
//extern "C" int dgesvd(char* JOBU, char* JOBVT, int* M, int* N, double* A,
//    int* LDA, double* S, double* U, int* LDU, double* VT,
//    int* LDVT, double* WORK, int* LWORK, int* INFO);
extern "C" void DGEEV(char* jobvl, char* jobvr, int* n, double* a,
	int* lda, double* wr, double* wi, double* vl, int* ldvl,
	double* vr, int* ldvr, double* work, int* lwork, int* info);

//#endif
#else
extern "C" int dgesv_(int* N, int* NRHS, double* A, int* LDA, int* iPiv,
	double* B, int* LDB, int* INFO);

extern "C" int dgetrs_(char* TRANS, int* N, int* NRHS, double* A, int* LDA,
	int* iPiv, double* B, int* LDB, int* INFO);

extern "C" int dgetrf_(int* M, int* N, double* A, int* LDA,
	int* iPiv, int* INFO);

extern "C" int dgetri_(int* N, double* A, int* LDA,
	int* iPiv, double* Work, int* WORKL, int* INFO);
extern "C" int dgerfs_(char* TRANS, int* N, int* NRHS, double* A, int* LDA,
	double* AF, int* LDAF, int* iPiv, double* B, int* LDB,
	double* X, int* LDX, double* FERR, double* BERR,
	double* WORK, int* IWORK, int* INFO);

// Added by Diego Heredia 13.06.2024
//extern "C" void dgesvd_(char* JOBU, char* JOBVT, int* M, int* N, double* A,
//    int* LDA, double* S, double* U, int* LDU, double* VT,
//    int* LDVT, double* WORK, int* LWORK, int* INFO);
extern "C" void dgeev_(char* jobvl, char* jobvr, int* n, double* A, int* lda,
	double* w, double* vl, int* ldvl, double* vr, int* ldvr,
	double* work, int* lwork, int* info);

#endif

int
Matrix::Solve(const Vector& b, Vector& x) const
{

	int n = numRows;

#ifdef _G3DEBUG    
	if (numRows != numCols) {
		opserr << "Matrix::Solve(b,x) - the matrix of dimensions "
			<< numRows << ", " << numCols << " is not square " << endln;
		return -1;
	}

	if (n != x.Size()) {
		opserr << "Matrix::Solve(b,x) - dimension of x, " << numRows << "is not same as matrix " << x.Size() << endln;
		return -2;
	}

	if (n != b.Size()) {
		opserr << "Matrix::Solve(b,x) - dimension of x, " << numRows << "is not same as matrix " << b.Size() << endln;
		return -2;
	}
#endif

	// check work area can hold all the data
	if (dataSize > sizeDoubleWork) {

		if (matrixWork != 0) {
			delete[] matrixWork;
			matrixWork = 0;
		}
		matrixWork = new (nothrow) double[dataSize];
		sizeDoubleWork = dataSize;

		if (matrixWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeDoubleWork = 0;
			return -3;
		}
	}

	// check work area can hold all the data
	if (n > sizeIntWork) {

		if (intWork != 0) {
			delete[] intWork;
			intWork = 0;
		}
		intWork = new (nothrow) int[n];
		sizeIntWork = n;

		if (intWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeIntWork = 0;
			return -3;
		}
	}


	// copy the data
	int i;
	for (i = 0; i < dataSize; i++)
		matrixWork[i] = data[i];

	// set x equal to b
	x = b;

	int nrhs = 1;
	int ldA = n;
	int ldB = n;
	int info;
	double* Aptr = matrixWork;
	double* Xptr = x.theData;
	int* iPIV = intWork;


#ifdef _WIN32

	DGESV(&n, &nrhs, Aptr, &ldA, iPIV, Xptr, &ldB, &info);

#else
	dgesv_(&n, &nrhs, Aptr, &ldA, iPIV, Xptr, &ldB, &info);
#endif

	return -abs(info);
}


int
Matrix::Solve(const Matrix& b, Matrix& x) const
{

	int n = numRows;
	int nrhs = x.numCols;

#ifdef _G3DEBUG    
	if (numRows != numCols) {
		opserr << "Matrix::Solve(B,X) - the matrix of dimensions [" << numRows << " " << numCols << "] is not square\n";
		return -1;
	}

	if (n != x.numRows) {
		opserr << "Matrix::Solve(B,X) - #rows of X, " << x.numRows << " is not same as the matrices: " << numRows << endln;
		return -2;
	}

	if (n != b.numRows) {
		opserr << "Matrix::Solve(B,X) - #rows of B, " << b.numRows << " is not same as the matrices: " << numRows << endln;
		return -2;
	}

	if (x.numCols != b.numCols) {
		opserr << "Matrix::Solve(B,X) - #cols of B, " << b.numCols << " , is not same as that of X, b " << x.numCols << endln;
		return -3;
	}
#endif

	// check work area can hold all the data
	if (dataSize > sizeDoubleWork) {

		if (matrixWork != 0) {
			delete[] matrixWork;
			matrixWork = 0;
		}
		matrixWork = new (nothrow) double[dataSize];
		sizeDoubleWork = dataSize;

		if (matrixWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeDoubleWork = 0;
			return -3;
		}
	}

	// check work area can hold all the data
	if (n > sizeIntWork) {

		if (intWork != 0) {
			delete[] intWork;
			intWork = 0;
		}
		intWork = new (nothrow) int[n];
		sizeIntWork = n;

		if (intWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeIntWork = 0;
			return -3;
		}
	}

	x = b;

	// copy the data
	int i;
	for (i = 0; i < dataSize; i++)
		matrixWork[i] = data[i];


	int ldA = n;
	int ldB = n;
	int info;
	double* Aptr = matrixWork;
	double* Xptr = x.data;

	int* iPIV = intWork;

	info = -1;

#ifdef _WIN32

	DGESV(&n, &nrhs, Aptr, &ldA, iPIV, Xptr, &ldB, &info);

#else
	dgesv_(&n, &nrhs, Aptr, &ldA, iPIV, Xptr, &ldB, &info);

	/*
	// further correction if required
	double Bptr[n*n];
	for (int i=0; i<n*n; i++) Bptr[i] = b.data[i];
	double *origData = data;
	double Ferr[n];
	double Berr[n];
	double newWork[3*n];
	int newIwork[n];

	dgerfs_("N",&n,&n,origData,&ldA,Aptr,&n,iPIV,Bptr,&ldB,Xptr,&ldB,
		Ferr, Berr, newWork, newIwork, &info);
	*/
#endif
	return -abs(info);
}


//// Added by Diego Heredia 13.06.2024
//int 
//Matrix::compute_SVD_decomposition(Matrix& U, Vector& S, Matrix& V)
//{
//    // Matrix sizes
//    int m = numRows;
//    int n = numCols;
//
//    // Step 1: Compute A^T * A
//    double* dataPtr_AtA = new (nothrow) double[m * m];
//    for (int i = 0; i < n; ++i) {
//        for (int j = 0; j < n; ++j) {
//            float sum = 0.0;
//            // Compute dot product of column i and column j of A
//            for (int k = 0; k < m; ++k) {
//                sum += data[k + i * m] * data[k + j * m]; // Accessing elements in column-major order
//            }
//            // Store result in column-major order
//            dataPtr_AtA[i + j * n] = sum;
//        }
//    }
//    /*std::cout << "Matrix  A^T * A:\n";
//    for (int j = 0; j < n; ++j) {
//        for (int i = 0; i < n; ++i) {
//            std::cout << dataPtr_AtA[i * n + j] << " ";
//        }
//        std::cout << "\n";
//    }*/
//
//    // Step 2: Compute eigenvalues and eigenvectors of A^T * A using LAPACKE_dgeev
//    int lda = n;
//    int ldvl = n;
//    int ldvr = n;
//    double* wr = new (nothrow) double[n];
//    double* wi = new (nothrow) double[n];
//    double* vl = new (nothrow) double[ldvl * n];
//    double* vr = V.data;
//
//    char jobvl = 'N'; // Do notCompute the left eigen vectors
//    char jobvr = 'V'; //  Compute the right eigen vectors
//    double wkopt;
//    double* work;
//    int lwork = -1;
//    int info;
//#ifdef _WIN32
//    // Query and allocate the optimal workspace
//    DGEEV(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, wr, wi, vl, &ldvl, vr, &ldvr,
//        &wkopt, &lwork, &info);
//    lwork = (int)wkopt;
//    work = new (nothrow) double[lwork];
//
//    // Solve the eigen problem
//    DGEEV(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, wr, wi, vl, &ldvl, vr, &ldvr,
//        work, &lwork, &info);
//
//    if (info != 0)
//        return -abs(info);
//#else
//    dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, wr, wi, vl, &ldvl, vr, &ldvr,
//        &wkopt, &lwork, &info);
//    lwork = (int)wkopt;
//    work = new (nothrow) double[lwork];
//
//    // Solve the eigen problem
//    dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, wr, wi, vl, &ldvl, vr, &ldvr,
//        work, & lwork, & info); 
//#endif
//    /*std::cout << "Eigenvalues of  A^T * A:\n";
//    for (int j = 0; j < n; ++j) {
//           std::cout << wr[j] << " ";
//        std::cout << "\n";
//    }*/
//    /*std::cout << "Eigenvectors of  A^T * A:\n";
//    for (int j = 0; j < n; ++j) {
//        for (int i = 0; i < n; ++i) {
//            std::cout << vr[i * n + j] << " ";
//        }
//        std::cout << "\n";
//    }*/
//
//    // Step 3: The singular values are the square roots of the eigenvalues
//    for (int i = 0; i < n; ++i) {
//        S[i] = std::sqrt(wr[i]);
//    }
//    //opserr << "This is S:" << S << endln;
//
//    // Step 4: The right singular vectors (V) are the eigenvectors of A^T * A
//    V.data = vr;
//    //opserr << "This is V:" << V << endln;
//
//    // Step 5: Compute the left singular vectors U
//    double* AmultV=new (nothrow) double[m*n];
//    for (int i = 0; i < n * m; ++i) {
//        AmultV[i] = 0.0;
//    }
//    for (int j = 0; j < n; ++j) {
//        for (int i = 0; i < m; ++i) {
//            for (int k = 0; k < n; ++k) {
//                AmultV[i + j * m] += data[i + k * m] * vr[k + j * n];
//            }
//        }
//    }
//    /*std::cout << "AV:\n";
//    for (int j = 0; j < n; ++j) {
//        for (int i = 0; i < n; ++i) {
//            std::cout << AmultV[i * n + j] << " ";
//        }
//        std::cout << "\n";
//    }*/
//    for (int i = 0; i < m; ++i) {
//        for (int j = 0; j < n; ++j) {
//            if (S[j]>0)
//            {
//                U.data[i + j * m] = AmultV[i + j * m] / S[j];
//            }
//        }
//    }
//    //opserr << "This is U:" << U << endln;
//
//    // Free dynamically alocated memory
//    delete[] dataPtr_AtA;
//    
//    delete[] wr;
//    delete[] wi;
//    delete[] vl;
//    delete[] work;
//
//    delete[] AmultV;
//
//    /*opserr << "This is U:" << U << endln;
//    opserr << "This is S:" << S << endln;
//    opserr << "This is V:" << V << endln;*/
//
//    return 1;
//}


// Added by Diego Heredia 15.06.2024
int
Matrix::compute_Eigen_decomposition(Matrix& Q, Vector& Lambda, Matrix& Qinv)
{
	// Check if matrix is square
	if (numRows != numCols) {
		opserr << "compute_Eigen_decomposition - the matrix of dimensions [" << numRows << "," << numCols << "] is not square\n";
		return -1;
	}

	// copy the data
	double* A_copy = new (nothrow) double[numCols * numCols];
	for (int i = 0; i < numCols * numCols; i++)
	{
		A_copy[i] = data[i];
	}

	// Step 1: Compute (right) eigen vectors and eigen values of A using LAPACKE_dgeev
	int lda = numCols;
	int ldvl = numCols;
	int ldvr = numCols;
	double* wi = new (nothrow) double[numCols];
	double* vl = new (nothrow) double[ldvl * numCols];

	char jobvl = 'N'; // Do notCompute the left eigen vectors
	char jobvr = 'V'; //  Compute the right eigen vectors
	double wkopt;
	double* work;
	int lwork = -1;
	int info;
#ifdef _WIN32
	// Query and allocate the optimal workspace
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		work, &lwork, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] work;
		return -abs(info);
	}
#else
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		work, &lwork, &info);
#endif

	// Step 2: Compute Qinv
	Qinv = Q; // Initialize
	int* iPIV = new (nothrow) int[numCols];

#ifdef _WIN32

	DGETRF(&numCols, &numCols, Qinv.data, &lda, iPIV, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] work;
		delete[] iPIV;
		return -abs(info);
	}

	lwork = -1;
	DGETRI(&numCols, Qinv.data, &lda, iPIV, work, &lwork, &info);

	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];
	DGETRI(&numCols, Qinv.data, &lda, iPIV, work, &lwork, &info);

#else
	dgetrf_(&numCols, &numCols, Qinv.data, &lda, iPIV, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] work;
		delete[] iPIV;
		return -abs(info);
	}

	lwork = -1;
	dgetri_(&numCols, Qinv.data, &lda, iPIV, work, &lwork, &info);

	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];
	dgetri_(&numCols, Qinv.data, &lda, iPIV, work, &lwork, &info);
#endif

	// Free dynamically alocated memory
	delete[] A_copy;
	delete[] wi;
	delete[] vl;
	delete[] work;
	delete[] iPIV;


	/*opserr << "This is Q:" << Q << endln;
	opserr << "This is Lambda:" << Lambda << endln;
	opserr << "This is Qinv:" << Qinv << endln;*/

	return 1;
}


// Added by Diego Heredia 16.06.2024
int
Matrix::solve_truncatedEigen(const Vector& b, Vector& x, const double& tol)
{
	// Check if matrix is square
	if (numRows != numCols) {
		opserr << "compute_Eigen_decomposition - the matrix of dimensions [" << numRows << "," << numCols << "] is not square\n";
		return -1;
	}

	// copy the data
	// copy the data
	double* A_copy = new (nothrow) double[numCols * numCols];
	for (int i = 0; i < numCols * numCols; i++)
	{
		A_copy[i] = data[i];
	}

	// Step 1: Compute (right) eigen vectors and eigen values of A using LAPACKE_dgeev
	int lda = numCols;
	int ldvl = numCols;
	int ldvr = numCols;
	double* wi = new (nothrow) double[numCols];
	double* vl = new (nothrow) double[ldvl * numCols];
	double* Q_data = new (nothrow) double[ldvl * numCols];
	double* Lambda_theData = new (nothrow) double[numCols];

	char jobvl = 'N'; // Do notCompute the left eigen vectors
	char jobvr = 'V'; //  Compute the right eigen vectors
	double wkopt;
	double* work1;
	int lwork = -1;
	int info;
#ifdef _WIN32
	// Query and allocate the optimal workspace
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda_theData, wi, vl, &ldvl, Q_data, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work1 = new (nothrow) double[lwork];

	// Solve the eigen problem
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda_theData, wi, vl, &ldvl, Q_data, &ldvr,
		work1, &lwork, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] work1;
		delete[] Q_data;
		delete[] Lambda_theData;
		return -abs(info);
	}
#else
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda_theData, wi, vl, &ldvl, Q_data, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work1 = new (nothrow) double[lwork];

	// Solve the eigen problem
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda_theData, wi, vl, &ldvl, Q_data, &ldvr,
		work1, &lwork, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] work1;
		delete[] Q_data;
		delete[] Lambda_theData;
		return -abs(info);
	}
#endif

	// Step 2: Compute Qinv
	double* Qinv_data = new (nothrow) double[ldvl * numCols];
	for (int i = 0; i < numCols * numCols; i++)
	{
		Qinv_data[i] = Q_data[i];
	}
	int* iPIV = new (nothrow) int[numCols];
	double* work2;

#ifdef _WIN32

	DGETRF(&numCols, &numCols, Qinv_data, &lda, iPIV, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] iPIV;
		delete[] Q_data;
		delete[] Lambda_theData;
		delete[] work1;
		return -abs(info);
	}

	lwork = -1;
	double work2_size;
	DGETRI(&numCols, Qinv_data, &lda, iPIV, &work2_size, &lwork, &info);

	lwork = (int)work2_size;
	work2 = new (nothrow) double[lwork];
	DGETRI(&numCols, Qinv_data, &lda, iPIV, work2, &lwork, &info);

#else
	dgetrf_(&numCols, &numCols, Qinv_data, &lda, iPIV, &info);

	if (info != 0)
	{
		// Free dynamically alocated memory
		delete[] A_copy;
		delete[] wi;
		delete[] vl;
		delete[] iPIV;
		delete[] Q_data;
		delete[] Lambda_theData;
		delete[] work1;
		delete[] work2;
		return -abs(info);
	}

	lwork = -1;
	double* work2_size;
	dgetri_(&numCols, Qinv_data, &lda, iPIV, work2_size, &lwork, &info);

	lwork = work2_size[0];
	work2 = new (nothrow) double[lwork];
	dgetri_(&numCols, Qinv_data, &lda, iPIV, work2, &lwork, &info);

#endif

	/*std::cout << "Q:\n";
	for (int j = 0; j < numCols; ++j) {
		for (int i = 0; i < numCols; ++i) {
			std::cout << Q_data[i * numCols + j] << " ";
		}
		std::cout << "\n";
	}
	std::cout << "Lambda:\n";
	for (int j = 0; j < numCols; ++j) {
		std::cout << Lambda_theData[j] << " ";
		std::cout << "\n";
	}
	std::cout << "Qinv:\n";
	for (int j = 0; j < numCols; ++j) {
		for (int i = 0; i < numCols; ++i) {
			std::cout << Qinv_data[i * numCols + j] << " ";
		}
		std::cout << "\n";
	}*/


	// Step 3 Compute x = Q * (Qinv * b / Lambda)
	Vector Qinv_b(numCols);
	for (int i = 0; i < numCols; ++i) {
		Qinv_b[i] = 0.0;
		for (int k = 0; k < numCols; ++k) {
			if (abs(Lambda_theData[i]) > tol) // truncate values 
			{
				Qinv_b[i] += Qinv_data[k * numCols + i] * b[k] / Lambda_theData[i];
			}
		}
	}
	//opserr << "This is Qinv_b:" << Qinv_b << endln;

	// Step 2: Compute Q * (Qinv * b / Lambda)
	for (int i = 0; i < numCols; ++i) {
		x[i] = 0.0;
		for (int j = 0; j < numCols; ++j) {
			x[i] += Q_data[j * numCols + i] * Qinv_b[j];
		}
	}

	//opserr << "This is x:" << x << endln;

	// Free dynamically alocated memory
	delete[] A_copy;

	delete[] Q_data;
	delete[] Lambda_theData;
	delete[] Qinv_data;

	delete[] wi;
	delete[] vl;
	delete[] work1;
	delete[] work2;
	delete[] iPIV;

	return 1;
}


// Added by Diego Heredia 18.02.2025
int Matrix::computePseudoInverseSymmetric(Matrix& APlus, const double tol)
{
	// Check if nan Added 18.03.2025
	for (int i = 0; i < numCols * numCols; i++)
	{
		if (isnan(data[i]))
		{
			return -1;
		}
	}

	// Check if matrix is square
	if (numRows != numCols) {
		opserr << "compute_Eigen_decomposition - the matrix of dimensions [" << numRows << "," << numCols << "] is not square\n";
		return -1;
	}

	// copy the data
	double* A_copy = new (nothrow) double[numCols * numCols];
	//opserr << "This is A.data: " << endln;
	for (int i = 0; i < numCols * numCols; i++)
	{
		//opserr <<  data[i] << endln;
		A_copy[i] = data[i];
	}

	// Step 1: Compute (right) eigen vectors and eigen values of A using LAPACKE_dgeev
	Vector Lambda(numCols);
	Matrix Q(numRows, numCols);

	int lda = numCols;
	int ldvl = numCols;
	int ldvr = numCols;
	double* wi = new (nothrow) double[numCols];
	double* vl = new (nothrow) double[ldvl * numCols];

	char jobvl = 'N'; // Do notCompute the left eigen vectors
	char jobvr = 'V'; //  Compute the right eigen vectors
	double wkopt;
	double* work;
	int lwork = -1;
	int info;
#ifdef _WIN32
	// Query and allocate the optimal workspace
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	DGEEV(&jobvl, &jobvr, &numCols, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		work, &lwork, &info);

	//// Some outputs
	//opserr << "This is Q: " << Q << endln;
	//opserr << "This is LambdaDiag: " << Lambda << endln;

	// Step 2: Compute Q*Lambda*Q^T
	// Find maximun eigenvalue
	double maxAbsEig = abs(Lambda(0));  // Initializing to the absolute value of the first eigenvalue
	for (int i = 1; i < numCols; i++) { // Loop through eigenvalues to find the max and min
		double absEig = abs(Lambda(i));
		if (absEig > maxAbsEig) {
			maxAbsEig = absEig;
		}
		}
	// Compute Q * Lambda
	Vector QMultInvLambda(numCols * numRows);
	for (int i = 0; i < numCols; ++i) {
		for (int j = 0; j < numCols; ++j) {
			//if (abs(Lambda[j]) > tol)// truncate values 
			if (abs(Lambda[j]) / maxAbsEig >= tol)// truncate values 
			{
				QMultInvLambda[i + j * numCols] = Q.data[i + j * numCols] / Lambda[j];
			}
		}
	}
	//opserr << "This is QMultInvLambda: " << QMultLambda << endln;

	// Compute Q * Lambda * Q'
	for (int i = 0; i < numCols; ++i) {
		for (int j = 0; j < numCols; ++j) {
			for (int k = 0; k < numCols; ++k) {
				APlus(i, j) += QMultInvLambda[i + k * numCols] * Q.data[j + k * numCols];
			}
		}
	}
	//opserr << "This is APlus: " << APlus << endln;

		// Free dynamically alocated memory
	delete[] A_copy;
	delete[] wi;
	delete[] vl;
	delete[] work;
	return -abs(info);
#else
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		work, &lwork, &info);

	// Step 2: Compute Q*Lambda*Q^T
	// Compute Q * Lambda
	Vector QMultInvLambda(numCols * numRows);
	for (int i = 0; i < numCols; ++i) {
		for (int j = 0; j < numCols; ++j) {
			if (abs(Lambda[j]) > tol)// truncate values 
			{
				QMultInvLambda[i + j * numCols] = Q.data[i + j * numCols] / Lambda[j];
			}
		}
	}
	//opserr << "This is QMultInvLambda: " << QMultLambda << endln;

	// Compute Q * Lambda * Q'
	for (int i = 0; i < numCols; ++i) {
		for (int j = 0; j < numCols; ++j) {
			for (int k = 0; k < numCols; ++k) {
				APlus(i, j) += QMultInvLambda[i + k * numCols] * Q.data[j + k * numCols];
			}
		}
	}
	//opserr << "This is APlus: " << APlus << endln;

		// Free dynamically alocated memory
	delete[] A_copy;
	delete[] wi;
	delete[] vl;
	delete[] work;
	return -abs(info);
#endif
}



int Matrix::checkIllCondition(double tol) const
{
	// Check if nan Added 18.03.2025
	for (int i = 0; i < numCols * numCols; i++)
	{
		if (isnan(data[i]))
		{
			return -1;
		}
	}

	// Returns 0 if matrix is not ill-conditioned 
	int isfailDGEEV = 0;

	// Check if matrix is square
	if (numRows != numCols) {
		opserr << "compute_Eigen_decomposition - the matrix of dimensions [" << numRows << "," << numCols << "] is not square\n";
		return -1;
	}

	// copy the data 
	double* A_copy = new (nothrow) double[numCols * numCols];
	//opserr << "This is A.data: " << endln;
	for (int i = 0; i < numCols * numCols; i++)
	{
		//opserr <<  data[i] << endln;
		A_copy[i] = data[i];
	}
	int numColsCopy = numCols;  // Copy the value of numCols

	// Step 1: Compute (right) eigen vectors and eigen values of A using LAPACKE_dgeev
	Vector Lambda(numCols);
	Matrix Q(numRows, numCols);

	int lda = numCols;
	int ldvl = numCols;
	int ldvr = numCols;
	double* wi = new (nothrow) double[numCols];
	double* vl = new (nothrow) double[ldvl * numCols];

	char jobvl = 'N'; // Do notCompute the left eigen vectors
	char jobvr = 'N'; //  Do notCompute the right eigen vectors
	double wkopt;
	double* work;
	int lwork = -1;
	int info;
#ifdef _WIN32
	// Query and allocate the optimal workspace
	DGEEV(&jobvl, &jobvr, &numColsCopy, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	DGEEV(&jobvl, &jobvr, &numColsCopy, A_copy, &lda, Lambda.theData, wi, vl, &ldvl, Q.data, &ldvr,
		work, &lwork, &info);

	// Free dynamically alocated memory
	delete[] A_copy;
	delete[] wi;
	delete[] vl;
	delete[] work;


	// Step 2: Check if ill conditioned
	isfailDGEEV = -abs(info);
	if (isfailDGEEV < 0) // if fail DGEEV
	{
		return -1;
	}
	else
	{
		double maxAbsEig = abs(Lambda(0));  // Initializing to the absolute value of the first eigenvalue
		double minAbsEig = abs(Lambda(0));  // Initializing to the absolute value of the first eigenvalue

		// Loop through eigenvalues to find the max and min
		for (int i = 1; i < numCols; i++) {
			double absEig = abs(Lambda(i));
			if (absEig > maxAbsEig) {
				maxAbsEig = absEig;
			}
			if (absEig < minAbsEig) {
				minAbsEig = absEig;
			}
	}

		// Check for singularity (both eigenvalues are small)
		if (minAbsEig < tol && maxAbsEig < tol) {
			return -1;
		}

		// Condition number: ratio of largest to smallest eigenvalue
		double condNum = maxAbsEig / minAbsEig;
		if (condNum > (1.0 / tol)) {  // Ill-conditioned matrix
			return -1;
		}

		// If neither condition is met, the matrix is not ill-conditioned
		return 0;
	}


#else
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		&wkopt, &lwork, &info);
	lwork = (int)wkopt;
	work = new (nothrow) double[lwork];

	// Solve the eigen problem
	dgeev_(&jobvl, &jobvr, &n, dataPtr_AtA, &lda, Lambda.theData, wi, vl, &ldvl, vr, &ldvr,
		work, &lwork, &info);

	// Free dynamically alocated memory
	delete[] A_copy;
	delete[] wi;
	delete[] vl;
	delete[] work;


	// Step 2: Check if ill conditioned
	isIllCondition = -abs(info);
	if (isIllCondition < 0) // if singular
	{
		return -1;
	}
	else
	{
		double maxAbsEig = abs(Lambda(0));  // Initializing to the absolute value of the first eigenvalue
		double minAbsEig = abs(Lambda(0));  // Initializing to the absolute value of the first eigenvalue

		// Loop through eigenvalues to find the max and min
		for (int i = 1; i < numCols; i++) {
			double absEig = abs(Lambda(i));
			if (absEig > maxAbsEig) {
				maxAbsEig = absEig;
			}
			if (absEig < minAbsEig) {
				minAbsEig = absEig;
			}
		}
		// Condition number is the ratio of the largest eigenvalue to the smallest
		double condNum = maxAbsEig / minAbsEig;

		// Check if ill-conditioned
		double oneDivCondNum = 1. / condNum;
		if (oneDivCondNum < tol) // ill conditioned
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}
#endif
}



int
Matrix::Invert(Matrix& theInverse) const
{

	int n = numRows;


#ifdef _G3DEBUG    

	if (numRows != numCols) {
		opserr << "Matrix::Solve(B,X) - the matrix of dimensions [" << numRows << "," << numCols << "] is not square\n";
		return -1;
	}

	if (n != theInverse.numRows) {
		opserr << "Matrix::Solve(B,X) - #rows of X, " << numRows << ", is not same as matrix " << theInverse.numRows << endln;
		return -2;
}
#endif

	// check work area can hold all the data
	if (dataSize > sizeDoubleWork) {

		if (matrixWork != 0) {
			delete[] matrixWork;
			matrixWork = 0;
		}
		matrixWork = new (nothrow) double[dataSize];
		sizeDoubleWork = dataSize;

		if (matrixWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeDoubleWork = 0;
			return -3;
	}
	}

	// check work area can hold all the data
	if (n > sizeIntWork) {

		if (intWork != 0) {
			delete[] intWork;
			intWork = 0;
		}
		intWork = new (nothrow) int[n];
		sizeIntWork = n;

		if (intWork == 0) {
			opserr << "WARNING: Matrix::Solve() - out of memory creating work area's\n";
			sizeIntWork = 0;
			return -3;
		}
	}

	// copy the data
	theInverse = *this;

	for (int i = 0; i < dataSize; i++)
		matrixWork[i] = data[i];

	int ldA = n;
	int info;
	double* Wptr = matrixWork;
	double* Aptr = theInverse.data;
	int workSize = sizeDoubleWork;

	int* iPIV = intWork;


#ifdef _WIN32

	DGETRF(&n, &n, Aptr, &ldA, iPIV, &info);

	if (info != 0)
		return -abs(info);

	DGETRI(&n, Aptr, &ldA, iPIV, Wptr, &workSize, &info);

#else
	dgetrf_(&n, &n, Aptr, &ldA, iPIV, &info);
	if (info != 0)
		return -abs(info);

	dgetri_(&n, Aptr, &ldA, iPIV, Wptr, &workSize, &info);

#endif

	return -abs(info);
}


int
Matrix::addMatrix(double factThis, const Matrix& other, double factOther)
{
	if (factThis == 1.0 && factOther == 0.0)
		return 0;

#ifdef _G3DEBUG
	if ((other.numRows != numRows) || (other.numCols != numCols)) {
		opserr << "Matrix::addMatrix(): incompatable matrices\n";
		return -1;
	}
#endif

	if (factThis == 1.0) {

		// want: this += other * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ += *otherDataPtr++;
		}
		else {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ += *otherDataPtr++ * factOther;
		}
	}

	else if (factThis == 0.0) {

		// want: this = other * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ = *otherDataPtr++;
		}
		else {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++)
				*dataPtr++ = *otherDataPtr++ * factOther;
		}
	}

	else {

		// want: this = this * thisFact + other * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++) {
				double value = *dataPtr * factThis + *otherDataPtr++;
				*dataPtr++ = value;
			}
		}
		else {
			double* dataPtr = data;
			double* otherDataPtr = other.data;
			for (int i = 0; i < dataSize; i++) {
				double value = *dataPtr * factThis + *otherDataPtr++ * factOther;
				*dataPtr++ = value;
			}
		}
	}

	// successfull
	return 0;
}


int
Matrix::addMatrixTranspose(double factThis, const Matrix& other, double factOther)
{
	if (factThis == 1.0 && factOther == 0.0)
		return 0;

#ifdef _G3DEBUG
	if ((other.numRows != numCols) || (other.numCols != numRows)) {
		opserr << "Matrix::addMatrixTranspose(): incompatable matrices\n";
		return -1;
	}
#endif

	if (factThis == 1.0) {

		// want: this += other^T * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++)
					*dataPtr++ += (other.data)[j + i * numCols];
	}
}
		else {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++)
					*dataPtr++ += (other.data)[j + i * numCols] * factOther;
			}
		}
	}

	else if (factThis == 0.0) {

		// want: this = other^T * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++)
					*dataPtr++ = (other.data)[j + i * numCols];
			}
		}
		else {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++)
					*dataPtr++ = (other.data)[j + i * numCols] * factOther;
			}
		}
	}

	else {

		// want: this = this * thisFact + other^T * factOther
		if (factOther == 1.0) {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++) {
					double value = *dataPtr * factThis + (other.data)[j + i * numCols];
					*dataPtr++ = value;
				}
			}
		}
		else {
			double* dataPtr = data;
			for (int j = 0; j < numCols; j++) {
				for (int i = 0; i < numRows; i++) {
					double value = *dataPtr * factThis + (other.data)[j + i * numCols] * factOther;
					*dataPtr++ = value;
				}
			}
		}
	}

	// successfull
	return 0;
}


int
Matrix::addMatrixProduct(double thisFact,
	const Matrix& B,
	const Matrix& C,
	double otherFact)
{
	if (thisFact == 1.0 && otherFact == 0.0)
		return 0;
#ifdef _G3DEBUG
	if ((B.numRows != numRows) || (C.numCols != numCols) || (B.numCols != C.numRows)) {
		opserr << "Matrix::addMatrixProduct(): incompatable matrices, this\n";
		return -1;
	}
#endif
	// NOTE: looping as per blas3 dgemm_: j,k,i
	if (thisFact == 1.0) {

		// want: this += B * C  otherFact
		int numColB = B.numCols;
		double* ckjPtr = &(C.data)[0];
		for (int j = 0; j < numCols; j++) {
			double* aijPtrA = &data[j * numRows];
			for (int k = 0; k < numColB; k++) {
				double tmp = *ckjPtr++ * otherFact;
				double* aijPtr = aijPtrA;
				double* bikPtr = &(B.data)[k * numRows];
				for (int i = 0; i < numRows; i++)
					*aijPtr++ += *bikPtr++ * tmp;
			}
		}
}

	else if (thisFact == 0.0) {

		// want: this = B * C  otherFact
		double* dataPtr = data;
		for (int i = 0; i < dataSize; i++)
			*dataPtr++ = 0.0;
		int numColB = B.numCols;
		double* ckjPtr = &(C.data)[0];
		for (int j = 0; j < numCols; j++) {
			double* aijPtrA = &data[j * numRows];
			for (int k = 0; k < numColB; k++) {
				double tmp = *ckjPtr++ * otherFact;
				double* aijPtr = aijPtrA;
				double* bikPtr = &(B.data)[k * numRows];
				for (int i = 0; i < numRows; i++)
					*aijPtr++ += *bikPtr++ * tmp;
			}
		}
	}

	else {
		// want: this = B * C  otherFact
		double* dataPtr = data;
		for (int i = 0; i < dataSize; i++)
			*dataPtr++ *= thisFact;
		int numColB = B.numCols;
		double* ckjPtr = &(C.data)[0];
		for (int j = 0; j < numCols; j++) {
			double* aijPtrA = &data[j * numRows];
			for (int k = 0; k < numColB; k++) {
				double tmp = *ckjPtr++ * otherFact;
				double* aijPtr = aijPtrA;
				double* bikPtr = &(B.data)[k * numRows];
				for (int i = 0; i < numRows; i++)
					*aijPtr++ += *bikPtr++ * tmp;
			}
		}
	}

	return 0;
}

int
Matrix::addMatrixTransposeProduct(double thisFact,
	const Matrix& B,
	const Matrix& C,
	double otherFact)
{
	if (thisFact == 1.0 && otherFact == 0.0)
		return 0;

#ifdef _G3DEBUG
	if ((B.numCols != numRows) || (C.numCols != numCols) || (B.numRows != C.numRows)) {
		opserr << "Matrix::addMatrixProduct(): incompatable matrices, this\n";
		return -1;
	}
#endif

	if (thisFact == 1.0) {
		int numMults = C.numRows;
		double* aijPtr = data;
		for (int j = 0; j < numCols; j++) {
			for (int i = 0; i < numRows; i++) {
				double* bkiPtr = &(B.data)[i * numMults];
				double* cjkPtr = &(C.data)[j * numMults];
				double sum = 0.0;
				for (int k = 0; k < numMults; k++) {
					sum += *bkiPtr++ * *cjkPtr++;
				}
				*aijPtr++ += sum * otherFact;
			}
		}
	}
	else if (thisFact == 0.0) {
		int numMults = C.numRows;
		double* aijPtr = data;
		for (int j = 0; j < numCols; j++) {
			for (int i = 0; i < numRows; i++) {
				double* bkiPtr = &(B.data)[i * numMults];
				double* cjkPtr = &(C.data)[j * numMults];
				double sum = 0.0;
				for (int k = 0; k < numMults; k++) {
					sum += *bkiPtr++ * *cjkPtr++;
				}
				*aijPtr++ = sum * otherFact;
			}
		}
	}
	else {
		int numMults = C.numRows;
		double* aijPtr = data;
		for (int j = 0; j < numCols; j++) {
			for (int i = 0; i < numRows; i++) {
				double* bkiPtr = &(B.data)[i * numMults];
				double* cjkPtr = &(C.data)[j * numMults];
				double sum = 0.0;
				for (int k = 0; k < numMults; k++) {
					sum += *bkiPtr++ * *cjkPtr++;
				}
				*aijPtr = *aijPtr * thisFact + sum * otherFact;
				aijPtr++;
			}
		}
	}

	return 0;
}


// to perform this += T' * B * T
int
Matrix::addMatrixTripleProduct(double thisFact,
	const Matrix& T,
	const Matrix& B,
	double otherFact)
{
	if (thisFact == 1.0 && otherFact == 0.0)
		return 0;
#ifdef _G3DEBUG
	if ((numCols != numRows) || (B.numCols != B.numRows) || (T.numCols != numRows) ||
		(T.numRows != B.numCols)) {
		opserr << "Matrix::addMatrixTripleProduct() - incompatable matrices\n";
		return -1;
	}
#endif

	// cheack work area can hold the temporary matrix
	int dimB = B.numCols;
	int sizeWork = dimB * numCols;

	if (sizeWork > sizeDoubleWork) {
		this->addMatrix(thisFact, T ^ B * T, otherFact);
		return 0;
	}

	// zero out the work area
	double* matrixWorkPtr = matrixWork;
	for (int l = 0; l < sizeWork; l++)
		*matrixWorkPtr++ = 0.0;

	// now form B * T * fact store in matrixWork == A area
	// NOTE: looping as per blas3 dgemm_: j,k,i

	double* tkjPtr = &(T.data)[0];
	for (int j = 0; j < numCols; j++) {
		double* aijPtrA = &matrixWork[j * dimB];
		for (int k = 0; k < dimB; k++) {
			double tmp = *tkjPtr++ * otherFact;
			double* aijPtr = aijPtrA;
			double* bikPtr = &(B.data)[k * dimB];
			for (int i = 0; i < dimB; i++)
				*aijPtr++ += *bikPtr++ * tmp;
		}
		}

	// now form T' * matrixWork
	// NOTE: looping as per blas3 dgemm_: j,i,k
	if (thisFact == 1.0) {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* ckiPtr = &(T.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *ckiPtr++ * *workkjPtr++;
				*dataPtr++ += aij;
			}
		}
	}
	else if (thisFact == 0.0) {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* ckiPtr = &(T.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *ckiPtr++ * *workkjPtr++;
				*dataPtr++ = aij;
			}
		}

	}
	else {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* ckiPtr = &(T.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *ckiPtr++ * *workkjPtr++;
				double value = *dataPtr * thisFact + aij;
				*dataPtr++ = value;
			}
		}
	}

	return 0;
	}





// to perform this += At * B * C
int
Matrix::addMatrixTripleProduct(double thisFact,
	const Matrix& A,
	const Matrix& B,
	const Matrix& C,
	double otherFact)
{
	if (thisFact == 1.0 && otherFact == 0.0)
		return 0;
#ifdef _G3DEBUG
	if ((numRows != A.numRows) || (A.numCols != B.numRows) || (B.numCols != C.numRows) ||
		(C.numCols != numCols)) {
		opserr << "Matrix::addMatrixTripleProduct() - incompatable matrices\n";
		return -1;
	}
#endif

	// cheack work area can hold the temporary matrix
	int sizeWork = B.numRows * numCols;

	if (sizeWork > sizeDoubleWork) {
		this->addMatrix(thisFact, A ^ B * C, otherFact);
		return 0;
	}

	// zero out the work area
	double* matrixWorkPtr = matrixWork;
	for (int l = 0; l < sizeWork; l++)
		*matrixWorkPtr++ = 0.0;

	// now form B * C * fact store in matrixWork == A area
	// NOTE: looping as per blas3 dgemm_: j,k,i

	int rowsB = B.numRows;
	double* ckjPtr = &(C.data)[0];
	for (int j = 0; j < numCols; j++) {
		double* aijPtrA = &matrixWork[j * rowsB];
		for (int k = 0; k < rowsB; k++) {
			double tmp = *ckjPtr++ * otherFact;
			double* aijPtr = aijPtrA;
			double* bikPtr = &(B.data)[k * rowsB];
			for (int i = 0; i < rowsB; i++)
				*aijPtr++ += *bikPtr++ * tmp;
		}
	}

	// now form A' * matrixWork
	// NOTE: looping as per blas3 dgemm_: j,i,k
	int dimB = rowsB;
	if (thisFact == 1.0) {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* akiPtr = &(A.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *akiPtr++ * *workkjPtr++;
				*dataPtr++ += aij;
			}
		}
	}
	else if (thisFact == 0.0) {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* akiPtr = &(A.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *akiPtr++ * *workkjPtr++;
				*dataPtr++ = aij;
			}
			}

		}
	else {
		double* dataPtr = &data[0];
		for (int j = 0; j < numCols; j++) {
			double* workkjPtrA = &matrixWork[j * dimB];
			for (int i = 0; i < numRows; i++) {
				double* akiPtr = &(A.data)[i * dimB];
				double* workkjPtr = workkjPtrA;
				double aij = 0.0;
				for (int k = 0; k < dimB; k++)
					aij += *akiPtr++ * *workkjPtr++;
				double value = *dataPtr * thisFact + aij;
				*dataPtr++ = value;
			}
		}
	}

	return 0;
	}



//
// OVERLOADED OPERATOR () to CONSTRUCT A NEW MATRIX
//

Matrix
Matrix::operator()(const ID& rows, const ID& cols) const
{
	int nRows, nCols;
	nRows = rows.Size();
	nCols = cols.Size();
	Matrix result(nRows, nCols);
	double* dataPtr = result.data;
	for (int i = 0; i < nCols; i++)
		for (int j = 0; j < nRows; j++)
			*dataPtr++ = (*this)(rows(j), cols(i));

	return result;
}

// Matrix &operator=(const Matrix  &V):
//      the assignment operator, This is assigned to be a copy of V. if sizes
//      are not compatable this.data [] is deleted. The data pointers will not
//      point to the same area in mem after the assignment.
//



Matrix&
Matrix::operator=(const Matrix& other)
{
	// first check we are not trying other = other
	if (this == &other)
		return *this;

	/*
	#ifdef _G3DEBUG
	  if ((numCols != other.numCols) || (numRows != other.numRows)) {
		opserr << "Matrix::operator=() - matrix dimensions do not match: [%d %d] != [%d %d]\n",
					numRows, numCols, other.numRows, other.numCols);
		return *this;
	  }
	#endif
	*/

	if ((numCols != other.numCols) || (numRows != other.numRows)) {
#ifdef _G3DEBUG    
		opserr << "Matrix::operator=() - matrix dimensions do not match\n";
#endif

		if (this->data != 0)
		{
			delete[] this->data;
			this->data = 0;
		}

		int theSize = other.numCols * other.numRows;

		data = new (nothrow) double[theSize];

		this->dataSize = theSize;
		this->numCols = other.numCols;
		this->numRows = other.numRows;
	}


	// now copy the data
	double* dataPtr = data;
	double* otherDataPtr = other.data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ = *otherDataPtr++;

	return *this;
}


// Move assignment
//
#ifdef USE_CXX11
Matrix&
Matrix::operator=(Matrix&& other)
{
	// first check we are not trying other = other
	if (this == &other)
		return *this;


	if (this->data != 0 && fromFree == 0) {
		delete[] this->data;
		this->data = 0;
	}

	this->data = other.data;
	this->dataSize = other.numCols * other.numRows;
	this->numCols = other.numCols;
	this->numRows = other.numRows;
	this->fromFree = other.fromFree;
	other.data = 0;
	other.dataSize = 0;
	other.numCols = 0;
	other.numRows = 0;
	other.fromFree = 1;

	return *this;
}
#endif


// virtual Matrix &operator+=(double fact);
// virtual Matrix &operator-=(double fact);
// virtual Matrix &operator*=(double fact);
// virtual Matrix &operator/=(double fact); 
//	The above methods all modify the current matrix. If in
//	derived matrices data kept in data and of sizeData no redef necessary.

Matrix&
Matrix::operator+=(double fact)
{
	// check if quick return
	if (fact == 0.0)
		return *this;

	double* dataPtr = data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ += fact;

	return *this;
}




Matrix&
Matrix::operator-=(double fact)
{
	// check if quick return
	if (fact == 0.0)
		return *this;

	double* dataPtr = data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ -= fact;

	return *this;
}


Matrix&
Matrix::operator*=(double fact)
{
	// check if quick return
	if (fact == 1.0)
		return *this;

	double* dataPtr = data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ *= fact;

	return *this;
}

Matrix&
Matrix::operator/=(double fact)
{
	// check if quick return
	if (fact == 1.0)
		return *this;

	if (fact != 0.0) {
		double val = 1.0 / fact;

		double* dataPtr = data;
		for (int i = 0; i < dataSize; i++)
			*dataPtr++ *= val;

		return *this;
	}
	else {
		// print out the warining message
		opserr << "WARNING:Matrix::operator/= - 0 factor specified all values in Matrix set to ";
		opserr << MATRIX_VERY_LARGE_VALUE << endln;

		double* dataPtr = data;
		for (int i = 0; i < dataSize; i++)
			*dataPtr++ = MATRIX_VERY_LARGE_VALUE;

		return *this;
	}
}


//    virtual Matrix operator+(double fact);
//    virtual Matrix operator-(double fact);
//    virtual Matrix operator*(double fact);
//    virtual Matrix operator/(double fact);
//	The above methods all return a new full general matrix.

Matrix
Matrix::operator+(double fact) const
{
	Matrix result(*this);
	result += fact;
	return result;
}

Matrix
Matrix::operator-(double fact) const
{
	Matrix result(*this);
	result -= fact;
	return result;
}

Matrix
Matrix::operator*(double fact) const
{
	Matrix result(*this);
	result *= fact;
	return result;
}

Matrix
Matrix::operator/(double fact) const
{
	if (fact == 0.0) {
		opserr << "Matrix::operator/(const double &fact): ERROR divide-by-zero\n";
		exit(0);
	}
	Matrix result(*this);
	result /= fact;
	return result;
}


//
// MATRIX_VECTOR OPERATIONS
//

Vector
Matrix::operator*(const Vector& V) const
{
	Vector result(numRows);

	if (V.Size() != numCols) {
		opserr << "Matrix::operator*(Vector): incompatable sizes\n";
		return result;
	}

	double* dataPtr = data;
	for (int i = 0; i < numCols; i++)
		for (int j = 0; j < numRows; j++)
			result(j) += *dataPtr++ * V(i);

	/*
	opserr << "HELLO: " << V;
	for (int i=0; i<numRows; i++) {
	double sum = 0.0;
	for (int j=0; j<numCols; j++) {
		sum += (*this)(i,j) * V(j);
		if (i == 9) opserr << "sum: " << sum << " " << (*this)(i,j)*V(j) << " " << V(j) <<
;
	}
	result(i) += sum;
	}
	opserr << *this;
	opserr << "HELLO result: " << result;
	*/

	return result;
}

Vector
Matrix::operator^(const Vector& V) const
{
	Vector result(numCols);

	if (V.Size() != numRows) {
		opserr << "Matrix::operator*(Vector): incompatable sizes\n";
		return result;
	}

	double* dataPtr = data;
	for (int i = 0; i < numCols; i++)
		for (int j = 0; j < numRows; j++)
			result(i) += *dataPtr++ * V(j);

	return result;
}


//
// MATRIX - MATRIX OPERATIONS
//


Matrix
Matrix::operator+(const Matrix& M) const
{
	Matrix result(*this);
	result.addMatrix(1.0, M, 1.0);
	return result;
}

Matrix
Matrix::operator-(const Matrix& M) const
{
	Matrix result(*this);
	result.addMatrix(1.0, M, -1.0);
	return result;
}


Matrix
Matrix::operator*(const Matrix& M) const
{
	Matrix result(numRows, M.numCols);

	if (numCols != M.numRows || result.numRows != numRows) {
		opserr << "Matrix::operator*(Matrix): incompatable sizes\n";
		return result;
	}

	result.addMatrixProduct(0.0, *this, M, 1.0);

	/****************************************************
	double *resDataPtr = result.data;

	int innerDim = numCols;
	int nCols = result.numCols;
	for (int i=0; i<nCols; i++) {
	  double *aStartRowDataPtr = data;
	  double *bStartColDataPtr = &(M.data[i*innerDim]);
	  for (int j=0; j<numRows; j++) {
	double *bDataPtr = bStartColDataPtr;
	double *aDataPtr = aStartRowDataPtr +j;
	double sum = 0.0;
	for (int k=0; k<innerDim; k++) {
	  sum += *aDataPtr * *bDataPtr++;
	  aDataPtr += numRows;
	}
	*resDataPtr++ = sum;
	  }
	}
	******************************************************/
	return result;
	}



// Matrix operator^(const Matrix &M) const
//	We overload the * operator to perform matrix^t-matrix multiplication.
//	reults = (*this)transposed * M.

Matrix
Matrix::operator^(const Matrix& M) const
{
	Matrix result(numCols, M.numCols);

	if (numRows != M.numRows || result.numRows != numCols) {
		opserr << "Matrix::operator*(Matrix): incompatable sizes\n";
		return result;
	}

	double* resDataPtr = result.data;

	int innerDim = numRows;
	int nCols = result.numCols;
	for (int i = 0; i < nCols; i++) {
		double* aDataPtr = data;
		double* bStartColDataPtr = &(M.data[i * innerDim]);
		for (int j = 0; j < numCols; j++) {
			double* bDataPtr = bStartColDataPtr;
			double sum = 0.0;
			for (int k = 0; k < innerDim; k++) {
				sum += *aDataPtr++ * *bDataPtr++;
			}
			*resDataPtr++ = sum;
		}
	}

	return result;
}




Matrix&
Matrix::operator+=(const Matrix& M)
{
#ifdef _G3DEBUG
	if (numRows != M.numRows || numCols != M.numCols) {
		opserr << "Matrix::operator+=(const Matrix &M) - matrices incompatable\n";
		return *this;
	}
#endif

	double* dataPtr = data;
	double* otherData = M.data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ += *otherData++;

	return *this;
}

Matrix&
Matrix::operator-=(const Matrix& M)
{
#ifdef _G3DEBUG
	if (numRows != M.numRows || numCols != M.numCols) {
		opserr << "Matrix::operator-=(const Matrix &M) - matrices incompatable [" << numRows << " ";
		opserr << numCols << "]" << "[" << M.numRows << "]" << M.numCols << "]\n";

		return *this;
	}
#endif

	double* dataPtr = data;
	double* otherData = M.data;
	for (int i = 0; i < dataSize; i++)
		*dataPtr++ -= *otherData++;

	return *this;
}


//
// Input/Output Methods
//

void
Matrix::Output(OPS_Stream& s) const
{
	for (int i = 0; i < noRows(); i++) {
		for (int j = 0; j < noCols(); j++)
			s << (*this)(i, j) << " ";
		s << endln;
	}
}


/*****************
void
Matrix::Input(istream &s)
{
	for (int i=0; i<noRows(); i++)
	for (int j=0; j<noCols(); j++)
		s >> (*this)(i,j);
}
*****************/

//
// friend stream functions for input and output
//

OPS_Stream& operator<<(OPS_Stream& s, const Matrix& V)
{
	s << endln;
	V.Output(s);
	s << endln;
	return s;
}


/****************
istream &operator>>(istream &s, Matrix &V)
{
	V.Input(s);
	return s;
}
****************/


int
Matrix::Assemble(const Matrix& V, int init_row, int init_col, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	int VnumRows = V.numRows;
	int VnumCols = V.numCols;

	int final_row = init_row + VnumRows - 1;
	int final_col = init_col + VnumCols - 1;

	if ((init_row >= 0) && (final_row < numRows) && (init_col >= 0) && (final_col < numCols))
	{
		for (int i = 0; i < VnumCols; i++)
		{
			pos_Cols = init_col + i;
			for (int j = 0; j < VnumRows; j++)
			{
				pos_Rows = init_row + j;

				(*this)(pos_Rows, pos_Cols) += V(j, i) * fact;
			}
		}
	}
	else
	{
		opserr << "WARNING: Matrix::Assemble(const Matrix &V, int init_row, int init_col, double fact): ";
		opserr << "position outside bounds \n";
		res = -1;
	}

	return res;
}


int
Matrix::Assemble(const Vector& V, int init_row, int init_col, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	int VnumRows = V.sz;
	int VnumCols = 1;

	int final_row = init_row + VnumRows - 1;
	int final_col = init_col + VnumCols - 1;

	if ((init_row >= 0) && (final_row < numRows) && (init_col >= 0) && (final_col < numCols))
	{
		for (int i = 0; i < VnumCols; i++)
		{
			pos_Cols = init_col + i;
			for (int j = 0; j < VnumRows; j++)
			{
				pos_Rows = init_row + j;

				(*this)(pos_Rows, pos_Cols) += V(j) * fact;
			}
		}
	}
	else
	{
		opserr << "WARNING: Matrix::Assemble(const Matrix &V, int init_row, int init_col, double fact): ";
		opserr << "position outside bounds \n";
		res = -1;
	}

	return res;
}


int
Matrix::AssembleTranspose(const Matrix& V, int init_row, int init_col, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	int VnumRows = V.numRows;
	int VnumCols = V.numCols;

	int final_row = init_row + VnumCols - 1;
	int final_col = init_col + VnumRows - 1;

	if ((init_row >= 0) && (final_row < numRows) && (init_col >= 0) && (final_col < numCols))
	{
		for (int i = 0; i < VnumRows; i++)
		{
			pos_Cols = init_col + i;
			for (int j = 0; j < VnumCols; j++)
			{
				pos_Rows = init_row + j;

				(*this)(pos_Rows, pos_Cols) += V(i, j) * fact;
			}
		}
	}
	else
	{
		opserr << "WARNING: Matrix::AssembleTranspose(const Matrix &V, int init_row, int init_col, double fact): ";
		opserr << "position outside bounds \n";
		res = -1;
	}

	return res;
}


int
Matrix::AssembleTranspose(const Vector& V, int init_row, int init_col, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	int VnumRows = V.sz;
	int VnumCols = 1;

	int final_row = init_row + VnumCols - 1;
	int final_col = init_col + VnumRows - 1;

	if ((init_row >= 0) && (final_row < numRows) && (init_col >= 0) && (final_col < numCols))
	{
		for (int i = 0; i < VnumRows; i++)
		{
			pos_Cols = init_col + i;
			for (int j = 0; j < VnumCols; j++)
			{
				pos_Rows = init_row + j;

				(*this)(pos_Rows, pos_Cols) += V(i) * fact;
			}
		}
	}
	else
	{
		opserr << "WARNING: Matrix::AssembleTranspose(const Matrix &V, int init_row, int init_col, double fact): ";
		opserr << "position outside bounds \n";
		res = -1;
	}

	return res;
}


int
Matrix::Extract(const Matrix& V, int init_row, int init_col, double fact)
{
	int pos_Rows, pos_Cols;
	int res = 0;

	int VnumRows = V.numRows;
	int VnumCols = V.numCols;

	int final_row = init_row + numRows - 1;
	int final_col = init_col + numCols - 1;

	if ((init_row >= 0) && (final_row < VnumRows) && (init_col >= 0) && (final_col < VnumCols))
	{
		for (int i = 0; i < numCols; i++)
		{
			pos_Cols = init_col + i;
			for (int j = 0; j < numRows; j++)
			{
				pos_Rows = init_row + j;

				(*this)(j, i) = V(pos_Rows, pos_Cols) * fact;
			}
		}
	}
	else
	{
		opserr << "WARNING: Matrix::Extract(const Matrix &V, int init_row, int init_col, double fact): ";
		opserr << "position outside bounds \n";
		res = -1;
	}

	return res;
}


Matrix operator*(double a, const Matrix& V)
{
	return V * a;
}




int
Matrix::Eigen3(const Matrix& M)
{
	//.... compute eigenvalues and vectors for a 3 x 3 symmetric matrix
	//
	//.... INPUTS:
	//        M(3,3) - matrix with initial values (only upper half used)
	//
	//.... OUTPUTS
	//        v(3,3) - matrix of eigenvectors (by column)
	//        d(3)   - eigenvalues associated with columns of v
	//        rot    - number of rotations to diagonalize
	//
	//---------------------------------------------------------------eig3==

	//.... Storage done as follows:
	//
	//       | v(1,1) v(1,2) v(1,3) |     |  d(1)  a(1)  a(3)  |
	//       | v(2,1) v(2,2) v(2,3) |  =  |  a(1)  d(2)  a(2)  |
	//       | v(3,1) v(3,2) v(3,3) |     |  a(3)  a(2)  d(3)  |
	//
	//        Transformations performed on d(i) and a(i) and v(i,j) become
	//        the eigenvectors.  
	//
	//---------------------------------------------------------------eig3==

	int     rot, its, i, j, k;
	double  g, h, aij, sm, thresh, t, c, s, tau;

	static Matrix  v(3, 3);
	static Vector  d(3);
	static Vector  a(3);
	static Vector  b(3);
	static Vector  z(3);

	static const double tol = 1.0e-08;

	// set dataPtr 
	double* dataPtr = data;

	// set v = M 
	v = M;

	//.... move array into one-d arrays
	a(0) = v(0, 1);
	a(1) = v(1, 2);
	a(2) = v(2, 0);


	for (i = 0; i < 3; i++) {
		d(i) = v(i, i);
		b(i) = v(i, i);
		z(i) = 0.0;

		for (j = 0; j < 3; j++)
			v(i, j) = 0.0;

		v(i, i) = 1.0;

	} //end for i

	rot = 0;
	its = 0;

	sm = fabs(a(0)) + fabs(a(1)) + fabs(a(2));

	while (sm > tol) {
		//.... set convergence test and threshold
		if (its < 3)
			thresh = 0.011 * sm;
		else
			thresh = 0.0;

		//.... perform sweeps for rotations
		for (i = 0; i < 3; i++) {

			j = (i + 1) % 3;
			k = (j + 1) % 3;

			aij = a(i);

			g = 100.0 * fabs(aij);

			if (fabs(d(i)) + g != fabs(d(i)) ||
				fabs(d(j)) + g != fabs(d(j))) {

				if (fabs(aij) > thresh) {

					a(i) = 0.0;
					h = d(j) - d(i);

					if (fabs(h) + g == fabs(h))
						t = aij / h;
					else {
						//t = 2.0 * sign(h/aij) / ( fabs(h/aij) + sqrt(4.0+(h*h/aij/aij)));
						double hDIVaij = h / aij;
						if (hDIVaij > 0.0)
							t = 2.0 / (hDIVaij + sqrt(4.0 + (hDIVaij * hDIVaij)));
						else
							t = -2.0 / (-hDIVaij + sqrt(4.0 + (hDIVaij * hDIVaij)));
					}

					//.... set rotation parameters

					c = 1.0 / sqrt(1.0 + t * t);
					s = t * c;
					tau = s / (1.0 + c);

					//.... rotate diagonal terms

					h = t * aij;
					z(i) = z(i) - h;
					z(j) = z(j) + h;
					d(i) = d(i) - h;
					d(j) = d(j) + h;

					//.... rotate off-diagonal terms

					h = a(j);
					g = a[k];
					a(j) = h + s * (g - h * tau);
					a(k) = g - s * (h + g * tau);

					//.... rotate eigenvectors

					for (k = 0; k < 3; k++) {
						g = v(k, i);
						h = v(k, j);
						v(k, i) = g - s * (h + g * tau);
						v(k, j) = h + s * (g - h * tau);
					} // end for k

					rot = rot + 1;

				} // end if fabs > thresh 
			} //else
			else
				a(i) = 0.0;

		}  // end for i

		//.... update the diagonal terms
		for (i = 0; i < 3; i++) {
			b(i) = b(i) + z(i);
			d(i) = b(i);
			z(i) = 0.0;
		} // end for i

		its += 1;

		sm = fabs(a(0)) + fabs(a(1)) + fabs(a(2));

	} //end while sm
	static Vector  dd(3);
	if (d(0) > d(1))
	{
		if (d(0) > d(2))
		{
			dd(0) = d(0);
			if (d(1) > d(2))
			{
				dd(1) = d(1);
				dd(2) = d(2);
			}
			else
			{
				dd(1) = d(2);
				dd(2) = d(1);
			}
		}
		else
		{
			dd(0) = d(2);
			dd(1) = d(0);
			dd(2) = d(1);
		}
	}
	else
	{
		if (d(1) > d(2))
		{
			dd(0) = d(1);
			if (d(0) > d(2))
			{
				dd(1) = d(0);
				dd(2) = d(2);
			}
			else
			{
				dd(1) = d(2);
				dd(2) = d(0);
			}
		}
		else
		{
			dd(0) = d(2);
			dd(1) = d(1);
			dd(2) = d(0);
		}
	}
	data[0] = dd(2);
	data[4] = dd(1);
	data[8] = dd(0);

	return 0;
}



Vector Matrix::diagonal() const
{

	if (numRows != numCols)
	{
		opserr << "Matrix::diagonal() - Matrix is not square numRows = " << numRows << " numCols = " << numCols << " returning truncated diagonal." << endln;
	}

	int size = numRows < numCols ? numRows : numCols;
	Vector diagonal(size);

	for (int i = 0; i < size; ++i)
	{
		diagonal(i) = data[i * numRows + i];
	}

	return diagonal;
}
