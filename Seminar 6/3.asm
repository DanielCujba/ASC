bits 32
global start
extern exit, printf, scanf, fopen, fclose, fread
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll


segment data use32 class=data
    format db "%X", 0
    n dd 0
    path db "textfile.txt", 0
    mode db "r", 0
    filehandle dd 0
    s db 0
    string resb 17


segment code use32 class=code
    start:
        push dword n
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword mode
        push dword path
        call [fopen]
        add esp, 4*2
        cmp eax, 0
        jz end
        mov [filehandle], eax
        
        mov eax,0
        mov ax, [n]
        mov edi, string
        loop_label:
            push eax
            push edi
            push dword [filehandle]
            push dword 1
            push dword 1
            push dword s
            call [fread]
            add esp, 4*3
            cmp eax, 0
            jz end
            pop edi
            pop eax
            shr eax, 1
            jnc loop_label
            mov edx,[s]
            mov [edi], edx
            inc edi
            jmp loop_label
        end:
        mov byte [edi], 0
        push dword string
        call [printf]
        add esp, 4
        push dword [filehandle]
        call [fclose]
        add esp, 4
        push dword 0
        call [exit]


