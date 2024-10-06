INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"
INCLUDE "cgb.inc"

; Check the timing of CH1's square wave position.
; Uses PCM (CGB only).

EntryPoint:
    DisableAPU

    EnableAPU

    xor a
    ldh [rNR10], a

    ; Initial length = 1
    ld a, $01
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Period = 0x7FD
    ld a, $FD
    ldh [rNR13], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $CF
    ldh [rNR14], a

    ; Wait
    Nops 41

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $0f
    jp nz, TestFailCGB

    ; Check PCM34
    ld a, b
    cp $00
    jp nz, TestFailCGB

    jp TestSuccessCGB