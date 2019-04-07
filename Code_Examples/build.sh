#!/bin/bash
ASSEMBLY_FILE="Assembly/$1.S"
BINARY_FILE="Bin/$1.bin"
OUTPUT_FILE="Bin/$1.o"
RV32I_FILE="RV32I/$1.rv32i"


#Initializing
cd $(dirname $0) #I have to look for something more elegant

if [ -f "$ASSEMBLY_FILE" ]
then
	echo "The file $ASSEMBLY_FILE will be assembled."
else
	echo "There is no file with this name: $1."
	echo "Please, verify whether the file is in the directory 'Assembly' and that it has no extension (.S)"
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
/opt/riscv/bin/riscv64-unknown-elf-as -march=rv32i $ASSEMBLY_FILE -o $OUTPUT_FILE
/opt/riscv/bin/riscv64-unknown-elf-objcopy -S -O binary $OUTPUT_FILE $BINARY_FILE 

rm $OUTPUT_FILE


#test=$(hexdump -e '16/1 "%02x " "\n"' $BINARY_FILE)
test=$(hexdump -e ' "%08x " ' $BINARY_FILE)

for i in $test
do
    echo "$i" >> "$RV32I_FILE"
done
