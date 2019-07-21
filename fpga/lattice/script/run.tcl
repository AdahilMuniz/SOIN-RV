#Files

set PRJ_DIR    [file normalize ./../../../]
set LATTIC_DIR [file normalize ./../      ]
set SRC_DIR    [file normalize $PRJ_DIR/src]
set INC_DIR    [file normalize $PRJ_DIR/include]

set FILE "RV32I.sv"
set FILE_NAME [file rootname [file tail $FILE]]
set SYNTH_FILE "synth_$FILE_NAME.v"

set OUT_DIR "output"

#Paramenters
#set IM_FILE {$PRJ_DIR/sw/RV32I/I_Type_Test.rv32i}
set IM_FILE {"../../../sw/RV32I/blink.rv32i"}
set DM_FILE {"../../../sw/RV32I/blink.rv32i"}

#Synthesis
set TOP_MODULE DATAPATH
set ARGS "-sv"

#FPGA
set PKG "sg48"
set DEVICE "5k"
set PCF_FILE "$LATTIC_DIR/constraint.pcf"


proc run_synthesis {args} {

    global ARGS
    global SRC_DIR
    global INC_DIR
    global TOP_MODULE
    global FILE
    global FILE_NAME
    global SYNTH_FILE
    global OUT_DIR

    global IM_FILE
    global DM_FILE

    puts "Starting Synthesis..."

    puts [ exec "yosys" -p "read_verilog $ARGS -DIM_FILE=$IM_FILE -DDM_FILE=$DM_FILE -I$INC_DIR $SRC_DIR/$FILE" \
                        -p "synth_ice40 -top $TOP_MODULE -blif $OUT_DIR/$FILE_NAME.blif" \
                        -p "write_verilog $OUT_DIR/$SYNTH_FILE"
         ]
}

proc run_place_route {args} {

    global PKG
    global DEVICE
    global PCF_FILE
    global FILE_NAME
    global OUT_DIR

    puts "Starting Place and Route .. "

    puts [ exec "arachne-pnr" -d "$DEVICE" -P "$PKG" \
                              -p "$PCF_FILE" "$OUT_DIR/$FILE_NAME.blif" \
                              -o "$OUT_DIR/$FILE_NAME.asc"
         ]
  
}

proc run_bin {args} {

    global FILE_NAME
    global OUT_DIR

    puts "Generating binary ..."

    puts [ exec "icepack" "$OUT_DIR/$FILE_NAME.asc" "$OUT_DIR/$FILE_NAME.bin" ]   
}

puts [ exec mkdir -p $OUT_DIR]

run_synthesis
run_place_route
#run_bin