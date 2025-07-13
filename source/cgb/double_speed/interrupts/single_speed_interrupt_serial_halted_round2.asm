INCLUDE "all.inc"

; Check the timing of serial interrupt while halted
; in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    DisableAPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

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

    halt

    Nops 61

    ; Read DIV
    ldh a, [rDIV]
    cp $11

    jp nz, TestFail
    jp TestSuccess
