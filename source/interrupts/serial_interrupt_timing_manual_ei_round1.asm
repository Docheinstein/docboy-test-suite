INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a serial interrupt set manually before EI.

EntryPoint:
    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; Halt
    halt
    nop

    ; If this is reached either Serial interrupt is not working or Serial is not working
    jp TestFail

TestFinish:
    ; 105 nops should read DIV=01
    Nops 105

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    jp TestFinish
