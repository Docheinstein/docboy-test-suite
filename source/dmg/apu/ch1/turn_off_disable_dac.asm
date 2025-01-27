INCLUDE "docboy.inc"

; Disabling PPU reset NR12 and turns off CH1 DAC

EntryPoint:
    EnableAPU

    ; DAC = 1
    ld a, $F8
    ldh [rNR12], a

    DisableAPU

    ; NR12 should be reset
    ldh a, [rNR12]

    cp $00
    jp nz, TestFail

    EnableAPU

    ; Trigger = 1
    ld a, $80
    ldh [rNR14], a

    ; CH1 should be off
    ldh a, [rNR52]
    and $01
    jp nz, TestFail

    jp TestSuccess
