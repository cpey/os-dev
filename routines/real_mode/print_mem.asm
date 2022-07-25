;
; Print memory
;
print_memory:
; bx - Adddress to start printing from
; cx - Bytes to print
  mov [BYTES_TO_PRINT], cx
  mov bx, BEGIN_LM_OFF    ; Address to load the sectors to (0x7e00).
  xor cx, cx
print_bytes_cont:
  mov dx, [bx]
  call print_hex_byte
  inc cx
  cmp cx, [BYTES_TO_PRINT]
  jge print_bytes_end
  inc bx
  jmp print_bytes_cont
  call disk_load
print_bytes_end:
  ret

BYTES_TO_PRINT db 0
