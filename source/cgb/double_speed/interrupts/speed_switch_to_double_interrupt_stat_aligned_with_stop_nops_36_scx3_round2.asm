INCLUDE "all.inc"

; Check the timing of speed switch when STAT interrupt is triggered nearby STOP instruction.

EntryPoint:
    DisablePPU

    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    EnablePPU

    Wait 114 * 143

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    Nops 36

    db $10
    nop
    
    Nops 58
	
    ldh a, [rDIV]
    cp $01
    
    jp nz, TestFail
    jp TestSuccess
