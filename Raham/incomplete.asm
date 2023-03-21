[org 0x0100]
jmp start 

; place final outputs in these variables
topAvg:    dw 0   
bottomAvg: dw 0

; the data array and its size
; change these two to ensure your program works correctly all the time
marks:     dw 25, 26, 13, 47, 36, 32, 5, 40, 18, 11, 22, 25, 33, 28, 29, 16, 20, 23, 26, 20, 42, 31, 32, 29, 11
size:      dw 25

;------------------------------------------------------------------ 
; bubblesort subroutine (Example 5.6 from BH)
; Required parameters (on stack): array start address, array size
; Returns: nothing
;------------------------------------------------------------------
bubblesort:   push bp                 ; save old value of bp 
              mov  bp, sp             ; make bp our reference point 
              sub sp, 2               ; make two byte space on stack
              push ax                 ; save old values of registers
              push bx 
              push cx 
              push si 
 
              mov  bx, [bp+6]         ; load start of array in bx 
              mov  cx, [bp+4]         ; load count of elements in cx 
              dec  cx                 ; last element not compared 
              shl  cx, 1              ; turn into byte count 
 
mainloop:     mov  si, 0              ; initialize array index to zero 
              mov  word [bp-2], 0     ; reset swap flag to no swaps 
 
innerloop:    mov  ax, [bx+si]        ; load number in ax 
              cmp  ax, [bx+si+2]      ; compare with next number 
              jbe  noswap             ; no swap if already in order 
 
              xchg ax, [bx+si+2]      ; exchange ax with second number 
              mov  [bx+si], ax        ; store second number in first 
              mov  word [bp-2], 1     ; flag that a swap has been done 
 
noswap:       add  si, 2              ; advance si to next index 
              cmp  si, cx             ; are we at last index 
              jne  innerloop          ; if not compare next two 
              cmp word [bp-2], 1      ; check if a swap has been done 
              je   mainloop           ; if yes make another pass  
 
              pop  si                 ; restore old value of registers 
              pop  cx
              pop  bx
              pop  ax
              mov  sp, bp             ; remove space created on stack
              pop  bp                 ; restore old value of bp 
              ret  4                  ; go back and remove two params
;------------------------------------------------------------------
; list_avg subroutine
; Required parameters (on stack): array start address, array size
; Returns (again, on stack): the average value
;------------------------------------------------------------------
list_avg:     ;
              ; 
              ; complete me
              ;
              ;
;------------------------------------------------------------------  
; divide subroutine
; Required parameters (on stack): dividend, divisor
; Returns (on stack): the integer quotient
;------------------------------------------------------------------
divide:       ;
              ; 
              ; complete me
              ;
              ;
;------------------------------------------------------------------ 
; Main program
; Sorts the marks array using bubblesort subroutine, then 
; calls list_avg subroutine on a sublist of first 3 elements
; and then on a sublist of last 3 elements
;------------------------------------------------------------------
start:        ;
              ; 
              ; complete me
              ;
              ;             
              
finish:       mov ax, 0x4c00
              int 21h
              