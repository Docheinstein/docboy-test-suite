INCLUDE "all.inc"

; Check that channel outputs 0 for the first duty step when it is turned on.

EntryPoint:
    ld hl, rPCM12

    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Period = 1
    ld a, $FF
    ldh [rNR23], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $87
    ldh [rNR24], a

    Nops 4

    ld a, [hl]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
