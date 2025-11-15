INCLUDE "all.inc"

; The last scanline of VBLANK STAT goes to HBLANK for a cycle.

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
    cp $80

    jp nz, TestFail
    jp TestSuccess
