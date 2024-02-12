// 
// working with multiple files in asm
// 


.align 4
.global _start

#include "userinput.s"

_start:
  // print the input holder
  adrp X1, input_msg@page
  add X1, X1, input_msg@pageoff

  bl _sizeof
  bl _print

  // actually taking the input
  mov X2, #16
  bl _read
  
  // print the output holder
  adrp X1, output_msg@page
  add X1, X1, output_msg@pageoff

  bl _sizeof
  bl _print

  // printing the input
  adrp X1, msg@page
  add X1, X1, msg@pageoff

  bl _sizeof
  bl _print

  b _terminate
