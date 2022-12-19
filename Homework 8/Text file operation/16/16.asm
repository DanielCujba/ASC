bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,printf,fread             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll



; our data is declared here (the variables needed by our program)


;A text file is given. Read the content of the file, count the number of letters 'y' and 'z' and display the values on the screen. The file name is defined in the data segment.

segment data use32 class=data
    ; ...
    file_path db "text.txt",0
    access_mode db "r",0
    message db `The number of 'y' in the file is: %d\nThe number of 'z' in the file is: %d`,0
    file dd 0
    a db 0
    count_y dd 0
    count_z dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode
        push dword file_path
        call [fopen]
        add ESP,4*2
        cmp EAX,0
        jz end
        mov [file],EAX
        
        push dword [file]
        push dword 1
        push dword 1
        push dword a
        
        loop_label:
        call [fread]
        cmp EAX,0
        jz done
        
        cmp byte [a],"y"
        jz inc_y
        cmp byte [a],"Y"
        jz inc_y
        
        cmp byte [a],"z"
        jz inc_z
        cmp byte [a],"Z"
        jz inc_z
        
        jmp loop_label
        
        inc_y:
        inc dword [count_y]
        jmp loop_label
        
        inc_z:
        inc dword [count_z]
        jmp loop_label
        
        done:
        add ESP,4*4
        push dword [file]
        call [fclose]
        add ESP,4*1
        
        push dword [count_z]
        push dword [count_y]
        push dword message
        call [printf]
        add ESP,4*3
        end:  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
