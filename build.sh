FILE="Code_Examples/RV32I/$1.rv32i"

if [ -z "$1" ]
then
    echo "Please supply the file name without extension"
    exit 0
fi

./Code_Examples/build.sh $1

vlib work
vlog +acc src/RV32I.vh
vlog -sv +acc +incdir+defines +incdir+test/SystemVerilog/model +incdir+test/SystemVerilog/programs test/SystemVerilog/tb_pkg.svh
vlog -sv +acc +incdir+defines +incdir+test/SystemVerilog/model +incdir+test/SystemVerilog/programs test/SystemVerilog/tb/tb.sv
vsim -gIM_FILE="$FILE" -do test/wave.do tb