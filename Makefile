asm32: build main.S asm.S
	as main.S --32 --defsym CODE=1 -o build/main.asm.o
	ld build/main.asm.o -melf_i386 -o build/asm
	objdump -d build/asm
	./build/asm

asm64: build main.S asm.S
	as main.S --defsym CODE=2 -o build/main.asm.o
	ld build/main.asm.o -o build/asm
	objdump -d build/asm
	./build/asm

build:
	mkdir build
