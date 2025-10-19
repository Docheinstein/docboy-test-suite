INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from increasing to decreasing
; and then back again to increasing with a period that would make the channel overflow.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $17
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 46
    ld a, $D2
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 8192

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $1F
    ldh [rNR10], a

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $17
    ldh [rNR10], a

    Wait 6093

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
