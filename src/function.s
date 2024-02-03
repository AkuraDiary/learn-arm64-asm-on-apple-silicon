//
// function calling in asm
//

/*
  in assembly a function call is executed via the bl instruction (branch with link)

  function calling convention in ARM64

  - push any register that need to be preserved into the stack
  - the first ten arguments are stored in the registers X0 to X9
  - Any further arguments are pushed to the stack
  - execute bl and run the function
  - place return value into X0 then execute ret
  - evaluate return value then pop previously saved register

  only in nested function calls is the stack used to save return address
  - save LR (Link Register) on the stack before the nested call
  - pop it off the stack into LR after returning from the nested function

*/


.global _start
.align 2

_start:
  b _hello_function
  

// here i just copied my printing function from the previous code
_hello_function:
  mov  X8, #0x480A 		// move output string to X8
  movk X8, #0x6C65, lsl#16  	// we're encode the output string by ascii code in hex value (I suppose)
  movk X8, #0x6F7c, lsl#32
  movk X8, #0x4D20, lsl#48
  	
  mov  x9, #0x2D31 		// second half to X9
  movk X9, #0x6F57, lsl#16
  movk X9, #0x6C72, lsl#32
  movk X9, #0x2164, lsl#48

  stp X8, X9, [SP, #-16]! 	// here we push the output string to stack
  mov x2, #0 	  		// initialize the x2 to 0 value for the loop counter
  bl _loop 			// branch link ( call ) the _loop function
  b _terminate			// call the terminate function right after _loop 

_loop:
  cmp x2, #16 		// compare the value inside x2 with value : 16 (the supposed len of the string)
  b.hs _end_loop 	// if x2 => 16 exit the loop
  add x2, x2, #1	// increment the x2 by the value of 1

  mov X0, #1
  mov x1, SP
  mov x16, #4
  svc 0

  b _loop		// re-iterate the loop

_end_loop:
  ret

_terminate:
  mov X0, 0 	 	// set return code 0 to X0
  mov X16, #1 	 	// Unix Code call for exit system
  svc #0	 	// call the kernel

 
