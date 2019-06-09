#!/bin/bash
ASSEMBLY_FILE="assembly/$1.S"
BINARY_FILE="bin/$1.bin"
OUTPUT_FILE="bin/$1.o"
RV32I_FILE="RV32I/$1.rv32i"

#Initializing
cd $(dirname $0) #I must look for something more elegant
mkdir -p "bin"
mkdir -p "RV32I"


if [ -f "$ASSEMBLY_FILE" ]
then
	echo "The file $ASSEMBLY_FILE will be assembled."
else
	echo "There is no file with this name: $1."
	echo "Please, verify whether the file is in the directory 'assembly' and that the name provided has no extension (.S)"
	exit 0
fi

if [ -f "$BINARY_FILE" ]
then
	rm $BINARY_FILE
fi

if [ -f "$RV32I_FILE" ]
then
	rm $RV32I_FILE
fi



#Assembling
riscv64-unknown-elf-as -march=rv32i $ASSEMBLY_FILE -o $OUTPUT_FILE
riscv64-unknown-elf-objcopy -S -O binary $OUTPUT_FILE $BINARY_FILE 

rm -rf $OUTPUT_FILE


#test=$(hexdump -e '16/1 "%02x " "\n"' $BINARY_FILE)
test=$(hexdump -e ' "%08x " ' $BINARY_FILE)

for i in $test
do
    echo "$i" >> "$RV32I_FILE"
done
