INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


; Check the duration of Pixel Transfer (Mode 3) at line 0, with:
; SCX=0
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set OAM Data
    ResetOAM

    ; Reset PPU phase
    EnablePPU

    Nops 59

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $87
    jp nz, TestFail

    jp TestSuccess