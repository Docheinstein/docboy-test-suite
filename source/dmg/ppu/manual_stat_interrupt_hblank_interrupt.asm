INCLUDE "all.inc"

; Check what happens by writing STAT's HBLANK INTERRUPT when current mode is HBLANK.
; It should raise a STAT interrupt.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    WaitMode 0

    ; Enable STAT's HBLANK interrupt
    ld a, %1000
    ldh [rSTAT], a

    ; Enable STAT interrupt
    ei
    ld a, %00010
    ldh [rIE], a

    di

    ; We should never reach this point
    jp TestFail

SECTION "STAT handler", ROM0[$48]
    ; This should be triggered
    jp TestSuccess
