INCLUDE "docboy.inc"

; Check that CH1 period sweep turns off CH1 with the correct timing.
; Here APU is disabled for a certain time.

EntryPoint:
    DisableAPU

    LongWait 512

    EnableAPU

    ; Sweep pace = 1
    ; Sweep shift = 0
    ld a, $10
    ldh [rNR10], a

    ; DAC = ON
    ld a, $f8
    ldh [rNR12], a

    ; Period = $7f0
    ld a, $f0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    ld de, $00

.loop
    ldh a, [rNR52]
    inc de
    and $01
    jr nz, .loop

    ld a, d
    cp $02
    jp nz, TestFail
    ld a, e
    cp $b1
    jp nz, TestFail

    jp TestSuccess

