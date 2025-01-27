INCLUDE "docboy.inc"

; STAT interrupt with OAM mode should be triggered by entering VBLANK.

EntryPoint:
    ; Wait for line 143
    WaitScanline 143

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable VBLANK interrupt
    ld a, STATF_MODE01
    ldh [rSTAT], a

    ; Reach the end of the scanline
    Nops 90

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable interrupts
    ei

    Nops 16

    ; This should not be reached
    jp TestFail


SECTION "STAT handler", ROM0[$48]
    jp TestSuccess
