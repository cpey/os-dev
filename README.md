# os-dev

Set of exercises to study on x86 platform boot and OS development.

## Tests

| ID | Boot sector program        | Description                                                                 |
|----|----------------------------|-----------------------------------------------------------------------------|
| 01 | 01.boot_sect.asm           | Simple boot sector written in assembly language.                            |
| 02 | 02.boot_sect_print.asm     | Prints a message to the screen using a BIOS routine.                        |
| 03 | 03.addressing.asm          | Addressing demonstration.                                                   |
| 04 | 04.addressing.fixed.asm    | Specifying the assembler the program load address.                          |
| 05 | 05.stack_manipulation.asm  | Demonstrates the use of the stack.                                          |
| 06 | 06.print_string.asm        | Prints string using function.                                               |
| 07 | 07.print_hex_strings.asm   | Prints a register value as a hex string.                                    |
| 08 | 08.addessing.segment.asm   | Memory addressing using segment offsetting.                                 |
| 09 | 09.read_sector.asm         | Read sectors from boot disk.                                                |
| 10 | 10.enter_protmode.asm      | Enters 32-bit protected mode.                                               |
| 11 | 11.enter_protmode_vga.asm  | Enters 32-bit protected mode clearing the screen.                           |
| 12 | 12.boot_kernel.asm         | Boots a C kernel in 32-bit protected mode.                                  |
| 13 | 12.boot_kernel.asm         | Boots a C kernel in 32-bit protected mode using a kernel entry routine.     |
| 14 | 14.enter_longmode.asm      | Enters 64-bit long mode.                                                    |
| 15 | 15.boot_sect_split.asm     | Boots into a second stage bootloader in 64-bit long mode.                   |
| 16 | 12.boot_kernel.asm         | Boots a C kernel as in #13, which enters 64-bit long mode.                  |

Build and run given test #id:  
`$ make test <#id>`

## References

[1] Writing a Simple Operating System — from Scratch by Nick Blundell  
https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

[2] Writing Your Own Toy Operating System: Guides & Tutorials  
http://www.independent-software.com/operating-system-development.html

[3] Yu Wangs Website documentation: Entering 32bit Protected Mode  
http://homepages.rpi.edu/~wangy52/PersonalWebsite/build/html/Misc/MyOS/src/Day02/Day02.html

[4] ROM BIOS — Vitaly Filatof  
http://vitaly_filatov.tripod.com/ng/asm/asm_001.html

[5] OSDev.org: Setting Up Long Mode  
https://wiki.osdev.org/Setting_Up_Long_Mode

[6] Intel® 64 and IA-32 Architectures Software Developer Manuals  
https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
