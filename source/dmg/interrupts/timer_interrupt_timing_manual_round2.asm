INCLUDE "all.inc"

; Check how much it takes to react to a timer interrupt set manually after EI.

EntryPoint:
    ; Enable interrupt
    ei

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIE], a
    ldh [rIF], a

    ; Busy loop
    Nops 64

    ; If this is reached Timer interrupt or Timer is not working
    jp TestFail

TestFinish:
    ; 100 nops should read DIV=02
    Nops 100

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    jp TestFinish
