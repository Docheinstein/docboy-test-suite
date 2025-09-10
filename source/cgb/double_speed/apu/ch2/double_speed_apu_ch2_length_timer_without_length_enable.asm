INCLUDE "all.inc"

; Check that length timer does not shutdown the channel if the length enable flag has not been set.

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

    ; Initial length timer = 56
    ld a, $38
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Period = 256
    ld a, $00
    ldh [rNR23], a

    ; Trigger = 1
    ; Length enable = 0
    ld a, $87
    ldh [rNR24], a

REPT 32
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f2

    jp nz, TestFail
    jp TestSuccess
