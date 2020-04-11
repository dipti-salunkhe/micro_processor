;Asg no. 	:	10
;Asg Name	: 	Write 80387 ALP to find the roots of the quadratic equation. 
;			All the possible cases must be considered in calculating the roots.
;--------------------------------------------------------------- 
%macro Print 2
	mov	rax,1		;print
	mov	rdi,1		;stdout/screen
	mov	rsi,%1	;msg
	mov	rdx,%2	;msg_len
	syscall
%endmacro

%macro Exit 0
	mov	rax,60	;exit
	mov	rdi,0
	syscall
%endmacro
;--------------------------------------------------------------- 
section .data	
	a 		dq 	1.0
	b 		dq 	2.0
	c 		dq 	1.0
	integer4 	dw 	4

	infmt 	db 	10,"a = %f",10,"b = %f",10,"c = %f",10,0
	outfmt 	db 	10,"Root 1 = %f",10,10,"Root 2 = %f",10,0

	imsg 		db	10,10,"Roots are Imaginary...",10,10
	imsg_len 	equ 	$-imsg
;--------------------------------------------------------------- 
section .bss
	sqrtdelta 	resq 1
	negb		resq 1
	root1		resq 1
	root2		resq 1
;--------------------------------------------------------------- 
global main
extern printf

section .text
main:
	push rbp
	finit				;Initialize 80387

				;a=,b=,c=
	mov 	rdi,infmt
	movq 	xmm0,[a]
	movq 	xmm1,[b]
	movq 	xmm2,[c]
	mov 	rax,3
	call 	printf
		
				; sqrt(b2 - 4ac)
	fld 	qword[b]		;Load b
	fmul 	qword[b]		;b square
	fld 	qword[a]		;Load a
	fmul 	qword[c]		;Calculate ac
	fimul word[integer4]	;Calculate 4ac
	fsub				;Delta (b_square - 4ac)
	fsqrt				;Square root of delta
	fst 	qword[sqrtdelta]	;Store in memory for future use

	FTST			; check st0 & 0
	FSTSW	ax			; Stores the coprocessor status word into AX register. 
					; FPU condition codes C3, c2, c0
	SAHF				; Stores the AH register into the FLAGS register. 
					; Loads the SF, ZF, AF, PF, and CF flags of the EFLAGS register
					; with values from the corresponding bits in the AH register 
					; (bits 7, 6, 4, 2, and 0, respectively). 

	JNC 	roots
imag:	Print	imsg, imsg_len
	jmp 	exit


roots:				;-b for roots
	fldz				;Load zero
	fsub 	qword[b]		;-b
	fst 	qword[negb]		;Store -b in memory for future use

				;1st root
	fadd				;-b + square root of delta
	fld 	qword[a]		;Load a
	fadd 	qword[a]		;Calcuate 2a
	fdiv				;Divide [-b + square root of delta] / 2a
	fstp 	qword[root1]	;Store root 1

				;2nd root
	fld 	qword[negb]		;Load -b
	fsub 	qword[sqrtdelta]	; -b - sq. root of delta
	fld 	qword[a]		;Load a
	fadd 	qword[a]		;Calcuate 2a
	fdiv				;Divide [-b + sq. root of delta]/2a
	fstp 	qword[root2]	;Store root 2

				;Display roots
	mov 	rdi,outfmt
	movq 	xmm0,[root1]
	movq 	xmm1,[root2]
	mov 	rax,2
	call 	printf
	
exit:	pop 	rbp
	Exit
