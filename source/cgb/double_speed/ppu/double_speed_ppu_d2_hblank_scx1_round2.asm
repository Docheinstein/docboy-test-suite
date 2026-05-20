INCLUDE "all.inc"

; Check how speed switch affects PPU timing in double speed mode.

EntryPoint:
    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop
    
    ; Reset PPU
    DisablePPU
    EnablePPU
    
    Wait 78 * 114

    Wait 120
    
    Wait 3

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess
