INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a serial interrupt while in busy loop.

EntryPoint:
    ; Enable interrupt
    ei

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

    ; Busy loop
    Nops 1024

    ; If this is reached either Serial interrupt is not working or Serial is not working
    jp TestFail

TestFinish:
    ; 53 nops should read DIV=11
    Nops 53

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $11
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    jp TestFinish
