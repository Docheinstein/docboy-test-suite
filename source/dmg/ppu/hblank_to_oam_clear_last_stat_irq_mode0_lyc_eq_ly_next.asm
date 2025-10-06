INCLUDE "all.inc"

; Check if STAT HBlank interrupt is raised for the transition between HBlank and OAM Scan.

EntryPoint:
    ld a, 43
    ld [rLYC], a

    DisablePPU
    EnablePPU

    ; Go to line 42
    Wait 42 * 114

    ; Skip OAM Scan
    Nops 20

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK and LYC interrupt
    ld a, STATF_MODE00 | STATF_LYC
    ldh [rSTAT], a

    ; Enable interrupts
    ei

    ld hl, FirstInterrupt

    ld de, $00
    ld bc, $00

Loop1:
    inc de
    jp Loop1

    jp TestFail

FirstInterrupt:
    ld hl, SecondInterrupt
    ei

Loop2:
    inc bc
    jp Loop2

    jp TestFail

SecondInterrupt:
    ld a, c
    cp $07
    jp nz, TestFail

    ld a, e
    cp $03
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp hl
