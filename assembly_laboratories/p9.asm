;8. Sa se citeasca un sir de caractere si un caracter de la tastatura si sa se afiseze pe ecran daca caracterul apare in sir.
;Exemplu:
;S: "ana are mere"
;C: 'a'
;rezultat: "DA"


assume cs:code,ds:data
data segment

S db 'ana are mere'
ls equ $-S
char db ?
da db 'DA$'
nu db 'NU$'
ok db 0

data ends
code segment



incepe:

mov ax,data
mov ds,ax

mov ah, 08h
int 21h
mov char, al

mov cx, ls
mov si, 0

este:
    mov al, byte ptr S[si]
    inc si
    cmp al, char
    JNE next
    JE isch
    isch:
        mov ok, 1
        mov ah, 09h
        mov dx, offset da
        int 21h
        jmp iesire
     next:
loop este

cmp ok, 0
JE nuapare
JNE iesire
nuapare:
mov ah, 09h
mov dx, offset nu
int 21h

iesire:
mov ax, 4C00h
int 21h
code ends
end incepe



