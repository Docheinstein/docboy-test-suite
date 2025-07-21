INCLUDE "all.inc"

; Change period through NR14 while channel is running (no retrigger).

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ld a, $FC
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a
	
	Nops 16

    ; Retrigger
	ld a, $06
    ldh [rNR14], a

    Wait 2596

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
