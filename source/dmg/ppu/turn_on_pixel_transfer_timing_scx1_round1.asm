INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


; Check the duration of Pixel Transfer (Mode 3) at line 0, with:
; SCX=1
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

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