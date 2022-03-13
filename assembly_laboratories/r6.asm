; 6. Se sa citeasca un sir de cifre a. Sa se salveze in sirul b doar cifrele pare. Sa se afiseze sirul b pe ecran.

assume cs:code,ds:data
data segment

a db 20, ?, 20 dup (?)
la db 0
b db 21 dup(?)
doi db 2
zece dw 10
linie db 10, 13, '$'
copie dw 0

data ends
code segment


af proc
    mov cx, 0
    cifre:
        mov dx, 0
        div zece
        push dx
        inc cx
        cmp ax, 0
    JNE cifre
    
    parc:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop parc

ret
af endp

incepe:
mov ax,data
mov ds,ax

mov ah, 0ah
mov dx, offset a
int 21h

mov al, byte ptr a[1]
mov la, al
mov ah, 0
mov cx, ax
mov si, 2
mov di, 0

repeta:
    mov al, a[si]
    sub al, '0'
    mov ah, 0
    mov bl, al
    div doi
    cmp ah, 0
    JNE impar
    JE par
    impar:
        jmp next
    par:
        mov b[di], bl
        inc di
    next:
    inc si
loop repeta

mov cx, di
mov si, 0
parcurgere:
    mov copie, cx
    mov al, b[si]
    mov ah, 0
    call af
    inc si
    mov ah, 09h
    mov dx, offset linie
    int 21h
    mov cx, copie
loop parcurgere

mov ax, 4C00h
int 21h
code ends
end incepe



