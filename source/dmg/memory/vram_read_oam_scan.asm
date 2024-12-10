INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from VRAM during OAM Scan should read FF instead.

EntryPoint:
    DisablePPU

    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Read back from VRAM
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
