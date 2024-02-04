//
// here we have
// - a print function in asm
//
//

.global _start
.align 2		// align the current location counter to the next 2^2 byte boundary


/* entry point */

_start:
  adr X8, message    	 	// addressing the message string into X8 register 
  ldr X9, =message_len  	// load pair the message_len pointer into X3 and X9 register
  stp X8, X9, [SP, #-16]! 	// push the message to stack
  
  mov X4, #0			// set the initial X4 value to be 0
  mov X3, #10			// set the X3 value to be 10
  bl _loop 			// call the loop function
  b _terminate


/*
  _loop
  simple loop implementation 
  x4 value to be compared
  x3 value to compare
*/

_loop:
  cmp X4, X3 			// compare the x4 value to 10
  b.cs _end_loop 	 	// this is the stop or termination condition where X4 > 10 is true
  
  // the loop body
  add X4, X4, #1		// increment the X4 by the value of 1

  mov X0, #1 			// call to stdout
  ldp X1, X2, [SP], #16 	// load the message string and message len  
  mov X16, #4			// write to stdout

  stp X1, X2, [SP, #-16]! 	// push the message string and len to the stack again to print it for next iteration
  svc #0			// system call

  b _loop 	    		// re-iterate the function

_end_loop:

  ldp X1, X2, [SP], #16
  eor X1, X1, X1
  eor X2, X2, X2

  ret

// _terminate
// call this to terminate the program
_terminate:
  mov X0, #0 	// return 0
  mov X16, #1	// UNIX exit sytem call code
  svc 0		// syscal

message: .asciz "hellow world \n"
message_len= .-message


