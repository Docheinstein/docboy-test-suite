INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 0 to 1
; with pace 0.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 0
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $00
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 1280
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 16

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $10
    ldh [rNR10], a

REPT 16
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
