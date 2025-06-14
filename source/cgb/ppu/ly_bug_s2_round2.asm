INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in single speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop
    
    ; Reset PPU
    DisablePPU
    EnablePPU
    
	; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    
	; Switch to single speed
    stop
        
    LongWait 76 * 114

    Nops 57

    ; Read LY
    ldh a, [rLY]
    cp $38

    jp nz, TestFail
    jp TestSuccess
