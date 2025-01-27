INCLUDE "docboy.inc"

; Check what happens by writing STAT's HBLANK INTERRUPT when current mode is HBLANK.
; It should set the IF's STAT flag.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    WaitMode 0

DoIt:
    ; Enable STAT's HBLANK interrupt
    ld a, %1000
    ldh [rSTAT], a

    ; Check IF: STAT flag should be set
    ldh a, [rIF]
    ld b, a

    ld a, $e2
    cp b
    jp nz, TestFail

    jp TestSuccess
