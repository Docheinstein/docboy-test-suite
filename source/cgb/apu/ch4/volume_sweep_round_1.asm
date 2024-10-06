INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"
INCLUDE "cgb.inc"

; Check the timing of CH4's volume sweep.
; Uses PCM (CGB only).

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Initial length = 3E
    ld a, $FE
    ldh [rNR41], a

    ; Initial volume = F
    ; Volume sweep = 1
    ld a, $F1
    ldh [rNR42], a

    ld a, $19
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $8F
    ldh [rNR44], a

    LongWait 16340

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $00
    jp nz, TestFailCGB

    ; Check PCM34
    ld a, b
    cp $F0
    jp nz, TestFailCGB

    jp TestSuccessCGB