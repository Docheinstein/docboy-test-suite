INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in double speed mode.

EntryPoint:
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
    
	; Switch to single speed
    stop
    
    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop
    
    Wait 76 * 114

    Nops 43

    ; Read LY
    ldh a, [rLY]
    cp $1c

    jp nz, TestFail
    jp TestSuccess
