INCLUDE "all.inc"

; Change period through NR14 while channel is running (without trigger).

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
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

    ; Wait for square wave position to reach digital output 1
    ld de, $00

.loopF:
    ldh a, [rPCM12]
    cp $0f
    inc de
    jp nz, .loopF

    ld a, d
    cp $03
    jp nz, TestFail

    ld a, e
    cp $30
    jp nz, TestFail

    ; Change period
    ld a, $06
    ldh [rNR14], a

    ; Wait for square wave position to reach digital output 0
    ld de, $00

.loop0:
    ldh a, [rPCM12]
    cp $00
    inc de
    jp nz, .loop0


    ld a, d
    cp $00
    jp nz, TestFail

    ld a, e
    cp $e7
    jp nz, TestFail

    jp TestSuccess