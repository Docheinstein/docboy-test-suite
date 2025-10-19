INCLUDE "all.inc"

; Check if CH1 is disabled if NR10 is written with certain period and step values.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 0
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $17
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 17
    ld a, $EF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 16

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $17
    ldh [rNR10], a

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
