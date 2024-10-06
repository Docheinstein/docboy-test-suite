INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"
INCLUDE "cgb.inc"

; Check the timing of CH1's volume sweep.
; Uses PCM (CGB only).

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty cycle = 75%
    ; Initial length = 3E
    ld a, $FE
    ldh [rNR11], a

    ; Initial volume = F
    ; Volume sweep = 1
    ld a, $F1
    ldh [rNR12], a

    ; Period = 0x7FC
    ld a, $FC
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $8F
    ldh [rNR14], a

    LongWait 16332

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $0F
    jp nz, TestFailCGB

    ; Check PCM34
    ld a, b
    cp $00
    jp nz, TestFailCGB

    jp TestSuccessCGB