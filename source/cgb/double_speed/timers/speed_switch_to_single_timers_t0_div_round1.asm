INCLUDE "all.inc"

; Check the timing of timers when switch to single speed at T=0.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

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
    
    Nops 60

    ; Read DIV
    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess
