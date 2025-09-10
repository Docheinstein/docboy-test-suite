INCLUDE "all.inc"

; Check the timing of the content of CH3's Wave RAM.

EntryPoint:
    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    EnableAPU

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 100
    ld a, $20
    ldh [rNR32], a

    ; Period = 1
    ld a, $FF
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    Nops 0

    ldh a, [rPCM34]
    cp $03

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $01,$23,$45,$67,$89,$AB,$CD,$EF
db $FE,$DC,$BA,$98,$76,$54,$32,$10
WaveRamEnd: