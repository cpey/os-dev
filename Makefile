01:
	nasm 01.boot_sect.asm -f bin -o boot_sect.bin
02:
	nasm 02.boot_sect_print.asm -f bin -o boot_sect.bin
03:
	nasm 03.addressing.asm -f bin -o boot_sect.bin
04:
	nasm 04.addressing.fixed.asm -f bin -o boot_sect.bin
run:
	qemu-system-i386 -nographic boot_sect.bin
