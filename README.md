# makefile_sdpt3

A Makefile to compile sdpt3 using gcc (Apple LLVM version 9.1.0 (clang-902.0.39.1)) and intel compiler (icc (ICC) 17.0.4 20170411). It worked flawlessly on my mac running Matlab 2017b.

# What has been modified

In order to get the Makefile working for both *icc* (Intel C) and *gcc* (clang) I had to modifiy some source files.

## mexschurfun.c 

1. Change all occurances of !isspX to (!isspX)
2. Change all occurances of !isspY to (!isspY)
 
## mexsmat.c

1. Change all occurances of !isspA to (!isspA)
2. Change all occurances of !isspB to (!isspB)

## mexsvec.c

1. Change all occurances of !isspA to (!isspA)
2. Change all occurances of !isspB to (!isspB)
 
# Instructions

1. Copy Makefile to Solvers/Mexfun
2. To create the mex functions simply issue the command make in Solvers/Mexfun
3. Carry on following the instructions of the original files in order to install under matlab.  No meed to rebuild though. 

# Original site

All the necessary information can be found at the original "fork" site of [sdpt3](https://github.com/sqlp/sdpt3)
