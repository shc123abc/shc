#!/bin/bash
#
# LLFI_BUILD_ROOT must be set to the directory where LLFI is installed (same as that in setup)

rm -rf ./llfi*

fname=test
# fname=$1

# Generate Makefile
python ../../../build/tools/GenerateMakefile --readable --all -o "$fname.ll"
# $LLFI_BUILD_ROOT/tools/GenerateMakefile --readable --all -o "$fname.ll"
make

# Instrument it
python ../../../build/bin/instrument --readable "$fname.ll"

# Call the profiling script
shift
python ../../../build/bin/profile ./llfi/"$fname-profiling.exe" 6

echo "1"

# Inject the faults
python ../../../build/bin/injectfault ./llfi/"$fname-faultinjection.exe" 6

echo "Done injecting faults"
