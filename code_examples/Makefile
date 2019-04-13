CC=riscv64-unknown-elf
ASSEMBLER=$(CC)-as
ASM_DIR=Assembly
BIN_DIR=Bin

FLAGS=-march=rv32i

help:
	echo $(ASSEMBLER)

compile:
test.o: test.S
	$(ASSEMBLER) $(FLAGS) -o $<