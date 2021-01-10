global SCRIPT_DIR

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "[ file normalize [ info script ] ]../../../../" ] 
}

source $SCRIPT_DIR/tcl/mentor/build_hdl.tcl

compile_design
compile_tb
load_sim