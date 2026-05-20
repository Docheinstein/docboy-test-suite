INCLUDE "all.inc"

; Check when IF for STAT HBlank is triggered with various SCX.

EntryPoint:
    DisablePPU

    ; Enable STAT (HBlank) interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    EnablePPU

    Wait 114

    ; Reset IF
    xor a
    ldh [rIF], a

    Wait 55

    ; Read IF
    ldh a, [rIF]
    cp $e0

    jp nz, TestFail
    jp TestSuccess

