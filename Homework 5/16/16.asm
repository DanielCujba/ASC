bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    S1 db 'abcbef'
    l1 equ $-S1
    S2 db '123456'
    l2 equ $-S2
    D resb l1/2+l2/2+l2 % 2

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EDI,0
        mov ESI,0
        S2_label:
            mov AL,[S2+ESI]
            mov [D+EDI],AL
            inc EDI
            add ESI,2
            cmp ESI,l2
            jb S2_label
        mov ESI,0
        S1_label:
            mov AL,[S1+1+ESI*2]
            mov [D+EDI],AL
            inc ESI
            inc EDI
            cmp ESI,l1/2
            jb S1_label
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
