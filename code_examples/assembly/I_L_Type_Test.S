.section .text
.globl _start
_start:


li x1, 1
li x6, 6
li x3, 3
li x5, 5
li x4, 4

sw x1,  2(x0)
sw x6, -2(x4)
sw x3,  4(x0)
sw x5,  10(x8)
sw x4,  20(x31)

lw x1,  2(x0)
lw x1, -2(x4)
lw x1,  4(x0)
lw x1,  10(x8)
lw x1,  20(x31)
