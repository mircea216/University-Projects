;7. Dandu-se un sir de dublucuvinte, sa se obtina un alt sir de dublucuvinte in care se vor pastra doar dublucuvintele din primul sir care au un numar ;par de biti cu valoare 1.


assume cs:code,ds:data
data segment



data ends
code segment

s dd 0FE98DC76h, 11b, 11000011b, 1
ls equ ($-s)/4 
d dd ls dup(?)
doi db 2

incepe:
mov ax,data
mov ds,ax

mov si, 0
mov di, 0
mov cx, ls

repeta:
    mov ax, word ptr s[si]
    mov dx, word ptr s[si+2]
    mov bh, 0
    mov bl, 0
    bitiax:
        shl ax, 1
        adc bl, 0
        cmp ax, 0
    jne bitiax
    bitidx:
        shl dx, 1
        adc bh, 0
        cmp dx, 0
    jne bitidx
    add bl, bh
    mov bh, 0
    mov ax, bx
    div doi
    cmp ah, 0
    JNE impar
    JE par
    impar:
        jmp next
    par:
        mov ax, word ptr s[si]
        mov dx, word ptr s[si+2]
        mov word ptr d[di], ax
        mov word ptr d[di], ax
        add di, 4
    
    next:
        add si, 4
        
loop repeta

mov ax, 4C00h
int 21h
code ends
end incepe



