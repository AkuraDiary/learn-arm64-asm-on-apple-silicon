//
// learn how to handle the user input in asm
// from this point I'm using trial and error methods while looking in the documentation
//

.data

.balign 4
 msg: .ds 16 			// input memory buffer for keyboard input

.balign 4
 input_msg: .asciz "Input Value : "

.balign 4
 output_msg: .asciz "Your Input : "


.text
.global _start
.align 4

_start:
 
  adrp X1, input_msg@page
  add X1, X1, input_msg@pageoff

  bl _sizeof
  bl _print

  mov X2, #16
  bl _read
  
  adrp X1, output_msg@page
  add X1, X1, output_msg@pageoff

  bl _sizeof
  bl _print
  
  adrp X1, msg@page
  add X1, X1, msg@pageoff
  
  bl _sizeof
  bl _print

  b _terminate 
 
/*
 _read:
 taking input from the terminal
 
 @ params
 X2 : lentgth of the input buffer

 @ usage example
 mov X2, #4
 bl _read_user_input

*/

_read:

  //  str LR, [SP, #-16]! 		// push the latest value of link register into the stack
  mov X0, #0 			// call to stdin

  Lloh0:adrp X1, msg@page
  Lloh1:add X1, X1, msg@pageoff
  
  .loh AdrpAdd Lloh0, Lloh1	// optimization things i havent understand

  mov X16, #3			// system read
  svc #0

  // we don't need this yet
  //  ldr LR, [SP, #-16]		// pop back the link register from the sta
  
  ret


/*
 print string into stdout

 @ params
 X1 : address or the string to be printed
 X2 :  len of the string

*/

_print:
 // str LR, [SP, #-16]!
 
 mov X0, #1 			// call to stdout
 mov X16, #4			// write to stdout 
 svc #0

 // ldr LR, [SP, #-16]!
 ret


/*
 _sizeof
 get the size of printed string
 
 @params
 X1 = address of the string, 
 X2 = out length, 
 
*/

_sizeof:        
  // str LR, [SP, #-16]!     	//Store registers

  mov X2, #0
  __loop:
             
    ldrb W0, [X1, X2]       	//load a byte into W0 (32 bit)
    add X2, X2, #1     		//Add 1 offset  
    cmp W0, #0          	//Compare byte with null value return
    b.ne __loop

  // ldr LR, [SP], #16         	//Load registers

  ret

_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0

