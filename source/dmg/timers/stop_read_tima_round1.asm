INCLUDE "all.inc"

; Run TIMA at a certain speed, then STOP.
; Read TIMA after resume.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Wait a bit
    Nops 256

    stop

    ldh a, [rTIMA]
    cp $41

    jp nz, TestFail
    jp TestSuccess
