INCLUDE "all.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160

    EnablePPU

    Wait 123

    ld a, $04
    ldh [rSCX], a

    Wait 47

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
