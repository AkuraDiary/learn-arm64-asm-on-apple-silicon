//
// basic of the ldr and str instruction
//

.global _start
.align 4

/*
  .text segment contains the actual code
  that will be executed
*/

/*
  now that we have some data stored in the .data section, we can use in our operation
  unfortunately, we can't use the regular mov operation to do so

  mov X1, var1  // if you use it like that, it won't compile
  becuase arm is using load and store architecture

  so instead we're gonna be using the ldr and str operation  
*/ 
	
.text

_start:

  adrp X1, ayam@PAGE 			// this is going to to put the memory location of the ayam label
  add X1, X1, ayam@PAGEOFF		// and not actually putting the value 5 into the register itself

  //adr X2, ayam
  //ldr X1, [X3]  	// now we're actually loading the value of ayam into the X1 register
			// by dereferencing it ayam's addres that's loaded in X1
  			// using ldr with [] loads the actual value similiar to dereferencing a pointer
   
  mov X0, #1
  mov X2, #10
  mov X16, #4
  svc #0

  mov X0, #69
  mov X16, #1
  svc #0


/*
 this is the data section
 where you put a complex data that's not gonna stored
 directly into the register
*/ 

.data			// now for some reason, i can't get the program running correctly if i'm using section  

ayam: 
  .asciz "ayam" 		// we declare a label called ayam with type of .word with the value of 5

//bebek: .asciz "bebek"


/*
  nb:  to understand what the data types you can work on with assembly, go read the documentation
  right now, the .word means group of 16 bits (2 Bytes)

  im using the X1 as my first GPR (general purpose register) because in this particular machine
  the X0 is preserved for the special register

  nb, if you're seeing @PAGE in this code, i get it from :
  https://stackoverflow.com/questions/65351533/apple-clang12-llvm-unknown-aarch64-fixup-kind

*/

