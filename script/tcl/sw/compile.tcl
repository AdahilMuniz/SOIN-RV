proc compile_s {args} {
    #GET
    global FILE
    global FILE_NAME
    global BIN_DIR

    #SET
    global OBJ_FILE

    set ARCH "rv32i"

    set OBJ_FILE "$BIN_DIR/$FILE_NAME.o"

    puts [ exec riscv64-unknown-elf-as -march=rv32i $FILE -o $OBJ_FILE ]
}

proc gen_rv_file {args} {
    #GET
    global FILE_NAME
    global OBJ_FILE
    global BIN_DIR
    global RV_FILE_DIR

    #SET
    global BIN_FILE
    global RV_FILE

    #Python Script
    set PYTHON_SCRIPT_DIR [ file normalize "../../python" ]; # TODO: Look for something more elegant
    set PYTHON_PARSE "$PYTHON_SCRIPT_DIR/parse_bin.py"

    set BIN_FILE "$BIN_DIR/$FILE_NAME.bin"
    set RV_FILE  "$RV_FILE_DIR/RV_FILE_DIR.rv32i"

    puts [ exec riscv64-unknown-elf-objcopy -S -O binary $OBJ_FILE $BIN_FILE  ]
    puts [ exec python $PYTHON_PARSE $BIN_FILE $RV_FILE ]
}

proc set_env {args} {
    #GET
    global FILE

    #SET
    global FILE_NAME
    global FILE_DIR
    global BIN_DIR
    global RV_FILE_DIR

    #Handle File
    set FILE_NAME [file rootname [file tail $FILE]]

    #Handle directories
    set FILE_DIR [ file normalize [ file dirname $FILE ] ]
    set OUT_ROOT_DIR [ file normalize "$FILE_DIR/.." ]
    set BIN_DIR "$OUT_ROOT_DIR/bin"
    set RV_FILE_DIR "$OUT_ROOT_DIR/RV32I"

    #Create output directories
    puts [ exec mkdir -p $BIN_DIR]
    puts [ exec mkdir -p $RV_FILE_DIR]
}

proc compile {args} {
    global FILE

    set FILE [ lindex $args 0]
    set FILE_EXTENSION [file extension $FILE]

    set_env

    if {$FILE_EXTENSION == ".S"} {
        compile_s
    } elseif {$FILE_EXTENSION == ".c"} {
        puts "> Compile C"
    } else {
        puts "> No valid extension."
    }

    gen_rv_file
}

#global FILE
set FILE [ file normalize [ lindex $argv 0 ] ]
compile $FILE