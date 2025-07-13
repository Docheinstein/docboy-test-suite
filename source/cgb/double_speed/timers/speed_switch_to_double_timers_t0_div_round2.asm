INCLUDE "all.inc"

; Check the timing of timers when switch to double speed at T=0.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop

    Nops 61

    ; Read STAT
    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess
