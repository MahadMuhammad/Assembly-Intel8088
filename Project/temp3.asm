[org 0x0100]
jmp start
clrscr:
    push ax
    push di
    mov ax,0xb800
    mov es,ax
    mov di,0
    l1:
    mov word [es:di],0x0720
    add di,2
    cmp di,4000
    jne l1
    pop di
    pop ax
    ret

my_rect:

    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    xor di,di
    mov ax,0xb800
    mov es,ax
    mov word di,[bp+12]
    mov byte dh,[bp+6]
    mov byte dl,[bp+4]
    mov word [es:di],dx
    mov cx,160
    sub cx,2
l2:
    add di,cx
    mov word [es:di],dx
    cmp word di,[bp+10]
    jbe l2
    mov bx,di

    mov cx,160
    add cx,2
    mov di,[bp+12]
l3:
    add di,cx
    mov word [es:di],dx
    cmp word di,[bp+8]
    jbe l3
    mov cx,di
    mov di,bx
l4:
    mov word [es:di],dx
    add di,2
    cmp di,cx
    jne l4


    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 10

start:
    xor ax,ax
    xor bx,bx 
    xor cx,cx 
    xor dx,dx

call clrscr

    mov ax,0
    push ax   ;+12
    mov ax,80
    push ax   ;+10
    mov ax,360;1324
    push ax ;+8
    xor ax,ax
    mov ax,0x07
    push  ax;+6
    xor ax,ax
    mov ax,'+'
    push   ax ;+4
    call my_rect

    xor ax,ax
    xor bx,bx 
    xor cx,cx 
    xor dx,dx

; call clrscr

;mov ax,1040
;push ax   ;+12
;mov ax,1604
;push ax   ;+10
;mov ax,1620
;push ax ;+8
;xor ax,ax
;mov ax,0x67
;push  ax;+6
;xor ax,ax
;mov ax,'*'
;push   ax ;+4
;call my_rect
mov ah,0x1
int 0x21
mov ax,0x4c00
int 0x21