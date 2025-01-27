INCLUDE "docboy.inc"

; Reading from Not Usable area during VBlank should should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to Not Usable
    ld a, $12
    ld hl, $fea0
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait VBlank
    WaitMode 1

    ; Read back from Not Usable
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
