INCLUDE "all.inc"

; Writing to OAM during Pixel Transfer should fail.

EntryPoint:
    DisablePPU

    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait Pixel Transfer
    WaitMode 3

    ; Write to OAM again
    ld a, $34
    ld [hl], a

    DisablePPU

    ; Read it back
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
