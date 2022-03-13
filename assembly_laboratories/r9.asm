;13. Se citesc de la tastatura doua cuvinte A si B. Sa se calculeze si sa se afiseze cuvantul pe ecran cuvantul C astfel:
;- bitii 0-3 ai lui C coincid cu bitii 4-7 ai lui A
;- bitii 4-7 ai lui C coincid cu bitii 1-4 ai lui B
;- bitii 8-10 ai lui C sunt 0
;- bitii 11-15 ai lui C coincid cu bitii 7-11 ai lui B
;Exemplu:
;A = 12487
;B = 35147
;C = 36956


assume cs:code,ds:data
data segment

sA db 6, ?, 6 dup(?)
sB db 6, ?, 6 dup(?)
la db ?
lb db ?
A dw 0
B dw 0
C dw 0
doi dw 2
linie db 10, 13, '$'
zece dw 10

data ends
code segment


sppp proc
    mov ah, 09h
    mov dx, offset linie
    int 21h 
ret
sppp endp

af2 proc
    mov cx, 0
    cif:
        mov dx, 0
        idiv doi
        push dx
        inc cx
        cmp ax, 0
    jne cif
    
    afff:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop afff
ret
af2 endp

incepe:
mov ax,data
mov ds,ax

mov ah, 0ah
mov dx, offset sA
int 21h 
mov al, byte ptr sA[1]
mov la, al

call sppp

mov ah, 0ah
mov dx, offset sB
int 21h 

mov al, byte ptr sB[1]
mov lb, al
call sppp

mov al, la
mov ah, 0
mov cx, ax
mov ax, 0
mov si, 2

formA:
    mul zece
    mov bl, byte ptr sA[si]
    sub bl, '0'
    mov bh, 0
    add ax, bx
    inc si
loop formA
mov A, ax

mov al, lb
mov ah, 0
mov cx, ax
mov ax, 0
mov si, 2

formB:
    mul zece
    mov bl, byte ptr sB[si]
    sub bl, '0'
    mov bh, 0
    add ax, bx
    inc si
loop formB
mov B, ax

mov ax, A
shr ax, 4
and ax, 0000000000001111b
mov C, ax
mov ax, B
shl ax, 3
and ax, 0000000011110000b
or C, ax
mov ax, B
shl ax, 4
and ax, 1111100000000000b
or C, ax
mov ax, C
call af2

mov ax, 4C00h
int 21h
code ends
end incepe



