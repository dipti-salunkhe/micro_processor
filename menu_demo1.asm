
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A3
;name       : CONVERT(a) HEX to BCD b) BCD to HEX
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
  
                                   ;here we have declared read macro to accept choice from user

   %macro  Read   2
      mov rax,0				;to read
	mov rdi,0				;to read input from keyboard
	mov rsi,%1				;starting address ... 1st parameter
	mov rdx,%2				;max lenght....2nd parameter
	syscall
  %endmacro

;_____________________________________________________________________________________________

section .data

     nline  dB  10,10

      msg    dB 10,"               ***Assignment 3***",10,10
             dB    "         CONVERT(a) HEX to BCD b) BCD to HEX ",10,10
             dB    "              sub = Microprocessor ",10,10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time

    menu     dB	   " MENU :",10
             dB	   "     1] HEX to BCD",10
		 dB      "     2] BCD to HEX",10
		 dB      "     3] EXIT      ",10,10
		 dB      " Enter your choice   :"  
       
     menu_len EQU $-menu

     hmsg		dB "  	Enter 4 digit hex number    : ",10,10
	 hmsg_len EQU $-hmsg 

     bmsg		dB "  	Enter 5 digit BCD number    :   ",10,10
 	 bmsg_len EQU $-bmsg 
   
     ehmsg		dB "  	Equivalante Hex number is   :",10
	 ehmsg_len EQU $-ehmsg 

     ebmsg		dB " 		 Equivalente BCD number is   :",10
	 ebmsg_len EQU $-ebmsg 

     exitmsg	dB "		Exit from program...",10
	 exitmsg_len EQU $-exitmsg 

     errmsg		dB "		Invalid choice",10,10
	 errmsg_len EQU $-errmsg 




;______________________________________________________________________________________________

section .bss

  buf		resb		2				;this has taken to has memory for choice and enter |1/2|->| so size is 2

  cha_ans   resb        16

;__________________________________________________________________________________________________
section .txt

global _start
_start:
	
          Print msg,msg_len                       ;call to macros syntax=macroname para1,para2,--
MENU :         Print menu,menu_len
               Read   buf,2				  ;2 values in buf array
               mov  al,[buf]				  ;value at buf[0] will stire at AL
   
c1   :        CMP   al,'1'				;here to take choice from user  if 1 then value at AL cmpare to 1
		  JNE   c2					;if not =1 then to net option
              call HEX_BCD				;if =1 then call to that function
              JMP  MENU					;again move to menu

c2   :	  CMP   al,'2'
		  JNE   c3
              call BCD_HEX
              JMP  MENU
c3   :	  CMP   al,'3'
		  JNE   ERROR
              Print exitmsg,exitmsg_len
              Exit

ERROR:       Print errmsg,errmsg_len
             JMP  MENU



  	  

     Exit     
;___________________________________________________________________________

HEX_BCD :

      Print hmsg,hmsg_len

      Print ebmsg,ebmsg_len

 RET
;______________________________________________________________________________

BCD_HEX :
 
     Print bmsg,bmsg_len

     Print ehmsg,ehmsg_len

 RET
;_________________________________________________________________________________  












