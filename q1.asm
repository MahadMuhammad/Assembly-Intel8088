[org 0x0100]

jmp start

message: db 'Hello World',0

clrscr:
        push es 
        push ax 
        push cx 
        push di 
        mov ax, 0xb800 
        mov es, ax ; point es to video base 
        xor di, di ; point di to top left column 
        mov ax, 0x0720 ; space char in normal attribute 
        mov cx, 2000 ; number of screen locations 
        cld ; auto increment mode 
        rep stosw ; clear the whole screen 
        pop di 
        pop cx 
        pop ax 
        pop es 
        ret 

strlen:
    push bp
    mov bp,sp
    push cs
    push cx
    push di

    les di,[bp+4]
    mov cx,0xffff
    xor al,al
    repne scasb
    mov ax,0xffff
    sub ax,cx
    dec ax

    pop di
    pop cx
    pop es
    pop bp
    ret 4

printstr:
    push bp
    mov bp,sp
    push es
    push ax
    push cx
    push si
    push di

    push ds
    mov ax,[bp+4]
    push ax
    call strlen
    push ax
    cmp ax,0
    jz exit
    mov cx,ax

    mov ax,0xb800
    mov es,ax
    mov al,80
    mul byte[bp+8]
    add ax,[bp+10]
   ; mov bx,25
    ;pop dx
    ;sub bx,dx

    add ax,25

    shl ax,1
    mov di,ax
    mov si,[bp+4]
    mov ah,[bp+6]

    cld 
nextchar:
    lodsb
    stosw
    loop nextchar
    
exit:
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp 
    ret 8

start:
    call clrscr

    mov ax,0
    push ax
     
    mov ax,0
    push ax

    mov ax, 0x71
    push ax
    mov ax,message
    push ax

    call printstr

mov ax,0x4c00
int 21h