global SCRIPT_DIR
global ROOT_DIR
global RV_FILE
global GUI

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

if {![ info exists ROOT_DIR]} {
    set ROOT_DIR [ file normalize "$SCRIPT_DIR../../" ] 
}

if {![ info exists RV_FILE]} {
    set RV_FILE [ file normalize [ file normalize [ lindex $argv 0 ] ] ]
}

if {![ info exists GUI]} {
    set GUI "0" 
}

if { ! [file exist "work"]} {
    exec vlib work
} else {
    if {! [file isdirectory "work"]} {
        vlib work
    }
}

#Source List
source $SCRIPT_DIR/tcl/common/list_design.tcl
source $SCRIPT_DIR/tcl/common/list_tb.tcl

#Source Procedures
source $SCRIPT_DIR/tcl/mentor/env.tcl
source $SCRIPT_DIR/tcl/mentor/compile.tcl
source $SCRIPT_DIR/tcl/mentor/load.tcl