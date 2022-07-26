;
; Sets CPU to 64-bit Long Mode
;
[bits 32]
[global set_long_mode]          ; In order to make this symbol visible when the    
                                ; object file that results from this module is used
                                ; as input file to the linker (e.g. test #16).
RET_LM dq 0
set_long_mode:  
  mov [RET_LM], edi

  ; Enable physical-address extensions
  mov eax, cr4
  or eax, 1 << 5
  mov cr4, eax

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

    call [RET_LM]

%include "define_gdt64.asm"
