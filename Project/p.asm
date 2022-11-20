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
; WINNING / DRAW:
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
;   INCLUDES
;   --------------------------------------------------------



   
main:




end:
    mov ax, 0x4c00      ; Exit to DOS
    int 21h             ; Call DOS interrupt