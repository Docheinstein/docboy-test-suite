INCLUDE "all.inc"

; Check what happens to DIV after a speed switch from single to double speed when timer runs at 4KHz.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 4KHZ Hz
    ld a, TACF_START | TACF_4KHZ
    ldh [rTAC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 112

    ; Switch to double speed
    stop

    Nops 60

    ; Check DIV
    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess
