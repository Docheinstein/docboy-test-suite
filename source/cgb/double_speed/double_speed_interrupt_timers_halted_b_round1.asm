INCLUDE "all.inc"

; Check the timing of timers interrupt in double speed mode while halted.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    Nops 1

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Enable interrupt
    ei

    ; Halt
    halt
    nop

    ; We should not reach this point
    jp TestFail

TestFinish:
    Nops 50

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    jp TestFinish
