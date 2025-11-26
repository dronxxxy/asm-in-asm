AIA_AX =  0b00000
AIA_CX =  0b00001
AIA_DX =  0b00010
AIA_BX =  0b00011
AIA_SP =  0b00100
AIA_BP =  0b00101
AIA_SI =  0b00110
AIA_DI =  0b00111
AIA_EAX = 0b01000
AIA_ECX = 0b01001
AIA_EDX = 0b01010
AIA_EBX = 0b01011
AIA_ESP = 0b01100
AIA_EBP = 0b01101
AIA_ESI = 0b01110
AIA_EDI = 0b01111
AIA_RAX = 0b10000
AIA_RCX = 0b10001
AIA_RDX = 0b10010
AIA_RBX = 0b10011
AIA_RSP = 0b10100
AIA_RBP = 0b10101
AIA_RSI = 0b10110
AIA_RDI = 0b10111
AIA_R8 =  0b11000
AIA_R9 =  0b11001
AIA_R10 = 0b11010
AIA_R11 = 0b11011
AIA_R12 = 0b11100
AIA_R13 = 0b11101
AIA_R14 = 0b11110
AIA_R15 = 0b11111

CODE16 = 0
CODE32 = 1
CODE64 = 2

.macro aia_rex w, r, x, b
  .byte 0b01000000 | (\w << 3) | (\r << 2) | (\x << 1) | (\b << 0)
.endm

.macro aia_pref_mov code, is_64h
  .if (\code == CODE16 && CODE != CODE16) || (\code == CODE32 && CODE == CODE16)
    .byte 0x66   
  .endif
  .if \code == CODE64 && CODE == CODE64
    aia_rex 1, 0, 0, \is_64h
  .endif
.endm

# Imm -> Reg(16, 32, 64) depending on prefix
.macro aia_movi reg, value
  IS_64H = 0
  REG_CODE = \reg >> 3
  .if REG_CODE == 0b11
    REG_CODE = 0b10
    IS_64H = 1
  .endif
  aia_pref_mov REG_CODE, IS_64H

  .byte 0xb8 + \reg & 0b111

  .if REG_CODE == CODE16
    .word \value   
  .elseif REG_CODE == CODE32
    .long \value   
  .elseif REG_CODE == CODE64
    .quad \value   
  .else
    .error "invalid register passed"
  .endif
.endm

.macro aia_syscall
  .if CODE == CODE64
    # syscall
    .word 0x050f
  .elseif CODE == CODE32
    # int 0x80
    .byte 0xcd
    .byte 0x80
  .else
    .error "unsupported syscall arch"
  .endif
.endm
