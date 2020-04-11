;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A7
;name       :Bubble sort
;___________________________________________________________________________

%include "macro.asm"

;__________________________________________________________________________
section .data

  
     nline  dB  10,10

      msg    dB 10,"               ***Assignment 7***",10,10
             dB    "           Find bubble sort of given array ",10,10
             dB    "              sub = Microprocessor ",10,10
            
      msg_len EQU $-msg                                                   ;to have len at run time


  fmsg 		dB 	"         Enter file Name : "
  fmsg_len 	EQU 	$-fmsg

  bmsg 		dB 	"       Bubble sort array :    "
  bmsg_len 	EQU 	$-bmsg

  fname DB "bubble.txt", 0

  errmsg	db	10," Error in opening file   ",10,10
  errmsg_len 	EQU 	$-errmsg

 

;------------------------------------------------------------------------------------------------------
section .bss

 	fhandle  resq 1
	buf      resb 5000

	buf_len   equ  $-buf
	abuf_len resq 1
	array    resb 50

 

 

;------------------------------------------------------------------------------------------------------
section .txt

global _start
_start :

 Print msg,msg_len

      Print	   fmsg,  fmsg_len
	Read     fname, 50
	dec      rax				;to remove enter space we hv to dec the rax n then put 0 value
	mov	byte[fname+rax],0

	Fopen	fname
	CMP	rax,	-1
	JE	error
	mov	[fhandle],	rax


 Fread [fhandle], buf, buf_len               ; Read the contents of file, RAX contains actual len of file
 dec rax                                   ; fname = file_name
 mov [abuf_len], rax   
 call buf_array

 call B_sort
 Fwrite [fhandle],bmsg,bmsg_len
 inc rbp
 Fwrite [fhandle],array,rbp

 Print array,rbp

Fclose [fhandle]                  ; Close file
Exit

 
error :	Print		errmsg,  errmsg_len
Exit

;--------------------------------------------------------------

buf_array:                          ;here 2 ->one is digit n other for enter

xor rbp, rbp
mov rcx, [abuf_len]

mov rsi, buf
mov rdi, array


back:

mov al, [rsi]
mov [rdi], al

inc rbp
inc rsi
inc rsi
inc rdi

dec rcx
dec rcx
JNZ back

 
RET

;--------------------------------------------------------------
B_sort:
	xor rcx,rcx
	dec rbp
oloop:
      mov rbx,0
      mov rsi,array

iloop:
	mov rdi,rsi
      inc rdi                       ; a[j+1]

      mov al,[rsi]
      cmp al,[rdi]
      jbe next

      mov dl,[rdi]
      mov [rdi],al
      mov [rsi],dl
next:
 	inc rsi
      inc rbx
      cmp rbx,rbp
	JB  iloop

	inc rcx
	cmp rcx,rbp
	Jb  oloop
RET
;......................................................................
