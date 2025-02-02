INCLUDE "all.inc"

; Check what happens to TIMA during a speed switch when timers runs at 16KHz.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 16KHZ Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 17

    ; Speed switch
    stop

    ; Check TIMA
    ldh a, [rTIMA]
    cp $01

    jp nz, TestFail
    jp TestSuccess
