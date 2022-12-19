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
    s1 db 12h,78h
    l1 equ $-s1
    s2 db 34h,0ABh
    l2 equ $-s2
    s3 resb l1+l2
    l3 equ $-s3
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX,l3
        mov ESI,0
        mov EDX,0
        mov EDI,s3
        cld
        
        label:
            mov AL,0FFh
            cmp ESI,l1
            jge a
            mov AL,[s1+ESI]
            a:
            mov BL,0FFh
            cmp EDX,l1
            jge b
            mov BL,[s2+EDX]
            b:
            cmp AL,BL
            jb less
            mov AL,BL
            inc EDX
            STOSB
            dec ECX
            jmp comp
            less:
            inc ESI
            dec ECX
            STOSB
            jmp comp
            comp:
                cmp ECX,0
                jg label
               
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
