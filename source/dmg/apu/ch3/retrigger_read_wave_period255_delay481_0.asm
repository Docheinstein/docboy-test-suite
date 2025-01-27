INCLUDE "docboy.inc"

; Reading from Wave RAM either reads the current byte CH3 is accessing or $FF.
; Check what happens when channel is retriggered.

EntryPoint:
    EnableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ; Volume = 0
    ld a, $00
    ldh [rNR32], a

    ; Period = 255
    ld a, $01
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    Nops 126 ; 00
    Nops 255 ; 11

    ; Push the CH3 timer somewhere in the middle
    Nops 100

    ; Retrigger with:
    ; Period = 1
    ld a, $FF
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    ldh a, [$FF30]

    cp $11
    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $00,$11,$22,$33,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
WaveRamEnd: