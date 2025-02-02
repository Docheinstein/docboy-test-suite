INCLUDE "all.inc"

; Check what happens to TIMA during a speed switch from double to single speed when timer runs at 262KHz.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

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

    Nops 2

    ; Switch to single speed
    stop

    ; Check TIMA
    ldh a, [rTIMA]
    cp $03

    jp nz, TestFail
    jp TestSuccess
