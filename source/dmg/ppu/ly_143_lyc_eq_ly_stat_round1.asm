INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


EntryPoint:
    DisablePPU
    ResetOAM
    EnablePPU

    ld a, $8f
    ldh [rLYC], a

    LongWait 114 * 142

    Nops 105

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
