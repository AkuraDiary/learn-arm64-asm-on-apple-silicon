//
// here we have
// - a print function in asm
//
//

.global _start
.align 2		// align the current location counter to the next 2^2 byte boundary


/* entry point */

_start:
  mov x3, #16  		// move the loop value into the x3 register 
  bl _loop 		// call the loop function

  b _terminate


/*
  _loop
  simple loop implementation 
  @params
  x2 value to be compared
  x3 value to compare
*/

_loop:
  mov x2, #0		// set the initial x2 value to be 0
  cmp x2, x3 		// compare the x2 to x3 value
  
  // this is the stop or termination condition
  b.hs _end_loop	// test if x2 > x3 if true, end the loop
  
  // this is the loop body  
  adr x1, message	// load the address correspond to the message label into x1 register
  

  add x2, x2, #1 	// increment value inside x2 by 1
  b _loop 	    	// re-iterate the function

_end_loop:
  ret

/*
  _print
  print a string into stdout 
  @params
  x1 : the string to be printed
  x2 : the len of the string
*/

_print:
  mov X0, #1 		// call to the system to stdout  
  mov X16, #4		// write to stdout
  svc 0			// syscall

// _terminate
// call this to terminate the program
_terminate:
  mov X0, #0 	// return 0
  mov X16, #1	// UNIX exit sytem call code
  svc 0		// syscal

message: .asciz "hellow world \n"
message_len= .-message


