bits 32
global start
extern exit,function,printf
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    str1 db "hello ",0
    str2 db "world",0
    new_str resb 100
    format db "%s",0

segment code use32 class=code
    start:
        push dword str1
        push dword str2
        push dword new_str
        call function
        add ESP,4*3
        push dword new_str
        push dword format
        call [printf]
        add ESP,4*2
        push dword 0
        call [exit]
