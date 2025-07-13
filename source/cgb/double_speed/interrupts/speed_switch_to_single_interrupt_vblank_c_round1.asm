INCLUDE "all.inc"

; Check the timing of speed switch when VBlank interrupt is triggered during a speed switch to double speed.

EntryPoint:
      ; Set SCX=0
        ld a, $00
        ldh [rSCX], a

        ; Reset PPU
        DisablePPU
        EnablePPU

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

    Nops 93

    db $10 ; STOP -> should work
    nop

    Nops 44

    ldh a, [rDIV]
    cp $80

    jp nz, TestFail
    jp TestSuccess