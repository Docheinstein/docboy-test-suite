INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


EntryPoint:
    DisablePPU
    ResetOAM
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    LongWait 114 * 143

    Nops 104

    ldh a, [rLY]
    cp $8f

    jp nz, TestFail

    jp TestSuccess
