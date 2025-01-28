INCLUDE "all.inc"

; Reading from OAM during Pixel Transfer should read FF instead.

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

    ; Read back from OAM
    ld a, [hl]
    cp $ff

    jp nz, TestFail
    jp TestSuccess
