bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 1
    b db 1
    c dw 1
    d dw 1
    x resd 1

; our code starts here
segment code use32 class=code
    start:
        mov ax,[a]      ;AX=a-low
        mov dx,[a+2]    ;DX=a-high  DX:AX=a-low
        mov bx,2        ;BX=2
        idiv bx         ;AX=a/2
        mov dx,ax       ;DX=a/2
        mov al,[b]      ;AL=b
        mov bl,3        ;BL=3
        imul bl         ;AX=b*3
        add dx,ax       
        mov ax,[c]
        imul word [d]
        push dx
        push ax
        pop eax
        mov eax,ecx
        mov ax,dx
        cwde
        sub eax,ecx
        add eax,100
        mov [x],eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
