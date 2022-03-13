;5. Se da un numar n (0<n<256) in segmentul de date. Sa se genereze si sa se afiseze pe ecran primii n termeni din sirul lui Fibonacci.
;Exemplu:
;n = 6
;rezultat: 1, 1, 2, 3, 5, 8


assume cs:code,ds:data
data segment

n dw 20
lens equ 20
fib dw lens dup(?)
suma dw ?
linienoua db 10, 13, '$'
zece dw 10
copie dw 0
copie1 dw 0
copie2 dw 0
sir db '1$'
da db 'DA$'

data ends
code segment

afisare10 proc

	mov cx, 0 
	
	repeta2:
		mov dx, 0
		div zece  
		push dx ;
		inc cx 
		cmp ax, 0
		JNE repeta2
 
	; numar cifre din numar	

	; afisez adunand caracterul '0' la cifra ca sa-il fac caracter cifra

	afisare:
		pop dx  ; in dl este cifra
		add dl, '0'                   ; afisez adunand caracterul '0' la cifra ca sa-il fac caracter cifra
		mov ah, 02h
		int 21h
	loop afisare 
ret  
afisare10 endp


incepe:

mov ax, data
mov ds, ax

mov cx, lens-2
mov di, 0 
mov fib[di], 1
mov ax, word ptr fib[di]
mov copie1, ax
add di, 2

mov fib[di], 1
mov bx, word ptr fib[di]
add di, 2
mov di, 4

mov ah, 09h
mov dx, offset sir
int 21h

mov ah, 09h
mov dx, offset linienoua
int 21h 

mov ah, 09h
mov dx, offset sir
int 21h

mov ah, 09h
mov dx, offset linienoua
int 21h 

mov ax, copie1

repeta:
	mov suma, ax
	add suma, bx
	mov bp, suma
	mov ax, bx
	mov bx, bp
	mov copie1,ax
	mov copie2,bx
	mov fib[di], bp
	mov copie, cx
	mov ax, suma
	call afisare10
		mov ah, 09h
		mov dx, offset linienoua
		int 21h
	mov cx, copie
	mov ax,copie1
	mov bx,copie2
	add di,2 
loop repeta

mov ax, 4C00h
int 21h
code ends
end incepe