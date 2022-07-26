;
; Sets the paging structures
;
[bits 32]
[global set_paging_structures]  ; In order to make this symbol visible when the    
                                ; object file that results from this module is used
                                ; as input file to the linker (e.g. test #16).
set_paging_structures: 

  ; Clear the page tables
  mov edi, 0x70000
  mov ecx, 0x4000 >> 2
  xor eax,eax
  rep stosd

  ; Allocating static paging structures.
  mov dword [0x70000], 0x71000 + 0b001 ; first PDP table
  mov dword [0x71000], 0x72000 + 0b111 ; first page directory
  mov dword [0x72000], 0x73000 + 0b111 ; first page table

  mov edi, 0x73000              ; address of first page table
  mov eax, 0 + 0b111
  mov ecx, 512                  ; number of pages to map (2 MB)

; VA                 PTE        PA
; --------------------------------------------
; 0000000000000000   0x73000    0x000000
; 0000000000001000   0x73004    0x001000
; 0000000000002000   0x73008    0x002000
; ...
; 00000000001FE000   0x737FC    0x1FE000
; 00000000001FF000   0x73800    0x1FF000
make_page_entries:
  stosd
  add edi, 4
  add eax, 0x1000
  loop make_page_entries

  ; load page-map level-4 base
  mov eax, 0x70000
  mov cr3, eax

  ret
