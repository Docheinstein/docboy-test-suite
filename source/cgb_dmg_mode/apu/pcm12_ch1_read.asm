INCLUDE "all.inc"

; Check if PCM12 can be accessed in DMG mode.

EntryPoint:
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

ReadPCM:
    ldh a, [rPCM12]
    cp $00
    jp z, ReadPCM

    cp $0f
    jp nz, TestFail

    jp TestSuccess