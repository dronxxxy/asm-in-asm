AIA_A =   0b0000
AIA_C =   0b0001
AIA_D =   0b0010
AIA_B =   0b0011
AIA_SP =  0b0100
AIA_BP =  0b0101
AIA_SI =  0b0110
AIA_DI =  0b0111
AIA_R8 =  0b1000
AIA_R9 =  0b1001
AIA_R10 = 0b1010
AIA_R11 = 0b1011
AIA_R12 = 0b1100
AIA_R13 = 0b1101
AIA_R14 = 0b1110
AIA_R15 = 0b1111

.macro _aia_rex w, r, x, b
  .byte 0b01000000 | (\w << 3) | (\r << 2) | (\x << 1) | (\b << 0)
.endm

.macro aia_movri reg, imm
  .if CODE64
    _aia_rex 1, 0, 0, (\reg & 0b1000) >> 3
  .elseif \reg > 0b111
    .error "too big register value"
  .endif
  .byte 0xb8 + (\reg & 0b111)
  .if CODE64
    .quad \imm
  .else
    .long \imm
  .endif
.endm

.macro aia_syscall
  .if CODE64
    # syscall
    .word 0x050f
  .else
    # int 0x80
    .byte 0xcd
    .byte 0x80
  .endif
.endm

