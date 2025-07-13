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

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 1

    ; Switch to single speed
    stop

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