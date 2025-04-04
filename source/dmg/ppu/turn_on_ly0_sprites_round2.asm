INCLUDE "all.inc"

; Check whether sprites are rendered on the first scanline after PPU is turn on.

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160

    ; Add a sprite at X=8 Y=0
    ld a, $10
    ld hl, $fe00
    ld [hli], a
    ld [hli], a

    EnablePPU_WithSprites

    Nops 60

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess