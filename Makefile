IBS=routines/real_mode
IPM=routines/protected_mode
BIN=boot_sect.bin
OPT=-f bin
SRC=tests
IMG=hda.img

01: $(SRC)/01.boot_sect.asm
	nasm $^ $(OPT) -o $(BIN)
02: $(SRC)/02.boot_sect_print.asm
	nasm $^ $(OPT) -o $(BIN)
03: $(SRC)/03.addressing.asm
	nasm $^ $(OPT) -o $(BIN)
04: $(SRC)/04.addressing.fixed.asm
	nasm $^ $(OPT) -o $(BIN)
05: $(SRC)/05.stack_manipulation.asm
	nasm $^ $(OPT) -o $(BIN)
06: $(SRC)/06.print_strings.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS)
07: $(SRC)/07.print_hex_strings.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS)
08: $(SRC)/08.addessing.segment.asm
	nasm $^ $(OPT) -o $(BIN)
09: $(SRC)/09.read_sector.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS)
10: $(SRC)/10.enter_protmode.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS) -i$(IPM)
11: $(SRC)/11.enter_protmode_vga.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS) -i$(IPM)
$(IMG): 11
	dd if=/dev/zero of=myos.img bs=1024 count=2880
	dd if=$(BIN) of=$@ seek=0 count=1 conv=notrunc
run: hda.img
	qemu-system-i386 -hda hda.img

