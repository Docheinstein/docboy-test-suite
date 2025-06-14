INCLUDE "all.inc"

; Check the value of LY at the end of line 152 and whether it is bugged or not.

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

    LongWait 21 * 114
    
    Nops 55

    LongWait 152 * 114
    
    Nops 1

    ; Read LY
    ldh a, [rLY]
    cp $98

    jp nz, TestFail
    jp TestSuccess
