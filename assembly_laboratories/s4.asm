; 7. Dându-se un sir de octeti, sa se obtina în AX suma numerelor întregi cuprinse între bitii 4-6 ai celor octetilor octeti.

assume cs:code,ds:data
data segment

s db 00010111b, 01111111b, 01010111b
ls equ $-s
suma dw 0
doi dw 2
data ends
code segment

af2 proc
    mov cx, 0
    cif:
       mov dx, 0
       div doi
       push dx
       inc cx
       cmp ax, 0
    jne cif
afcf:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
loop afcf
ret
af2 endp


incepe:
mov ax,data
mov ds,ax

mov cx, ls
mov si, 0
mov ax, 0
repeta:
    mov bl, byte ptr s[si]
    shr bl, 4
    and bl, 00000111b
    mov dl, bl
    mov dh, 0
    add ax, dx
    inc si
loop repeta

call af2

mov ax, 4C00h
int 21h
code ends
end incepe