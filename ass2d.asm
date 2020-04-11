
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A2_d
;name       : Block transfer with overload with string 
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
             dB "          Block transfer with overload with string",10,10
             dB "              sub = Microprocessor ",10,10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time


      bmsg1   dB    10,"          Block Before transfer          "
      bmsg1_len EQU $-bmsg1   

      Nmsg1   dB    10,"           Block after transfer           "
      Nmsg1_len EQU $-Nmsg1

      smsg    dB    10,"            source block          :"
      smsg_len EQU $-smsg
     
      dmsg    dB    10,"            desti  block          :"
      dmsg_len EQU $-dmsg  

      srcblk   dB    11H,22H,33H,44H,55H
      desblk    times 5  dB 0                                            ;5 times if src block initialize by 0
   
      count    EQU   5
     
      space    dB    " "						;can be written as 32  or 20H
;______________________________________________________________________________________________________________

 section .bss

    char_ans resB  16
;______________________________________________________________________________________________________________

section .txt

global _start
_start:
	
         Print msg,msg_len                           ;call to macros syntax=macroname para1,para2,--
  	

        Print bmsg1,bmsg1_len				     ;block before transfer    
    
            Print smsg,smsg_len 			     ;source block
               mov rsi,srcblk
               call display_block

            Print dmsg,dmsg_len 			     ;destination block
               mov rsi,desblk-2				;modification from 2a
               call display_block

        call BT_NO


        Print Nmsg1,Nmsg1_len				     ;block after transfer 

           Print smsg,smsg_len 			     ;source block
                mov rsi,srcblk
                call display_block

           Print dmsg,dmsg_len 			     ;destination block
                mov rsi,desblk-2				;modification from 2a
                call display_block

         

         Exit     
;___________________________________________________________________________

display_2:

  mov rsi,char_ans+1				;
	mov rcx,2
	mov rbx,16

back1:	XOR rdx,rdx
	      DIV rbx

	cmp DL,9
	jbe add_30
	add DL,07H

add_30:	add DL,30H

     mov [rsi],DL
     
	dec rsi
	dec rcx
	jnz back1

   Print char_ans,2


RET
;________________________________________________________________________________________________

display_block:

         mov  rbp,count						;counter 5
back:    mov  al,[rsi]						;value of rsi in al 8 bit
   
         push  rsi                                     ;address backup
        
         call  display_2
         Print space ,1
 
         pop  rsi							;adreess call
       
         inc  rsi
         dec  rbp

         jnz  back
    

  RET 
;________________________________________________________________________________________________

BT_NO:
	     mov rsi,srcblk+4				;modify
           mov rdi,desblk-2+4				;modify
	     mov rcx,count

 
            STD                                            ;modify   ;back_2:  mov al,[rsi]
                                                             ;mov [rdi],al
          REP  MOVSB							       ;inc rsi
	   								       ;inc rdi
	    									 ;dec rcx
	    									 ;jnz back_2
RET







