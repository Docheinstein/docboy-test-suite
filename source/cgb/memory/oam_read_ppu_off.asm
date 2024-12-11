INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Reading from OAM with PPU off should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    ; Read back from OAM
    ld a, [hl]
    cp $12

    jp nz, TestFailCGB
    jp TestSuccessCGB
