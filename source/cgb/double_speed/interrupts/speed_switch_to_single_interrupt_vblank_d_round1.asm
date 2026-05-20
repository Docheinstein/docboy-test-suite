INCLUDE "all.inc"

; Check the timing of speed switch when VBlank interrupt is triggered during a speed switch to double speed.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop

    Wait 1

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

    Wait 93

    db $10 ; STOP -> should work
    nop

    Wait 27

    ldh a, [rDIV]
    cp $10

    jp nz, TestFail
    jp TestSuccess