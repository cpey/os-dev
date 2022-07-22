# os-dev

## Tests

| Program                   | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
|01.boot_sect.asm           | Simple boot sector written in assembly language.                            |
|02.boot_sect_print.asm     | Simple boot sector that prints a message to the screen using a BIOS routine.|
|03.addressing.asm          | Addressing demonstration.                                                   |
|04.addressing.fixed.asm    | Specifying the assembler the program load address.                          |
|05.stack_manipulation.asm  | Demonstrates the use of the stack.                                          |
|06.print_string.asm        | Prints string using function.                                               |
|07.print_hex_strings.asm   | Prints a register value as a hex string.                                    |
|08.addessing.segment.asm   | Memory addressing using segment offsetting.                                 |
|09.read_sector.asm         | Read sectors from boot disk.                                                |
|10.enter_protmode.asm      | Enters 32-bit protected mode.                                               |
|11.enter_protmode_vga.asm  | Enters 32-bit protected mode clearing the screen.                           |

## References

[1] Writing a Simple Operating System — from Scratch by Nick Blundell  
https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

[2] Writing Your Own Toy Operating System: Guides & Tutorials  
http://www.independent-software.com/operating-system-development.html

[3] Yu Wangs Website documentation: Entering 32bit Protected Mode  
http://homepages.rpi.edu/~wangy52/PersonalWebsite/build/html/Misc/MyOS/src/Day02/Day02.html

[4] ROM BIOS — Vitaly Filatof  
http://vitaly_filatov.tripod.com/ng/asm/asm_001.html
