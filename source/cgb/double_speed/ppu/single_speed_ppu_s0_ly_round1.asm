INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 78 * 114

    Nops 109

    ; Read LY
    ldh a, [rLY]
    cp $4e

    jp nz, TestFail
    jp TestSuccess
