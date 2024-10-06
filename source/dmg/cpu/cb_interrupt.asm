INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check whether interrupt can occur in the middle of a CB-prefixed instruction.

EntryPoint:
    ; Reset interrupt flags
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, $04
    ldh [rIE], a

    ; Enable interrupts
    ei
    nop

    ; Reset D and E
    ld de, $0000

    ; Reset TIMA
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    REPT 20
        inc d ; $14
        rlc d ; $CB $02
    ENDR

    jp TestFail

TestFinish:
    ld a, d
    cp 6
    jp nz, TestFail

    ld a, e
    cp 0
    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    jp TestFinish
