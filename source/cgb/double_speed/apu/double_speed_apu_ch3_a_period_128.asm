INCLUDE "all.inc"

; Check the duration of speed switch from single to double by evaluating CH3 wave position.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    EnableAPU

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a

    ld a, $20
    ldh [rNR32], a

    ; Period = 128
    ld a, $80
    ldh [rNR33], a

    ld a, $87
    ldh [rNR34], a

    Wait 3094

    ; Read PCM3
    ldh a, [rPCM34]
    cp $0c

    jp nz, TestFail
    jp TestSuccess

WaveRam:
db $00,$11,$22,$33,$44,$55,$66,$77
db $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
WaveRamEnd: