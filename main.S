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
