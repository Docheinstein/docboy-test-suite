INCLUDE "all.inc"

; Check the timing of VBlank interrupt
; in single speed (after a switch back from double speed).

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

    EnablePPU

    ; Skip some lines
    Nops 114 * 142

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable VBlank interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ei

    xor a

REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $d8

    jp nz, TestFail
    jp TestSuccess


SECTION "VBlank handler", ROM0[$40]
    jp TestContinue
