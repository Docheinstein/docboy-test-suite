INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Writing to VRAM at boot time should write data correctly.

EntryPoint:
    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    ; Read it back
    ld a, [hl]
    cp $12

    jp nz, TestFailCGB
    jp TestSuccessCGB
