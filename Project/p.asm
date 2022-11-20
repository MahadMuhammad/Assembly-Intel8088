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

board:  
        db 0,0,0,0          ; 1 | 2 | 3 | 4
        db 0,0,0,0          ; Q | W | E | R
        db 0,0,0,0          ; A | S | D | F
        db 0,0,0,0          ; Z | X | C | V 

TURN:  db 1                 ;   1 = Player 1, 2 = Player 2, 3 = Game Over 

P1WIN: db 'Player-1 Wins!'  ;   Player 1 wins message

P2WIN: db 'Player-2 Wins!'  ;   Player 2 wins message

DRAW:  db 'Draw!'           ;   Game Draw message

ERROR: db 'Error!'          ;   Game Error message

;   --------------------------------------------------------
;   BASIC FUNCTIONS
;   --------------------------------------------------------

Intro:                             ;   First Prints DOT on screen, wait for user & prints grey color on screen 
                                   ;   Used in main function
            call Dot               ;   Call the Dot function
            call AnyKeyPress       ;   Call the AnyKeyPress function
            pusha                  ;   Save the registers

            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,0        ;   Set a pointer to the start of the video memory
            mov ah,0x77     ;   set color ASCII code (0111 0111)
            mov al,20h      ;   set the blank character     
            mov cx,2000     ;   set the number of characters to write
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte

    
            popa            ;   Restore the registers
            ret
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
        mov ah,0x0e         ;   Set the attribute byte
        mov al,0x07         ;   Set the color to white
        mov [es:di],al      ;   Set the color to white
        mov cx,2000

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        ret
;   --------------------------------------------------------
AnyKeyPress:                ;   Wait for any key press  (Used in Intro function)
        pusha               ;   Save the registers

        mov ah,0x00         ;   Set the interrupt number
        int 0x16            ;   Call the interrupt

        popa                ;   Restore the registers
        ret
;   --------------------------------------------------------
Delay:                    ;   Delay function 
        pusha             ;   Save the registers
	    mov cx,0xffff     ;   Set the counter to 0xffff

	    LoopDelay:                  ;   LoopDelay label
	    	    loop LoopDelay      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller
;   --------------------------------------------------------

;___________________________________________________________
;   --------------------------------------------------------
;   FUNCTION: main
;   --------------------------------------------------------
main:
    call Intro           ; First Prints DOT on screen, wait for user & prints grey color on screen
    ;call initBoard      ;   Initialize the board
    ;call displayBoard   ;   Display the board
    ;call player1        ;   Player 1 turn
    ;call player2        ;   Player 2 turn
    ;call checkWin       ;   Check if the game is won
    ;call checkDraw      ;   Check if the game is a draw
    ;call displayBoard   ;   Display the board
    ;call displayResult  ;   Display the result
    ;ret                 ;   Return to the caller







end:
    mov ax, 0x4c00      ; Exit to DOS
    int 21h             ; Call DOS interrupt