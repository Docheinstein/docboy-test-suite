INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 17 * 114
    
    Nops 109

    ; Read LY
    ldh a, [rLY]
    cp $11

    jp nz, TestFail
    jp TestSuccess
