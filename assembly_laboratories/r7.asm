;1. Se da un sir de cuvinte s. Sa se construiasca sirul de octeti d, astfel incat d sa contina pentru fiecare pozitie din s:
;- numarul de biti de 0, daca numarul este negativ
;- numarul de biti de 1, daca numarul este pozitiv
;Exemplu:
;s: -22, 145, -48, 127
;in binary: 
;1111111111101010, 10010001, 1111111111010000, 1111111
;d: 3, 3, 5, 7

assume cs:code,ds:data
data segment

s dw -22, 145, -48, 127
ls equ ($-s)/2
d db ls (?)
copie dw 0
numar dw 0
saispe db 16

data ends
code segment


incepe:
mov ax,data
mov ds,ax

mov cx, ls
mov si, 0
mov di, 0
repeta:
    mov copie, cx
    mov ax, word ptr s[si]
    mov numar, ax
    mov cx, 16
    mov bl, 0
    biti:  
        shl ax, 1
        adc bl, 0
    loop biti
    mov ax, numar
    cmp ax, 0
    JG pozitiv
    JL negativ
    pozitiv:
        mov dl, saispe
        sub dl, bl
        mov d[di], dl
        inc di
        jmp next
    negativ:    
        mov d[di], bl
        inc di
    next:
        mov cx, copie
        add si, 2
loop repeta

mov ax, 4C00h
int 21h
code ends
end incepe



