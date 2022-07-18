;
; A simple boot sector program that demonstrates addressing.
;
mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; First attempt
mov al, the_secret
int 0x10 ; Does this print an X? Fails

; Second attempt
mov al, [the_secret]
int 0x10        ; Does this print an X? Fails
; The problem is, that the CPU treats the offset as though it was from the
; start of memory, rather than the start address of our loaded code, which
; would land it around about in the interrupt vector.

; Third attempt
mov bx, the_secret
add bx, 0x7c00  ; Address where our boot sector is loaded by the BIOS
mov al, [bx]
int 0x10        ; Does this print an X? Succeeds

; Fourth attempt
; Manually calculating the offset from the raw binary
mov al, [0x7c1d]
int 0x10        ; Does this print an X? Succeeds
jmp $           ; Jump forever.

the_secret:
db "X"

; Padding and magic BIOS number.
times 510 - ($-$$) db 0
dw 0xaa55
