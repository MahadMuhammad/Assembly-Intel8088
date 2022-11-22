;   --------------------------------------------------------
;   Author: Muhammad Mahad
;   4x4 TIC TAC TOE
;   Architechture: Intel IAPX-88 (8080) 16 bit
;   Emulator: DOSBOX
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   BOARD LAYOUT (0-15) IN BACKGROUND
;   --------------------------------------------------------
;           1 | 2 | 3 | 4
;           Q | W | E | R
;           A | S | D | F
;           Z | X | C | V
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   GAMEPLAY
;   --------------------------------------------------------
;        Player 1 is X and Player 2 is O
; STARTING: 
;   1. Player 1 starts the game
;   2. Player 1 chooses a position of X on the board
;   3. Player 2 chooses a position of O on the board
;   4. Repeat until a player wins or the board is full
; ERROR:
;   1. If a player chooses a position that is already taken
;      the game will display an error message and the player
;      will have to choose another position
;   2. If a player chooses a position that is not on the board
;      the game will display an error message and the player
;      will have to choose another position
; WINNING / DRAW :
;   1. If a player gets 4 X's or O's in a row, column, or diagonal
;      the game will display a message and the player will win
;   2. If the board is full and no player has won, the game will
;      display a message and the game will end in a tie
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   GAME LOGIC
;   --------------------------------------------------------
;   1. The game is won if any of the following conditions are true
;       a. The first row is filled with Xs or Os
;       b. The second row is filled with Xs or Os
;       c. The third row is filled with Xs or Os
;       d. The fourth row is filled with Xs or Os
;       e. The first column is filled with Xs or Os
;       f. The second column is filled with Xs or Os
;       g. The third column is filled with Xs or Os
;       h. The fourth column is filled with Xs or Os
;       i. The first diagonal is filled with Xs or Os
;       j. The second diagonal is filled with Xs or Os
;   2. The game is a draw if all the positions are filled and no player has won
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   DATA STRUCTURES / BACKEND
;   --------------------------------------------------------
;   1. The board is represented by a 4x4 array
;   2. The array is initialized with 0s
;   3. The array is updated with 1s and 2s
;   4. 1 represents X and 2 represents O
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   ALGORITHM
;   --------------------------------------------------------
;   1. Initialize the board with 0s
;   2. Display the board
;   3. Player 1 enters the position where he wants to place X
;   4. Update the board
;   5. Display the board
;   6. Check if the game is won or a draw
;   7. If the game is won or a draw, display the result and exit
;   8. If the game is not won or a draw, go to step 3
;   --------------------------------------------------------
;___________________________________________________________




;   --------------------------------------------------------
;   CODE
;   --------------------------------------------------------
[org 0x0100]        ;   Start of the program
    jmp main        ; jump to main

;   --------------------------------------------------------
;   DEFINITIONS
;   --------------------------------------------------------

BOARD:                      ;   Board array
        db 0,0,0,0          ; 1 | 2 | 3 | 4
        db 0,0,0,0          ; Q | W | E | R
        db 0,0,0,0          ; A | S | D | F
        db 0,0,0,0          ; Z | X | C | V 

COUNTS:  db 15             ;   Number of positions on the board

P1WIN: db 'Player-1 Wins!'  ;   Player 1 wins message

P2WIN: db 'Player-2 Wins!'  ;   Player 2 wins message

DRAW:  db 'The Game Draw!'           ;   Game Draw message

ERROR: db 'Error! (Change the Position), Box Occupied'          ;   Game Error message

WRONGKEY: db 'Error! Wrong Key Pressed'          ;   Wrong Key Pressed message

WELCOME: db 'Welcome to 4x4 TIC TAC TOE'          ;   Welcome message

GAME_ENDED: db 'The Game Ended! (Good Bye!)'          ;   Game Ended message

PRESSANYKEYTOCONTINUE: db 'Press any key to continue'          ;   Press any key to continue message

P1TURN: db 'Player-1 Turn'          ;   Player 1 Turn message

P2TURN: db 'Player-2 Turn'          ;   Player 2 Turn message

MESSAGETICTACTOE: db 'Welcome To TIC TAC TOE by MAHAD', 0       ;  Message to be displayed at the top of screen

;   --------------------------------------------------------
;   BASIC FUNCTIONS
;   --------------------------------------------------------

Intro:                             ;   First Prints DOT on screen, wait for user & prints grey color on screen 
                                   ;   Used in main function
            call PrintWELCOME       ;   Call the AnyKeyPress function
            call Dot               ;   Call the Dot function
            
            pusha                  ;   Save the registers

            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,0        ;   Set a pointer to the start of the video memory
            mov ah,0x77     ;   set color ASCII code (0111 0111)
            mov al,20h      ;   set the blank character     
            mov cx,80*1     ;   set the number of characters to write (Only First Line)
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte


            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,160      ;   Set a pointer to the start of the video memory
            mov ah,0x60     ;   set color ASCII code (0111 1111)
            mov al,20h      ;   set the blank character     
            mov cx,2000-80  ;   set the number of characters to write
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte

            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,160*24        ;   Set a pointer to the start of the video memory
            mov ah,0x30     ;   set color ASCII code (0111 1111)
            mov al,20h      ;   set the blank character     
            mov cx,80*25    ;   set the number of characters to write
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte


    
            popa            ;   Restore the registers
           
            ret             ;   Return (to the main function)
;   --------------------------------------------------------
DisplayBoard:                   ; Display the board & call P1Turn function
        pusha                  ;   Save the registers

        

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160+2     ;   Set a pointer to the start of the video memory
                        mov ah,0     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-2   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        
                        
                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*2+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*3+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*4+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*5+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*6+4     ;   Set a pointer to the start of the video memory
                        mov ah,00     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*7+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*8+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*9+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*10+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*11+4     ;   Set a pointer to the start of the video memory
                        mov ah,000     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*12+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*13+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*14+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*15+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*16+4     ;   Set a pointer to the start of the video memory
                        mov ah,00     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*17+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*18+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*19+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*20+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*21+2     ;   Set a pointer to the start of the video memory
                        mov ah,0     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-2   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        ; Print Centre & left line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 160*2+2 ; point di to top left column 
                                nextchar: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 80 ; move to next screen location 
                                                cmp di, 3362 ; has the whole screen cleared 
                                                jne nextchar ; if no clear next position 
                        
                        ; Print Right vertical Line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 160*3-4 ; point di to top left column 
                                nextchar2: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 160 ; move to next screen location 
                                                cmp di, 3516 ; has the whole screen cleared 876
                                                jne nextchar2 ; if no clear next position

                         ; Print Right vertical Line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 362 ; point di to top left column  (160*2+2)+(322+80)= 724 | 724/2=362
                                nextchar3: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 80 ; move to next screen location 
                                                cmp di, 3402 ; has the whole screen cleared 876
                                                jne nextchar3 ; if no clear next position

                        




        popa            ;   Restore the registers
        call PrintP1TURN    ;   Call the PrintP1TURN function
        call PrintMESSAGETICTACTOE
        ret             ;   Return (to the main function)




;   --------------------------------------------------------
ClearThatUserSegment:
        pusha           ;   Save the registers

        mov ax,0xb800   ;   Set the video memory address
        mov es,ax       ;   Set the video memory segment
        mov di,160*22+2     ;   Set a pointer to the start of the video memory
        mov ah,0x60     ;   set color ASCII code (0111 1111)
        mov al,20h      ;   set the blank character     
        mov cx,80-2   ;   set the number of characters to write
        cld             ;   clear direction flag
        rep stosw       ;   Fill the video memory with the attribute byte

        popa            ;   Restore the registers
        ret             ;   Return
;   --------------------------------------------------------
ClearThatUpperSegment:
        pusha           ;   Save the registers

        mov ax,0xb800   ;   Set the video memory address
        mov es,ax       ;   Set the video memory segment
        mov di,160+2     ;   Set a pointer to the start of the video memory
        mov ah,0     ;   set color ASCII code (0111 1111)
        mov al,20h      ;   set the blank character     
        mov cx,80-2   ;   set the number of characters to write
        cld             ;   clear direction flag
        rep stosw       ;   Fill the video memory with the attribute byte

        popa            ;   Restore the registers
        ret             ;   Return
;   --------------------------------------------------------

;___________________________________________________________
;   --------------------------------------------------------
;   EXTRA FUNCTIONS
;   --------------------------------------------------------
Dot:                        ;   Prints dots on screen  (Used in Intro function)
        pusha               ;   Save the registers  

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ah,0x0e         ;   Set the attribute byte (0x0e)
        mov al,0x07         ;   Set the color to white
        mov [es:di],al      ;   Set the color to white
        mov cx,2000

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
AnyKeyPress:                ;   Wait for any key press  (Used in Intro function)
        pusha               ;   Save the registers

        mov ah,0x00         ;   Set the interrupt number
        int 0x16            ;   Call the interrupt

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
ClearScreen:                ;   CLear Screen with spaces
        pusha               ;   Save the registers  

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ax,0x0720       ;   Set the attribute byte (0x0e)
        mov cx,2000         ;   Set the number of characters to write

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
Delay:                    ;   Delay function 
        pusha             ;   Save the registers
	
        mov cx,0xffff     ;   Set the counter to 0xffff
	    
            LoopDelay:                  ;   LoopDelay label
	    	    loop LoopDelay      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller
;   --------------------------------------------------------
PrintP1WIN:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P1WIN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt



        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintP2WIN:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P2WIN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt



        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintDRAW:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,DRAW    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintERROR:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1614   ;   row 22, column 33
        mov cx,42       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,ERROR    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintWRONGKEY:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1616   ;   row 22, column 33
        mov cx,24       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,WRONGKEY    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return
