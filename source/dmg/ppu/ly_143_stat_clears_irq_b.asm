INCLUDE "all.inc"

; Check IF for STAT interrupt for line 144.

EntryPoint:
    DisablePPU

    Memset $fe00, $00, 160

    ld a, $8e
    ldh [rLYC], a

    EnablePPU

    Wait 114 * 142

    ; Wait HBlank
    Nops 70

    ld a, STATF_LYC | STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 40

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
