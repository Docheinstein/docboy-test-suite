INCLUDE "all.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's OAM Scan interrupt.

EntryPoint:
    DisablePPU
    EnablePPU

    Wait 114

    Nops 106

    xor a
    ldh [rIF], a

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess