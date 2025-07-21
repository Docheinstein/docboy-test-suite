INCLUDE "all.inc"

; Retrigger the channel while it is running.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
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
	
	Nops 2

    ; Retrigger
    ldh [rNR14], a

	Nops 2

    ldh a, [rPCM12]
    cp $0f

    jp nz, TestFail
    jp TestSuccess
