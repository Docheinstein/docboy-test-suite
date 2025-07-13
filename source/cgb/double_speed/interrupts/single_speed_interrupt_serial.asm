INCLUDE "all.inc"

; Check what the timing of serial interrupt in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    DisableAPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

    ; Enable Serial interrupt
    xor a
    ldh [rIF], a

    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ei

    xor a
    ld b, a

REPT 16
    inc a
REPT 512
    inc b
ENDR
ENDR


TestContinue:
    cp $02
    jp nz, TestFail

    ld a, b
    cp $f5

    jp nz, TestFail
    jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestContinue
