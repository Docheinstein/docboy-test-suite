INCLUDE "all.inc"

; Check the value of LY at the end of line 143 and whether it is bugged or not.

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

    Wait 143 * 114
    
    Nops 0

    ; Read LY
    ldh a, [rLY]
    cp $8f

    jp nz, TestFail
    jp TestSuccess
