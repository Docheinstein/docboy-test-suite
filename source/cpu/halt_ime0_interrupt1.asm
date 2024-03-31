INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how HALT behaves with:
; * IME       : disabled
; * Interrupt : pending

EntryPoint:
    ; Enable timer interrupt and set timer interrupt flag
    ld a, $04
    ldh [rIF], a
    ldh [rIE], a

    ; Enable timer
    ldh [rTAC], a

    ; Reset D and E
    ld de, $0000

    halt

    inc d ; <- this should be read twice (HALT BUG)
    inc e

    ld a, d
    cp 2
    jp nz, TestFail

    ld a, e
    cp 1
    jp nz, TestFail

    jp TestSuccess



