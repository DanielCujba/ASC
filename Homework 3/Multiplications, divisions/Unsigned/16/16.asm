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
        div EBX             ;EAX=x/2
        mov BX,0
        mov BL,[b]          ;BX=b
        add BX,[a]          ;BX=a+b
        mov ECX,EAX         ;ECX=x/2
        mov AX,100          ;AX=100
        mul BX              ;EAX=100*(a+b)
        add ECX,EAX         ;ECX=x/2+100*(a+b)
        mov AX,3            ;AX=3
        mov DX,0            ;DX:AX=3
        mov BX,0            ;BX=0
        mov BL,[d]            ;BX=d
        add BX,[c]          ;BX=c+d
        div BX              ;AX=3/(c+d)
        mov EBX,0
        mov BX,AX           ;EBX=3/(c+d)
        sub ECX,EBX         ;ECX=x/2+100*(a+b)-3/(c+d)
        mov EAX,[e]         ;EAX=e
        mul dword [e]       ;EDX:EAX=e*e
        add EAX,ECX
        adc EDX,0           ;EDX:EAX=x/2+100*(a+b)-3/(c+d)+e*e
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
