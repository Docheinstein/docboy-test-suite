INCLUDE "all.inc"

; Check how speed switch affects DIV APU tick and volume sweep with different starting DIV_APU and DIV configurations.

EntryPoint:
    xor a
    ldh [rDIV], a

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

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Wait 2048
    Wait 1024

    ; Switch to double speed
    stop

    Wait 20477

    ldh a, [rPCM12]
    cp $e0

    jp nz, TestFail
    jp TestSuccess
