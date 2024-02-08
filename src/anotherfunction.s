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

  bl _add_nums		// this is a branch with link instruction that will set the lr register

  			// in this case, since we use X0 as our return value, and we calling
 			// terminate immediately, we should be get 3 as our exit code

  b _terminate	  	// lr will be saving this instruction's address

_add_nums:
  add X0, X0, X1 	// the return value of a function is gonna restored into the X0
  ret 		 	// we're using the ret keyword to exit from the function

_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0



