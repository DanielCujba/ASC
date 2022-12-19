%ifndef _SUBPROGRAM_ASM_
%define _SUBPROGRAM_ASM_ 
subprogram:
    mov ECX,8
    mov EBX,[ESP+4]
    mov EAX,[ESP+8]
    .label:
        mov [EBX+ECX*8],EAX
        rol EAX,4
    loop .label
    ret

%endif