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

    ; Clock shift = 15
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 2
    ld a, $F2
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

REPT 32
    Wait 131072
ENDR

    ldh a, [rPCM34]
    cp $00

    jp nz, TestFail
    jp TestSuccess