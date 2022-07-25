# Build and run given test #id:
# $	make test <#id>

IBS=routines/real_mode
IPM=routines/protected_mode
ILM=routines/long_mode
OUT=build
BIN=$(OUT)/boot_sect.bin
OPT=-f bin
SRC=tests
IMG=$(OUT)/hda.img
KDIR=kernel
KBIN=kernel.bin
KBUILD=$(OUT)/$(KBIN)

.PHONY: run clean test build-dir

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
12: $(SRC)/12-13.boot_kernel.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS) -i$(IPM)
14: $(SRC)/14.enter_logmode.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS) -i$(IPM) -i$(ILM)
15: $(SRC)/15.boot_sect_split.asm
	nasm $^ $(OPT) -o $(BIN) -i$(IBS) -i$(IPM) -i$(ILM)

build-dir:
	@-mkdir $(OUT)
TID=$(filter-out test,$(MAKECMDGOALS))
test: build-dir
ifeq ($(TID),12)
	@$(MAKE) run-12
else ifeq ($(TID),13)
	@$(MAKE) run-13
else
	@$(MAKE) $(TID)
	dd if=/dev/zero of=$(IMG) bs=1024 count=10
	dd if=$(BIN) of=$(IMG) seek=0 count=2 conv=notrunc
	#cat $(BIN) > $(IMG)
	if [ $(TID) -ge 14 ] ; then \
		qemu-system-x86_64 -hda $(IMG); \
	else \
		qemu-system-i386 -hda $(IMG); \
	fi
endif

K01:
	cd $(KDIR) && $(MAKE) $@
K02:
	cd $(KDIR) && $(MAKE) $@
$(IMG):
	cat $(BIN) $(KBUILD) > $@
run-12: build-dir 12 K01 $(IMG)
	qemu-system-i386 -hda $(IMG)
run-13: build-dir 12 K02 $(IMG)
	qemu-system-i386 -hda $(IMG)

clean:
	rm -rf $(OUT)

