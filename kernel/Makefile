OUT=../build
KERNEL_OBJ=$(OUT)/kernel.o
KENTRY_OBJ=$(OUT)/kernel_entry.o
BIN=$(OUT)/kernel.bin
SRC=src
KROUT=../routines/kernel

$(KENTRY_OBJ): $(KROUT)/kernel_entry.asm
	nasm $< -f elf64 -o $@

$(KERNEL_OBJ): $(SRC)/01.kernel.c
	gcc -ffreestanding -c  $< -o $(KERNEL_OBJ)

K01: $(KERNEL_OBJ)
	ld -o $(BIN) -Ttext 0x1000 $< --oformat binary

K02: $(KENTRY_OBJ) $(KERNEL_OBJ) 
	ld -o $(BIN) -Ttext 0x1000 $^ --oformat binary
