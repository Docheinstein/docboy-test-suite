INCLUDE "all.inc"

; Check if retriggering affects volume sweep with various DIV-APU values..

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Duty = 75 %
    ld a, $C0
    ldh [rNR21], a

    ; Initial volume = F
    ; Direction = 0 (decrease)
    ; Pace = 1
    ld a, $F1
    ldh [rNR22], a

    ; Period = 1
    ld a, $FF
    ldh [rNR23], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR24], a

    Wait 8192
    Wait 2048 * 7

    ; Trigger = 1
    ld a, $87
    ldh [rNR24], a

    Wait 10192

    ldh a, [rPCM12]
    cp $e0

    jp nz, TestFail
    jp TestSuccess
