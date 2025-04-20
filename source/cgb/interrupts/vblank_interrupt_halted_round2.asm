INCLUDE "all.inc"

; Check the timing of Vblank interrupt while halted.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    ; Skip some lines
    Nops 114 * 142

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable VBlank interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    halt

    Nops 15

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess