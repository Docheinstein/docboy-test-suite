INCLUDE "docboy.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    ; 7 nops should read VBLANK from STAT mode
    Nops 7

    ; Read STAT's mode bits
    ldh a, [rSTAT]
    ld b, $03
    and b

    ; Check result
    ld b, STATF_HBL
    cp b
    jp nz, TestFail

    jp TestSuccess
