INCLUDE "all.inc"

; Check the timing of vblank interrupt in double speed mode.

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

    Nops 1

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Enable interrupt
    ei

    xor a

REPT 200
    inc a
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    cp $64

    jp nz, TestFail
    jp TestSuccess


SECTION "VBlank handler", ROM0[$40]
    jp TestFinish
