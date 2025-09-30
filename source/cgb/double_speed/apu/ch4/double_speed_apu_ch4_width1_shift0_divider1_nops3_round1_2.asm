INCLUDE "all.inc"

; Check the timing of CH4 when width bit is set.

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

    Nops 3

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 0
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 1
    ld a, $09
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 55

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess