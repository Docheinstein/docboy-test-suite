INCLUDE "all.inc"

; Check the timing of timers interrupt
; in single speed (after a switch back from double speed).

EntryPoint:
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

    ; Enable TIMER interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ei

    xor a

REPT 512
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $04

    jp nz, TestFail
    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestContinue
