INCLUDE "all.inc"

; Check channel timing in double speed.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty cycle = 50%
    ld a, $80
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ld a, $FF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR14], a

    Wait 17931

    ldh a, [rPCM12]
    cp $0F
    jp nz, TestFail
    jp TestSuccess