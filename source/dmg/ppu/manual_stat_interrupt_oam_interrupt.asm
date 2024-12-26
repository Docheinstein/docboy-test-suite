INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by writing STAT's OAM INTERRUPT when current mode is OAM.
; It should NOT raise a STAT interrupt.

EntryPoint:
    Nops 114

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    WaitMode 2

    ; Enable STAT's OAM interrupt
    ld a, %100000
    ldh [rSTAT], a

    ; Enable STAT interrupt
    ei
    ld a, %00010
    ldh [rIE], a

    Nops 2

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestFail
