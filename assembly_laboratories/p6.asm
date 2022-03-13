;9. Se da un sir de dublucuvinte. Sa se genereze sirul D care sa contina toti octetii inferiori ai word-urilor inferioare care au valoare para si negativa. Sa se afiseze sirul D (in baza 10) pe ecran.
;Exemplu:
;S: 123456D4h, ABCDEFABh, C5F3B1E2H 
;D: D4h, E2h
;rezultat: -44, -30

assume cs:code,ds:data
data segment

S dd 123456D4h, 0ABCDEFABh, 0C5F3B1E2h
lens equ ($-S)/4
R db lens dup(?)
two db 2
ten dw 10
copie dw 0
linie db 10, 13, '$'
data ends
code segment
af proc
	mov cx, 0
	cifre:
		mov dx, 0
		idiv ten
		push dx
		inc cx
		cmp ax, 0
	JNE cifre
	
	afis:
		pop dx
		add dl, '0'
		mov ah, 02h
		int 21h
	loop afis
ret
af endp
incepe:

mov ax,data
mov ds,ax

mov al, lens

mov cx, lens
mov si, 0
mov di, 0

repeat:
	mov copie, cx
	mov al, byte ptr S[si]
	mov bl, al
	cmp al, 0
	JGE pozitiv
	JL negativ
		pozitiv:
			jmp next
		negativ:
			mov al, bl
			cbw
			idiv two
			cmp ah, 0
			JNE impar
			JE par
				impar:
					jmp next
				par:	
					mov dl, '-'
					mov ah, 02h
					int 21h
					mov R[di], bl
					inc di		
					mov al, 255
					sub al, bl
					inc al
					mov ah, 0
					call af
					mov ah, 09h
					mov dx, offset linie
					int 21h
	next:
	add si, 4
	mov cx, copie
loop repeat



mov ax, 4C00h
int 21h
code ends
end incepe