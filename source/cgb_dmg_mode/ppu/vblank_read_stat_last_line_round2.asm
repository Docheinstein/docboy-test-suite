INCLUDE "all.inc"

; Differently from DMG, the last scanline of VBLANK STAT goes straight from VBLANK to OAM SCAN (instead of passin through HBLANK).

EntryPoint:
    ; Reset STAT
    xor a
    ldh [rSTAT], a

    ; Reset LYC
    ld a, $10
    ldh [rLYC], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 114 * 153
    Wait 110

    ldh a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess
