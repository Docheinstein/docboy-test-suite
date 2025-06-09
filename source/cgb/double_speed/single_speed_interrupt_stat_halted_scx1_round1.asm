INCLUDE "all.inc"

; Check the timing of STAT interrupt with a certain SCX while halted
; in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    DisableAPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

    ; Reset DIV
    xor a
    ldh [rDIV], a


    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    halt

    Nops 6

    ldh a, [rDIV]
    cp $02

    jp nz, TestFail
    jp TestSuccess
