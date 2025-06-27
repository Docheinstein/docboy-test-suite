INCLUDE "all.inc"

; Retriggering CH3 while it is reading a byte rom Wave RAM corrupts wave ram.

EntryPoint:
    EnableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 0
    ld a, $00
    ldh [rNR32], a

    ; Period = 1
    ld a, $F9
    ldh [rNR33], a

    ; Trigger
    ld a, $87
    ldh [rNR34], a

    Nops 47

    ; Retrigger
    ldh [rNR34], a

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
db $44,$55,$66,$77,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
ExpectedWaveRamEnd: