[bits 32]
;
; Switch to long mode
;
switch_to_lm:
  ; Enable physical-address extensions
  mov eax, cr4
  or eax, 1 << 5
  mov cr4, eax

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

; VA                 PTE        Phys. Address
; --------------------------------------------
; 0000000000000000   0x73000    0x001000
; 0000000000001000   0x73004    0x002000
; 0000000000002000   0x73008    0x003000
; ...
; 00000000001FE000   0x737FC    0x1FF000
; 00000000001FF000   0x73800    0x200000
make_page_entries:
  stosd
  add edi, 4
  add eax, 0x1000
  loop make_page_entries

  ; load page-map level-4 base
  mov eax, 0x70000
  mov cr3, eax

  ; Enable long mode
  mov ecx, 0xC0000080           ; EFER MSR
  rdmsr
  or eax, 1 << 8                ; set the LM-bit
  wrmsr

  lgdt[GDT64.Pointer]

  ; Enable paging
  mov eax, cr0
  or eax, 1 << 31
  mov cr0, eax

  jmp GDT64.Code:Realm64

; Use 64-bit.
[bits 64]
; Initialize registers and the stack once in LM.
Realm64:
    cli                         ; Clear the interrupt flag.
    mov ax, GDT64.Data          ; Set the A-register to the data descriptor.
    mov ds, ax                  ; Set the data segment to the A-register.
    mov es, ax                  ; Set the extra segment to the A-register.
    mov fs, ax                  ; Set the F-segment to the A-register.
    mov gs, ax                  ; Set the G-segment to the A-register.
    mov ss, ax                  ; Set the stack segment to the A-register.

    mov rbp, 0x1FE000           ; Update our stack position in VM
    mov rsp, rbp

    call BEGIN_2ND_STAGE
