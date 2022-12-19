bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll  ; printf is a function that prints a formatted string to the standard output
import scanf msvcrt.dll   ; scanf is a function that reads a formatted string from the standard input

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    read_number db "%d",0
    a dd 0
    b dd 0
    message db "Sum=%d",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; read a and b
        push    dword a
        push    dword read_number
        call    [scanf]
        add    esp, 4*2
        push    dword b
        push    dword read_number
        call    [scanf]
        add    esp, 4*2
        ;print out the sum
        mov    eax, [a]
        add    eax, [b]
        push    eax
        push    dword message
        call    [printf]
        add    esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
