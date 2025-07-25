INCLUDE "all.inc"

; Check if the channel samples with DAC off and trigger on.

EntryPoint:
    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    EnableAPU

    ; Volume = 100
    ld a, $20
    ldh [rNR32], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR34], a

    Nops 1024

    ldh a, [rPCM34]
    cp $00

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd: