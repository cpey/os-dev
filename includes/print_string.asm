print_string:
    pusha
    mov ah, 0x0e
ps_next:
    cmp BYTE [bx], 0
    je ps_out
    mov al, [bx]
    int 0x10
    inc bx
    jmp ps_next
ps_out:
    popa
    ret
