INCLUDE "all.inc"

; Check volume sweep timing (without initial reset of DIV and APU).

EntryPoint:
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

    Wait 14397
    ldh a, [rPCM12]
    cp $e0

    jp nz, TestFail
    jp TestSuccess
