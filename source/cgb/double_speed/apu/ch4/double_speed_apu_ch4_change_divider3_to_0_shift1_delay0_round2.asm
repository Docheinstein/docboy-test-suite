INCLUDE "all.inc"

; Check what happens to CH4 when NR43 divider is changed while it's active.

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

    ; Clock shift = 1
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 3
    ld a, $13
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 0

    ; Clock shift = 1
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 0
    ld a, $10
    ldh [rNR43], a

    Wait 123

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
