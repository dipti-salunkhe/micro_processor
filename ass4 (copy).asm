
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A4
;name       : mul of two 16-bit hex no. Use add and shift method.
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

      msg    dB 10,"               ***Assignment 4***",10,10
             dB    "         MUL USING SHIFT INSTRUCTION  ",10,10
             dB    "              sub = Microprocessor ",10,10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time

    menu     dB	   " MENU :",10
             dB	   "     1] SA",10
		 dB      "     2] SHA",10,10
		 dB      " Enter your choice   :"  
       
     menu_len EQU $-menu

     n1msg		dB "  	Enter 1st number    : ",10,10
	 n1msg_len EQU $-n1msg 

    n2msg		dB "  	Enter 2nd number    : ",10,10
	 n2msg_len EQU $-n2msg 

     rsamsg		dB "  	Equivalante SA no. is   :",10
	 rsamsg_len EQU $-rsamsg 

     rsbmsg		dB " 		 Equivalente SHA no. is   :",10
	 rsbmsg_len EQU $-rsbmsg 

     exitmsg	dB "		Exit from program...",10
	 exitmsg_len EQU $-exitmsg 

     errmsg		dB "		Invalid choice",10,10
	 errmsg_len EQU $-errmsg 




;______________________________________________________________________________________________

section .bss

  buf		resb		5				; 4no +enter
  n1        resw        1				;16 bit
  n2        resw        1

  ansh      resw        1				;SA
  ansl      resw        1

  ans       resd		1					;SHA

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
              call  SA				;if =1 then call to that function
              JMP  MENU					;again move to menu

c2   :	  CMP   al,'2'
		  JNE   EXIT
              call SHA
              JMP  MENU


EXIT:       Print errmsg,errmsg_len
                  Exit



  	  

     Exit     
;___________________________________________________________________________

SA :

      Print  n1msg,n1msg_len
	call   Accept_4
      mov    [n1],bx			;when dest is variable correct type of regester is to be use ...use bx not ebx


      Print  n2msg,n2msg_len
	call   Accept_4
      mov    [n2],bx

      mov  bx,00
	mov  [ansh],bx		;variable cnt directly initialize to 0 ...so 1st ini bx=0 n then these
	mov  [ansl],bx
 
      mov  cx,[n2]
	mov  ax,[n1]

back_10: add  [ansl],ax
      jnc     next
      inc     word[ansh]				;different***************

next: dec cx
      jnz back_10

      Print rsamsg,rsamsg_len

	mov   ax,[ansh]
      call  display_4

      mov   ax,[ansl]
      call  display_4 

 RET
;______________________________________________________________________________

SHA :
 
       

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

display_8:

mov rsi,char_ans+7				;
	mov rcx,8
	mov rbx,16

back_1:	XOR rdx,rdx
	      DIV rbx

	cmp DL,9
	jbe add__30
	add DL,07H

add__30:	add DL,30H

     mov [rsi],DL
     
	dec rsi
	dec rcx
	jnz back_1

   Print char_ans,2





RET
;________________________________________________________________________________________________







