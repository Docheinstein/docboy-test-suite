INCLUDE "all.inc"

; Check the timing of CH4's volume sweep.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    Nops 1

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 0
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 2
    ld a, $0a
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 49

    ldh a, [rPCM34]
    cp $00

    jp nz, TestFail
    jp TestSuccess