INCLUDE "all.inc"

; Check IF for STAT interrupt for line 144.

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    Wait 114 * 142

    ld a, STATF_MODE10
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 96

    ldh a, [rSTAT]
    cp $a0

    jp nz, TestFail

    jp TestSuccess
