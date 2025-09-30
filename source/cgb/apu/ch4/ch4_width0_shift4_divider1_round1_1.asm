INCLUDE "all.inc"

; Check the timing of CH4's volume sweep.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 4
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 1
    ld a, $41
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Wait 926

    ldh a, [rPCM34]
    cp $00

    jp nz, TestFail
    jp TestSuccess