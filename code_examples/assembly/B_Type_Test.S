.section .text
.equ N, 10
.globl _start
_start:

addi x10, x0 , 0
li x1, N
_LOOP1:
addi x10, x10, 1
beq x10, x1, _END
beq x0, x0, _LOOP1
_END:
#x10 = 0x0A

li x1, 0xBEBA
sw x1, 0(x10)

addi x11, x0 , 0
li x2, N
_LOOP2:
addi x11, x11, 1
bne x11, x2, _LOOP2
#x11 = 0x0A

li x2, 0xCAFE
slli x1, x1, 16
or x1, x1, x2
sw x1, 0(x11)

addi x12, x0 , 0
li x3, N
_LOOP3:
addi x12, x12, 1
blt x12, x3, _LOOP3
#x12 = 0x0A

addi x13, x0 , -10
li x4, N
_LOOP4:
addi x13, x13, 1
blt x13, x4, _LOOP4
#x13 = 0x0A

addi x14, x0 , 0
li x5, N
_LOOP5:
addi x14, x14, 1
bltu x14, x5, _LOOP5
#x14 = 0x0A

addi x15, x0 , -10
li x6, N
_LOOP6:
addi x15, x15, 1
bltu x15, x6, _LOOP6
#x15 = 0xF7

addi x16, x0 , N
li x7, 0
_LOOP7:
addi x16, x16, -1
bge x16, x7, _LOOP7
#x16 = 0xFF

addi x17, x0 , N
li x8, 1
_LOOP8:
addi x17, x17, -1
bgeu x17, x8, _LOOP8
#x17 = 0x00

addi x18, x0 , N
li x9, -10
_LOOP9:
addi x18, x18, -1
bgeu x18, x9, _LOOP9
#x18 = 0x09
