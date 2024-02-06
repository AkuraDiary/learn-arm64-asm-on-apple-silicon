//
// compare operation in asm
//

/*
  cmp<c>, <Rn>, <Rm>

  compare actually substracting the Rn with Rm (Rn-Rm)
  and set the CPSR based on the result, and discarding the result of the operation
  compare operation is usually used right before the branch operation
*/

.global _start
.align 4

_start:
  mov X0, #4
  mov X1, #1

  cmp X0, X1 	// it's actually doing X0 - X1 
		// if X0 > X1 -> result is positive  	[ the carry bit is gonna set to 1 ]
		// if X0 < X1 -> result is negative 	[ the negative bit is gonna set to 1 ]
   		// if X0 == X1 -> result is 0 		[ the zero bit is gonna set to 1 ] 
   		// this is gonna set the flag in the CPSR based on the value  		
  //mov X0, CPSR
	
  b _terminate



_terminate:
   // we're gonna use whatever left in X0 as our exit code
   mov X16, #1
   svc #0


/*
  for more information about the CPSR's flags, read the documentation
  - https://developer.arm.com/documentation/den0042/a/Unified-Assembly-Language-Instructions/Instruction-set-basics/Status-flags-and-condition-codes
  
  the carry bit is set to true if the operation did not require borrow

*/
