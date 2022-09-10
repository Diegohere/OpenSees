//Added by Diego Heredia, RESSLab EPFL

#ifndef NewtonCotesBeamIntegrationUpdated_h
#define NewtonCotesBeamIntegrationUpdated_h

#include <BeamIntegration.h>

class Matrix;
class ElementalLoad;
class Channel;
class FEM_ObjectBroker;

class NewtonCotesBeamIntegrationUpdated : public BeamIntegration
{
public:
	//constructor
	NewtonCotesBeamIntegrationUpdated();

	//destructor
	virtual ~NewtonCotesBeamIntegrationUpdated();

	//Methods
	void getSectionLocations(int nIP, double L, double* xi);
	void getSectionWeights(int nIP, double L, double* wt);

	BeamIntegration* getCopy(void);

	// These two methods do nothing
	int sendSelf(int cTag, Channel& theChannel) { return 0; }
	int recvSelf(int cTag, Channel& theChannel,
		FEM_ObjectBroker& theBroker) {
		return 0;
	}

	void Print(OPS_Stream& s, int flag = 0);
};


#endif // !NewtonCotesBeamIntegrationUpdated_h
