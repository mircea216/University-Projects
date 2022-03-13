;14. Se citesc de la tastatura doua cuvinte A si B. Sa se calculeze si sa se afiseze cuvantul pe ecran cuvantul C astfel:
;- bitii 0-3 ai lui C coincid cu bitii 6-9 ai lui A
;- bitii 4-6 ai lui C au valoarea 1
;- bitii 7-10 ai lui C coincid cu bitii 0-3 ai lui A
;- bitii 11-15 ai lui C coincid cu bitii 3-7 ai lui B
;Exemplu:
;A = 42590
;B = 15955
;C = 22393

assume cs:code,ds:data
data segment
sirA db 6, ?, 6 dup(?)
la db ?
sirB db 6, ?, 6 dup(?)
lb db ?
A dw 0
B dw 0
zece dw 10
linie db 10, 13, '$'
C dw 0
doi dw 2

data ends
code segment

af proc
    mov cx, 0
    cf:
        mov dx, 0
        div doi
        push dx
        inc cx
        cmp ax, 0
        jne cf
        
    afis:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop afis
ret
af endp

incepe:
mov ax,data
mov ds,ax
    
mov ah, 0ah
mov dx, offset sirA
int 21h

mov ah, 09h
mov dx, offset linie
int 21h

mov al, byte ptr sirA[1]
mov la, al

mov ah, 0ah
mov dx, offset sirB
int 21h

mov ah, 09h
mov dx, offset linie
int 21h

mov al, byte ptr sirB[1]
mov lb, al

mov al, la
mov ah, 0
mov cx, ax
mov si, 2
mov ax, 0
formareA:
        mul zece
        mov bl, byte ptr sirA[si]
        sub bl, '0'
        mov bh, 0
        add ax, bx
        inc si
loop formareA
mov A, ax

mov al, lb
mov ah, 0
mov cx, ax
mov si, 2
mov ax, 0

formareB:
        mul zece
        mov bl, byte ptr sirB[si]
        sub bl, '0'
        mov bh, 0
        add ax, bx
        inc si
loop formareB
mov B, ax


mov ax, A
mov cl, 6
shr ax, cl
and ax, 0000000000001111b
mov C, ax
or C,   0000000001110000b
mov ax, A
mov cl, 7
shl ax, cl
and ax, 0000011110000000b
or C, ax
mov ax, B
mov cl, 8
shl ax, cl
and ax, 1111110000000000b
or C, ax

mov ax, C
call af

mov ax, 4C00h
int 21h
code ends
end incepe



