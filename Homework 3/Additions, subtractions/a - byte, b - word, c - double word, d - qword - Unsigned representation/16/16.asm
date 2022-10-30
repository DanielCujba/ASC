bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 12h
    b dw 74A1h
    c dd 243F2149h
    d dq 768AC79B8296E852h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX,0
        mov EBX,0
        mov AL,[a]      ;EAX=a
        mov BX,[b]      ;EBX=b
        add EBX,EAX     ;EBX=b+a
        mov ECX,[c]     ;ECX=c
        sub ECX,EAX     ;ECX=c-a
        sub ECX,EBX     ;ECX=c-a-(b+a)
        add ECX,[c]     ;ECX=c-a-(b+a)+c
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
