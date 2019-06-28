global SCRIPT_DIR
global GUI

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

source $SCRIPT_DIR/tcl/gui/panel.tcl
source $SCRIPT_DIR/tcl/sw/build_sw.tcl
source $SCRIPT_DIR/tcl/mentor/build_hdl.tcl