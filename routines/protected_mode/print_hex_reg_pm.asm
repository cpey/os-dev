;
; Print register value directly to memory (i.e. without using BIOS)
;
[bits 32]
WORD_SIZE equ 4         ; 4-byte word

print_hex_reg_pm:
  ; edx regsiter to print
  pusha
  mov edi, HEX_OUT      ; ecx: destination string to fill with the ascii
                        ; values of the word (edx)                      
  mov eax, WORD_SIZE    
  shl eax, 1            ; eax: nibble position to print
phrpm_cont:
  mov ecx, edx
  mov ebx, eax          ; positions to shift right: ebx = (4 * (eax - 1))
  dec ebx
  shl ebx, 2
  cmp ebx, 0
  je phrpm_no_shr
phrpm_shr:              ; Shift to the nibble to write
  shr ecx, 1
  dec ebx
  jnz phrpm_shr
  ;cmp ebx, 0
  ;jg phrpm_shr
phrpm_no_shr:
  and ecx, 0x0000000F
  push edx
  mov dl, cl
  call enc_dl_low_to_ascii
  mov BYTE [edi], dl    ; update encoded ascii to the hex string
  pop edx
  inc edi
  dec eax
  jnz phrpm_cont
phrpm_out:
  mov ebx, HEX_OUT
  call print_string_pm
  popa
  ret

enc_dl_low_to_ascii:
  and dl, 0x0F
  cmp dl, 0xa
  jge edlta_update_byte_enc_a_to_f
  add dl, 0x30          ; calculate ascii for hex values 0 to 9
  jmp edlta_update_byte_update_char
edlta_update_byte_enc_a_to_f:
  add dl, 0x57          ; calculate ascii for hex values a to f
edlta_update_byte_update_char:
  ret

; Data
HEX_OUT:
  db "00000000", 0

%include "print_string_pm.asm"
