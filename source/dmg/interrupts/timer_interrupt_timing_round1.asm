INCLUDE "all.inc"

; Check how much it takes to react to a timer interrupt while in busy loop.

EntryPoint:
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

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Busy loop
    Nops 64

    ; If this is reached Timer interrupt or Timer is not working
    jp TestFail

TestFinish:
    ; 35 nops should read DIV=0
    Nops 35

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    jp TestFinish
