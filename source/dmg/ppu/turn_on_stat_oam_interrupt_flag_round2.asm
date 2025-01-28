INCLUDE "all.inc"

; Turning on PPU with STAT's OAM interrupt flag set shouldn't set IF's STAT bit nor raise interrupt.

EntryPoint:
    DisablePPU

    ld a, STATF_MODE10
    ldh [rSTAT], a

    xor a
    ldh [rIF], a

    EnablePPU

    Nops 110

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess