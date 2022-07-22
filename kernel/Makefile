OUT=build
OBJ=$(OUT)/kernel.o
BIN=$(OUT)/kernel.bin
SRC=src

kernel.bin: $(SRC)/01.kernel.c
	@-mkdir $(OUT)
	gcc -ffreestanding -c  $^ -o $(OBJ)
	ld -o $(BIN) -Ttext 0x1000 $(OBJ) --oformat binary

clean:
	rm -rf $(OUT)
