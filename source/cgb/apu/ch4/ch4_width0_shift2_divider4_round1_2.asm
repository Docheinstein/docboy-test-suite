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

    ; Clock shift = 2
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 4
    ld a, $24
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Wait 927

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess