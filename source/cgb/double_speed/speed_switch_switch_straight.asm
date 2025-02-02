INCLUDE "all.inc"

; Simply change speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Change speed
    stop

    jp TestSuccess