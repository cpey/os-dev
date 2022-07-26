OUT=../build
KERNEL_OBJ=$(OUT)/kernel.o
KERNEL64_OBJ=$(OUT)/kernel64.o
KENTRY_OBJ=$(OUT)/kernel_entry.o
BIN=$(OUT)/kernel.bin
SRC=src
KROUT=../routines/kernel
LMROUT=../routines/long_mode/

$(KENTRY_OBJ): $(KROUT)/kernel_entry.asm
	nasm $< -f elf64 -o $@

KOBJ01: $(SRC)/01.kernel.c
	gcc -ffreestanding -c  $< -o $(KERNEL_OBJ)

KOBJ02: $(SRC)/02.kernel.c
	gcc -ffreestanding -c $< -o $(KERNEL_OBJ)

K01: KOBJ01
	ld -o $(BIN) -Ttext 0x1000 $(KERNEL_OBJ) --oformat binary

K02: $(KENTRY_OBJ) KOBJ01
	ld -o $(BIN) -Ttext 0x1000 $< $(KERNEL_OBJ) --oformat binary

K03: $(KENTRY_OBJ) KOBJ02
	ld -O0 -o $(BIN) -Ttext 0x1000 \
		$< \
		$(OUT)/set_paging_structures.o \
		$(OUT)/set_long_mode.o $(KERNEL_OBJ) \
		--oformat binary
