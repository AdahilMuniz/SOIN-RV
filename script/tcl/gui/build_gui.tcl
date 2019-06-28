global SCRIPT_DIR

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

source $SCRIPT_DIR/tcl/gui/panel.tcl
source $SCRIPT_DIR/tcl/sw/compile.tcl