INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 78 * 114

    Nops 111

    ; Read STAT
    ldh a, [rSTAT]
    cp $82

    jp nz, TestFail
    jp TestSuccess
