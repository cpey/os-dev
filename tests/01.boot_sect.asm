loop:
jmp loop
times 510-($-$$) db 0

; magic number at the end of the boot sector
dw 0xaa55
