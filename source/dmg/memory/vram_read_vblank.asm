INCLUDE "all.inc"

; Reading from VRAM during HBlank should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait VBlank
    WaitMode 1

    ; Read back from VRAM
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
