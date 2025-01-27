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
