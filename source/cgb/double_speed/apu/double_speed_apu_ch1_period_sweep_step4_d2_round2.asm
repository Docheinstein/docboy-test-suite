INCLUDE "all.inc"

; Check when CH1 is disabled due to period sweep timing overflow with step 4.

EntryPoint:
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Wait 1

    xor a
    ldh [rDIV], a

    Wait 1

    EnableAPU

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 4
    ld a, $34
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

    Wait 1

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 94160
    Wait 12

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
