INCLUDE "all.inc"

; Check the timing of timers in double speed mode.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Enable timer at 4KHZ Hz
    ld a, TACF_START | TACF_4KHZ
    ldh [rTAC], a

    ; Switch to double speed
    stop

    ld a, $20
    ldh [rTIMA], a

    LongWait 2039

    Nops 1

    ldh a, [rTIMA]
    cp $28

    jp nz, TestFail
    jp TestSuccess