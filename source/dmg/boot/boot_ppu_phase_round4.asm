INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    ; Wait for the next frame first VBlank cycle
    LongWait 114 * 144 + 8

    ; Read STAT's mode bits
    ldh a, [rSTAT]
    ld b, $03
    and b

    ; Check result
    ld b, STATF_VBL
    cp b
    jp nz, TestFail

    jp TestSuccess
