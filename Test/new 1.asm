; The code below will calculate the result of some arithmetic operations in the EAX register, save the value of the registers, then display the result value and restore the value of the registers.
bits 32

global start        

; declare extern functions
extern exit, printf  
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell assembler function is found in library msvcrt.dll
                          
segment data use32 class=data
	
	
segment code use32 class=code
	start:
		; will calculate 20 + 123 + 7 in EAX
		mov al, 250>>4
        mov al,0ffffh>>4
        mov al,0efffh>>12
        mov al,-1>>4
        mov al,-1>>12
		push dword 0      ; we place on stack parameter for exit
		call [exit]       ; call exit to end the program