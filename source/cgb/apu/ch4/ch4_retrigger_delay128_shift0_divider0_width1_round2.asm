INCLUDE "all.inc"

; Check the timing of CH4 when the channel is retriggered (once) while it's active.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 0
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 0
    ld a, $08
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 128

    ldh [rNR44], a

    Wait 27

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess