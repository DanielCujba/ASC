bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
                          
;Read two numbers a and b (in base 10) from the keyboard and calculate their product. This value will be stored in a variable called "result" (defined in the data segment).


segment data use32 class=data
    query db "%d",0
    a dd 0
    b dd 0
    result dq 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a
        push dword query
        call [scanf]
        add ESP,4*2
        
        push dword b
        push dword query
        call [scanf]
        add ESP,4*2
        
        mov EAX,[a]
        imul dword [b]
        mov [result],EAX
        mov [result+4],EDX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
