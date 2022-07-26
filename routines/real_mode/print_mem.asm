;
; Print memory
;
print_mem:
; bx - Adddress to start printing from
; cx - Bytes to print
  mov [BYTES_TO_PRINT], cx
  xor cx, cx
print_mem_cont:
  mov dx, [bx]
  call print_hex_byte
  inc cx
  cmp cx, [BYTES_TO_PRINT]
  jge print_mem_end
  inc bx
  jmp print_mem_cont
  call disk_load
print_mem_end:
  ret

BYTES_TO_PRINT db 0

%include "print_hex_byte.asm"
