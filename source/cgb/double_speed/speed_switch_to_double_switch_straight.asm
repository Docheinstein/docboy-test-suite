INCLUDE "all.inc"

; Simply change speed from single to double speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    jp TestSuccess