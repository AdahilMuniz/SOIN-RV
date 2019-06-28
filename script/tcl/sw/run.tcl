global SCRIPT_DIR

if {![ info exists SCRIPT_DIR]} {
    set SCRIPT_DIR [ file normalize "../../[ file dirname [ info script ] ]" ] 
}

source $SCRIPT_DIR/tcl/sw/build_sw.tcl

compile_sw $FILE_TO_COMPILE