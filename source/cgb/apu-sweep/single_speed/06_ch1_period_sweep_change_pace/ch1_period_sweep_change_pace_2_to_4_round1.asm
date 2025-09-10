INCLUDE "all.inc"

; Check what happens if period sweep pace is changed from 2 to 4
; before a recalculation.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $26
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 96
    ld a, $A0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 8192

    ; (Period sweep ticked)

    ; Pace = 4
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $46
    ldh [rNR10], a

    Wait 6369

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
