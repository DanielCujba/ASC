%ifndef _WRITEFILE_ASM_
%define _WRITEFILE_ASM_

extern fopen,fprintf,fclose
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

write_to_file:
    mov EAX,[ESP+4*1]
    mov EBX,[ESP+4*2]
    push EBX
    push EAX
    call [fopen]
    add ESP,4*2
    mov ECX,[ESP+4*3]
    mov EDX,[ESP+4*4]
    push ECX
    push EDX
    push EAX
    call [fprintf]
    pop EAX
    add ESP,4*2
    push EAX
    call [fclose]
    add ESP,4*1
    ret
%endif