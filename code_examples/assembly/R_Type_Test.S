.section .text
.globl _start
_start:

add x1, x0, x2
add x1, x0, x5
slt x2, x1, x3
addi x1, x0, -2
addi x2, x0, -1
slt x3, x2, x1
sltu x3, x2, x1
sll x3, x2, x1
srl x4, x2, x3
sra x5, x4, x2
xor x6, x5, x5
xor x6, x5, x4 
or x7, x6, x6
or x7, x6, x5
and x8, x7, x3 

