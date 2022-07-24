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
  or  eax, 1 << 8               ; set the LM-bit
  wrmsr

  lgdt[GDT64.Pointer]

  ; Enable paging
  mov eax, cr0
  or eax, 1 << 31
  mov cr0, eax

  jmp GDT64.Code:Realm64

; Use 64-bit.
[bits 64]
; Initialise registers and the stack once in LM.
Realm64:
    cli                         ; Clear the interrupt flag.
    mov ax, GDT64.Data          ; Set the A-register to the data descriptor.
    mov ds, ax                  ; Set the data segment to the A-register.
    mov es, ax                  ; Set the extra segment to the A-register.
    mov fs, ax                  ; Set the F-segment to the A-register.
    mov gs, ax                  ; Set the G-segment to the A-register.
    mov ss, ax                  ; Set the stack segment to the A-register.

    mov rbp, 0x90000            ; Update our stack position so it is right
    mov rsp, rbp                ; at the top of the free space.

    call BEGIN_LM
