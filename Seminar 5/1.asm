bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll  ; printf is a function that prints a string to the standard output. It is defined in msvcrt.dll
import scanf msvcrt.dll   ; scanf is a function that reads a string from the standard input. It is defined in msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    message db "n=",0
    n dd 0
    read db "%d",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Write a programs that prints the message "n=" on the screen and then read from keyword the value for the signed number n
        push dword message
        call [printf]
        add ESI,4*1
        push dword n
        push dword read
        call [scanf]
        add ESI,4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
