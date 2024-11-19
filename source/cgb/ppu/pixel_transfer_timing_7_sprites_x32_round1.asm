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

    Nops 184

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    cp $83
    jp nz, TestFailCGB

    jp TestSuccessCGB

OamData:
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
OamDataEnd: