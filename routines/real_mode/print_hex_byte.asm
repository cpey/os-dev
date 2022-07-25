;
; Print the byte in dl as hex
;
print_byte:
; dl byte to print
; bx destination string to fill with the ascii values of the byte (dl)
; cx iteration counter
; ax number of positions to shift right the byte to print
  pusha
  mov bx, HEX_OUT
  xor cx, cx
ph_next:
  mov ax, 4           ; get each nibble at a time by doing
  cmp cx, 2           ; bx = (dl >> i * 4) & 0x0F
  jge ph_out
  push cx
  shl cx, 2
  sub ax, cx
  push dx
ph_shr:
  cmp ax, 0
  jle ph_enc
  shr dl, 1
  dec ax
  jmp ph_shr
ph_enc:
  and dl, 0x0F
  cmp dl, 0xa
  jge ph_enc_a_to_f
  add dl, 0x30        ; calculate ascii for hex values 0 to 9
  jmp ph_update_char
ph_enc_a_to_f:
  add dl, 0x57        ; calculate ascii for hex values a to f
ph_update_char:
  mov BYTE [bx], dl   ; update encoded ascii to the hex string
  pop dx
  pop cx
  inc cx
  inc bx
  jmp ph_next
ph_out:
  mov bx, HEX_OUT
  call print_string
  popa
  ret

; Data
HEX_OUT:
  db "00", 0
