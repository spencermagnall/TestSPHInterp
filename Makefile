FC=gfortran
FFLAGS= -fopenmp -ffast-math -ftree-vectorize -fdefault-real-8 -fdefault-double-8 -Wall -funroll-loops -fcheck=bounds -cpp  -Wno-tabs -g -O3 
SRC= interpolate3D.f90 utils_tables.f90 geometry.f90 stretchmap.f90 random.f90 set_unifdis.f90 testinterp.F90
OBJ=${SRC:.f90=.o}

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

testsphinterp: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)
clean:
	rm *.o *.mod
	rm testsphinterp
cleanruns:
	rm -f snap_*
	rm -f Momentum
	rm -f *.txt
