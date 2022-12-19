;An unsigned number a on 32 bits is given. Print the hexadecimal 
;representation of a, but also the results of the circular permutations 
;of its hex digits.

bits 32
global start

extern exit,printf
import exit msvcrt.dll
import printf msvcrt.dll

%include "subprogram.asm"

segment data use32 class=data
    format db "%X ",0
    a dd 12ABCDEFh
    permutations resd 8

segment code use32 class=code
start:
    push dword [a]
    push dword permutations
    call subprogram
    add ESP,4*2
    mov ECX,8
    label:
    push ECX
    push dword [permutations+ECX*8]
    push dword format
    call [printf]
    add ESP,4*2
    pop ECX
    loop label
    push dword 0
    call [exit]

