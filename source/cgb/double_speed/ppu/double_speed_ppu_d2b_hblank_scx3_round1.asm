INCLUDE "all.inc"

; Check how speed switch affects PPU timing in double speed mode.

EntryPoint:
    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop
    
    Nops 1
    
    ; Reset PPU
    DisablePPU
    EnablePPU
    
    Wait 78 * 114

    Nops 120
    
    Nops 3

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
