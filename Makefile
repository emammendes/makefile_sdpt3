# This is a makefile to compile sdpt3 using intel studio on mac
#
# I had to modify the following files due to compilation warnings:
#
# mexschurfun.c 
#
# 1) Change all occurances of !isspX to (!isspX)
# 2) Change all occurances of !isspY to (!isspY)
# 
# mexsmat.c
#
# 1) Change all occurances of !isspA to (!isspA)
# 2) Change all occurances of !isspB to (!isspB)
#
# mexsvec.c
#
# 1) Change all occurances of !isspA to (!isspA)
# 2) Change all occurances of !isspB to (!isspB)
# 
# Instructions:
#
# To create the mex functions simply issue the command make all inside Solvers/Mexfun


# define matlab dir
MDIR = /Applications/MATLAB_R2017b.app

# compiles mex files using gcc
CC = gcc

# compiler flags for gcc
# To avoid lots of warning msgs I have added two -Wno
CCFLAGS = -O3 -fpic -march=x86-64 -Wno-implicit-function-declaration -Wno-pointer-sign

# to use the intel compiler instead, uncomment CC and CCFLAGS below:

# compiles mex file using the intel compiler
#CC = icc

# compiler flags for intel compiler
#CCFLAGS = -O3 -fPIC -D__amd64

# Figure out which platform we're on
UNAME = $(shell uname -s)

# Linux
ifeq ($(findstring Linux,${UNAME}), Linux)
	# define which files to be included
	CINCLUDE = -I$(MDIR)/extern/include -Ic++ -shared
	# define extension
	EXT = mexa64
endif

# Mac OS X
ifeq ($(findstring Darwin,${UNAME}), Darwin)
	# define which files to be included
	CINCLUDE = -L$(MDIR)/bin/maci64 -Ic++ -shared -lmx -lmex -lmat -lmwblas
	# define extension
	EXT = mexmaci64
	# CCFLAGS += -std=c++11 
endif

# All rules as object files

OBJ0 := mexMatvec.o 
OBJ1 := mexProd2nz.o 
OBJ2 := mexinprod.o	
OBJ3 := mexnnz.o 
OBJ4 := mexschur.o	
OBJ5 := mexskron.o 
OBJ6 := mexsvec.o	
OBJ7 := mextriangsp.o 
OBJ8 := mexProd2.o 
OBJ9 := mexexpand.o	
OBJ10 := mexmat.o 
OBJ11 := mexqops.o 
OBJ12 := mexschurfun.o	
OBJ13 := mexsmat.o	
OBJ14 := mextriang.o

OBJVARS := OBJ0  OBJ1  OBJ2  OBJ3  OBJ4  OBJ5  OBJ6  OBJ7  OBJ8  OBJ9 OBJ10 OBJ11 OBJ12 OBJ13 OBJ14 

# Sources and object files

SRC := $(wildcard *.c)
OBJ := $(patsubst %.c,%.o,$(SRC))

# Object files

$(OBJ): %.o: %.c
	$(CC) $(CCFLAGS) -I$(MDIR)/extern/include -c -Ic++ $< -o $@

# Mex functions

.PHONY: all clean 

EXTS :=

# $(1): variable name
define MY_rule
$(1)_EXT := $$(patsubst %.o,%.$$(EXT),$$(firstword $$($(1))))

EXTS += $$($(1)_EXT)

$$($(1)_EXT): $$($(1))
	$$(CC) $$(CCFLAGS) $$(CINCLUDE) $$^ -o $$@
endef

$(foreach v,$(OBJVARS),$(eval $(call MY_rule,$(v))))

all: $(EXTS)

clean:
	rm -f $(OBJ) $(EXTS)
	