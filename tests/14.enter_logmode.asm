;
; A boot sector that enters 64-bit long mode.
;
[org 0x7c00]

  mov bp, 0x9000          ; Set the stack.
  mov sp, bp
  
  mov bx, MSG_REAL_MODE
  call print_string

  call switch_to_pm       ; Note that we never return from here.
  
  jmp $

%include "define_gdt.asm"
%include "print_string.asm"
%include "print_string_lm.asm"
%include "switch_to_pm.asm"
%include "switch_to_lm.asm"

[bits 32]
BEGIN_PM:
  call switch_to_lm       ; Note that we never return from here.

  jmp $

[bits 64]
BEGIN_LM:
  mov ebx, MSG_LONG_MODE
  call print_string_lm    ; Use our 32-bit print routine.

  jmp $                   ; Hang.

; Global variables
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_LONG_MODE db "Successfully landed in 64-bit Long Mode", 0

; Bootsector padding
times 510 - ($ - $$) db 0
dw 0xaa55
