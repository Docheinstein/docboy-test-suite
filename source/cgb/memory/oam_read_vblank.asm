INCLUDE "docboy.inc"

; Reading from OAM during VBlank should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    EnablePPU

    WaitMode 1

    ; Wait VBlank
    WaitMode 1

    ; Read back from OAM
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
