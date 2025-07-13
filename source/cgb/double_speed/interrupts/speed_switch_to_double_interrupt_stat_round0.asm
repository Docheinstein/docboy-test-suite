INCLUDE "all.inc"

; Check the timing of speed switch when STAT interrupt is triggered during a speed switch to double speed.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    EnablePPU

    ; Go to line 42
    Wait 114 * 42

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Switch to double speed
    stop

    ; Read DIV
    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess