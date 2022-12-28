bits 32
global _subprogram

segment code use32 class=code public
    _subprogram:
        mov ECX,8
        mov EBX,[ESP+4]
        mov EAX,[ESP+8]
        .label:
            mov [EBX+ECX*4-4],EAX
            rol EAX,4
        loop .label
        ret
