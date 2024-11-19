INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check the duration of Pixel Transfer (Mode 3), with:

EntryPoint:
    DisablePPU

    ; Set OAM Data
    ResetOAM
    Memcpy $fe00, OamData, OamDataEnd - OamData

    EnablePPU

    Nops 176

    ; We should already be in HBlank
    ldh a, [rSTAT]
    cp $80
    jp nz, TestFailCGB

    jp TestSuccessCGB

OamData:
    db $10, 32, $00, $00
OamDataEnd: