

assume cs:code,ds:data
data segment


s dw -22, 145, -48, 127
ls equ ($-s)/2
d db ls dup(?)
copie dw 0
numar dw 0
saispe db 16
zece dw 10
linie db 10, 13, '$'

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

mov cx, ls
mov si, 0
mov di, 0

repeta:
    mov ax, word ptr s[si]
    mov numar, ax
    mov bl, 0
    biti:  
        shl ax, 1
        adc bl, 0
        cmp ax, 0
    JNE biti
    mov ax, numar
    cmp ax, 0
    JGE pozitiv
    JL negativ
    negativ:
        mov dl, saispe
        sub dl, bl
        mov d[di], byte ptr dl
        inc di
        jmp next
    pozitiv:    
        mov d[di], byte ptr bl
        inc di
    next:
        add si, 2
loop repeta

mov si, 0
mov cx, ls
afs:
    mov copie, cx
    mov al, byte ptr d[si]
    mov ah, 0
    call af
    mov ah, 09h
    mov dx, offset linie
    int 21h
    inc si
    mov cx, copie
loop afs
mov ax, 4C00h
int 21h
code ends
end incepe



