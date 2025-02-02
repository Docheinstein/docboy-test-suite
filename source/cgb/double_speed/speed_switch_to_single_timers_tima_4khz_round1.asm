INCLUDE "all.inc"

; Check what happens to TIMA during a speed switch from double to single speed when timer runs at 4KHz.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

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

    ; Switch to single speed
    stop

    ; Check TIMA
    ldh a, [rTIMA]
    cp $80

    jp nz, TestFail
    jp TestSuccess
