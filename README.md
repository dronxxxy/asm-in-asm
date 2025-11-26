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


