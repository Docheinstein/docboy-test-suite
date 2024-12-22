INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    ResetOAM

    EnablePPU

    Nops 123

    ld a, $06
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 33

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess
