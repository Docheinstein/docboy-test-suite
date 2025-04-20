INCLUDE "all.inc"

; Check the timing of STAT interrupt during speed switch to single speed.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    EnablePPU

    ; Go to line 42
    LongWait 114 * 42

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

    Nops 5

    ; Read DIV
    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess