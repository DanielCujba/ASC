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
    a dw 4A2Fh
    b dw 8241h
    c dw 931Dh
    d resw 1

; our code starts here
segment code use32 class=code
    start:
        mov AX,[a]
        and AX,0000_0000_0011_1110b
        shr AX,1
        
        mov BX,[b]
        and BX,0000_0111_1100_0000b
        shr BX,6
        
        mov CX,[c]
        and CX,1111_1000_0000_0000b
        shr CX,11
        
        mov DX,0
        add DX,AX
        add DX,BX
        add DX,CX
        mov [d],DX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
