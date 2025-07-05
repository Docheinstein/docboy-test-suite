INCLUDE "all.inc"

; Check how speed switch affects PPU timing in double speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
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

    Nops 223

    Nops 40

    ; Read STAT
    ldh a, [rSTAT]
    cp $82

    jp nz, TestFail
    jp TestSuccess
