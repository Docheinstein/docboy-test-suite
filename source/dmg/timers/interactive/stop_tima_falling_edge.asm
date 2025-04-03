INCLUDE "all.inc"

; Run TIMA at a certain speed, then STOP when DIV selected bit is high.
; TIMA should be ticked.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    ; Wait for bit 7 to go high
    Nops 280

    stop

    ldh a, [rTIMA]
    cp $05

    jp nz, TestFail
    jp TestSuccess

