bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fprintf,fscanf,fread,fwrite,remove,rename,fclose
import exit msvcrt.dll  ; exit is a function that terminates the program. It is defined in msvcrt.dll
import fopen msvcrt.dll   ; fopen is a function that opens a file. It is defined in msvcrt.dll
import fprintf msvcrt.dll ; fprintf is a function that prints a formatted string to a file. It is defined in msvcrt.dll
import fscanf msvcrt.dll  ; fscanf is a function that reads a formatted string from a file. It is defined in msvcrt.dll
import fread msvcrt.dll   ; fread is a function that reads a block of data from a file. It is defined in msvcrt.dll
import fwrite msvcrt.dll  ; fwrite is a function that writes a block of data to a file. It is defined in msvcrt.dll
import remove msvcrt.dll  ; remove is a function that deletes a file. It is defined in msvcrt.dll
import rename msvcrt.dll  ; rename is a function that renames a file. It is defined in msvcrt.dll
import fclose msvcrt.dll  ; fclose is a function that closes a file. It is defined in msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_path_read db "a.txt", 0 ; the path to the file we want to open
    file_path_write db "b.txt", 0 ; the path to the file we want to open
    access_mode_read db "r", 0       ; the access mode we want to use when opening the file
    access_mode_write db "w", 0      ; the access mode we want to use when opening the file
    file_read dd 0 ; the file pointer returned by fopen
    file_write dd 0 ; the file pointer returned by fopen
    read_value dd 0 ; the value read from the file

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; open the file
        push    dword access_mode_read ; push the parameter for fopen onto the stack
        push    dword file_path_read ; push the parameter for fopen onto the stack
        call   [fopen]         ; call fopen to open the file
        add    esp, 4*2         ; remove the parameters from the stack
        cmp     eax, 0         ; compare the return value of fopen with 0
        jz     exit_label           ; if fopen returned 0, then the file could not be opened, so we exit_label the program
        mov     [file_read], eax    ; save the file pointer returned by fopen in the variable file
        
        push   dword access_mode_write ; push the parameter for fopen onto the stack
        push   dword file_path_write ; push the parameter for fopen onto the stack
        call   [fopen]         ; call fopen to open the file
        add    esp, 4*2         ; remove the parameters from the stack
        cmp     eax, 0         ; compare the return value of fopen with 0
        jz     exit_label           ; if fopen returned 0, then the file could not be opened, so we exit_label the program
        mov     [file_write], eax    ; save the file pointer returned by fopen in the variable file

        ; read the file
        loop_label:

        push    dword [file_read] ; push the parameter for fread onto the stack
        push    dword 1      ; push the parameter for fread onto the stack
        push    dword 1      ; push the parameter for fread onto the stack
        push    dword read_value ; push the parameter for fread onto the stack
        call   [fread]         ; call fread to read the file
        add    esp, 4*4         ; remove the parameters from the stack
        cmp    eax, 0         ; compare the return value of fread with 0
        jz     end           ; if fread returned 0, then the file could not be read, so we exit_label the program

        inc byte [read_value] ; increment the value read from the file

        push    dword [file_write] ; push the parameter for fwrite onto the stack
        push    dword 1      ; push the parameter for fwrite onto the stack
        push    dword 1      ; push the parameter for fwrite onto the stack
        push    dword read_value ; push the parameter for fwrite onto the stack
        call   [fwrite]         ; call fwrite to write the file
        add   esp, 4*4         ; remove the parameters from the stack
        cmp    eax, 0         ; compare the return value of fwrite with 0
        jz     exit_label           ; if fwrite returned 0, then the file could not be written, so we exit_label the program
        jmp loop_label

        end:

        ; close the file
        push    dword [file_read] ; push the parameter for fclose onto the stack
        call   [fclose]         ; call fclose to close the file
        add    esp, 4         ; remove the parameter from the stack
        push    dword [file_write] ; push the parameter for fclose onto the stack
        call   [fclose]         ; call fclose to close the file
        add    esp, 4         ; remove the parameter from the stack

        ;remove a.txt file
        push    dword file_path_read ; push the parameter for remove onto the stack
        call   [remove]         ; call remove to remove the file
        add    esp, 4         ; remove the parameter from the stack


        ;rename b.txt to a.txt
        push    dword file_path_read ; push the parameter for rename onto the stack
        push    dword file_path_write ; push the parameter for rename onto the stack
        call   [rename]         ; call rename to rename the file
        add    esp, 4*2         ; remove the parameters from the stack


        exit_label:
        push    dword 0      ; push the parameter for exit_label onto the stack
        call    [exit]       ; call exit_label to terminate the program
