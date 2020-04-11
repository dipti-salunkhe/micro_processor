
;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A6
;name       :  ABOUT GDTR,LDTR,TR,MSW
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
;_____________________________________________________________________________________________

section .data

     nline  dB  10,10
     colon  dB ":"

      msg    dB 10,"               ***Assignment 6***",10,10
             dB    "              ABOUT GDTR,LDTR,TR,MSW  ",10,10
             dB    "              sub = Microprocessor ",10
            
      msg_len EQU $-msg                                                   ;to have len at run time


     lmsg		dB 10,"  	LDTR is    : "
	 lmsg_len EQU $-lmsg 

    gmsg		dB 10,"  	GDTR is    : "
	 gmsg_len EQU $-gmsg
     
     imsg		dB 10,"  	IDTR is    : "
	 imsg_len EQU $-imsg 

     tmsg		dB 10,"  	TR is      : "
	 tmsg_len EQU $-tmsg 
    
     mswmsg		dB 10,"  	MSW is     : "
	 mswmsg_len EQU $-mswmsg 

    pmsg		dB 10,"  	 Processor is in protected mode!!!    ",10
	 pmsg_len EQU $-pmsg 

    rmsg		dB 10,"  	Processor is in real mode!!!    ",10
	 rmsg_len EQU $-rmsg 

     exitmsg	dB 10,"		Exit from program...",10
	 exitmsg_len EQU $-exitmsg 
;______________________________________________________________________________________________

section .bss

  GDTR resw	3		;GDTR is 48 bit
  IDTR resw	3
  LDTR resw	1
  TR	 resw	1
  MSW	 resw	1

  char_ans   resb        16

;__________________________________________________________________________________________________
section .txt

global _start
_start:
	
          Print msg,msg_len                   
      
         SMSW   BX		;store msw into bx
         BT   BX,0		;check 63 th bit 1/0
	   JC   pmode
	  Print rmsg,rmsg_len
         JMP  next_0

pmode :  Print pmsg,pmsg_len
         JMP next_0

next_0: SGDT  [GDTR]		;storing into memory variable gdtr
	  SIDT  [IDTR]
	  SLDT  [LDTR]
	  STR   [TR]
	  SMSW  [MSW]

     Print lmsg,lmsg_len
     mov  ax,[LDTR]
     call display_4

     Print tmsg,tmsg_len
     mov  ax,[TR]
     call display_4

 
    Print mswmsg,mswmsg_len
    mov  ax,[MSW]
     call display_4  
    
     Print gmsg,gmsg_len			;base : limit
     mov  ax,[GDTR+4]				;ax=ah+al=  |11 22|  33 44 55 66
     call display_4
     mov  ax,[GDTR+2]
     call display_4
     Print colon,1
     mov  ax,[GDTR+0]
     call display_4

      Print imsg,imsg_len
     mov  ax,[IDTR+4]
     call display_4
     mov  ax,[IDTR+2]
     call display_4
     Print colon,1
     mov  ax,[IDTR+0]
     call display_4

     Exit     
;___________________________________________________________________________
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

   Print char_ans,4

RET
;________________________________________________________________________________________________
