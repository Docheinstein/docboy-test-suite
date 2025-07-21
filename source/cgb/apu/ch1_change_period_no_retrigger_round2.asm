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
    Wait 9000

   ; Change period without retrigger
    ld a, $07
    ldh [rNR14], a

    Wait 1771

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
