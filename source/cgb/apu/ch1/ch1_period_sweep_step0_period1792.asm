INCLUDE "all.inc"

; Check when CH1 is disabled due to period sweep timing overflow with step 0.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $30
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 1024
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

REPT 32
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
