
;name       :dipti
;roll_no    :241
;assignment :A0
;___________________________________________________________________________

	%macro Print 2		; %macro  macroname parameters
       
        mov rax,1		;to print on screen
	mov rdi,1		;srceen/ stdin
	mov rsi,%1		;starting address-----1st parameter
	mov rdx,%2              ;length--------2nd parameter
	syscall			;to execute

    
        %endmacro
        
        %macro Exit 0
        mov rax,60		;it is related to exit(0);
        mov rdi,0		;0 in exit
        syscall
       
       %endmacro
;____________________________________________________________________________
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
	
         Print msg,msg_len                  ;call to macros syntax=macroname para1,para2,--
         Print msg1,msg1_len

         Exit
      

      
;___________________________________________________________________________

