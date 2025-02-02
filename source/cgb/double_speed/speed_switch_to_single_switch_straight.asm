INCLUDE "all.inc"

; Simply change speed from double to single speed.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Prepare speed switch again
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Change speed again
    stop

    jp TestSuccess