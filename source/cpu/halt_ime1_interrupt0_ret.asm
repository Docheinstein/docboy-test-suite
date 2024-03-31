INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how HALT behaves with:
; * IME       : enabled
; * Interrupt : nothing pending

EntryPoint:
    ; Reset interrupt flags
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, $04
    ldh [rIE], a

    ; Enable timer
    ldh [rTAC], a

    ; Reset D and E
    ld de, $0000

    ; Enable interrupts
    ei
    nop

    halt

    inc d
    inc e

    ld a, d
    cp 1
    jp nz, TestFail

    ld a, e
    cp 1
    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    ret


