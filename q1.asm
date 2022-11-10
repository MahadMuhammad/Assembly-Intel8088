[org 0x0100]

jmp  start

clrscr:
    push es
    push ax
    push cx
    push di

    mov  ax, 0xb800
    mov  es, ax
    xor  di, di
    mov  ah, 0x07
    mov al,'M'
    mov  cx, 2000

                    ; auto-increment mode 
    rep stosw           ; rep cx times, store words 
                        ; source is ax for word, al for bytes 
                        ; destination is es:di 
                        ; inc/dec di as well by 2 bytes 

    pop di
    pop  cx
    pop  ax
    pop  es
    ret


start: 

    mov  ax, 0xb800
    mov  es, ax
    xor  di, di
    mov  ah, 0x07
    mov al,0x20
    mov  cx, 2000

    cld           ; auto-increment mode 
    rep stosw           ; rep cx times, store words 
    mov  ax, 0x4c00
    int  0x21