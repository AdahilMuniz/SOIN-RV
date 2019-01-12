#!/bin/sh

# Assembly the program file 
./../../Code_Examples/build.sh $1

rm -rf obj_dir
rm -f  datapath.vcd

# Run Verilator and include C++ testbench
verilator -Wall --cc --trace -I../../src -I../../defines ../../src/DATAPATH.v --exe sim_main.cpp

# Build C++ project
make -j -C obj_dir/ -f VDATAPATH.mk VDATAPATH

# Run executable simulation
obj_dir/VDATAPATH

# Waveforms
gtkwave datapath.vcd datapath.sav &