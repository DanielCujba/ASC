;Se citesc dintr-un fisier caractere, pana la intalnirea caracterului 
;#. Sa se afiseze la consola numarul literelor mici, urmat de numarul 
;literelor mari citite.

bits 32
global start
extern exit,printf,fread,fopen,fclose


import exit msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll


segment data use32 class=data
    file_path db "file.txt",0
    mode db "r",0
    file resd 1
    char resb 1
    upcount dd 0
    locount dd 0
    upwrite db "The number of upper case letters:  %d",10,13,0
    lowrite db "The number of lower case letters:  %d",10,13,0
    


segment code use32 class=code
start:
    push dword mode
    push dword file_path
    call [fopen]
    add esp,4*2
    mov [file], EAX
    cmp EAX,0
    je error

    
    loop_label:
        push dword [file]
        push dword 1
        push dword 1
        push dword char
        call [fread]
        add esp,4*4
        cmp EAX,"0"
        je end
        cmp byte [char],"#"
        je end
        cmp byte [char],"A"
        jl loop_label
        cmp byte [char],"z"
        jg loop_label
        cmp byte [char],"Z"
        jle upper
        cmp byte [char],"a"
        jge lower
        jmp loop_label


        upper:
            inc dword [upcount]
            jmp loop_label
        lower:
            inc dword [locount]
            jmp loop_label

    end:
    push dword [file]
    call [fclose]
    add esp, 4*1

    push dword [locount]
    push dword lowrite
    call [printf]
    add esp,4*2

    push dword [upcount]
    push dword upwrite
    call [printf]
    add esp,4*2

    error:

    push dword 0
    call [exit]

