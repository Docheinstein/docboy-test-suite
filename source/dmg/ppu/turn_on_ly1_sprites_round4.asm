INCLUDE "docboy.inc"

; Check whether sprites are rendered on the second scanline after PPU is turn on.

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160

    ; Add a sprite at X=8 Y=0
    ld a, $10
    ld hl, $fe00
    ld [hli], a
    ld [hli], a

    EnablePPU

    Nops 114 + 62

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess