INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a vblank interrupt while in busy loop.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Wait LY == 143
    WaitScanline $8f

    ; Enable interrupt
    ei

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Busy loop
    Nops 128

    ; If this is reached VBLANK interrupt or PPU is not working
    jp TestFail

TestFinish:
    ; 22 nops should read DIV=2
    Nops 22

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

