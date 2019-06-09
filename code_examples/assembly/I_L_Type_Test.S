.section .text
.globl _start
_start:


li x2, 0x0ABACA7E 
li x6, 0xBEBACAFE 
li x3, 0x00BA7A7A
li x5, 0x0000B0DE 
li x7, 0x0000B0CA 

li x4 , 4
li x8 , 8
li x31, 31

sw x2,  2(x0)
sw x6, -2(x4)
sw x3,  4(x0)
sw x5,  10(x8)
sw x7,  20(x31)

lw x1,  2(x0)   #0x0ABA_CA7E
lw x1, -2(x4)   #0xBEBA_CAFE
lw x1,  4(x0)   #0x00BA_7A7A
lw x1,  10(x8)  #0x0000_B0DE
lw x1,  20(x31) #0x0000_B0CA

lh x1,  2(x0)   #0xFFFF_CA7E
lh x1, -2(x4)   #0xFFFF_CAFE
lh x1,  4(x0)   #0x0000_7A7A
lh x1,  10(x8)  #0xFFFF_B0DE
lh x1,  20(x31) #0xFFFF_B0CA

lhu x1,  2(x0)   #0x0000_CA7E
lhu x1, -2(x4)   #0x0000_CAFE
lhu x1,  4(x0)   #0x0000_7A7A
lhu x1,  10(x8)  #0x0000_B0DE
lhu x1,  20(x31) #0x0000_B0CA

lb x1,  2(x0)   #0x0000_007E
lb x1, -2(x4)   #0xFFFF_FFFE
lb x1,  4(x0)   #0x0000_007A
lb x1,  10(x8)  #0xFFFF_FFDE
lb x1,  20(x31) #0xFFFF_FFCA

lbu x1,  2(x0)   #0x0000_007E
lbu x1, -2(x4)   #0x0000_00FE
lbu x1,  4(x0)   #0x0000_007A
lbu x1,  10(x8)  #0x0000_00DE
lbu x1,  20(x31) #0x0000_00CA
