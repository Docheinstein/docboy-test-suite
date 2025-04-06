INCLUDE "all.inc"

; Check if TIMA is reloaded with TMA during a speed switch from single to double speed when timer runs at 262KHz.

EntryPoint:
    ; Write something to TMA
    ld a, $42
    ldh [rTMA], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ld a, 0xFC
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 3

    ; Switch to double speed
    stop

    ; Check TIMA
    ldh a, [rTIMA]
    cp $57

    jp nz, TestFail
    jp TestSuccess
