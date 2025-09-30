INCLUDE "all.inc"

; Check the timing of CH4 when the channel is retriggered (once) while it's active.

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
    
    Nops 1

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 3
    ; LFSR width = 0 (15 bit)
    ; Clock divider = 2
    ld a, $32
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 16

    ldh [rNR44], a

    Wait 1841

    ldh a, [rPCM34]
    cp $00

    jp nz, TestFail
    jp TestSuccess
