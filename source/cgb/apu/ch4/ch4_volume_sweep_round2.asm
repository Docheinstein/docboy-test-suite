INCLUDE "all.inc"

; Check the timing of CH4's volume sweep.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Initial length = 3E
    ld a, $FE
    ldh [rNR41], a

    ; Initial volume = F
    ; Volume sweep = 1
    ld a, $F1
    ldh [rNR42], a

    ld a, $19
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $8F
    ldh [rNR44], a

    Wait 16341

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $00
    jp nz, TestFail

    ; Check PCM34
    ld a, b
    cp $E0
    jp nz, TestFail

    jp TestSuccess