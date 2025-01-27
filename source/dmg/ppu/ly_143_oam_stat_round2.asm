INCLUDE "docboy.inc"

; Check IF for STAT interrupt for line 144.

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    LongWait 114 * 142

    ld a, STATF_MODE10
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 97

    ldh a, [rSTAT]
    cp $a2

    jp nz, TestFail

    jp TestSuccess
