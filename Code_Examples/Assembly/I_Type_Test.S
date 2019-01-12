.section .text
.globl _start
_start:

addi x1, x0, 2
addi x1, x0, -2
slti x2, x1, -3
slti x2, x1, 1
sltiu x1, x1, -3 #Doesn't work
sltiu x1, x1, 3
