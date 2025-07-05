INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

EntryPoint:
    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 78 * 114

    Nops 57
    
    Nops 2

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
