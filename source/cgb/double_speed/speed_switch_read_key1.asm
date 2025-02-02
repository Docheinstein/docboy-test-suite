INCLUDE "all.inc"

; Read KEY1 after speed switch.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Change speed
    stop

    ; Read KEY1
    ldh a, [rKEY1]
    cp $fe

    jp nz, TestFail
    jp TestSuccess