INCLUDE "all.inc"

; STAT interrupt with OAM mode should not be triggered by entering HBLANK.

EntryPoint:
    ; Wait for line 143
    WaitScanline 143

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Reach the end of the scanline
    Nops 90

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable interrupts
    ei

    Nops 16

    ; This should be reached
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestFail
