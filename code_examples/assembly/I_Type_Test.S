.section .text
.globl _start
_start:

addi x1, x0, 2
addi x1, x0, -2
slti x2, x1, -3
slti x2, x1, 1
sltiu x1, x1, -3
sltiu x1, x1, 3
slli x3, x2, 1
slli x3, x2, 3
srli x4, x2, 1
srli x4, x2, 3
srai x5, x2, 2
srai x5, x2, 3
xori x6, x5, 5
xori x6, x5, -5 
ori x7, x6, 3
ori x7, x6, -2
andi x8, x7, 3
andi x8, x7, -2 

