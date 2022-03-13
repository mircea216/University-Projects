;8. Sa se citeasca un sir de caractere si sa se afiseze cate litere contine.
;Exemplu:
;S: "ana are 3 mere!"
;rezultat: 10

assume cs:code,ds:data
data segment

s db '#@ana are 3 mere!AZ12'
ls equ $-s
counter db 0
counter2 db 0
caracsp db 0

data ends
code segment




incepe:
mov ax,data
mov ds,ax

mov cx, ls
mov si, 0
mov ax, 0
repeta:
    mov al, byte ptr s[si]
    cmp al, 'A'
    JAE ebun
    JB nue
    ebun:
        cmp al, 'Z'
        JBE literamica
        JA verifica
        literamica:
            inc counter
            jmp next
        verifica:
            cmp al, 'a'
            JAE cmare
            JB nubun
            nubun:
                jmp next
            cmare:
                cmp al, 'z'
                JBE litmare
                JA nubunlit
                litmare:
                    inc counter
                    jmp next
                nubunlit:
                    jmp next
    nue:
    next:
    inc si
loop repeta

mov si, 0
mov cx, ls
numaracifre:
    mov al, byte ptr s[si]
    cmp al, '0'
    JAE posibil
    JB impo
    posibil:
        cmp al, '9'
        JBE cifra
        JA nuecf
        cifra:
            inc counter
            jmp next1
        nuecf:
            jmp next1      
    impo:
    next1:
    inc si
loop numaracifre

mov al, byte ptr ls
sub al, counter
mov caracsp, al

mov ax, 4C00h
int 21h
code ends
end incepe