bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)

;Read two numbers a and b (in base 10) from the keyboard. Calculate and print their arithmetic average in base 16

segment data use32 class=data
    read_query db "%d",0
    write_query db "The arithmetic average in base 16 is: 0x%08X",0
    a dd 0
    b dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a
        push dword read_query
        call [scanf]
        add ESP,4*2
        
        push dword b
        push dword read_query
        call [scanf]
        add ESP,4*2
        
        mov EAX,[a]
        add EAX,[b]
        sar EAX,1
        
        push EAX
        push write_query
        call [printf]
        add ESP, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