;   --------------------------------------------------------
PrintWELCOME:
        call ClearScreen        ;   Clear the screen


        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0C18   ;   row 22, column 33
        mov cx,26       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,WELCOME    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call PrintPRESSANYKEYTOCONTINUE
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return
;   --------------------------------------------------------
PrintGAME_ENDED:
        call ClearScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0C18   ;   row 22, column 33
        mov cx,27       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,GAME_ENDED    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call PrintPRESSANYKEYTOCONTINUE
        call AnyKeyPress        ;   Wait for any key press
        call EndGame    ;   End the game
        ret            ;   Return
;   -------------------------------------------------------
PrintPRESSANYKEYTOCONTINUE:
        ;call ClearScreen        ;   Clear the screen
        
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1614   ;   row 22, column 33
        mov cx,25       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,PRESSANYKEYTOCONTINUE    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return
;   -------------------------------------------------------
PrintP1TURN:
        ;call ClearScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0118   ;   row 22, column 33
        mov cx,13       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P1TURN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        ret            ;   Return
;     -------------------------------------------------------
PrintP2TURN:
        ;call ClearScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0118   ;   row 22, column 33
        mov cx,13       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P2TURN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        ret            ;   Return
;     -------------------------------------------------------
StringLength:           ; This function return length of string in ax register
    push bp             ;   Save the base pointer
    mov bp,sp           ;   Set the base pointer to the stack pointer
    push es             ;   Save the segment register
    push cx             ;   Save the counter
    push di             ;   Save the index register

    les di, [bp+4]      ; point es:di to string 
    mov cx, 0xffff      ; load maximum number in cx 
    mov al,0            ; load a zero in al 
    repne scasb         ; find zero in the string 
    mov ax, 0xffff      ; load maximum number in ax 
    sub ax, cx          ; find change in cx 
    dec ax              ; exclude null from length 

    pop di 
    pop cx 
    pop es 
    pop bp 
    ret 4 
;  -------------------------------------------------------  
printstr:                       ; subroutine to print a string
    push bp                     ; takes the x position, y position, attribute, and address of a null 
    mov bp, sp                  ; terminated string as parameters
    push es 
    push ax 
    push cx 
    push si 
    push di 
    push ds ; push segment of string 
    mov ax, [bp+4] 
    push ax ; push offset of string 
    call StringLength ; calculate string length
    cmp ax, 0 ; is the string empty 
    jz printstr_exit ; no printing if string is empty
    mov cx, ax ; save length in cx 
    mov ax, 0xb800 
    mov es, ax ; point es to video base 
    mov al, 80 ; load al with columns per row 
    mul byte [bp+8] ; multiply with y position 
    add ax, [bp+10] ; add x position 
    shl ax, 1 ; turn into byte offset 
    mov di,ax ; point di to required location 
    mov si, [bp+4] ; point si to string 
    mov ah, [bp+6] ; load attribute in ah 
    cld ; auto increment mode 
        printstr_nextchar: 
                lodsb ; load next char in al 
                stosw ; print char/attribute pair 
                loop printstr_nextchar ; repeat for the whole string 
        printstr_exit: 
                pop di 
                pop si 
                pop cx 
                pop ax 
                pop es 
                pop bp 
                ret 8 
;  -------------------------------------------------------
PrintMESSAGETICTACTOE:
        pusha           ;   Save the registers

        mov ax, 22      ;  Move the x position
        push ax         ; push x position 
        mov ax, 0       ;  Move the y position
        push ax         ; Move the y position
        mov ax,0xF4     ; Red on White Blinking
        push ax         ; push attribute 
        mov ax, MESSAGETICTACTOE        ;  Move the address of the string 
        push ax         ; push offset of string 
        call printstr   ; print the string 
        mov ah, 0       ; service 0 – get keystroke 
        int 0x16        ; call BIOS keyboard service

        popa            ;   Restore the registers
        ret             ;   Return
;___________________________________________________________
;   --------------------------------------------------------
;   FUNCTION: main
;   --------------------------------------------------------
main:
    call Intro           ; First Prints DOT on screen, wait for user & prints grey color on screen
    call DisplayBoard   ;   Display the board
    call PrintP1WIN     ;   Print P1WIN
    call AnyKeyPress
    call ClearThatUserSegment       ;   Clear that PrintP1WIN segment
    call AnyKeyPress
    call PrintP1TURN
    call AnyKeyPress
    call ClearThatUpperSegment       ;   Clear that PrintP1TURN segment
    call AnyKeyPress
    call AnyKeyPress
    call PrintGAME_ENDED
    ;call Game
    ;call displayBoard   ;   Display the board
    ;call displayResult  ;   Display the result

EndGame:                ; End Function (Terminates the Program)
    mov ax, 0x4c00      ; Exit to DOS
    int 21h             ; Call DOS interrupt
;   --------------------------------------------------------
;   END OF CODE
;   --------------------------------------------------------
;___________________________________________________________