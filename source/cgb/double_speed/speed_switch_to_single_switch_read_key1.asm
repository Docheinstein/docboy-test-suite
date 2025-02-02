INCLUDE "all.inc"

; Read KEY1 after speed switch from double to single speed.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Read KEY1
    ldh a, [rKEY1]
    cp $fe
    jp nz, TestFail

    ; Prepare speed switch again
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Change speed again
    stop

    ; Read KEY1
    ldh a, [rKEY1]
    cp $7e
    jp nz, TestFail

    jp TestSuccess