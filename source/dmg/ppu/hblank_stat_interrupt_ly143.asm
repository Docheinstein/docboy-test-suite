INCLUDE "all.inc"

; Check if STAT HBlank interrupt is raised for the transition between VBlank and OAM Scan.

EntryPoint:
    DisablePPU
    EnablePPU

    Wait 143 * 114

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Reset IF
    xor a
    ldh [rIF], a

    ld de, $00

    ; Enable interrupts
    ei

Loop:
    inc de
    jp Loop

    jp TestFail

TestEnd:
    ld a, e
    cp $08
    jp nz, TestFail
    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestEnd
