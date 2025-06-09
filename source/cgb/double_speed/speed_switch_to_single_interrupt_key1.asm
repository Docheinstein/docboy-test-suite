INCLUDE "all.inc"

; Check KEY1 after an interrupt is triggered during speed switch to single speed.

EntryPoint:
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

    ; Read DIV
    ldh a, [rKEY1]
    cp $7e

    jp nz, TestFail
    jp TestSuccess