//Added by Diego Heredia, RESSLab EPFL

#include <NewtonCotesBeamIntegrationUpdated.h>
#include <elementAPI.h>
#include <ID.h>

void* OPS_NewtonCotesBeamIntegrationUpdated(int& integrationTag, ID& secTags)
{
    if (OPS_GetNumRemainingInputArgs() < 3) {
        opserr << "insufficient arguments:integrationTag,secTag,N\n";
        return 0;
    }

    // inputs: integrationTag,secTag,N
    int iData[3];
    int numData = 3;
    if (OPS_GetIntInput(&numData, &iData[0]) < 0) return 0;

    integrationTag = iData[0];
    if (iData[2] > 0) {
        secTags.resize(iData[2]);
    }
    else {
        secTags = ID();
    }
    for (int i = 0; i < secTags.Size(); i++) {
        secTags(i) = iData[1];
    }

    return new NewtonCotesBeamIntegrationUpdated;
}

//constructor
NewtonCotesBeamIntegrationUpdated::NewtonCotesBeamIntegrationUpdated() :
    BeamIntegration(BEAM_INTEGRATION_TAG_NewtonCotes)
{
    // Nothing to do
}

//destructor
NewtonCotesBeamIntegrationUpdated::~NewtonCotesBeamIntegrationUpdated()
{
    // Nothing to do
}

BeamIntegration*
NewtonCotesBeamIntegrationUpdated::getCopy(void)
{
    return new NewtonCotesBeamIntegrationUpdated();
}

void
NewtonCotesBeamIntegrationUpdated::getSectionLocations(int numSections, double L,
    double* xi)
{
    //integrate between 0 and 1
    double a = 0;
    double b = 1;

    for (int i = 0; i < numSections; i++)
    {
        xi[i] = a + (double)i / ((double)numSections - 1) * (b - a);
    }
}

void
NewtonCotesBeamIntegrationUpdated::getSectionWeights(int numSections, double L,
    double* wt)
{
    //get integration location
    double* x;
    x = new double[numSections];
    //integrate between 0 and 1
    double a = 0.0;
    double b = 1.0;

    for (int i = 0; i < numSections ; i++)
    {
        x[i] = a + (double)i / ((double)numSections - 1) * (b - a);
    }


    int i;
    int j;
    int k;
    double ya;
    double yb;
    double* d;
    d = new double[numSections];

    for (i = 0; i < numSections; i++)
    {
        for (j = 0; j < numSections; j++)
        {
            d[j] = 0.0;
        }
        d[i] = 1.0;

        for (j = 2; j <= numSections; j++)
        {
            for (k = j; k <= numSections; k++)
            {
                d[numSections + j - k - 1] = (d[numSections + j - k - 2] - d[numSections + j - k - 1]) / (x[numSections - k] - x[numSections + j - k - 1]);
            }
        }
        for (j = 1; j <= numSections - 1; j++)
        {
            for (k = 1; k <= numSections - j; k++)
            {
                d[numSections - k - 1] = d[numSections - k - 1] - x[numSections - k - j] * d[numSections - k];
            }
        }

    ya = d[numSections - 1] / (double)(numSections);
    for (j = numSections - 2; 0 <= j; j--)
    {
        ya = ya * a + d[j] / (double)(j + 1);
    }
    ya = ya * a;

    yb = d[numSections - 1] / (double)(numSections);
    for (j = numSections - 2; 0 <= j; j--)
    {
        yb = yb * b + d[j] / (double)(j + 1);
    }
    yb = yb * b;

    wt[i] = yb - ya;
}

delete[] d;
}

void
NewtonCotesBeamIntegrationUpdated::Print(OPS_Stream& s, int flag)
{
    if (flag == OPS_PRINT_PRINTMODEL_JSON) {
        s << "{\"type\": \"NewtonCotes\"}";
    }

    else {
        s << "NewtonCotes" << endln;
    }
}