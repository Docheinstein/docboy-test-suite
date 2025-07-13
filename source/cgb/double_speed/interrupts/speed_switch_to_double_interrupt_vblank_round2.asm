INCLUDE "all.inc"

; Check the timing of speed switch when VBlank interrupt is triggered during a speed switch to double speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU
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

    ; Switch to double speed
    stop

    Nops 4

    ; Read DIV
    ldh a, [rDIV]
    cp $6b

    jp nz, TestFail
    jp TestSuccess