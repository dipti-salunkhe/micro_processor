;name       : Dipti Sanjay Salunkhe.
;roll_no    : 241
;assignment : A5
;name       : Far and near concept
;___________________________________________________________________________
          global buf,abuf_len,char
          extern far_pro


       %include "macro1.asm"		;to open another file in this program
 ;__________________________________________________________________________  
section .data

     nline  dB  10,10
    
      msg    dB 10,"               ***Assignment 5***",10,10
             dB    "               Far and near concept ",10,10
             dB    "              sub = Microprocessor ",10
            
      msg_len EQU $-msg           
      
      fmsg     dB 10,"		Enter file name :"               
	fmsg_len EQU $-fmsg 

      errmsg     dB 10,"		Errr in opening file...",10
                
	 errmsg_len EQU $-errmsg 
  
      cmsg     dB   10,"         Enter the char u wnt to find  :"
        cmsg_len  equ  $-cmsg
;___________________________________________________________________________

section .bss
  fname      resb   50        ;accept file name and name lemn
  fhandle    resQ   1		;ptr to file
  buf        resb   100		;having characetrs
  buf_len    equ    $-buf	;to find actual len of file
  abuf_len   resq   1 		;q is taken as rax 64 is taken
  char       resb   2
;___________________________________________________________________________
section .txt
global _start
_start:
	
          Print msg,msg_len 
                  
          Print fmsg,fmsg_len
          Read  fname ,50
          dec   rax
	    mov   byte[fname+rax],0 


   fopen fname				      ;open file
   CMP   rax,-1			            ;compare char in file if -1 terminate else conti
   JS   err
   mov   [fhandle],rax		            ;mov all data into file from reg rax

   fread [fhandle],buf,buf_len		;fread macro has 3 parameters
   mov [abuf_len],rax

   Print cmsg,cmsg_len
   Read  char,2
   call far_pro                             
 
  fclose [fhandle]
Exit
 

err : Print errmsg,errmsg_len


    

     Exit     
;___________________________________________________________________________

