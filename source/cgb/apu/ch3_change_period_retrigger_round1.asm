INCLUDE "all.inc"

; Change CH3 period with a retrigger.

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

    ; Period
    ld a, $FF
    ldh [rNR33], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR34], a

    Nops 4096

    ; Trigger = 1
    ld a, $81
    ldh [rNR34], a

    Nops 379

    ldh a, [rPCM34]
    cp $05

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd: