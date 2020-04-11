
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A2
;name       : Block transfer with non_overload
;___________________________________________________________________________

	%macro Print 2		; %macro  macroname parameters
       
      mov rax,1		      ;to print on screen
	mov rdi,1		      ;srceen/ stdin
	mov rsi,%1		      ;starting address-----1st parameter
	mov rdx,%2              ;length--------2nd parameter
	syscall			;to execute

     %endmacro
  
     
    %macro Exit 0

        Print nline,2 

        mov rax,60		;it is related to exit(0);
        mov rdi,0		      ;0 in exit
        syscall
       
       %endmacro

;____________________________________________________________________________
section .data


	nline  dB  10,10


	msg    dB "               ***Assignment 2***",10,10
             dB "          Block transfer with non_overload ",10,10
             dB "              sub = Microprocessor ",10,10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time


      bmsg1   dB    10,"          Block Before transfer          "
      bmsg1_len EQU $-bmsg1   

      Nmsg1   dB    10,"           Block after transfer           "
      Nmsg1_len EQU $-Nmsg1

      smsg    dB    10,"            source block          :"
      smsg_len EQU $-smsg
     
      dmsg    dB    10,"            desti  block          :",10,10
      dmsg_len EQU $-dmsg  
;______________________________________________________________________________________________________________

 section .bss

    char_ans resB  16
;______________________________________________________________________________________________________________

section .txt

global _start
_start:
	
         Print msg,msg_len                      ;call to macros syntax=macroname para1,para2,--
  	

        Print bmsg1,bmsg1_len        
        Print smsg,smsg_len 
        Print dmsg,dmsg_len 


        Print Nmsg1,Nmsg1_len
        Print smsg,smsg_len 
        Print dmsg,dmsg_len 


         

         Exit     
;___________________________________________________________________________







