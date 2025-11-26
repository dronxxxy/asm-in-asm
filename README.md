# asm-in-asm

"Crossplatform" assembly, written using macros of GNU assembly.

This example can be ran on 32-bit and 64-bit x86 machines and doesn't use any mnemonics provided by GNU assembly. All instructions are using .byte preudo-mnemonics to be embedded into binary.

## Building

If you wanna build 32-bit assembly for i386

```shell
make asm32
```

but if you wanna build 64-bit assembly for x86_64

```shell
make asm64
```

## Example

Basic "Hello, world" example :)

```asm
.include "asm.S"
.include "linux.S"

.global _start

.section .text
  _start:
    aia_movi AIA_AX, 1

    aia_movi SYSCALL_NUM, SYSCALL_WRITE
    aia_movi SYSCALL_ARG1, 1
    aia_movi SYSCALL_ARG2, hello
    aia_movi SYSCALL_ARG3, hello_len
    aia_syscall

    aia_movi SYSCALL_NUM, SYSCALL_EXIT
    aia_movi SYSCALL_ARG1, 0
    aia_syscall

.section .rodata
  hello: .ascii "Hello, world!\n"
  hello_len = . - hello
```

