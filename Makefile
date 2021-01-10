SW_FILE  ?= ./sw/c/helloworld.c
ROOT_DIR = ./

help:
	@echo "-----------------------HELP--------------------------"
	@echo "build_gui  --- Build the gui interface."
	@echo "build_hdl  --- Compile and load the HDL source files."
	@echo "compile_sw --- Compile C or Assembly software."

build_gui:
	./build.sh

build_hdl:
	tclsh ./script/tcl/mentor/run.tcl

compile_sw:
	tclsh ./script/tcl/sw/run.tcl $(SW_FILE)

clean:
	rm -rf work transcript vsim.wlf ./script/mentos/work ./sw/bin ./sw/RV32I