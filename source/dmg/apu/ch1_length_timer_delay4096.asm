INCLUDE "all.inc"

; Check that CH1 length timer turns off CH1 with the correct timing.

EntryPoint:
    Wait 4096

    EnableAPU

    xor a
    ldh [rNR10], a

    ; Initial length = 1
    ld a, $01
    ldh [rNR11], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR14], a

    ld de, $00

.loop
    ldh a, [rNR52]
    inc de
    and $01
    jr nz, .loop

    ld a, d
    cp $62
    jp nz, TestFail
    ld a, e
    cp $e5
    jp nz, TestFail

    jp TestSuccess
