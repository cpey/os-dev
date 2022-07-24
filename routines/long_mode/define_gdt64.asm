;
; Definition of GDT and GDT descriptor for 64-bit long mode
;

; Access bits
PRESENT        equ 1 << 7
NOT_SYS        equ 1 << 4
EXEC           equ 1 << 3  ; Executable
DC             equ 1 << 2  ; Conforming
RW             equ 1 << 1  ; Readable/Writable for code/data GDT
ACCESSED       equ 1 << 0

; Flags bits
GRAN_4K       equ 1 << 7   ; Granularity
SZ_32         equ 1 << 6   ; Size
LONG_MODE     equ 1 << 5   ; Long mode

GDT64:
   .Null: equ $ - GDT64
       dq 0
   .Code: equ $ - GDT64
       dd 0xFFFF                                   ; Base (low, bits 0-15)  & Limit (bit 0-15)
       db 0                                        ; Base (mid, bits 16-23)
       db PRESENT | NOT_SYS | EXEC | RW            ; Access
       db GRAN_4K | LONG_MODE | 0xF                ; Flags & Limit (high, bits 16-19)
       db 0                                        ; Base (high, bits 24-31)
   .Data: equ $ - GDT64
       dd 0xFFFF                                   ; Base (low, bits 0-15)  & Limit (bit 0-15)
       db 0                                        ; Base (mid, bits 16-23)
       db PRESENT | NOT_SYS | RW                   ; Access
       db GRAN_4K | SZ_32 | 0xF                    ; Flags & Limit (high, bits 16-19)
       db 0                                        ; Base (high, bits 24-31)
   .TSS: equ $ - GDT64
       dd 0x00000068
       dd 0x00CF8900
   .Pointer:
       dw $ - GDT64 - 1
       dq GDT64

; GDT64.Code, and GDT64.Data will be used as constants for the GDT segment
; descriptor offsets for CODE and DATA segments in long mode.
