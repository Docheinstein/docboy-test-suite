INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by writing STAT's VBLANK INTERRUPT when current mode is VBLANK.
; It should raise a STAT interrupt.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    WaitMode 1

    ; Enable STAT's VBLANK interrupt
    ld a, %10000
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
