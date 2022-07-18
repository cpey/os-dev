INC=includes
BIN=boot_sect.bin
OPT=-f bin

01: 01.boot_sect.asm
	nasm $^ $(OPT) -o $(BIN)
02: 02.boot_sect_print.asm
	nasm $^ $(OPT) -o $(BIN)
03: 03.addressing.asm
	nasm $^ $(OPT) -o $(BIN)
04: 04.addressing.fixed.asm
	nasm $^ $(OPT) -o $(BIN)
05: 05.stack_manipulation.asm
	nasm $^ $(OPT) -o $(BIN)
06: 06.print_strings.asm
	nasm $^ $(OPT) -o $(BIN) -i$(INC)
run:
	qemu-system-i386 -nographic $(BIN)
