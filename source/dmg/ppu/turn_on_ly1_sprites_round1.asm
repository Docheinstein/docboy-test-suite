INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check whether sprites are rendered on the second scanline after PPU is turn on.

EntryPoint:
    DisablePPU
    ResetOAM

    ; Add a sprite at X=8 Y=0
    ld a, $10
    ld hl, $fe00
    ld [hli], a
    ld [hli], a

    EnablePPU

    Nops 114 + 59

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    ld b, a

    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess