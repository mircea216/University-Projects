
;13. Se citesc de la tastatura doua cuvinte A si B. Sa se calculeze si sa se afiseze cuvantul pe ecran cuvantul C astfel:
;- bitii 0-3 ai lui C au valoarea 1101
;- bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
;- bitii 9-12 ai lui C au valoarea 1
;- bitii 13-15 ai lui C coincid cu bitii 7-9 ai lui B
;Exemplu:
;A = 42590
;B = 15955
;C = 40941


assume cs:code,ds:data
data segment

sA db 6, ?, 6 dup(?)
sB db 6, ?, 6 dup(?)
la db ?
lb db ?
linie db 10, 13, '$'
A dw 0
B dw 0
zece dw 10
C dw 0
doi dw 2
saispe dw 16


data ends
code segment

af proc
    mov cx, 0
    cifre:
        mov dx, 0
        div doi
        inc cx
        push dx
        cmp ax, 0
    JNE cifre
    
    afis:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop afis
ret
af endp

af16 proc
    mov cx, 0
    cif:
        mov dx, 0
        div saispe
        push dx
        inc cx
        cmp ax, 0
        JNE cif
        
    aff:
        pop dx
        mov al, dl
        cmp al, 10
        JAE litera
        JB cifra
        litera:
            add al, 55
            mov dl, al
            jmp displayy
        cifra:
            add al, '0'
            mov dl, al
        displayy:
            mov ah, 02h
            int 21h
    loop aff


ret
af16 endp


incepe:
mov ax,data
mov ds,ax

mov ah, 0ah
mov dx, offset sA
int 21h

mov al, byte ptr sA[1]
mov la, al

mov ah, 09h
mov dx, offset linie
int 21h


mov ah, 0ah 
mov dx, offset sB
int 21h

mov al, byte ptr sB[1]
mov lb, al

mov ah, 09h
mov dx, offset linie
int 21h

mov al, la
mov ah, 0
mov cx, ax
mov si, 2
mov ax, 0

repetaA:
    mul zece
    mov bl, byte ptr sA[si]
    sub bl, '0'
    mov bh, 0
    add ax, bx
    inc si
loop repetaA

mov A, ax

mov al, lb
mov ah, 0
mov cx, ax
mov si, 2
mov ax, 0

repetaB:
    mul zece
    mov bl, byte ptr sB[si]
    sub bl, '0'
    mov bh, 0
    add ax, bx
    inc si
loop repetaB

mov B, ax
mov C,  0000000000001101b
mov ax, A
mov cl, 4
shl ax, cl
and ax, 0000000111110000b
or C, ax
or C, 0001111000000000b
mov bx, B
and bx, 0000001110000000b
mov cl, 6
shl bx, cl
or C, bx
mov ax, C
call af
mov ah, 09h
mov dx, offset linie
int 21h
mov ax, C
call af16
mov ax, 246
call af16
mov ax, 4C00h
int 21h
code ends
end incepe



