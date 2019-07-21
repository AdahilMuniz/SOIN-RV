global FILE_TO_COMPILE
global SCRIPT_DIR

if {![ info exists FILE_TO_COMPILE]} {
    set FILE_TO_COMPILE [ file normalize [ lindex $argv 0 ] ]   
}

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

source $SCRIPT_DIR/tcl/sw/build_sw.tcl

compile_sw $FILE_TO_COMPILE