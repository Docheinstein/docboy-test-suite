INCLUDE "all.inc"

; Check the timing of the content of CH3's Wave RAM.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    Memcpy $FF30, WaveRam, WaveRamEnd - WaveRam

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    ; Enable = 1
    ld a, $80
    ldh [rNR30], a
    
    ; Volume = 100
    ld a, $20
    ldh [rNR32], a

    ld a, $FC
    ldh [rNR33], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR34], a

	Nops 5

    ldh a, [rPCM34]
    cp $02

    jp nz, TestFail
    jp TestSuccess
    
    
WaveRam:
db $12,$34,$56,$78,$9A,$BC,$DE,$FE
db $DC,$BA,$98,$76,$54,$32,$13,$45
WaveRamEnd:

