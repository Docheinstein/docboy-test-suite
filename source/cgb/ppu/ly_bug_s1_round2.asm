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
    
	; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    
	; Switch to single speed
    stop
    
    ; Reset PPU
    DisablePPU
    EnablePPU
    
    Wait 77 * 114

    Nops 110

    ; Read LY
    ldh a, [rLY]
    cp $4e

    jp nz, TestFail
    jp TestSuccess
