include ../../../Makefile.def

OBJS       = \
	TestNonlocalElement3dDH.o \
	TestNonlocalElement2dDH.o \
	TclTestNonlocalElementDH.o

# Compilation control

all:         $(OBJS)

# Miscellaneous
tidy:	
	@$(RM) $(RMFLAGS) Makefile.bak *~ #*# core

clean: tidy
	@$(RM) $(RMFLAGS) $(OBJS) *.o

spotless: clean

wipe: spotless

# DO NOT DELETE THIS LINE -- make depend depends on it.
