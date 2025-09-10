INCLUDE "all.inc"

; Retrigger the channel while it is running.

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
	
	Nops 12

    ; Retrigger
    ldh [rNR14], a

	Nops 0

    ldh a, [rPCM12]
    cp $0f

    jp nz, TestFail
    jp TestSuccess
