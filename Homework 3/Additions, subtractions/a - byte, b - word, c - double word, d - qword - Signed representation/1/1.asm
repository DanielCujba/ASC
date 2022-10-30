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
        cwde            ;EAX=a
        mov EBX,EAX     ;EBX=a
        mov AX,[b]      ;AX=b
        cwde            ;EAX=b
        add EAX,[c]     ;EAX=c+b
        add EAX,EBX     ;EAX=c+b+a
        cdq             ;EDX:EAX=c+b+a
        mov EBX,[d]
        mov ECX,[d+4]   ;ECX:EBX=d
        add EBX,[d]
        adc ECX,[d+4]   ;ECX:EBX=d+d
        sub EAX,EBX
        sbb EDX,ECX     ;EDX:EAX=(c+b+a)-(d+d)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
