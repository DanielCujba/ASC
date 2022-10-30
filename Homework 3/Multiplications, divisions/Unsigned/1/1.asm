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
    b dd 7483AB72h
    c dq 768AC79B8296E852h

; our code starts here
segment code use32 class=code
    start:
        mov AL,[a]      ;AL=a
        mul byte [a]    ;AX=a*a
        mov BX,AX
        mov EAX,0
        mov AX,BX       ;EAX=a*a
        sub EAX,[b]     ;EAX=a*a-b
        add EAX,7       ;EAX=a*a-b+7
        mov EDX,0       ;EDX:EAX=a*a-b+7
        mov EBX,0       ;EBX=0
        mov BL,[a]      ;EBX=a
        add EBX,2       ;EBX=2+a
        div EBX         ;EAX=(a*a-b+7)/(2+a)
        mov EDX,0       ;EDX:EAX=(a*a-b+7)/(2+a)
        add EAX,[c]
        adc EDX,[c+4]   ;EDX:EAX=c+(a*a-b+7)/(2+a)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
