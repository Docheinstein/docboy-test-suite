IF !DEF(APU_INC)
DEF APU_INC EQU 1

INCLUDE "hardware.inc"

MACRO EnableAPU
    ld a, $80
    ldh [rNR52], a

    ld a, $FF
    ldh [rNR51], a

    ld a, $00
    ldh [rNR50], a

ENDM

MACRO DisableAPU
    ld a, $00
    ldh [rNR52], a
ENDM

; Emits an audible beep through CH1
MACRO Beep
    ; Enable APU
    ld a, $80
    ldh [rNR52], a

    ; Enable all channels
    ld a, $FF
    ldh [rNR51], a

    ; Maximum volume
    ld a, $77
    ldh [rNR50], a

    ; Disable period sweep
    xor a
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Period = 96
    ld a, $A0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a
ENDM

ENDC