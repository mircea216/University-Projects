;11. Se da un sir de dublucuvinte. Sa se genereze sirul D care sa contina toti octetii inferiori ai word-urilor superioare care au ultima cifra egala cu 8. Sa se afiseze sirul D (in baza 10) pe ecran.
;Exemplu:
;S: 12443478h, AB32CDABh, C576B1E5h
;D: 44h, 76h
;rezultat: 68, 118

assume cs:code,ds:data
data segment

S dd 12443478h, 0AB32CDABh, 0C576B1E5h
ls equ ($-S)/4
R db ls dup(?)
zece db 10
saispe dw 16
linie db 10, 13, '$'
copie dw ?

data ends
code segment

af16 proc
    mov cx, 0
    cf:
        mov dx, 0
        div saispe
        push dx 
        inc cx
        cmp ax, 0
        JNE cf
        
    afi:
        pop dx
        mov al, dl
        cmp al, 10
        JAE litera
        JB cifra
        litera:
            add al, 55
            mov dl, al
            jmp afis
        cifra:
            add al, '0'
            mov dl, al
        afis:
        mov ah, 02h
        int 21h
    loop afi
    
ret
af16 endp

;
incepe:
mov ax,data
mov ds,ax

mov cx, ls
mov si, 2
mov di, 0
repeta:
    mov copie, cx
    mov al, byte ptr S[si]
    mov bl, al
    cbw 
    idiv zece
    cmp ah, 8
    JNE nue8
    JE e8
    nue8:
        jmp next
    e8:
        mov R[di], bl
        inc di
        mov al, bl
        mov ah, 0
        call af16
        mov ah, 09h
        mov dx, offset linie
        int 21h
    next:
    mov cx, copie
    add si, 4
loop repeta

mov ax, 4C00h
int 21h
code ends
end incepe



