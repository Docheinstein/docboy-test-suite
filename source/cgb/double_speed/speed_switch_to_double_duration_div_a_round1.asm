INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating DIV.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 4KHZ Hz
    ld a, TACF_START | TACF_4KHZ
    ldh [rTAC], a

    Wait 52

    ; Read DIV
    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess