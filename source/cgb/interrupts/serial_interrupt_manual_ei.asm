INCLUDE "all.inc"

; Check the timing of serial interrupt while halted if interrupt is set manually before EI.

EntryPoint:
    DisablePPU

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

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

    ; Enable interrupt
    ei

REPT 256
    inc a
ENDR

TestContinue:
    cp $09

    jp nz, TestFail
    jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestContinue