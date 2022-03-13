;2. Sa se citeasca de la tastatura un sir de octeti S si sa se afiseze pe ecran diferenta lor.
;Exemplu:
;S: 12, 3, 4, 6
;Diferenta: -1

assume cs:code,ds:data
data segment

S db 0, 12, 12
ls equ $-S
diferenta db 'diferenta: $'
dif db ?
copie db 0
zece dw 10

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

mov cx, ls - 1
mov si, 1
mov al, byte ptr s[0]
repeta:
    mov bl, byte ptr S[si]
    sub al, bl
    inc si
loop repeta
mov dif, al
mov copie, al
cmp al, 0
JGE pozitiv
JL negativ
pozitiv:
    mov ah, 0
    call af
    jmp iesire
    
negativ:
    mov dl, '-'
    mov ah, 02h
    int 21h
    mov al, dif
    neg al
    mov ah, 0
    call af
    
iesire:

mov ax, 4C00h
int 21h
code ends
end incepe



