INCLUDE "all.inc"

; Check volume sweep timing with various DIV[4] values when turning APU on/off.

EntryPoint:
    xor a
    ldh [rDIV], a

    Wait 1024

    DisableAPU

    Wait 1024

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

    Wait 16341

    ldh a, [rPCM12]
    cp $e0

    jp nz, TestFail
    jp TestSuccess
