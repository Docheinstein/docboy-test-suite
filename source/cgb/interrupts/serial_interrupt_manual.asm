INCLUDE "all.inc"

; Check the timing of serial interrupt while halted if interrupt is set manually after EI.

EntryPoint:
    DisablePPU

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ; Enable Serial interrupt
    ld a, IEF_SERIAL
    ldh [rIF], a
    ldh [rIE], a

REPT 256
    inc a
ENDR

TestContinue:
    cp $08

    jp nz, TestFail
    jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestContinue