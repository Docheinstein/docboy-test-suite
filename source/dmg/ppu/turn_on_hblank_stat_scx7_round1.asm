INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    ResetOAM

    EnablePPU

    Nops 123

    ld a, $07
    ldh [rSCX], a

    Nops 46

    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail

    jp TestSuccess
