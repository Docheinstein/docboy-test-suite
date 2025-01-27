INCLUDE "docboy.inc"

; Check what happens by writing STAT's VBLANK INTERRUPT when current mode is VBLANK.
; and then reset IF. IF's STAT flag should remain unset.

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

    ; Reset IF
    xor a
    ldh [rIF], a

    Nops 2

    ; Check IF: STAT flag should be unset
    ldh a, [rIF]
    ld b, a

    ld a, $e0
    cp b
    jp nz, TestFail

    jp TestSuccess
