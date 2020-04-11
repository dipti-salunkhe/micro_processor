   extern buf,abuf_len,char
    global      far_pro
 %include "macro1.asm"	
;_________________________________________________________
section .data


nline  dB  10,10
 cmsg     dB 10,"	     char is occured  :"               
	cmsg_len EQU $-cmsg 

 nmsg     dB 10,"	     New line is occured :"               
	nmsg_len EQU $-nmsg 

 smsg     dB 10,"	     Space is occured :"               
	smsg_len EQU $-smsg 


;______________________________________________

section .bss
  
 ccount   resQ  1
 ncount   resQ  1
 scount   resQ  1
 char_ans   resb   16
;____________________________________________________
   global abc
section .txt
abc :
far_pro:
	
   mov  rsi,buf			;take all contents of file
   mov  rcx,[abuf_len] 		;take len cnt
   mov  BL,[char]             ;take char u want to search in BL

backk:  mov  AL,[rsi]

c1:  CMP AL,' '
     JNE c2
     inc Qword[scount]
     JMP nxt

c2:  CMP AL,10                  ;new line
     JNE c3
     inc Qword[ncount]
     JMP nxt

c3:  CMP AL,BL                   ;char u have taken for search
     JNE nxt
     inc Qword[ccount]
   
nxt: inc rsi
     dec rcx
     JNZ  backk

Print cmsg,cmsg_len
mov  rax,[ccount]
call display_4

Print smsg,smsg_len
mov  rax,[scount]
call display_4

Print nmsg,nmsg_len
mov  rax,[ncount]
call display_4



   

     RET  
;___________________________________________________________________________

display_4:

      mov rsi,char_ans+3				;
	mov rcx,4
	mov rbx,16            		;decimal

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

