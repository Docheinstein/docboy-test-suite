INCLUDE "all.inc"

; Check timing of length timer in double speed mode.

EntryPoint:
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    xor a
    ldh [rDIV], a

    ; Volume = 100
    ld a, $20
    ldh [rNR32], a

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Length Timer = 128
    ld a, $7F
    ldh [rNR31], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $c7
    ldh [rNR34], a

    Wait 1052648

    ldh a, [rNR52]
    cp $f4

    jp nz, TestFail
    jp TestSuccess
