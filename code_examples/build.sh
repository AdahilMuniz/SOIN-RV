#!/bin/bash
CODE_TYPE=$1 
ASSEMBLY_FILE="assembly/$2.S"
C_FILE="c/$2.c"
BINARY_FILE="bin/$2.bin"
OUTPUT_FILE="bin/$2.o"
RV32I_FILE="RV32I/$2.rv32i"

echo $C_FILE
echo $BINARY_FILE

#Initializing
cd $(dirname $0) #I must look for something more elegant
mkdir -p "bin"
mkdir -p "RV32I"


if [ -f "$BINARY_FILE" ]
then
    rm -rf $BINARY_FILE
fi

if [ -f "$RV32I_FILE" ]
then
    rm -rf $RV32I_FILE
fi



#Assembling
if [ "$CODE_TYPE" = "-s" ]; then

    if [ -f "$ASSEMBLY_FILE" ]
    then
        echo "The file $ASSEMBLY_FILE will be assembled."
    else
        echo "There is no file with this name: $2."
        echo "Please, verify whether the file is in the directory 'assembly' and that the name provided has no extension"
        exit 0
    fi
    riscv64-unknown-elf-as -march=rv32i $ASSEMBLY_FILE -o $OUTPUT_FILE

elif [ "$CODE_TYPE" = "-c" ]; then
    if [ -f "$C_FILE" ]
    then
        echo "The file $C_FILE will be compiled."
    else
        echo "There is no file with this name: $2."
        echo "Please, verify whether the file is in the directory 'c' and that the name provided has no extension"
        exit 0
    fi
    riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 $C_FILE -o $OUTPUT_FILE
else
    echo "Please supply a valid file type switch."
    echo "-c     C File"
    echo "-s     Assembly File"
    exit 0
fi


riscv64-unknown-elf-objcopy -S -O binary $OUTPUT_FILE $BINARY_FILE 

rm -rf $OUTPUT_FILE


#test=$(hexdump -e '16/1 "%02x " "\n"' $BINARY_FILE)
test=$(hexdump -e ' "%08x " ' $BINARY_FILE)

for i in $test
do
    echo "$i" >> "$RV32I_FILE"
done
