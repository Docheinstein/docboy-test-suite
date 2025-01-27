INCLUDE "docboy.inc"

; Check what happens by writing STAT's VBLANK INTERRUPT when current mode is VBLANK.
; It should set the IF's STAT flag.

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
    ld a, %00010
    ldh [rIE], a

    ; Check IF: STAT flag should be set
    ldh a, [rIF]
    ld b, a

    ld a, $e3
    cp b
    jp nz, TestFail

    jp TestSuccess
