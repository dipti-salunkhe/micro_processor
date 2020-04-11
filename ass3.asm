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

    menu     dB 10,  " MENU :",10
             dB	   "     1] HEX to BCD",10
		 dB      "     2] BCD to HEX",10
		 dB      "     3] EXIT      ",10,10
		 dB      " Enter your choice   :"  
       
     menu_len EQU $-menu

     hmsg		dB  "  	Enter 4 digit hex number    : "
	 hmsg_len EQU $-hmsg 

     bmsg		dB  "  	Enter 5 digit BCD number    :   "
 	 bmsg_len EQU $-bmsg 
   
     ehmsg		dB  " 	Equivalante Hex number is   :"
	 ehmsg_len EQU $-ehmsg 

     ebmsg		dB " 	      Equivalente BCD number is   :"
	 ebmsg_len EQU $-ebmsg 

     exitmsg	dB "		Exit from program...",10
	 exitmsg_len EQU $-exitmsg 

     errmsg		dB "		Invalid choice",10,10
	 errmsg_len EQU $-errmsg 




;______________________________________________________________________________________________

section .bss

  buf		resb		6				;this has taken to has memory for choice and enter |1/2|->| so size is 2

  char_ans   resb        16

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
	call Accept_4
      mov rax,rbx

	      xor	rbp,rbp			; dig counter
		mov	rbx,10
		
back2:	xor	rdx,rdx           	;initialize
		DIV	RBX				; (rdx:rax)/rbx = rdx:R ,, rax:Q
		
		push 	dx				;we need to push remainder to get each digit of decimal
		inc	rbp	
		cmp	rax,0		    	      ; compare q=0
		jnz	back2
		
		Print	ebmsg,ebmsg_len
		
back3:	pop	dx				;pop remainder and convert it into decimal
		add	dl,30H
		mov	[char_ans],dl
		Print	char_ans,1
		
		dec	rbp
		jnz	back3
RET


    

 
;______________________________________________________________________________

BCD_HEX :
 
     Print bmsg,bmsg_len
     Read  buf,6				;5+1 enter
     xor rcx,rcx
     xor  rax,rax

     mov rbx,10
     mov  rbp,5
     mov rsi,buf

back4: mul rbx
       mov  cl,[rsi]
       sub  cl,30h

      add  rax,rcx

   inc rsi
   dec rbp
   jnz  back4

  mov rbp,rax


     Print ehmsg,ehmsg_len

    mov rax,rbp
  call display_4


 RET
;_________________________________________________________________________________  

Accept_4:

    Read buf,5		;5= 4+enter
    mov rcx,4			;count 4
    mov rsi,buf             ;initialize buf

    xor rbx,rbx			;ini rbx=0
    xor rax,rax

back:  SHL bx,4		;shift 4 bits

       mov al,[rsi]	;copy value from rsi to al


      cmp al,'0'			;see and compare value with o - 9
      JB err
      cmp al,'9'
      JBE sub30

      cmp al,'A'			;see and compare value with A-S
      JB err
      cmp al,'F'
      JBE sub37

      cmp al,'a'
      JB err
      cmp al,'f'
      JBE sub57


err:  Print errmsg,errmsg_len
      Exit


     sub57: sub al,20h			;ALL sub r for convert it to ascii
     sub37: sub al,07h
     sub30: sub al,30h

     add bx,ax

     inc rsi
     dec rcx
     jnz back


 RET
;_________________________________________________________________________________
display_4:

mov rsi,char_ans+3				;
	mov rcx,4
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


