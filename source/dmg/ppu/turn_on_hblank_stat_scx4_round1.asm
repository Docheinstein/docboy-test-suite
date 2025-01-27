INCLUDE "docboy.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160

    EnablePPU

    Nops 123

    ld a, $04
    ldh [rSCX], a

    Nops 46

    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail

    jp TestSuccess
