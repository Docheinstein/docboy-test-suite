INCLUDE "all.inc"

; Check the timing of serial interrupt while halted.

EntryPoint:
    DisablePPU

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    halt

    Nops 60

    ldh a, [rDIV]
    cp $10

    jp nz, TestFail
    jp TestSuccess