INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "print.inc"
INCLUDE "debug.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's OAM Scan interrupt.

EntryPoint:
    DisablePPU

    ld a, STATF_MODE10
    ldh [rSTAT], a

    EnablePPU

    LongWait 114

    Nops 105

    xor a
    ldh [rIF], a

    ldh [rSTAT], a

    ldh a, [rIF]
    DumpRegisters

    jp nz, TestFail

    jp TestSuccess