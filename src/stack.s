//
// basic stack in asm 
//

/*
 stack is a data structure for short-term memory allocation at runtime
 - LIFO (last in first out) principle 
 - grows towards the smallest
 - one entry is 128 bits / 16 bytes
  
 SP (stack pointer) contains the address of top of the stack
  - SP must always be aligned to 16 bytes boundary
  - No explicit push or pop in arm architecture
    so instead we manipulate the str/stp (to push) & ldr/ldp (to pop)  

  i.e : 

  stp X0, X1, [SP, #-16]! 	// push X0, X1, to the stack then decrease SP by 16
  ldp X0, X1, [SP], #16 	// pop stack entry into X0, X1 then increase SP by 16
 
nb: 
 apple use Little Endian Format (on apple silicone)
 it means that first byte in a chunk of data gets stored at the lowest address, vice versa

 ARM in general support both Little Endian & Big Endian

*/ 


.global _start
.align 2


_start:
  mov  X8, #0x480A 		// move output string to X8
  movk X8, #0x6C65, lsl#16
  movk X8, #0x6F7c, lsl#32
  movk X8, #0x4D20, lsl#48
  	
  mov  x9, #0x2D31 		// second half to X9
  movk X9, #0x6F57, lsl#16
  movk X9, #0x6C72, lsl#32
  movk X9, #0x2164, lsl#48

  stp X8, X9, [SP, #-16]! 	//push the output string to stack
  mov X2, #0			// initialize x2 with 0
  b _loop 

_loop:
  cmp X2, #16			// compare X2 with 16 (X2 > 16)
  b.cs _terminate		// if true terminate loop
  add X2, X2, #1		// increment x2 by 1
  mov X0, #1			// call to stdout

  // since the stack pointer is already pointing to the last added item 
  // in this case which is the X8 & X9 containing the message 
  // we can just point it into the X1 register
  mov X1, SP		
 
  mov X16, #4 			// UNIX call to write to stdout
  svc #0			// call the kernel
  b _loop

  //b _terminate	// call terminate to end the program

_terminate:
  mov X0, #0 	// return code 0
  mov X16, #1 	// UNIX exit system call code
  svc #0  	// call the kernel
