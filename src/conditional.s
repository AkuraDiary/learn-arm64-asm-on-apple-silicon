//
// basic conditional and branching in asm
//

/*

 <labels> : name a specific location in memory
  
 branching in asm

 we use b mnemonic (operation) to jump into unconditional branching
 
 now we can also put the condition into branch operation before actually jump into our labels
 for more information about the operations & conditions check this doc:
 https://developer.arm.com/documentation/den0042/a/Unified-Assembly-Language-Instructions/Instruction-set-basics/Conditional-execution

 conditional is taking the condition from the CPSR's flag

 
 put in mind that comparing and conditionally jumping doesnt mean that the other condition won't be executed
 BIG NO

 asm actually gonna execute whatever comes below it

 so in this below code example, if the condition is not fulfilled, it will keep executing the
 code inside _cond_equal label 

 labels did not "isolate" as i like to say, your code, it just like its name, it's just a label
 
 (you don't have to)
 I think you have to put or call the cmp again at every condition, because CSPR is always gonna change (i guess) 
 but i haven't confirmed it yet
*/


.global _start
.align 4

_start:
   mov X0, #4
   mov X1, #5
  
   cmp X0, X1
   b.eq _cond_equal		// if the X0 and the X1 is equal, in other words it will look the Zero CPSR flag
  				// and do the jump (branching) if the flags is active (1) 
   
   //cmp X0, X1
   b.ne _cond_not_equal		// branch not equal, so if X0 & X1 is not equal, it will look into the Zero CPSR flag
 				// and do the jump if the flag is inactive (0)
   //cmp X0, X1
   b.lt _cond_less_than       	// branch less than (signed), 
				// so it will check the if the N (Negative) flag  != V (oVerflow)   
   //cmp X0, X1
   b.gt _cond_greater_than   	// branch greater than (signed) 
				// will do the jump if the Z (Zero) flag == 0 AND N (Negative) flag == 0

   // so if i want to skip the _cond_equal from being executed, i need to add a branch without condition execution
   
   b _cond_else  		// sort of else statement in regular programming language

 
   
_cond_equal:
   mov X0, #1 		// set the exit code to 1
   b _terminate

_cond_not_equal:
   mov X0, #2
   b _terminate

_cond_less_than:
   mov X0, #3
   b _terminate

_cond_greater_than:
   mov X0, #4
   b _terminate

_cond_else:
   mov X0, #-1 		// set the exit code to 2
   b _terminate


_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0
