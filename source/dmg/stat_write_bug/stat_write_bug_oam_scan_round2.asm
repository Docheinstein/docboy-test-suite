INCLUDE "all.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's OAM Scan interrupt.

EntryPoint:
    DisablePPU
    EnablePPU

    LongWait 114

    Nops 107

    xor a
    ldh [rIF], a

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess