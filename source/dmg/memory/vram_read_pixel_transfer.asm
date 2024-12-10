INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from VRAM during Pixel Transfer should read FF instead.

EntryPoint:
    DisablePPU

    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait Pixel Transfer
    WaitMode 3

    ; Read back from VRAM
    ld a, [hl]
    cp $ff

    jp nz, TestFail
    jp TestSuccess
