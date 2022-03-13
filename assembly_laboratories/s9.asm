; sa se numere vocalele


assume cs:code,ds:data
data segment

a db 'ana e oachesiuAEUOI'
la equ $-a
voc db 'aeiouAEIOU'
lvoc equ $-voc
counter db 0
zece dw 10

data ends
code segment

af proc
    mov cx, 0
    cf:
        mov dx, 0
        div zece
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

mov cx, la
mov si, 0

textp:
    mov al, a[si]
    mov di, 0
    mov dx, lvoc
    vocale:
        mov bl, voc[di]
        cmp bl, al
        JE evoc
        JNE nuevoc
        evoc:
            inc counter
            jmp next
        nuevoc:
            jmp next
        next:
        dec dx
        inc di
        cmp dx, 0
    JNE vocale
    inc si
loop textp
mov al, counter
mov ah, 0
call af
mov ax, 4C00h
int 21h
code ends
end incepe