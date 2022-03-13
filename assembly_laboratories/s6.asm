;8. Sa se citeasca un sir de caractere si sa se afiseze cate litere contine.
;Exemplu:
;S: "ana are 3 mere!"
;rezultat: 10

assume cs:code,ds:data
data segment

s dd 123A456Dh, 0FEAB2349h
ls equ $-s
maxi db 0
saispe dw 16

data ends
code segment

af16 proc
    mov cx, 0
    cif:
        mov dx, 0
        div saispe
        push dx
        inc cx
        cmp ax, 0
    jne cif
    
    afff:
       pop dx
       mov al, dl
       cmp al, 10
       JAE elit
       JB ecif
       elit:
       add al, 55
       mov dl, al
       mov ah, 02h
       int 21h
       jmp nextt
       ecif:
       add al, '0'
       mov dl, al
       mov ah, 02h
       int 21h
       nextt:
    loop afff

ret
af16 endp

incepe:
mov ax,data
mov ds,ax

mov cx, ls
mov al, byte ptr s[0]
mov maxi, al
mov si, 1

repeta:
    mov al, byte ptr s[si]
    cmp al, maxi
    JA emaxi
    JBE nuemaxi
    emaxi:
        mov maxi, al
        jmp next
    nuemaxi:
    next:
    inc si
loop repeta

mov al, maxi
mov ah, 0
call af16
mov al, 169
mov ah, 0
call af16
mov ax, 4C00h
int 21h
code ends
end incepe