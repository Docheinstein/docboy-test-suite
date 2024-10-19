INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


; Check the duration of Pixel Transfer (Mode 3) at line 0 of next frame, with:
; SCX=2
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    ; Set OAM Data
    ResetOAM

    ; Reset PPU phase
    EnablePPU

    LongWait 154 * 114
    Nops 60

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $84
    jp nz, TestFail

    jp TestSuccess