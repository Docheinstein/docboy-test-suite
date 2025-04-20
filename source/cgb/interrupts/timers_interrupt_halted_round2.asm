INCLUDE "all.inc"

; Check the timing of timers interrupt while halted.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    halt

    Nops 44

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess