;
; Print memory
;
print_mem:
; bx - Adddress to start printing from
; cx - Bytes to print
  mov [BYTES_TO_PRINT], cx
  mov bx, BEGIN_LM_OFF    ; Address to load the sectors to (0x7e00).
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
