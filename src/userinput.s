//
// learn how to handle the user input in asm
// from this point I'm using trial and error methods while looking in the documentation
//

.data

.balign 4
 msg: .ds 16 			// input memory buffer for keyboard input
				// we're actually gonna use this field
 				// to store our input from terminal

.balign 4
 input_msg: .asciz "Input Value : "

.balign 4
 output_msg: .asciz "Your Input : "


.text
.global _start
.align 4

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
 
/*
 @Documentation

 _read:
 taking input from the terminal
 
 @params
 X2 : lentgth of the input string

 @usage example
 mov X2, #4
 bl _read_user_input

 @explanation
 now like the stdout that will print the value from the X1 register
 stdin will save the value into X1, but in order to use it,
 we have to store it into the .data section
 in this case msg label, which has the buffer size of 16 
*/

_read:

  mov X0, #0 			// call to stdin

  Lloh0:adrp X1, msg@page	// here we're addressing the msg label in the data section
  Lloh1:add X1, X1, msg@pageoff // into the X1 register, to hold our inputs
  
  .loh AdrpAdd Lloh0, Lloh1	// optimization things i havent understand

  mov X16, #3			// call to stdin
  svc #0			// syscall
 
  ret


/*
 print string into stdout

 @ params
 X1 : address or the string to be printed
 X2 : len of the string

*/

_print:
 
 mov X0, #1 			// call to stdout
 mov X16, #4			// write to stdout 
 svc #0

 ret


/*
 _sizeof
 get the size of printed string
 
 @params
 X1 = address of the string, 
 X2 = out length, 
 
*/

_sizeof:        

  mov X2, #0
  __loop:
             
    ldrb W0, [X1, X2]       	//load a byte into W0 (32 bit)
    add X2, X2, #1     		//Add 1 offset  
    cmp W0, #0          	//Compare byte with null value return
    b.ne __loop

  ret

_terminate:
  // we'll use whatever left in X0 as our exit code
  mov X16, #1
  svc #0

