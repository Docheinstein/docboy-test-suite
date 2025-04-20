INCLUDE "all.inc"

; Check the timing of serial interrupt while halted if interrupt is set manually before EI.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIF], a
    ldh [rIE], a

    ; Enable interrupt
    ei

REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $05

    jp nz, TestFail
    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestContinue
