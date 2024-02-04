//
// better understanding for the ldr and str instruction
//

.global _start
.align 2

_start:

  b _terminate

_terminate:
 mov X0, #0
 mov X16, #1
 svc 0

