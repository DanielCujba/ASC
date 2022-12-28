bits 32
global sum

segment code use32 class=code
    sum:
        mov EAX,[ESP+4]
        mov EBX,0
        mov ECX,10
        loop1:
            cmp eax,0
            je end
            mov EDX,0
            div ECX
            add EBX,EDX
            jmp loop1
        
        end:
        mov EDX,[ESP+8]
        mov [EDX],EBX
        ret