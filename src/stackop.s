//
// a lil bit more on 
// stack operations
// 

/*
 here we're gonna elevate the function
 using stack operationsi
  
 keep in mind that the stack is growing downwards
 
 and subtract from the stack pointer to allocate spaces from new value
*/


.global _start
.align 4

_start:
  // now if you ought to put this logic into another function
  // we're gonna have to save our lr (Link Register) into the stack
  // so the program will remember where its left of

  // str LR, [SP, #-16]! // i commented this because i dont think it's necessary, and i havent fully understand it

  
  // the first 4 arguments in a fucntion is stored in the X0 - X3 register
  mov X0, #1			// arg 1
  mov X1, #2			// arg 2
  mov X2, #3			// arg 3
  mov X3, #4			// arg 4 

  // and the rest is stored in the stack
  
  // sub SP, SP, #8		// here we should be allocating some space inside the stack
  
  mov X4, #5
  mov X5, #6 
  stp X4, X5, [SP, #-16]!	// now remeber we don't have a specific push operation in arm64 asm
				// at least in apple silicon
   		
  bl _add_nums			// this is a branch with link instruction that will set the lr register

  // mov X2, X0			// 
  
  // add SP, SP, #8
  // ldr LR, [SP], #16
 
  b _terminate	  		// 1 + 2 + 3 + 4 + 5 + 6  = 21 we should get this in our exit code


_add_nums:
  add X0, X0, X1 		// the return value of a function is gonna restored into the X0
  add X0, X0, X2
  add X0, X0, X3

  // now we get the arguments from the stack
  
  ldp X4, X5, [SP], #16
  
  add X4, X4, X5
  add X0, X0, X4

  ret 		 		// we're using the ret keyword to exit from the function


_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0


/*
 SP (stack pointer) contains the address of top of the stack
  - SP must always be aligned to 16 bytes boundary
  - No explicit push or pop in arm architecture
    so instead we manipulate the str/stp (to push) & ldr/ldp (to pop)  

  i.e : 

  stp X0, X1, [SP, #-16]! 	// push X0, X1, to the stack then decrease SP by 16
  ldp X0, X1, [SP], #16 	// pop stack entry into X0, X1 then increase SP by 16
*/
