INCLUDE "all.inc"

; Simply change speed from double to single speed.

EntryPoint:
    DisablePPU
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    Nops 1

    ; Prepare speed switch again
    ld a, $01
    ldh [rKEY1], a

    ; Change speed again
    stop

    jp TestSuccess