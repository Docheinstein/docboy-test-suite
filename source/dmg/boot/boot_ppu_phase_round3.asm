INCLUDE "docboy.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    ; Wait for the next frame last HBlank cycle
    LongWait 114 * 144 + 7

    ; Read STAT's mode bits
    ldh a, [rSTAT]
    ld b, $03
    and b

    ; Check result
    ld b, STATF_HBL
    cp b
    jp nz, TestFail

    jp TestSuccess
