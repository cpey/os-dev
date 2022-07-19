;
; A simple boot sector program that demonstrates segment offsetting
;

; Because we do not use the org directive, the assmebler does not offset our
; labels to the correct memory locations.

mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; First attempt
mov al, [the_secret]
int 0x10                    ; Does this print an X? Fails

; Second attempt
mov bx, 0x7c0               ; Can’t set ds directly, so set bx
mov ds, bx                  ; then copy bx to ds.
mov al, [the_secret]
int 0x10                    ; Does this print an X? Succeeds

; Third attempt
mov al, [es:the_secret]     ; Tell the CPU to use the es (not ds) segment.
int 0x10                    ; Does this print an X? Fails

; Fourth attempt
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10                    ; Does this print an X? Succeeds

jmp $                       ; Jump forever.

the_secret:
db "X"

; Padding and magic BIOS number.
times 510 -($ - $$) db 0
dw 0xaa55
