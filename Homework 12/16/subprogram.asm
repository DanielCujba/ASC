bits 32
global _subprogram

segment code use32 class=code public
    _subprogram:
        cld
        mov ESI,[ESP+4]
        mov EDI,[ESP+8]
        mov EAX,0
        mov EBX,0
        label:
            lodsb
            cmp byte AL,0
            je end
            cmp byte AL,'b'
            jne skip
            mov EAX,EBX
            stosd
            mov EBX,0
            jmp label
            skip:
            sub AL,'0'
            mov ECX,0
            mov Cl,AL
            mov EAX,EBX
            mov EDX,2
            mul EDX
            mov EBX,EAX
            add EBX,ECX
            jmp label
        end:
        ret