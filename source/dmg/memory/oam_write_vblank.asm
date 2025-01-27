INCLUDE "docboy.inc"

; Writing to OAM during VBlank should write data correctly.

EntryPoint:
    DisablePPU

    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait VBlank
    WaitMode 1

    ; Write to OAM again
    ld a, $34
    ld [hl], a

    DisablePPU

    ; Read it back
    ld a, [hl]
    cp $34

    jp nz, TestFail
    jp TestSuccess
