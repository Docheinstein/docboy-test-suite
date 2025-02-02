INCLUDE "all.inc"

; Check the duration of speed switch by evaluating CH4 output.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

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

    ; Change speed
    stop

    ; Read PCM3
    ldh a, [rPCM34]
    cp $e0

    jp nz, TestFail
    jp TestSuccess