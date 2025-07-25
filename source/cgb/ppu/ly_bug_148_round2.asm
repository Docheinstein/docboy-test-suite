INCLUDE "all.inc"

; Check the value of LY at the end of line 148 and whether it is bugged or not.

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

    Wait 21 * 114
    
    Nops 55

    Wait 148 * 114
    
    Nops 2

    ; Read LY
    ldh a, [rLY]
    cp $95

    jp nz, TestFail
    jp TestSuccess
