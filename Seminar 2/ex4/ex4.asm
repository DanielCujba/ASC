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
    a db 10
    b dw 2
    c dd 3 
    d db 4
    f dw 1
    g dw 2
    x dq 2
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]          ;AL=a
        cbw                 ;AX=a
        imul word [b]       ;DX:AX=a*b
        push dx             ;stack: dx,
        push ax             ;stack: dx,ax
        mov al,[d]          ;AL=d
        cbw                 ;AX=d
        cwde                ;EAX=d
        mov ecx,[c]         ;ECX=c
        sub ecx,eax         ;ECX=c-d
        pop eax             ;EAX=a*b , stack:
        cdq                 ;EDX:EAX=a*b
        idiv dword ecx      ;EAX=(a*b)/(c-d)
        mov ecx,eax         ;ECX=(a*b)/(c-d)
        mov ax,[f]          ;AX=f
        imul word [g]       ;DX:AX=f*g
        push dx             ;stack: DX
        push ax             ;stack: DX,AX
        pop eax             ;EAX=f*g , stack:
        add eax,ecx         ;EAX=(a*b)/(c-d)+f*g
        cdq                 ;EDX:EAX=(a*b)/(c-d)+f*g
        add [x],eax
        adc [x+4],edx
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
