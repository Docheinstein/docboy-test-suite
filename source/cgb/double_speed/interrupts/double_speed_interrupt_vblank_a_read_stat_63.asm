INCLUDE "all.inc"

; Check the timing of vblank interrupt in double speed mode.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    Nops 1

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 2 * 114 * 143 + 114

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    nop

    xor a

    Nops $63

    ldh a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess


SECTION "VBlank handler", ROM0[$40]
    jp TestFail
