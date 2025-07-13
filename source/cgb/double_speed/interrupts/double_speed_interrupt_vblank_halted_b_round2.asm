INCLUDE "all.inc"

; Check the timing of vblank interrupt in double speed mode while halted.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 2 * 114 * 143 + 114

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable interrupt
    ei

    ; Halt
    halt
    nop

    ; We should not reach this point
    jp TestFail

TestFinish:
    Nops 15

    ldh a, [rDIV]
    cp $02

    jp nz, TestFail

    jp TestSuccess


SECTION "VBlank handler", ROM0[$40]
    jp TestFinish
