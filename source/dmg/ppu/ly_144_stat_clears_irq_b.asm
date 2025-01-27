INCLUDE "docboy.inc"

; Check IF for STAT interrupt for line 144.

EntryPoint:
    DisablePPU

    Memset $fe00, $00, 160

    ld a, $8f
    ldh [rLYC], a

    EnablePPU

    LongWait 114 * 143

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
    cp $e1

    jp nz, TestFail

    jp TestSuccess
