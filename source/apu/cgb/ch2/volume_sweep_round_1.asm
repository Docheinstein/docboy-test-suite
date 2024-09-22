INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"

; Check the timing of CH2's volume sweep.
; Uses PCM (CGB only).

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU


    ; Duty cycle = 75%
    ; Initial length = 3E
    ld a, $FE
    ldh [rNR21], a

    ; Initial volume = F
    ; Volume sweep = 1
    ld a, $F1
    ldh [rNR22], a

    ; Period = 0x7FC
    ld a, $FC
    ldh [rNR23], a

    ; Trigger = 1
    ld a, $8F
    ldh [rNR24], a

    LongWait 16336

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $F0
    jp nz, TestFail

    ; Check PCM34
    ld a, b
    cp $00
    jp nz, TestFail

    jp TestSuccess