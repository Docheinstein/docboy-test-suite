INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's HBlank interrupt with different SCXs.

EntryPoint:
    DisablePPU

    ; Write SCX=1
    ld a, $01
    ldh [rSCX], a

    ld a, LCDCF_ON | LCDCF_BGON
    ldh [rLCDC], a

    LongWait 114

    xor a
    ldh [rIF], a

    Nops 56

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess
