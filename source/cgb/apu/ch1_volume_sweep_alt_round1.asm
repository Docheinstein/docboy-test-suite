INCLUDE "all.inc"

; Check CH1 volume sweep timing.

EntryPoint:
    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty Cycle = 25%
    ld a, $40
    ldh [rNR11], a

    ; Initial volume = A
    ; Envelope direction = 1
    ; Sweep = 1
    ld a, $A9
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    xor a
    ldh [rDIV], a

    Wait 16336
    Wait 44

    ldh a, [rPCM12]
    cp $0a

    jp nz, TestFail
    jp TestSuccess
