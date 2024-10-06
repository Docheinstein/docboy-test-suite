INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by writing STAT's OAM INTERRUPT when current mode is OAM.
; It should NOT set the IF's STAT flag.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    WaitMode 2

    ; Enable STAT's OAM interrupt
    ld a, %100000
    ldh [rSTAT], a

    ; Check IF: STAT flag should be set
    ldh a, [rIF]
    ld b, a

    ld a, $e0
    cp b
    jp nz, TestFail

    jp TestSuccess
