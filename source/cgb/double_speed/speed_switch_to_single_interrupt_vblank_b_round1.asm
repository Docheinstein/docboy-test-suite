INCLUDE "all.inc"

; Check the timing of Vblank interrupt during speed switch to single speed.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    EnablePPU

    ; Go to line 42
    Wait 114 * 42

   ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_VBLANK
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Switch to single speed
    stop

    ; Read DIV
    ldh a, [rDIV]
    cp $db

    jp nz, TestFail
    jp TestSuccess