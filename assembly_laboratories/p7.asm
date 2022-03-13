;10. Se da un sir de dublucuvinte. Sa se genereze sirul D care sa contina toti octetii superiori ai word-urilor inferioare care au valoare impara si divizibila cu 5. Sa se afiseze sirul D (in baza 10) pe ecran.
;Exemplu:
;S: 12341978h, ABCD14ABh, C5F373E5h 
;D: 19h, 73h
;rezultat: 25, 115


assume cs:code,ds:data
data segment

S dd 12341978h, 0ABCD14ABh, 0C5F373E5h
ls equ ($-S)/4
R db ls dup(?)
doi db 2
cinci db 5
zece dw 10
linie db 10, 13, '$'
copie dw ?

data ends

code segment
  
af proc
    mov cx, 0
    repeat2:
        mov dx, 0
        idiv zece
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
af endp



incepe:

mov ax, data
mov ds, ax

mov cx, ls
mov si, 1
mov di, 0

repeat1:
    mov copie, cx
    mov al, byte ptr S[si]
    mov bl, al  
    cbw
    idiv doi
    cmp ah, 0
    JE par
    JNE impar
    par:
        jmp next
    impar:
        mov al, bl  
        cbw
        idiv cinci
        cmp ah, 0
        JNE ndiviz
        JE diviz
        ndiviz:
            jmp next
        diviz:
            mov R[di], bl
            inc di
            mov al, bl
            call af
            mov ah, 09h
            mov dx, offset linie
            int 21h
    next:
        add si, 4
        mov cx, copie
loop repeat1


mov ax, 4C00h
int 21h
code ends
end incepe