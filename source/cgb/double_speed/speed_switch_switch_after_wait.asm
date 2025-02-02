INCLUDE "all.inc"

; Prepare speed switch, wait a bit, then change speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Wait a bit
    LongWait 1000

    ; Change speed
    stop

    jp TestSuccess