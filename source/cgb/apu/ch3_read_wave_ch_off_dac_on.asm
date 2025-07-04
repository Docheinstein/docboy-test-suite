INCLUDE "all.inc"

; Reading from Wave RAM when channel is off and DAC is on.

EntryPoint:
    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    EnableAPU

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 0
    ld a, $00
    ldh [rNR32], a

    ; Period = 3
    ld a, $FD
    ldh [rNR33], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR34], a

    ; Wait a bit
    Nops 128

    ; Enable = 0
    ld a, $00
    ldh [rNR30], a

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Read
    ldh a, [$FF30]
    ld b, a
    Nops 1

    ldh a, [$FF30]
    ld c, a
    Nops 1

    ldh a, [$FF30]
    ld d, a
    Nops 1

    ldh a, [$FF30]
    ld e, a

    ; Compare
    ld a, b
    cp $12

    ld a, c
    cp $12

    ld a, d
    cp $12

    ld a, e
    cp $12

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd: