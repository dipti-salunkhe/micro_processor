;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A9
;name       : Factorial
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

      msg    dB 10,"               ***Assignment 9***",10,10
             dB    "            Factorial of given number ",10,10
             dB    "              sub = Microprocessor ",10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time

   

     emsg		dB  "  	Enter 4 digit number     : "
	emsg_len EQU $-emsg 

     amsg		dB  "  	Factoial of number is    : "
 	amsg_len EQU $-amsg    

     exitmsg	dB "		Exit from program...",10
	 exitmsg_len EQU $-exitmsg 

     errmsg		dB "		Invalid choice",10,10
	 errmsg_len EQU $-errmsg 




;______________________________________________________________________________________________

section .bss

  n1         resq        1
  ans        resq        1
  buf		 resb		 5				
  char_ans   resb        16

;__________________________________________________________________________________________________
section .txt

global _start
_start:
	
          Print msg,msg_len
	    Print emsg,emsg_len 
          call Accept_4
          mov rcx,rbx           ;ans in accept stored in rbx   take it in rcx

          call factorial
          Print amsg,amsg_len
          mov rax,[ans]
          call display_4
                      
	    
  	  

     Exit     
;___________________________________________________________________________
 factorial:

   push rcx
   cmp  rcx,1
   JLE  fact
   dec rcx
   call factorial

fact: cmp  qword[ans],0
      JNE    nxtt
      mov   qword[ans],1
 
nxtt:pop rax               ;pop alla from rcx into rax
     cmp  rax,0
     JNE  fact1
      mov  rax,1
    

fact1:     MUL qword[ans]        ;whtever will be in rax mul it with ans
     mov [ans],rax


RET
;________________________________________________________________________

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

mov rsi,char_ans+15				
	mov rcx,16
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

   Print char_ans,16





RET
;________________________________________________________________________________________________


