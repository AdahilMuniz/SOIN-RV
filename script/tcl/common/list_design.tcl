global LIST_DESIGN

set LIST_DESIGN [ list ]

set ROOT_DIR "../../.."

#Top File#
set module(name) "Top"
set module(file) "$ROOT_DIR/src/RV32I.sv"
set module(incdir) "$ROOT_DIR/include"

lappend LIST_DESIGN [array get module]

