INCLUDE "all.inc"

; Prepare speed switch, wait a bit, then change speed from single to double speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Wait a bit
    Wait 1000

    ; Change speed
    stop

    jp TestSuccess