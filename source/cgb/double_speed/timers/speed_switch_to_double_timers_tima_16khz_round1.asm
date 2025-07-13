INCLUDE "all.inc"

; Check what happens to TIMA during a speed switch from single to double speed when timer runs at 16KHz.

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

    Nops 16

    ; Switch to double speed
    stop

    ; Check TIMA
    ldh a, [rTIMA]
    cp $00

    jp nz, TestFail
    jp TestSuccess
