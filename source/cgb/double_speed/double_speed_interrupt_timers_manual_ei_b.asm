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

    ; Manually set interrupt timer
    ld a, IEF_TIMER
    ldh [rIF], a

    ld a, IEF_TIMER
    ldh [rIE], a

    ; Enable interrupt
    ei

REPT 200
    inc b
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestFinish
