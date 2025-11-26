asm32: build main.S asm-in-asm.S
	as main.S --32 --defsym CODE64=0 -o build/main.asm.o
	ld build/main.asm.o -melf_i386 -o build/asm
	./build/asm

asm64: build main.S asm-in-asm.S
	as main.S --defsym CODE64=1 -o build/main.asm.o
	ld build/main.asm.o -o build/asm
	./build/asm

build:
	mkdir build
