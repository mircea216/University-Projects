;15. Se dau A si B de tip byte, C word si D doubleword. Sa se calculeze expresia: C+(A*B-D+3)/(B*B-C) si sa se afiseze rezultatul pe ecran.
;Exemplu:
;A = 12
;B = 104
;C = 12325
;D = 75412
;rezultat: 12374

assume cs:code,ds:data
data segment

A db 12
B db 104
C dw 12325
D dd 75412
par1 dw ?
par2 dw ?
trei dd 3
result dw ?
zece dw 10

data ends
code segment

afis proc
	mov cx, 0
	cifre:
		mov dx, 0
		div zece
		push dx
		inc cx 
		cmp ax, 0
			JNE cifre


	afisare:
		pop dx
		add dl, '0'
		mov ah, 02h
		int 21h
	loop afisare
	
ret
afis endp 

incepe:
mov ax,data
mov ds,ax

mov al, B
imul B
sub ax, C
mov par2,ax
mov al,A
imul B
cwd
mov bx, word ptr D+0
mov cx, word ptr D+2
sub ax, bx
sbb dx, cx
mov bx, word ptr trei+0
mov cx, word ptr trei+2
add ax, bx
adc dx, cx
idiv par2
add ax, C
call afis
mov ax, 4C00h
int 21h
code ends
end incepe