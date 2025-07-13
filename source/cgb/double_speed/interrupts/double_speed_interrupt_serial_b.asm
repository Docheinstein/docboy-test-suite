INCLUDE "all.inc"

; Check the timing of serial interrupt in double speed mode.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ; Enable interrupt
    ei

    xor a

REPT 1024
    inc a
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    cp $ee
    jp nz, TestFail

    jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestFinish

