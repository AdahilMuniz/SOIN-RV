ROOT_DIR="$(pwd)"

FILE_TO_COMPILE="$1"

FILE_TO_LOAD="$RV32I_DIR/$1.rv32i"
SCRIPT_DIR="$ROOT_DIR/script"

GUI="1" #Enable ModelSim GUI

ARGS=""

if [[ $GUI -eq "0" ]]; then
    ARGS="$ARGS -c"
fi

if [ ! -d "work" ]
then
    vlib work
fi

vsim $ARGS \
-do "set GUI $GUI" \
-do "set FILE_TO_COMPILE $FILE_TO_COMPILE" \
-do "set FILE_TO_LOAD $FILE_TO_LOAD" \
-do "set ROOT_DIR $ROOT_DIR" \
-do "set SCRIPT_DIR $SCRIPT_DIR" \
-do "script/tcl/sw/compile.tcl" \
-do "script/tcl/sw/build_sw.tcl" \
-do "script/tcl/mentor/env.tcl" \
-do "script/tcl/common/list_design.tcl" \
-do "script/tcl/common/list_tb.tcl" \
-do "script/tcl/mentor/compile.tcl" \
-do "script/tcl/mentor/load.tcl" \
-do "script/tcl/mentor/build_hdl.tcl"