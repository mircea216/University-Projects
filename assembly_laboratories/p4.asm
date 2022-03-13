;12. Se da un sir de dublucuvinte. Sa se genereze sirul D care sa contina toti octetii superiori ai word-urilor superioare care au ultima cifra egala cu 7. Sa se afiseze sirul D (in baza 10) pe ecran.
;Exemplu:
;S:3934780Ah, ABCDAB32h, 6BF3B1E5h
;D: 39h, 6Bh
;rezultat: 57, 107


assume cs:code,ds:data
data segment

S dd 3934780Ah, 0ABCDAB32h, 6BF3B1E5h
lens equ ($-S)/4
D db lens dup(?)
zece db 10
ten dw 10
linie db 10, 13, '$'
copie dw 0

data ends
code segment


af proc

mov cx, 0

repeat:
	cwd
	idiv ten
	push dx
	inc cx
	cmp ax, 0
	JNE repeat

afis:
	pop dx
	add dl,'0'
	mov ah, 02h
	int 21h

loop afis


ret
af endp


incepe:
mov ax,data
mov ds,ax

mov ax,0

mov cx, lens
mov si, 3
mov di, 0

repeta:
	mov al, byte ptr S[si]
	mov bl, al
	cbw
	idiv zece
	mov copie, cx
	CMP ah, 7
	JNE notequal
	JE equal
	notequal:
		jmp next
	equal:
		mov D[di], bl
		mov al, bl
		cbw
		call af
		mov ah, 09h
		mov dx, offset linie
		int 21h
		inc di
	next:
		add si, 4
		mov cx, copie
loop repeta
 
mov ax, 4C00h
int 21h
code ends
end incepe