INCLUDE "all.inc"

; Check the timing of timer interrupt during speed switch to single speed.

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

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable Timer interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Switch to single speed
    stop

    Nops 44

    ; Read DIV
    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess