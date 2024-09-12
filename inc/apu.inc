MACRO WaitApuTick
    LongWait 16824 / 4
ENDM

MACRO WaitApuTicks
REPT \1
    WaitApuTick
ENDR
ENDM

MACRO DisableAPU
    ld a, $00
    ldh [rNR52], a
ENDM

MACRO EnableAPU
    ld a, $80
    ldh [rNR52], a

    ld a, $FF
    ldh [rNR51], a

    ld a, $00
    ldh [rNR50], a

ENDM

MACRO SyncCH1PeriodSweep
    ld a, $11
    ldh [rNR10], a

    ld a, $08
    ldh [rNR12], a

    ld a, $FF
    ldh [rNR13], a

    ld a, $83
    ldh [rNR14], a

.loop:
    ldh a, [rNR52]
    and $01
    jr nz, .loop

ENDM