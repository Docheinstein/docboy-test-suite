INCLUDE "all.inc"

; Check the timing of timers interrupt in double speed mode when enabled manually.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    Nops 1

    ld b, $00

    ; Enable interrupt
    ei

    ; Manually set interrupt timer
    ld a, IEF_TIMER
    ldh [rIF], a

    ld a, IEF_TIMER
    ldh [rIE], a

REPT 200
    inc b
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    ld a, $00
    cp b
    jp nz, TestFail

    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestFinish
