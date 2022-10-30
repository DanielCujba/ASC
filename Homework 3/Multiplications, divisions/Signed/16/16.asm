bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 7293h
    b db 0A8h
    c dw 0B749h
    d db 4Bh
    e dd 7483AB72h
    x dq 768AC79Bh
    
; our code starts here
segment code use32 class=code
    start:
        mov EAX,[x]
        mov EDX,[x+4]       ;EDX:EAX=x
        mov EBX,2           ;EBX=2
        idiv EBX            ;EAX=x/2
        push EAX
        mov AL,[b]          ;AL=b
        cbw                 ;AX=b
        mov BX,AX           ;BX=b
        pop EAX
        add BX,[a]          ;BX=a+b
        mov ECX,EAX         ;ECX=x/2
        mov AX,100          ;AX=100
        imul BX              ;EAX=100*(a+b)
        add ECX,EAX         ;ECX=x/2+100*(a+b)
        mov AX,3            ;AX=3
        cwd                 ;DX:AX=3
        push AX
        mov AL,[d]          ;AL=d
        cbw                 ;AX=d
        mov BX,AX           ;BX=d
        pop AX
        add BX,[c]          ;BX=c+d
        idiv BX             ;AX=3/(c+d)
        cwde
        sub ECX,EAX         ;ECX=x/2+100*(a+b)-3/(c+d)
        mov EAX,ECX
        cdq
        mov EBX,EDX
        mov EAX,[e]         ;EAX=e
        imul dword [e]      ;EDX:EAX=e*e
        add EAX,ECX
        adc EDX,EBX           ;EDX:EAX=x/2+100*(a+b)-3/(c+d)+e*e
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
