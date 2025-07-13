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
    
    ; Reset PPU
    DisablePPU
    EnablePPU
    
    Wait 143 * 228

    Nops 224

    ; Read STAT
    ldh a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess
