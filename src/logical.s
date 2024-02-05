//
// basic logical operators in asm
//

.global _start
.align 2


_start:
  mov X1, #0x42
  mov X2, #0x26

  and X0, X1, X2 	// now for some reason, the and operator can't use a register and direct value
			// i.e and X0, X1, #0x26 ( it didnt work) and you have to put the value
			// into another register first

  

  b _terminate



_terminate:
 // mov X0, #69
 // we're gonna use whatever left in X0 as our return code
 mov X16, #1
 svc #0


