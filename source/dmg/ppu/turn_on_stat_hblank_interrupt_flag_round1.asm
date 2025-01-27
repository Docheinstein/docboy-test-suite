INCLUDE "docboy.inc"

; Turning on PPU with STAT's HBlank interrupt flag set shouldn't set IF's STAT bit nor raise interrupt.

EntryPoint:
    DisablePPU

    ld a, STATF_MODE00
    ldh [rSTAT], a

    xor a
    ldh [rIF], a

    EnablePPU

    Nops 59

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess