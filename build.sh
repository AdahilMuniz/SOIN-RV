FILE="code_examples/RV32I/$2.rv32i"

./code_examples/build.sh $1 $2

vlib work
vlog -sv +acc +incdir+include src/RV32I.sv
vlog -sv +acc test/SystemVerilog/interfaces/test_if.sv
vlog -sv +acc test/SystemVerilog/interfaces/memory_if.sv
vlog -sv +acc test/SystemVerilog/interfaces/reg_file_if.sv
vlog -sv +acc +incdir+include +incdir+test/SystemVerilog/model +incdir+test/SystemVerilog/environment test/SystemVerilog/tb_pkg.svh
vlog -sv +acc +incdir+include +incdir+test/SystemVerilog/interfaces test/SystemVerilog/tb/tb.sv
vsim -classdebug -gIM_FILE="$FILE" -do test/wave.do tb