; z=(5*a-b/7)/(3/b+a*a)

assume cs:code,ds:data
data segment

a db 5
b dw 21
sapte db 7
trei dd 3
interm dw 0
z dw ?

data ends
code segment



incepe:
mov ax,data
mov ds,ax


mov al, 5
imul a
mov bx, ax
mov ax, b
idiv sapte
cbw
sub bx, ax
mov ax, word ptr trei
mov dx, word ptr trei + 2
idiv b
mov cx, ax
mov al, a
imul a
add ax, cx
mov cx, ax
mov interm, bx
mov ax, word ptr interm
mov dx, word ptr interm + 2
idiv cx
mov z, ax

mov ax, 4C00h
int 21h
code ends
end incepe



