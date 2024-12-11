INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to OAM at boot time should write data correctly.

EntryPoint:
    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    ; Read it back
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
