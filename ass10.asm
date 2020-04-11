;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A10
;name       : Find Mean,variance,std deviation
;__________________________________________________________________

           extern printf		;inbuilt function
;__________________________________________________________________


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

;___________________________________________________________________________

section .data

     nline  dB  10,10

      msg    dB 10,"               ***Assignment 10***",10,10
             dB    "          Find Mean,variance,std deviation ",10,10
             dB    "              sub = Microprocessor ",10,10
            
      msg_len EQU $-msg                 ;to have len at run time

   

     array    dq     11.11,22.22,33.33,44.44,55.55
     count    dw    5
     istring  db     "	  Array is :    ",10,"	%e",10,"	%e",10,"	%e",10,"	%e",10,"	%e",10,10,0
     ostring  db     "	mean=%e",10, "	var =%e",10,"	sd  =%e",10,0         ;terminate with 0
;______________________________________________________________________________________________

section .bss

  mean       resq        1
  var        resq        1
  sd		 resq		 1				

;__________________________________________________________________________________________________
section .txt

global  main				  ;we r using 80387
main:     
          push rbp                             ;main is used

	  Print msg,msg_len

    mov  rdi,istring
    movq  xmm0,[array]			;in 80387 specifies size and name of register
    movq  xmm1,[array+8]    
    movq  xmm2,[array+16]    
    movq  xmm3,[array+24] 
    movq  xmm4,[array+32]
       mov  rax,5			;mov input
   call printf

              ;-------------mean----------------------------

   finit				;initialize coprocessor
   fldz				;make top of stack 0
  mov rbx,array
  xor rsi,rsi
  xor rcx,rcx
  mov cx,[count]

back: fadd qword[rbx+(rsi*8)]       ;indirect add mode
      inc  rsi
      loop back
   
   fidiv word[count]			;div all sum byy count
   fstp  qword[mean]			;store mean at top n pop


            ;-----------variance and sd----------------------

  mov rbx,array
  xor rsi,rsi
  xor rcx,rcx
  mov cx,[count]   
  fldz				   ;initialize 1st top with 0  (for add)
back2: fldz				   ;again top =0 so result store will add to zero n top before top is pop (for mul)
       fld  qword[rbx+(rsi*8)]	;point to starting 1st element
       fsub qword[mean]
	 fst  st1
       fmul
       fadd
       inc rsi
       loop back2

   fidiv word[count]			;div all sum byy count
   fst  qword[var]			;DONT pop

  fsqrt
  fstp  qword[sd]

      ;-------------------------------------------




   mov rdi,ostring
   mov rax,3
    movq  xmm0,[mean]    
    movq  xmm1,[var]    
    movq  xmm2,[sd]
    call printf

   pop  rbp
     Exit     
;___________________________________________________________________________


