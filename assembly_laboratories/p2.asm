;7. Sa se citeasca un sir de caractere si sa se afiseze cate spatii sunt in sir.
;Exemplu:
;S: "ana are mere"
;rezultat: 2

assume cs:code,ds:data
data segment

sir db '           .'
lensir equ $-sir
counter db 0
zece dw 10

data ends

code segment

afis10 proc

mov cx, 0
cifre:
	mov dx, 0
	div zece
	push dx
	inc cx
	cmp ax, 0
	JNE cifre

afisarecifre:
	pop dx		; in dl vom avea ultima cifra
	add dl, '0'	; o transformam in caracter
	mov ah, 02h
	int 21h
loop afisarecifre
	
ret
afis10 endp



incepe:
mov ax, data
mov ds, ax

mov cx, lensir
mov si, 0
repeta:
	mov al,sir[si]
	cmp al, ' '
	JNE notegal
	JE egal
	notegal:
		jmp next
	egal:
		inc counter
	next:
		inc si
	
loop repeta

mov al, counter
mov ah, 0
call afis10

mov ax, 4C00h
int 21h
code ends
end incepe
