bits 32
global function


segment code use32 class=code public
    function:
        mov esi, [esp+12]
        mov edi, [esp+4]
        loop1:
            movsb
            cmp [esi], byte 0
            jne loop1
        mov esi, [esp+8]
        loop2:
            movsb
            cmp [esi], byte 0
            jne loop2
        mov [edi], byte 0
        ret