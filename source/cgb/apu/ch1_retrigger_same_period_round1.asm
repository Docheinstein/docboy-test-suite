INCLUDE "all.inc"

; Retrigger the channel while it is running.

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

   ; Change period with retrigger
    ld a, $80
    ldh [rNR14], a

    Wait 7169

    ldh a, [rPCM12]
    cp $0f

    jp nz, TestFail
    jp TestSuccess