bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)


;Given a byte string S of length l, obtain the string D of length l-1 as D(i) = S(i) * S(i+1) (each element of D is the product of two consecutive elements of S).


segment data use32 class=data
    ; ...
    S db 1,2,3,4
    l equ $-S
    D resw l-1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; mov ECX,0
        ; jmp_label:
            ; mov AL,[S+ECX]
            ; mov BL,[S+ECX+1]
            ; imul BL
            ; mov [D+2*ECX],AX
            ; inc ECX
            ; cmp ECX,l-1
            ; jb jmp_label
            
        mov ECX,l
        mov ESI,0
        jmp_label:
            mov AL,[S+ESI]
            mov BL,[S+ESI+1]
            imul BL
            mov [D+2*ESI],AX
            inc ESI
            loop jmp_label
            
           
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
