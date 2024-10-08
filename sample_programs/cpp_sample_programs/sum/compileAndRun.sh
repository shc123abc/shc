#!/bin/bash
#
# LLFI_BUILD_ROOT must be set to the directory where LLFI is installed (same as that in setup)

rm -rf ./llfi*

fname=$1
fname=sumtest

# Generate Makefile
python ../../../build/tools/GenerateMakefile --readable --all -o "$fname.ll"
make

# Instrument it
python ../../../build/bin/instrument.py --readable "$fname.ll"

# Call the profiling script
shift
python ../../../build/bin/profile ./llfi/"$fname-profiling.exe" 5

# Inject the faults
python ../../../bin/injectfault.py ./llfi/"$fname-faultinjection.exe" 5 

echo "Done injecting faults"
