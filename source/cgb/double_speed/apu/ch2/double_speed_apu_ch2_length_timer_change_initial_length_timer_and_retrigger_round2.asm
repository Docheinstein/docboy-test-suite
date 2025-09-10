INCLUDE "all.inc"

; Change value of initial length timer while it's active and retrigger the channel.

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

    ; Initial length timer = 56
    ld a, $38
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Period = 256
    ld a, $00
    ldh [rNR23], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C7
    ldh [rNR24], a

    Wait 16384

    ; Initial length timer = 16
    ld a, $10
    ldh [rNR21], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C7
    ldh [rNR24], a

    Wait 389072

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
