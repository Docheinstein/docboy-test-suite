INCLUDE "all.inc"

; Check what happens to CH4 when NR43 width is changed while it's active.

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

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 2
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 2
    ld a, $22
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 32

    ; Clock shift = 2
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 2
    ld a, $2a
    ldh [rNR43], a

    Wait 445

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess