global SCRIPT_DIR

source panel.tcl
source ../sw/compile.tcl

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

panel_run