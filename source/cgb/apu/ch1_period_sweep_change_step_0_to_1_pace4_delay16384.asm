INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 0 to 1
; with pace 4.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 4
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $40
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 32
    ld a, $E0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 16384

    ; Pace = 4
    ; Direction = 0 (increase)
    ; Step = 1
    ld a, $41
    ldh [rNR10], a

REPT 16
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
