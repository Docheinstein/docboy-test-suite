INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check whether sprites are rendered on the first scanline after PPU is turn on.

EntryPoint:
    DisablePPU
    ResetOAM

    ; Add a sprite at X=8 Y=0
    ld a, $10
    ld hl, $fe00
    ld [hli], a
    ld [hli], a

    EnablePPU

    Nops 60

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess