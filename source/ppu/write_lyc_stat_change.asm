INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to LYC affects STAT LYC_EQ_LY bit.

EntryPoint:
    ; Wait for start of scanline
    Nops 8

    ; Write to LYC
    ld a, $42
    ldh [rLYC], a

    ; Read from STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $82
    cp b
    jp nz, TestFail

    jp TestSuccess
