INCLUDE "all.inc"

; Check how much it takes to react to a vblank interrupt set manually before EI.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; If this is reached VBLANK interrupt or PPU is not working
    jp TestFail

TestFinish:
    ; 106 nops should read DIV=02
    Nops 106

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestFinish