INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Turning on PPU with STAT's OAM interrupt flag set shouldn't set IF's STAT bit nor raise interrupt.

EntryPoint:
    DisablePPU

    ld a, STATF_MODE10
    ldh [rSTAT], a

    xor a
    ldh [rIF], a

    EnablePPU

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess