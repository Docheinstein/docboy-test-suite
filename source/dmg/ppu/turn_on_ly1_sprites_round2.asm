INCLUDE "all.inc"

; Check whether sprites are rendered on the second scanline after PPU is turn on.

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160

    ; Add a sprite at X=8 Y=0
    ld a, $10
    ld hl, $fe00
    ld [hli], a
    ld [hli], a

    EnablePPU_WithSprites

    Nops 114 + 60

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    ld b, a

    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess