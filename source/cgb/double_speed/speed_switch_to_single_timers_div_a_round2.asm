INCLUDE "all.inc"

; Check what happens to DIV during a speed switch from double to single speed.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

    Nops 61

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess
