//
// basic logical operators in asm
//

.global _start
.align 2


_start:
  mov X1, #0x42 // #66
  mov X2, #0x26 // #38

  // this should output 2 (in the exit code) in dec
  // and X0, X1, X2 	// now for some reason, the and operator can't use a register and direct value
			// i.e and X0, X1, #0x26 ( it didnt work) and you have to put the value
			// into another register first

  // this should output 102 (in the exit code) in dec
  // orr X0, X1, X2  

  // this should output 100 (in the exit code) in dec
  // eor X0, X1, X2

  // this is negation operator, move and negate the B (X1) value into A (X0)
  // this should output 189 in dec (in the exit code)
  mvn X0, X1

  b _terminate



_terminate:
 // mov X0, #69
 // we're gonna use whatever left in X0 as our return code
 mov X16, #1
 svc #0


