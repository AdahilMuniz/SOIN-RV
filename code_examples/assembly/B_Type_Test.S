.section .text
.equ N, 10
.globl _start
_start:

addi x1, x0 , 0
li x2, N
_LOOP1:
addi x1, x1, 1
beq x1, x2, _END
beq x0, x0, _LOOP1
_END:
li x2, 0xBEBA
sw x2, 0(x1)

addi x1, x0 , 0
li x3, N
_LOOP2:
addi x1, x1, 1
bne x1, x3, _LOOP2

li x3, 0xCAFE
slli x2, x2, 16
or x2, x2, x3
sw x2, 0(x1)

