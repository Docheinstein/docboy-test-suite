INCLUDE "all.inc"

; TODO: test on real hardware.
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

    ; Halt
    halt
    nop

    ; If this is reached VBLANK interrupt or PPU is not working
    jp TestFail

TestFinish:
    ; 21 nops should read DIV=1
    Nops 21

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestFinish

