FILE="code_examples/RV32I/$1.rv32i"

if [ -z "$1" ]
then
    echo "Please supply the file name without extension"
    exit 0
fi

./code_examples/build.sh $1

vlib work
vlog -sv +acc +incdir+include src/RV32I.sv
vlog -sv +acc +incdir+include include/types_pkg.svh
vlog -sv +acc test/SystemVerilog/interfaces/test_if.sv
vlog -sv +acc test/SystemVerilog/interfaces/memory_if.sv
vlog -sv +acc test/SystemVerilog/interfaces/reg_file_if.sv
vlog -sv +acc +incdir+include +incdir+test/SystemVerilog/model +incdir+test/SystemVerilog/environment test/SystemVerilog/tb_pkg.svh
vlog -sv +acc +incdir+include +incdir+test/SystemVerilog/interfaces test/SystemVerilog/tb/tb.sv
vsim -classdebug -gIM_FILE="$FILE" -do test/wave.do tb