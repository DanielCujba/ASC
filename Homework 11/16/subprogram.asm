%ifndef _SUBPROGRAM_ASM_
%define _SUBPROGRAM_ASM_

table db ""
maximum dd 0

get_max:
    mov ESI,[ESP+4]
    begin:
    mov ECX,0
    loop_label:
    lodsb
    cmp AL,' '
    je eon
    cmp AL,0
    je zero
    sub AL,"0"
    mov EBX,0
    mov BL,AL
    mov EAX,ECX
    mov EDX,10
    mul EDX
    add EAX,EBX
    mov ECX,EAX
    jmp loop_label
    eon:
        cmp ECX,[maximum]
        jb begin
        mov [maximum],ECX
        jmp begin
    zero:
    cmp ECX,[maximum]
    jb ending
    mov [maximum],ECX
    ending:
    mov EAX,[maximum]
    ret
%endif
