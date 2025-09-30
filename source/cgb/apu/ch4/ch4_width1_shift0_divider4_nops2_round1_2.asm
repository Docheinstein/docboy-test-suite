INCLUDE "all.inc"

; Check the timing of CH4's volume sweep.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU

    Nops 1

    EnableAPU


    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 0
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 4
    ld a, $0c
    ldh [rNR43], a

    Nops 1

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Wait 102

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess