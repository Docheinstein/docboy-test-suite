INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check that this happens for LYC_EQ_LY interrupt when LYC == LY

EntryPoint:
    DisablePPU
    EnablePPU

    LongWait 114

    Nops 30

    ; Set LYC=66
    ld a, $01
    ldh [rLYC], a

    xor a
    ldh [rIF], a

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess