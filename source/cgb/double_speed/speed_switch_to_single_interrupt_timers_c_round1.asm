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

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Enable timer interrupt
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    Nops 1

    ; Switch to single speed
    stop

    Nops 11

    ; Read DIV
    ldh a, [rDIV]
    cp $3f

    jp nz, TestFail
    jp TestSuccess