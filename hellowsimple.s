//
// hellow world
//

.global _start
.align 2

_start:
  
  b _print		// call the print function
  
  b _terminate

_print:
  // Parameters
  // x1 : the string to be printed
  // x2 : the len of the string

  mov X0, #1 		// stdout
  adr x1, message	// address the string message into x1 register
  mov x2, #14		// address the initial len into the x2 register
  mov X16, #4		// write to stdout
  svc 0			// syscall

_terminate:
  mov X0, #0 	// return 0
  mov X16, #1	// terminate
  svc 0		// syscal

// messages data
message: .ascii "hellow world\n" 


