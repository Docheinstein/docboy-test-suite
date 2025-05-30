INCLUDE "all.inc"

; Turning on PPU with STAT's HBlank interrupt flag set shouldn't set IF's STAT bit nor raise interrupt.

EntryPoint:
    DisablePPU

    ld a, STATF_MODE00
    ldh [rSTAT], a

    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ei

    EnablePPU

    Nops 58

    jp TestFail

SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestSuccess