INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Writing to Not Usable area during VBlank should write data correctly.

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

    ; Write to Not Usable again
    ld a, $34
    ld [hl], a

    DisablePPU

    ; Read it back
    ld a, [hl]
    cp $34

    jp nz, TestFailCGB
    jp TestSuccessCGB