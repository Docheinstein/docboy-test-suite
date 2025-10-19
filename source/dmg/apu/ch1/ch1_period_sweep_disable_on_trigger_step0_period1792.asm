INCLUDE "all.inc"

; Check if CH1 is disabled on trigger with step 0 with period that wouldn't make it overflow.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $20
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 1792
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $81
    ldh [rNR14], a

REPT 16
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
