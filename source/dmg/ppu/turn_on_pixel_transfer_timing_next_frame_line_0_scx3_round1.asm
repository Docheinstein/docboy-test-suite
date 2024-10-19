INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


; Check the duration of Pixel Transfer (Mode 3) at line 0 of next frame, with:
; SCX=3
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    ; Set OAM Data
    ResetOAM

    ; Reset PPU phase
    EnablePPU

    LongWait 154 * 114
    Nops 59

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $87
    jp nz, TestFail

    jp TestSuccess