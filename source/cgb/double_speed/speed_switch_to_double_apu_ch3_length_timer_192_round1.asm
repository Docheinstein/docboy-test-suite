INCLUDE "all.inc"

; Check how length timer ticks during double speed mode.

EntryPoint:
    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

	EnableAPU

    ; Volume = 100
    ld a, $20
    ldh [rNR32], a

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Length Timer = 192
    ld a, $3F
    ldh [rNR31], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $c7
    ldh [rNR34], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

REPT 48
    Wait 31871
ENDR
    Wait 14381

    ldh a, [rNR52]
    cp $f4

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd:
