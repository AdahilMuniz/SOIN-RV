ROOT_DIR="$(pwd)"
FILE="$ROOT_DIR/code_examples/RV32I/$2.rv32i"
SCRIPT_DIR="$ROOT_DIR/script"

./code_examples/build.sh $1 $2

vlib work

vsim \
-do "set FILE $FILE" \
-do "set ROOT_DIR $ROOT_DIR" \
-do "set SCRIPT_DIR $SCRIPT_DIR" \
-do "script/tcl/common/list_design.tcl" \
-do "script/tcl/common/list_tb.tcl" \
-do "script/tcl/mentor/compile.tcl" \
-do "script/tcl/mentor/load.tcl" \
-do "script/tcl/mentor/run.tcl"