INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's VBlank interrupt.

EntryPoint:
    DisablePPU
    EnablePPU

    LongWait 143 * 114

    Nops 104

    xor a
    ldh [rIF], a

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e3

    jp nz, TestFail

    jp TestSuccess