INCLUDE "docboy.inc"

; Reading from Not Usable area during Pixel Transfer should read FF.

EntryPoint:
    DisablePPU

    ; Write something to Not Usable
    ld a, $12
    ld hl, $fea0
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait Pixel Transfer
    WaitMode 3

    ; Read back from Not Usable
    ld a, [hl]
    cp $ff

    jp nz, TestFail
    jp TestSuccess
