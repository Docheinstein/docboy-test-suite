INCLUDE "docboy.inc"

; Check how much it takes to react to a joypad interrupt set manually after EI.

EntryPoint:
    ; Enable interrupt
    ei

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable JOYPAD interrupt
    ld a, IEF_HILO
    ldh [rIE], a
    ldh [rIF], a

    ; Busy loop
    Nops 64

    ; If this is reached either Serial interrupt is not working or Serial is not working
    jp TestFail

TestFinish:
    ; 107 nops should read DIV=01
    Nops 107

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Joypad handler", ROM0[$60]
    jp TestFinish
