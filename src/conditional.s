//
// conditional in asm
//

/*

 <labels> : name a specific location in memory
  
 branching in asm

 we use b mnemonic (operation) to jump into unconditional branching
 
 now we can also put the condition into branch operation before actually jump into our labels
 for more information about the operations & conditions check this doc:
 https://developer.arm.com/documentation/den0042/a/Unified-Assembly-Language-Instructions/Instruction-set-basics/Conditional-execution

 conditional is taking the condition from the CPSR's flag

 
*/


.global start
.align 4



_start:
   mov X0, #4
   mov X1, #5
  
   cmp X0, X1
   b.eq _cond_equal	// if the X0 and the X1 is equal, in other words it will look the Zero CPSR flag
  			// and do the jump (branching) if the flags is active (1) 

   

_cond_equal:
    mov X0, #1 		// set the exit code to 1
    b _terminate

_cond_two:
   mov X0, #2 		// set the exit code to 2
   b _terminate


_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0
