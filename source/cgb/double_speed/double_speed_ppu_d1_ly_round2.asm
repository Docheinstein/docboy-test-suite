INCLUDE "all.inc"

; Check how speed switch affects PPU timing in double speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU
    EnablePPU
    
	; Switch to double speed
    stop
    
    LongWait 78 * 114

    Nops 53

    ; Read LY
    ldh a, [rLY]
    cp $1d

    jp nz, TestFail
    jp TestSuccess
