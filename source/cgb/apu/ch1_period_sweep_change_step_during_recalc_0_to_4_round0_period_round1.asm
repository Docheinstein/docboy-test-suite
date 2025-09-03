INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 0 to 4
; during a period sweep tick.

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

    ; Period = 65
    ld a, $BF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 22477

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 4
    ld a, $34
    ldh [rNR10], a

    Wait 10246

    ldh a, [rPCM12]
    cp $0a

    jp nz, TestFail
    jp TestSuccess
