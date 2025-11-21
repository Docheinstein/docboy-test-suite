INCLUDE "all.inc"

; Check if STAT OAM interrupt is raised for the transition between VBlank and OAM Scan.

EntryPoint:
    DisablePPU
    EnablePPU

    Wait 144 * 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ld de, $00

    ; Enable interrupts
    ei

Loop:
    inc de
    jp Loop

    jp TestFail

TestEnd:
    ld a, d
    cp $00
    jp nz, TestFail

    ld a, e
    cp $bb
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp TestEnd
