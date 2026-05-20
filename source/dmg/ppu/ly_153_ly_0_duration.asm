INCLUDE "all.inc"

; LY should not reach 154.
; LY is set to 0 just after scaline 153 and it remains 0 for two scanlines.

EntryPoint:
    ; Wait for line 143
    WaitScanline 143

    ; Skip 10 lines
    Wait 10 * 114

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    ; Skip a line
    Wait 114

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    jp TestSuccess