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
        mov AL,[a]      ;AL=a
        cbw
        cwde
        cdq             ;EDX:EAX=a
        mov EBX,[d]
        mov ECX,[d+4]   ;ECX:EBX=d
        sub EBX,EAX
        sbb ECX,EDX     ;ECX:EBX=d-a
        sub EAX,[c]     ;EAX=a-c
        cdq
        sub EBX,EAX
        sbb ECX,EDX     ;ECX:EBX=(d-a)-(a-c)
        sub EBX,[d]
        sbb ECX,[d+4]   ;ECX:EBX=(d-a)-(a-c)-d
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
