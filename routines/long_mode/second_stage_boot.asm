[org 0x1000]
;
; Meant to be copied at the 2nd sector of boot image. It simulates
; a 2nd stage bootloader running in 64-bit long mode.
;
[bits 64]
SECOND_STAGE_BOOT:
  mov ebx, MSG_LONG_MODE
  call print_string_lm    ; Use our 64-bit print routine.

  jmp $                   ; Hang.

%include "print_string_lm.asm"

MSG_LONG_MODE db "Successfully landed 2nd stage bootloader in 64-bit Long Mode", 0

; Second sector padding
times 512 - ($ - $$) db 0
