INCLUDE "all.inc"

; Check timing of channel disable due to period sweep timing overflow.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $36
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 36
    ld a, $E1
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 6

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
