;Read a string of unsigned numbers in base 10 from keyboard. 
;Determine the maximum value of the string and write it in the file 
;max.txt (it will be created) in 16 base.

bits 32

global start

extern exit,printf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

%include "subprogram.asm"
%include "writefile.asm"

segment data use32 class=data
    dd 0
    read_format db "%100[0-9a-zA-Z ]",0
    write_format db "%X",0
    text_file db "text_file.txt",0
    mode db "w",0
    string times 101 db 0 
    max resd 1

segment code use32 class=code
start:
    push dword string
    push dword read_format
    call [scanf]
    add ESP,4*2
    push dword max
    push dword string
    call get_max
    add ESP,4*2
    push dword write_format
    push EAX
    push dword mode
    push dword text_file
    call write_to_file
    add ESP, 4*2
    push dword 0
    call [exit]