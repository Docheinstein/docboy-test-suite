INCLUDE "all.inc"

; Check the timing of VBlank interrupt while halted
; in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    EnablePPU

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


    ; Skip glitched line 0
    Nops 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    halt

    Nops 21

    ldh a, [rDIV]
    cp $5c

    jp nz, TestFail
    jp TestSuccess
