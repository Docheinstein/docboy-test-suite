INCLUDE "all.inc"

; Check the timing of speed switch when VBlank interrupt is triggered during a speed switch to double speed.

EntryPoint:
    DisablePPU
    EnablePPU

    Wait 114 * 143

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable VBlank interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    Nops 91

    db $10 ; STOP -> should work
    nop

    Nops 57

    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess