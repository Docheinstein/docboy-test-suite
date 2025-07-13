INCLUDE "all.inc"

; Check the timing of stat interrupt in double speed mode when enabled manually.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ld b, $00

    ; Enable interrupt
    ei

    ; Manually set interrupt timer
    ld a, IEF_STAT
    ldh [rIF], a

    ld a, IEF_STAT
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


SECTION "STAT handler", ROM0[$48]
    jp TestFinish