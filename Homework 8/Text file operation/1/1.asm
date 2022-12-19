bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,printf,fread,strchr              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import strchr msvcrt.dll



; our data is declared here (the variables needed by our program)


;A text file is given. Read the content of the file, count the number of vowels and display the result on the screen. The name of text file is defined in the data segment.

segment data use32 class=data
    ; ...
    file_path db "text.txt",0
    access_mode db "r",0
    vowels db "aeiouAEIOU",0
    message db "The number of vowels in the file is: %d",0
    file dd 0
    a db 0
    count dd 0

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
        push dword [a]
        push dword vowels
        call [strchr]
        add ESP,4*2
        cmp EAX,0
        jz loop_label
        inc dword [count]
        jmp loop_label
        done:
        add ESP,4*4
        ; exit(0)
        push dword [file]
        call [fclose]
        add ESP,4*1
        push dword [count]
        push dword message
        call [printf]
        add ESP,4*2
        end:  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
