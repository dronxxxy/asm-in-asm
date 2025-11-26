.global _start

.include "asm-in-asm.S"

.if CODE64
  SYSCALL_NUM = AIA_A
  SYSCALL_A1 = AIA_DI
  SYSCALL_A2 = AIA_SI
  SYSCALL_A3 = AIA_D
  SYSCALL_A4 = AIA_R10
  SYSCALL_A5 = AIA_R8
  SYSCALL_A6 = AIA_R9

  SYSCALL_WRITE = 1
  SYSCALL_EXIT = 60
.else
  SYSCALL_NUM = AIA_A
  SYSCALL_A1 = AIA_B
  SYSCALL_A2 = AIA_C
  SYSCALL_A3 = AIA_D
  SYSCALL_A4 = AIA_SI
  SYSCALL_A5 = AIA_DI
  SYSCALL_A6 = AIA_BP

  SYSCALL_WRITE = 4
  SYSCALL_EXIT = 1
.endif

.section .text
  _start:
    aia_movri SYSCALL_NUM, SYSCALL_WRITE
    aia_movri SYSCALL_A1, 1
    aia_movri SYSCALL_A2, hello
    aia_movri SYSCALL_A3, hello_len
    aia_syscall

    aia_movri SYSCALL_NUM, SYSCALL_EXIT
    aia_movri SYSCALL_A1, 0
    aia_syscall

.section .rodata
  hello: .ascii "Hello, world!\n"
  hello_len = . - hello
