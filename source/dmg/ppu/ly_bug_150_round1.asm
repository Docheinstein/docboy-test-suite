INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 150 * 114
    
    Nops 110

    ; Read LY
    ldh a, [rLY]
    cp $97

    jp nz, TestFail
    jp TestSuccess
