;
; A simple boot sector program that demonstrates addressing.
; Specifying where the code is being loaded.
;
[org 0x7c00]

mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; Second attempt
mov al, [the_secret]
int 0x10

the_secret:
db "X"

; Padding and magic BIOS number.
times 510 - ($-$$) db 0
dw 0xaa55
