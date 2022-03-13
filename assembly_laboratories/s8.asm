; sa se roteasca 

assume cs:code,ds:data
data segment

s db 1,2,-3,4,5,5
ls equ $-s
d db ls-1 dup(?)
copie dw 0
zece dw 10
linie db 10, 13, '$'

data ends
code segment

afi proc
    mov cx, 0
    cifre:
        mov dx, 0
        div zece
        push dx
        inc cx
        cmp ax, 0
    jne cifre
    
    afcf:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop afcf
ret
afi endp
incepe:
mov ax,data
mov ds,ax

mov cx, ls-1
mov si, 0
mov di, 0
repeta:
    mov al, s[si]
    mov bl, s[si+1]
    sub al, bl
    mov d[di], al
    inc si
    inc di
loop repeta

mov cx, ls-1
mov si, 0
aff:
    mov al, byte ptr d[si]
    mov bl, al
    mov copie, cx
    cmp al, 0
    JL negativ
    JGE pozitiv
    negativ:
        mov dl, '-'
        mov ah, 02h
        int 21h
        mov al, bl
        not al
        inc al
        mov ah, 0
        call afi
        jmp next
    pozitiv:
        mov ah, 0
        call afi
        next: 
    mov ah, 09h
    mov dx, offset linie
    int 21h
    inc si
    mov cx, copie
loop aff
mov ax, 4C00h
int 21h
code ends
end incepe