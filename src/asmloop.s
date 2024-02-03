//
// here we have
// - a print function in asm
//
//

.global _start
.align 2		// align the current location counter to the next 2^2 byte boundary

_start:
  adr x1, message	// address the string message into x1 register
  b _print		// call the print function
  
  b _terminate

_print:
  // Parameters
  // x1 : the string to be printed
  // x2 : the len of the string

  mov X0, #1 		// stdout  
  ldr x2, =message_len	// address the message_len into the x2 register
  mov X16, #4		// write to stdout
  svc 0			// syscall

_terminate:
  mov X0, #0 	// return 0
  mov X16, #1	// terminate
  svc 0		// syscal

message: .asciz "hellow world \n"
message_len= .-message


