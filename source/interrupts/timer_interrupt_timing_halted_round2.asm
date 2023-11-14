INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a timer interrupt while halted.

EntryPoint:
    ; Enable interrupt
    ei

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Halt
    halt
    nop

    ; If this is reached Timer interrupt or Timer is not working
    jp TestFail

TestFinish:
    ; 35 nops should read DIV=1
    Nops 35

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    jp TestFinish
