INCLUDE "all.inc"

; Check the timing of serial interrupt during speed switch to single speed.

EntryPoint:
    DisablePPU
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Enable Serial interrupt
    xor a
    ldh [rIF], a

    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 1

    ; Switch to single speed
    stop

    Nops 61

    ; Read DIV
    ldh a, [rDIV]
    cp $11

    jp nz, TestFail
    jp TestSuccess