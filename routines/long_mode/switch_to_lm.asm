[bits 32]
;
; Switch to long mode
;
switch_to_lm:

  call set_paging_structures

  mov edi, BEGIN_LM               ; VA called once in 64-bit LM
  call set_long_mode

%include "set_paging_structures.asm"
%include "set_long_mode.asm"
