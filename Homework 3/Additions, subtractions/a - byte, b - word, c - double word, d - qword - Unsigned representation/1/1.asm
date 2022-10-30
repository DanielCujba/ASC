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
        mov EBX,0       ;EBX=0
        mov BL,[a]      ;EBX=a
        mov EDX,[d+4]     ;
        mov EAX,[d]   ;EDX:EAX=d
        add EAX,EBX
        adc EDX,0       ;EDX:EAX=a+d
        mov EBX,[c]
        mov ECX,0       ;ECX:EBX=c
        sub EBX,EAX
        sbb ECX,EDX     ;ECX:EBX=c-(a+d)
        push EBX
        push ECX
        mov EDX,[d+4]
        mov EAX,[d]   ;EDX:EAX=d
        mov ECX,0
        mov CX,[b]      ;ECX=b
        add EAX,ECX
        adc EDX,0       ;EDX:EAX=b+d
        pop ECX
        pop EBX         ;ECX:EBX=c-(a+d)
        add EAX,EBX
        adc EDX,ECX     ;EDX:EAX=c-(a+d)+(b+d)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
