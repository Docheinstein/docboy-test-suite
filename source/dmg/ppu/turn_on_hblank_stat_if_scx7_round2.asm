INCLUDE "docboy.inc"

; Check IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160

    EnablePPU

    Nops 123

    ld a, $07
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 34

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess
