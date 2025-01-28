INCLUDE "all.inc"

; Check how much it takes to react to a timer interrupt set manually before EI.

EntryPoint:
    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable SERIAL interrupt
    ld a, IEF_TIMER
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; If this is reached Timer interrupt or Timer is not working
    jp TestFail

TestFinish:
    ; 98 nops should read DIV=02
    Nops 98

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
