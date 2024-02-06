.global _start
.align 2

/*
 this one's ain't much

 data types in arm asm
 
 in general

 byte : 8 bits
 halfword : 16 bits
 word : 4 bytes ( 32 bits )

 hexadecimal digits are represented by 4 bits


 how to convert from negative into positive number

 - flip all the bits except the LSB (Least Significant Bit) that's non zero
   and all bits to its right

 i.e

  here we have a #25 and #-25

#25
Hex: 00000019
Binary: 0000 0000 0000 0000 0000 0000 0001 1001
Decimal: 1+8+16=25

Hex: ffffffe7
Binary:   1111 1111 1111 1111 1111 1111 1110 0111
Positive: 0000 0000 0000 0000 0000 0000 0001 1001 //keep the least significant bit that's not zero and all bits on its right as it was



_start:
  mov X0, #25
  mov X1, #-25
  
  mov X2, #16

  mov X3, #-16


_terminate:
  // we'll output whatever left in X0 (exit return code) 
  mov X16, #1
  svc #0

