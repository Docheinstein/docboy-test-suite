INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

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
        
    Wait 78 * 114

    Nops 4
    
    Nops 1

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
