
%macro Print 2

mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall

%endmacro
;_________________________________
%macro Read 2

mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall

%endmacro
;__________________________________
%macro Exit 0
 Print nline,2 
mov rax,60
mov rdi,0
syscall

%endmacro
;__________________________________
%macro fopen 1

mov rax,2		;2=open fun number
mov rdi,%1		;filename
mov rsi,2		;mode=r/w
mov rdx,0777o	;octal
syscall

%endmacro
;___________________________________
%macro fclose 1

mov rax,3		;3=close fun number
mov rdi,%1		;filename
syscall

%endmacro
;___________________________________
%macro fread 3

mov rax,0
mov rdi,%1		;filename
mov rsi,%2		;1 st parameter
mov rdx,%3		;2nd paremeter
syscall

%endmacro


