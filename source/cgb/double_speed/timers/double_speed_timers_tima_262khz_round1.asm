INCLUDE "all.inc"

; Check the timing of TIMA in double speed when timer runs at 262KHz.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Reset DIV
    ; xor a
    ; ldh [rDIV], a

    ; Reset TIMA
    ; ldh [rTIMA], a

    Nops 0

    ; Check TIMA
    ldh a, [rTIMA]
    cp $02

    jp nz, TestFail
    jp TestSuccess
