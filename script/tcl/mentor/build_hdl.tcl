global SCRIPT_DIR
global ROOT_DIR
global GUI

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

if {![ info exists ROOT_DIR]} {
    set ROOT_DIR [ file normalize "../../../[ file dirname [ info script ] ]" ] 
}

if {![ info exists GUI]} {
    set GUI "0" 
}


#Source List
source $SCRIPT_DIR/tcl/common/list_design.tcl
source $SCRIPT_DIR/tcl/common/list_tb.tcl

#Source Procedures
source $SCRIPT_DIR/tcl/mentor/env.tcl
source $SCRIPT_DIR/tcl/mentor/compile.tcl
source $SCRIPT_DIR/tcl/mentor/load.tcl

compile_design
compile_tb
load_sim