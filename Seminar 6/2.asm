bits 32
global start

extern sum,exit,printf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    format db "%u",0
    n dd 0
    result dd 0

segment code use32 class=code
    start:
    push dword n
    push dword format
    call [scanf]
    add ESP,4*2
    push dword result
    push dword [n]
    call sum
    add ESP,4*2
    push dword [result]
    push dword format
    call [printf]
    add ESP,4*2
    push dword 0
    call [exit]

