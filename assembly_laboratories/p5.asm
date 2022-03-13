assume cs:code,ds:data
data segment


citit db 10, ?, 10 dup (?)

ls db ?

;super db 'super$'
data ends
code segment



incepe:

mov ax,data
mov ds,ax

;mov ah, 08h
;int 21h

;mov dl, 3
;add dl, '0'
;mov ah, 02h
;int 21h

;mov ah, 09h
;mov dx, offset super
;int 21h

mov ah, 0Ah
mov dx, offset citit
int 21h

mov bl, byte ptr citit[1]
mov ls,bl
mov bh, 0
mov si, bx


mov citit[si+2], '$'
mov ah, 09h
mov dx, offset citit
int 21h


mov ax, 4C00h
int 21h
code ends
end incepe