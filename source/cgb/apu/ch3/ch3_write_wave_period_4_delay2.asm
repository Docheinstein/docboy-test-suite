INCLUDE "all.inc"

; Writing to Wave RAM while it is on either writes the current byte CH3 is accessing.

EntryPoint:
    EnableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 0
    ld a, $00
    ldh [rNR32], a

    ; Period = 4
    ld a, $FC
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    Nops 2

    ; Write to wave ream
    ldh [$FF30], a

    ; Enable = 0
    xor a
    ldh [rNR30], a

    ; Read wave ram
    Memcmp $ff30, ExpectedWaveRam, ExpectedWaveRamEnd - ExpectedWaveRam
    jp nz, TestFail

    jp TestSuccess

WaveRam:
db $00,$11,$22,$33,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
WaveRamEnd:

ExpectedWaveRam:
db $87,$11,$22,$33,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
ExpectedWaveRamEnd: