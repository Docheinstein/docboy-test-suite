INCLUDE "all.inc"

; Change CH3 period with a retrigger after channel is turned off.

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

    ; Enable = 0
    ld a, $00
    ldh [rNR30], a

    Nops 1024

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR34], a

    ld a, $02
    ldh [rNR34], a

    Nops 889

    ldh a, [rPCM34]
    cp $05

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd: