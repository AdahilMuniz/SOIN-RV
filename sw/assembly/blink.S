.section .text
.equ N, 12500000
#.equ N, 10
.globl _start
_start:

addi x14, x0, 4

_LOOP1:
addi x11, x0 , 0
li x2, N
sw x14, 0(x0)
_LOOP2:
addi x11, x11, 1
bne x11, x2, _LOOP2
xori x14, x14, 4
beq x0, x0, _LOOP1
