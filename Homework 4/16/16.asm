bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4Fh
    b dw 8241h
    c resd 1

; our code starts here
segment code use32 class=code
    start:
        mov ECX,0
        mov CL,1111_1111b
        mov EAX,0
        mov AL,[a]
        and AL,1111_0000b
        shl EAX,4
        or ECX,EAX
        
        mov EBX,0
        mov BX,[b]
        and EBX, 0000_0011_1111_1100b
        shl EBX,10
        or ECX,EBX
        mov EAX,0
        mov AL,[a]
        and AL,0000_1111b
        shl EAX,20
        or ECX,EAX
        mov EAX,0
        mov AL,[b+1]
        ror EAX,8
        or ECX,EAX
        mov [c],ECX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
