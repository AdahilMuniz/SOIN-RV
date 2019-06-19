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

sw x2,  2(x0)   #DATAMEM[ 0] = 0x0ABA_CA7E 
sw x6, -2(x16)  #DATAMEM[ 3] = 0xBEBA_CAFE
sw x3,  4(x0)   #DATAMEM[ 1] = 0x00BA_7A7A
sw x5,  10(x8)  #DATAMEM[ 4] = 0x0000_B0DE
sw x7,  20(x31) #DATAMEM[12] = 0x0000_B0CA


sb x2,  2(x0)   #DATAMEM[ 0] = 0x0A7E_CA7E
sb x6, -2(x16)  #DATAMEM[ 3] = 0xBEFE_CAFE
sb x3,  4(x0)   #DATAMEM[ 1] = 0x00BA_7A7A
sb x5,  10(x8)  #DATAMEM[ 4] = 0x00DE_B0DE
sb x7,  20(x31) #DATAMEM[12] = 0xCA00_B0CA

sh x2,  2(x0)   #DATAMEM[ 0] = 0xCA7E_CA7E 
sh x6, -2(x16)  #DATAMEM[ 3] = 0xBEBA_BEBA
sh x3,  4(x0)   #DATAMEM[ 1] = 0x00BA_7A7A
sh x5,  10(x8)  #DATAMEM[ 4] = 0xB0DE_B0DE
#sh x7,  20(x31)#Misaligned