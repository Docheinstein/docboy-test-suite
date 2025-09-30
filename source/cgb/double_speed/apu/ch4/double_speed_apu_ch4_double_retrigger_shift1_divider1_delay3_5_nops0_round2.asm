INCLUDE "all.inc"

; Check the timing of CH4 when the channel is retriggered (twice) while it's active.

EntryPoint:
    ld hl, rNR44

    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU
    
    Nops 0

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 1
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 1
    ld a, $11
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 3
    
    ld [hl], a

    Nops 5

    ld [hl], a

    Wait 230

    ldh a, [rPCM34]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
