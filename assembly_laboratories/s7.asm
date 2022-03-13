; sa se roteasca 

assume cs:code,ds:data
data segment

sa db 16, ?, 16 dup(?)
la db ?
A dw 0
B db 10001000b
linie db 10, 13, '$'
doi dw 2
rez dw 0

data ends
code segment


incepe:
mov ax,data
mov ds,ax

mov ah, 0ah
mov dx, offset sa
int 21h

mov al, byte ptr sa[1]
mov la, al

mov ah, 09h
mov dx, offset linie
int 21h

mov ax, 0
mov si, 2
mov cl, la
mov ch, 0
formA:
    mul doi
    mov bl, byte ptr sa[si]
    sub bl, '0'
    mov bh, 0
    mov dx, bx
    add ax, dx
    inc si
loop formA
mov A, ax

mov al, B
mov bl, al
shr bl, 5
and bl, 00000111b
mov cl, byte ptr bl
mov ax, A
rol ax, cl 
mov rez, ax
mov ax, 4C00h
int 21h
code ends
end incepe