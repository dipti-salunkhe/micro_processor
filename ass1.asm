
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A1
;name       : count positive and negative numbers from array
;___________________________________________________________________________

	%macro Print 2		; %macro  macroname parameters
       
        mov rax,1		      ;to print on screen
	mov rdi,1		      ;srceen/ stdin
	mov rsi,%1		      ;starting address-----1st parameter
	mov rdx,%2              ;length--------2nd parameter
	syscall			;to execute

    
        %endmacro
        
        %macro Exit 0
        mov rax,60		;it is related to exit(0);
        mov rdi,0		      ;0 in exit
        syscall
       
       %endmacro
;____________________________________________________________________________
section .data


	nline  dB  10,10


	msg    dB "               ***Assignment 1***",10,10
             dB "       count positive and negative numbers in array ",10,10
             dB "              sub = Microprocessor ",10,10,10
            
          msg_len EQU $-msg                                                                             ;to have len at run time

     Pmsg1 dB    10,"               positive numbers are    : "

           Pmsg1_len EQU $-Pmsg1   

     Nmsg1 dB    10,"               negative numbers are    : "

           Nmsg1_len EQU $-Nmsg1

     array64   DQ  11H,22H,33H,44H,55H, 11H,22H,33H,44H,55H, -11H,22H,33H,-44H,55H, -11H,22H,33H,-44H,55H 
           
     count  EQU 20                                                                                       ;constant                     
;______________________________________________________________________________________________________________

 section .bss

   Pcount  resQ  1             ;here all are uninitialize so no D but res   and 1=size

   Ncount  resQ  1 

   char_ans resB  16
;______________________________________________________________________________________________________________

section .txt

global _start
_start:
	
         Print msg,msg_len                      ;call to macros syntax=macroname para1,para2,--
  

    

		mov	rsi,array64				;starting address of array in RSI
		mov	rcx,count				;RCX=counter register

		mov	rbx,0					;RBX= counter reg of +no
		mov	rdx,0					;RDX=counter reg of -no
      
   Back :	mov   rax,[rsi]				;value at RSI stired at reg RAX				;
	      SHL	rax,1					;shiftleft will done and carrybit will check 0=-, 1=+
	      JC	negative				;if carry=0  jump to -
	      inc	rbx					;
	      jmp	next

negative:   inc  rdx

 next   :  add  rsi,8
	     dec  rcx
	     jnz  Back

	    mov  [Pcount],rbx
	    mov  [Ncount],rdx	


         Print Pmsg1,Pmsg1_len
         mov rax,[Pcount]
         call display_16


         Print Nmsg1,Nmsg1_len
         mov rax,[Ncount]
         call display_16

        Print nline,2  

         Exit     
;___________________________________________________________________________

display_16:
	mov rsi,char_ans+1				;
	mov rcx,2
	mov rbx,10

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







