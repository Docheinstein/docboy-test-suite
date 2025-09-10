INCLUDE "all.inc"

; Check what happens if period sweep pace is changed from 4 to 6
; during a period sweep tick.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 4
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $46
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 256
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 8192
    Wait 8192
    Wait 8192
    Wait 6095

    ; Pace = 6
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $66
    ldh [rNR10], a

    Wait 327682

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
