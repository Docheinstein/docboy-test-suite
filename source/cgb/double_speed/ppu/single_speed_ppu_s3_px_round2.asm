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
    
	Nops 1

	; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    
	; Switch to single speed
    stop
        
    Wait 78 * 114

    Nops 56

    Nops 20

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
