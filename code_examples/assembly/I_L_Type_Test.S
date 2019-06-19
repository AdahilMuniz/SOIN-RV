.section .text
.globl _start
_start:


li x2, 0x0ABACA7E 
li x6, 0xBEBACAFE 
li x3, 0x00BA7A7A
li x5, 0x0000B0DE 
li x7, 0x0000B0CA 

li x16 , 16 
li x8  , 8
li x31 , 31

sw x2,  2(x0)
sw x6, -2(x16)
sw x3,  4(x0)
sw x5,  10(x8)
sw x7,  20(x31)

lw x1,  2(x0)   #0x0ABA_CA7E
lw x1, -2(x16)  #0xBEBA_CAFE
lw x1,  4(x0)   #0x00BA_7A7A
lw x1,  10(x8)  #0x0000_B0DE
lw x1,  20(x31) #0x0000_B0CA

lh x1,  2(x0)   #0x0000_0ABA
lh x1, -2(x16)  #0xFFFF_BEBA
lh x1,  4(x0)   #0x0000_7A7A
lh x1,  10(x8)  #0x0000_0000
#lh x1,  20(x31)# Misaligned

lhu x1,  2(x0)   #0x0000_0ABA
lhu x1, -2(x16)  #0x0000_BEBA
lhu x1,  4(x0)   #0x0000_7A7A
lhu x1,  10(x8)  #0x0000_0000
#lhu x1,  20(x31) #0x0000_B0CA # Misaligned

lb x1,  2(x0)   #0xFFFF_FFBA
lb x1, -2(x16)  #0xFFFF_FFBA
lb x1,  4(x0)   #0x0000_007A
lb x1,  10(x8)  #0x0000_0000
lb x1,  20(x31) #0x0000_0000

lbu x1,  2(x0)   #0x0000_00BA
lbu x1, -2(x16)  #0x0000_00BA
lbu x1,  4(x0)   #0x0000_007A
lbu x1,  10(x8)  #0x0000_0000
lbu x1,  20(x31) #0x0000_0000
