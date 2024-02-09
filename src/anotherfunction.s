//
// yet another function implementation in asm
//

/*
  we're gonna recreating this function in asm

  int add_num(int num1, int num2){
   return num1 + num2;
  }

  int main(void){
   add_nums(1,2)
   return 0
  }
  


 nb
  the first four arguments to a function 
  are stored in register X0 - X3
  the rest of it is stored into the stuck

  return value is stored in X0

  lr register stores the address of the instruction to execute after the function call
  in other words it stores the address of the instruction bellow the bl call
 
*/


.global _start
.align 4

_start:
  mov X0, #1
  mov X1, #2

  // now lets say you want to use the original value of the X0 & X1 after the call
  // we have to push it first to the stack
		
  stp X0, X1, [SP, #-16]!	// now remeber we don't have a specific push operation in arm64 asm
				// at least in apple silicon

   		
  bl _add_nums			// this is a branch with link instruction that will set the lr register

  				// in this case, since we use X0 as our return value, and we calling
 				// terminate immediately, we should be get 3 as our exit code

  mov X2, X0			// we're storing the function result in X2

  ldp X0, X1, [SP], #16		// here we're popping back the original value into X0 & X1
   				// by doing this operation we should be have 1 as our exit code

  b _terminate	  		// lr will be saving this instruction's address

_add_nums:
  add X0, X0, X1 		// the return value of a function is gonna restored into the X0
  ret 		 		// we're using the ret keyword to exit from the function

_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0


/*

 nb explanation for the stack operation
  
 - LIFO (last in first out) principle 
 - grows towards the smallest
 - one entry is 128 bits / 16 bytes (which mean for no brainer like me, we should put two value (in pair) instead of one to maximize the stack utilities)
  
 SP (stack pointer) contains the address of top of the stack
  - SP must always be aligned to 16 bytes boundary
  - No explicit push or pop in arm architecture
    so instead we manipulate the str/stp (to push) & ldr/ldp (to pop)  

  i.e : 

  stp X0, X1, [SP, #-16]! 	// push X0, X1, to the stack then decrease SP by 16
  ldp X0, X1, [SP], #16 	// pop stack entry into X0, X1 then increase SP by 16
  
*/
