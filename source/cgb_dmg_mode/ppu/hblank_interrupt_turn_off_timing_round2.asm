INCLUDE "all.inc"

; Turn off PPU just before an HBLANK interrupt is going to be raised.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable HBLANk interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    EnablePPU

    ; Skip some lines
    Wait 114 * 10

    ; Enable interrupt
    xor a
    ldh [rIF], a

    ei

    ; Wait some time
    Nops 54

    ; Disable PPU
    DisablePPU

    Nops 20

    jp TestFail


SECTION "STAT handler", ROM0[$48]
    jp TestSuccess
