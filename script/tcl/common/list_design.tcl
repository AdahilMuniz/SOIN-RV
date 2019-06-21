global LIST_DESIGN

set LIST_DESIGN [ list ]

#Top File#
set module(name)   "Top"
set module(files)  [ list "RV32I.sv" ]
set module(dir)    "$ROOT_DIR/src"
set module(incdir) [ list "$ROOT_DIR/include"]

lappend LIST_DESIGN [array get module]

