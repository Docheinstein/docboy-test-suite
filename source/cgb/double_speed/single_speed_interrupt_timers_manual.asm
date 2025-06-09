INCLUDE "all.inc"

; Check the timing of STAT interrupt during speed switch to single speed.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 1

    ; Switch to double speed
    stop

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

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

REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $04

    jp nz, TestFail
    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestContinue
