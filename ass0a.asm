
;name       :dipti
;roll_no    :241
;assignment :A0
;___________________________________________________________________________
section .data
	
	msg dB "*** Hello World ***",10
	    dB "*** Hello World ***",10
            dB "*** Hello World ***",10
            dB "*** Hello World ***",10,10
  
        
            
        msg_len EQU $-msg             ;to have len at run time

          msg1 dB "***  pccoe ***",10

          msg1_len EQU $-msg1             ;to have len at run time
;___________________________________________________________________________

section .txt

global _start
_start:
	mov rax,1		;to print on screen
	mov rdi,1		;srceen/ stdin
	mov rsi,msg		;starting address
	mov rdx,msg_len	        ;length
	syscall			;to execute

       mov rax,1		;to print on screen
	mov rdi,1		;srceen/ stdin
	mov rsi,msg1		;starting address
	mov rdx,msg1_len	        ;length
	syscall			;to execute


       mov rax,60		;it is related to exit(0);
       mov rdi,0		;0 in exit
       syscall
;___________________________________________________________________________

