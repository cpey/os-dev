;
; A boot sector that prints a string using our function.
;

[org 0x7c00]        ; Tell the assembler where this code will be loaded

mov bp, 0x8000      ; Set the base of the stack a little above where BIOS
mov sp, bp          ; loads our boot sector - so it won ’t overwrite us.

mov dx, 0x1fb6      ; store the value to print in dx
call print_hex

jmp $               ; Hang

%include "print_string.asm"
%include "print_hex.asm"

; Padding and magic BIOS number.
times 510 - ( $ - $$ ) db 0
dw 0xaa55
