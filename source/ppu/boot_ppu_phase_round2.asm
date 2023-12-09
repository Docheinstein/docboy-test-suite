INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    ; 8 nops should read OAM SCAN from STAT mode
    Nops 8

    ; Read STAT's mode bits
    ldh a, [rSTAT]
    ld b, $03
    and b

    ; Check result
    ld b, STATF_OAM
    cp b
    jp nz, TestFail

    jp TestSuccess