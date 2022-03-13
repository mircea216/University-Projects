; A: 2, 1, -3, 3, -5, 2, 6 - octeti
; B: 4, 5, 7, -15, 2, 1 - 
; D1: 1, 3, 5, 7, 1 - impare pozitive
; D2: -5, -15       - negative diviz la 5

assume cs:code,ds:data
data segment

A db 177, 2 , 1, -3, 3, 3, -5, 2, 6
la equ $-A
B db 4, 5, 7, -15, 2, 1
lb equ $-B
D1 db la + lb dup(?)
D2 db la + lb dup(?)
doi db 2
cinci db 5
zece dw 10
linie db 10, 13, '$'
copie dw ?

data ends
code segment

af proc
    mov cx, 0
    cf: 
        mov dx, 0
        idiv zece
        push dx
        inc cx
        cmp ax, 0
        JNE cf
    afis:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
    loop afis
ret
af endp

spp proc
    mov dl, ' '
    mov ah, 02h
    int 21h
ret
spp endp 

minuss proc
    mov dl, '-'
    mov ah, 02h
    int 21h
ret
minuss endp 

incepe:

mov ax,data
mov ds,ax

mov cx, la
mov si, 0
mov di, 0

impare:
    mov copie, cx
    mov al, byte ptr A[si]
    mov bl, al
    cmp al, 0
    JLE lower
    JG greater
    lower:
        jmp next
    greater:
        cbw
        idiv doi
        cmp ah, 1
        JNE par
        JE impar
        par: 
            jmp next
        impar:
            mov D1[di], bl
            mov al, bl
            mov ah, 0
            call af
            call spp
            inc di
    next:
        mov cx, copie
        inc si
loop impare
       
mov cx, lb
mov si, 0
impare1:
    mov copie, cx
    mov al, byte ptr B[si]
    mov bl, al
    cmp al, 0
    JLE lower1
    JG greater1
    lower1:
        jmp next1
    greater1:
        cbw
        idiv doi
        cmp ah, 1
        JNE par1
        JE impar1
        par1: 
            jmp next1
        impar1:
            mov D1[di], bl
            mov al, bl
            mov ah, 0
            call af
            call spp
            inc di
    next1:
        mov cx, copie
        inc si

loop impare1

mov cx, la
mov si, 0
mov di, 0
diviz5:
   mov copie, cx
   mov al, byte ptr A[si]
   mov bl, al
   cmp al, 0
   JGE greater2
   JL lower2
   greater2:
        jmp next2
   lower2:
        cbw
        idiv cinci
        cmp ah, 0
        JNE ncinci1
        JE  cinci1
        ncinci1: 
            jmp next2
        cinci1:
            call minuss
            mov D2[di], bl
            mov al, 255
            sub al, bl
            inc al
            mov ah, 0
            call af
            call spp
            inc di
    next2:
        mov cx, copie
        inc si
loop diviz5

mov cx, lb
mov si, 0

diviz51:
   mov copie, cx
   mov al, byte ptr B[si]
   mov bl, al
   cmp al, 0
   JGE greater3
   JL lower3
   greater3:
        jmp next3
   lower3:
        cbw
        idiv cinci
        cmp ah, 0
        JNE ncinci12
        JE  cinci12
        ncinci12: 
            jmp next2
        cinci12:
            call minuss
            mov D2[di], bl
            mov al, 255
            sub al, bl
            inc al
            mov ah, 0
            call af
            call spp
            inc di
    next3:
        inc si
        mov cx, copie
loop diviz51



mov ax, 4C00h
int 21h
code ends
end incepe



