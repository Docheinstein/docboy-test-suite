INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Writing to VRAM during OAM Scan should write data correctly.

EntryPoint:
    DisablePPU

    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Write to VRAM again
    ld a, $34
    ld [hl], a

    DisablePPU

    ; Read it back
    ld a, [hl]
    cp $34

    jp nz, TestFailCGB
    jp TestSuccessCGB
