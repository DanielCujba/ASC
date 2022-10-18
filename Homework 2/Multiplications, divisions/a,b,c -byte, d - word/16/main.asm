bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10
    b db 12
    c db 5
    d dw 45
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax,0
        mov al,[a]
        add al,[b]
        mov bl,2
        div bl
        mov bl,al
        mov ax,0
        mov al,[a]
        div byte [c]
        mov cl,10
        sub cl,al
        add bl,cl
        mov ax,0
        mov al,[b]
        mov cl,4
        div cl
        add bl,al
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
