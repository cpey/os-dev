;
; A boot sector that enters 64-bit long mode. The boot sector is sp
;
[org 0x7c00]
BEGIN_LM_OFF equ 0x1000

  mov [BOOT_DRIVE], dl    ; BIOS stores our boot drive in DL

  mov bp, 0x9000          ; Set the stack.
  mov sp, bp
 
;  mov bx, MSG_REAL_MODE
;  call print_string
  call load_sector        ; Load the 2nd sector
  ;mov bx, BEGIN_LM_OFF
  ;mov cx, 20
  ;call print_mem
  call switch_to_pm       ; Note that we never return from here.

  jmp $

%include "print_hex.asm"
;%include "print_hex_byte.asm"
;%include "print_mem.asm"
%include "disk_load.asm"
%include "define_gdt.asm"
%include "define_gdt64.asm"
%include "print_string.asm"
;%include "print_string_pm.asm"
%include "switch_to_pm.asm"
%include "switch_to_lm.asm"

[bits 16]
; Load 2nd sector
load_sector:

  mov bx, BEGIN_LM_OFF    ; Address to load the sectors to (0x7e00).
  mov dh, 2               ; How many sectors to load (excluding
  mov dl, [BOOT_DRIVE]    ; the boot sector) from the boot disk.
  call disk_load

  ret

[bits 32]
BEGIN_PM:
;  mov ebx, MSG_PROT_MODE
;  call print_string_pm    ; Use our 32-bit print routine.
  call switch_to_lm       ; Note that we never return from here.

  jmp $

; Global variables
BOOT_DRIVE    db 0
;MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
;MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0

; Bootsector padding
times 510 - ($ - $$) db 0
dw 0xaa55

; Second sector
[bits 64]
BEGIN_LM:
  mov ebx, MSG_LONG_MODE
  call print_string_lm    ; Use our 64-bit print routine.

  jmp $                   ; Hang.

%include "print_string_lm.asm"

MSG_LONG_MODE db "Successfully landed in 64-bit Long Mode", 0

; Second sector padding
times 1024 - ($ - $$) db 0
