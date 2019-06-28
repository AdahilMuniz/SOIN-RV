global LIST_TB
global ROOT_DIR

set LIST_TB [ list ]

#TB Interfaces#
set tb(name)   "TB Interface"
set tb(files)  [ list "test_if.sv" \
                      "memory_if.sv" \
                      "reg_file_if.sv" \
               ]
set tb(dir)    "$ROOT_DIR/test/SystemVerilog/interfaces"
set tb(incdir) [ list ]

lappend LIST_TB [array get tb]


#TB Package#
set tb(name)   "TB Package"
set tb(files)  [ list "tb_pkg.svh" ]
set tb(dir)    "$ROOT_DIR/test/SystemVerilog"
set tb(incdir) [ list "$ROOT_DIR/include"\
                      "$ROOT_DIR/test/SystemVerilog/model"\
                      "$ROOT_DIR/test/SystemVerilog/environment"\
               ]

lappend LIST_TB [array get tb]

#TB#
set tb(name)   "TB"
set tb(files)  [ list "tb.sv" ]
set tb(dir)    "$ROOT_DIR/test/SystemVerilog/tb"
set tb(incdir) [ list "$ROOT_DIR/include"\
                      "$ROOT_DIR/test/SystemVerilog/interfaces"\
               ]

lappend LIST_TB [array get tb]