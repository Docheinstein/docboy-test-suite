INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in double speed mode.

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

    LongWait 38 * 114

    Nops 151

    Nops 1

    ; Read LY
    ldh a, [rLY]
    cp $66

    jp nz, TestFail
    jp TestSuccess
