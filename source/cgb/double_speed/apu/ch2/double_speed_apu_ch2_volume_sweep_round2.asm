INCLUDE "all.inc"

; Check timing of volume sweep in double speed mode.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

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
    Wait 8192
    Wait 8192
    Wait 8155

    ldh a, [rPCM12]
    cp $e0

    jp nz, TestFail
    jp TestSuccess
