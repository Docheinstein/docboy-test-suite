INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

EntryPoint:
    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 78 * 114

    Wait 57
    
    Wait 3

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess
