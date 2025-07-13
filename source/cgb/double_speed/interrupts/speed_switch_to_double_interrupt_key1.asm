INCLUDE "all.inc"

; Check KEY1 after an interrupt is triggered during speed switch to double speed.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

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

    ; Switch to double speed
    stop

    ; Read KEY1
    ldh a, [rKEY1]
    cp $fe

    jp nz, TestFail
    jp TestSuccess