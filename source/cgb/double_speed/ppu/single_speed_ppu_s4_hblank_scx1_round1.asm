INCLUDE "all.inc"

; Check how speed switch affects PPU timing in single speed mode.

EntryPoint:
    ; Set SCX=1
    ld a, $01
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
        
    Wait 78 * 114

    Nops 29
    
    Nops 0

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
