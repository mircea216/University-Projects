;2. Sa se citeasca de la tastatura un sir de octeti S si sa se afiseze pe ecran suma lor.
;Exemplu:
;S: 1, 2, 3, 4
;Suma: 10


assume cs:code,ds:data
data segment

S db 10, ?, 10 dup(?)
ls db 0
suma db 0
doi dw 2
newl db 10, 13, '$'

data ends
code segment

af2 proc
    mov cx, 0
    repeat2:
        mov dx, 0
        idiv doi
        push dx
        inc cx
        cmp ax, 0
        JNE repeat2
        
    afis:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    
    loop afis
    
ret
af2 endp 


incepe:

mov ax,data
mov ds,ax

mov ah, 0Ah
mov dx, offset S
int 21h

mov ah, 09h
mov dx, offset newl
int 21h

mov al, byte ptr S[1]
mov ls, al
mov ah, 0

mov cx, ax
mov si, 2

repeat:
    mov al, byte ptr S[si]
    sub al,'0'
    add suma, al
    inc si
loop repeat

mov al, suma
mov ah, 0
call af2

mov ax, 4C00h
int 21h
code ends
end incepe



