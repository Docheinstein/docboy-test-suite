INCLUDE "all.inc"

; Reading from Wave RAM either reads the current byte CH3 is accessing or $FF

EntryPoint:
    EnableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 0
    ld a, $00
    ldh [rNR32], a

    ; Period = 3
    ld a, $FD
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    Nops 4

    ldh a, [$FF30]

    cp $FF
    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $00,$11,$22,$33,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
WaveRamEnd: