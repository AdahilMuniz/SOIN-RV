global SCRIPT_DIR

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

source $SCRIPT_DIR/tcl/gui/build_gui.tcl

panel_run