INCLUDE "all.inc"

; Check that length timer shutdowns the channel.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    ; Initial length timer = 0
    ld a, $00
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Period = 256
    ld a, $00
    ldh [rNR23], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C7
    ldh [rNR24], a

    Wait 520154

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
