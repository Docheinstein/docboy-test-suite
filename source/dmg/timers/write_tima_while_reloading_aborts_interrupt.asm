INCLUDE "docboy.inc"

; Writing to TIMA while it is reloading should abort the interrupt.

EntryPoint:
    ; Set TMA to something
    ld a, $66
    ldh [rTMA], a

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    Nops 8

    ; Write something to TIMA
    ldh [rTIMA], a

    ; Just wait a bit to see if interrupt comes
    Nops 10

    ; Disable interrupts now to continue executing safely
    di

    ; Read IF
    ldh a, [rIF]
    ld b, a

    ; Timer interrupt flag should be not set
    ld a, $e0
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    ; If we get here the interrupt has not been aborted by TIMA write
    jp TestFail
