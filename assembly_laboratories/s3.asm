;1. Se citeste de la tastatura o litera L. Se da un sir de caractere in data segment. Sa se inlocuiasca fiecare aparatie a lui L in sirul din data segment cu litera X. Sa se afiseze acest sir nou rezultat pe ecran.


assume cs:code,ds:data
data segment

s db 'Buna mAria'
ls equ $-s
linie db 10, 13, '$'
char db ?

data ends
code segment



incepe:
mov ax,data
mov ds,ax

mov ah, 08h
int 21h
mov char, al
mov ah, 09h
mov dx, offset linie
int 21h


mov si, 0
mov cx, ls

repeta:
    mov al, byte ptr s[si]
    cmp al, char
    JE ech
    JNE nuech
    ech:
        mov s[si], 'X'
        jmp endrep
    nuech:
        jmp endrep
    endrep:
        inc si
loop repeta
mov s[si], '$'
mov ah, 09h
mov dx, offset s
int 21h

mov ax, 4C00h
int 21h
code ends
end incepe



