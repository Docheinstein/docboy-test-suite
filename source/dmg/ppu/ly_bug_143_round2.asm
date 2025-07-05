INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 143 * 114
    
    Nops 111

    ; Read LY
    ldh a, [rLY]
    cp $90

    jp nz, TestFail
    jp TestSuccess
