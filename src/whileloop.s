//
// basic while loop implementation in asm
//


.global _start
.align 4


_start:
  mov X0, #0 	 	// we'll set the initial value here
  b _loop


_loop:
  cmp X0, #5		// then we compare with the value we wanted to compare, here i'm using 5
  b.ge _terminate 	// the condition for Greater than or equal (signed)
 			// this should make our exit code to be 5
  add X0, X0, #1 	// then we increment the X0 by the value of 
 			// this should make our exit code to be 5
  b _loop		// then we re iterate it

_terminate:
  // we'll use whatever left in x0 as our exit code
  mov X16, #1
  svc #0





