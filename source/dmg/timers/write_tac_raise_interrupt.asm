INCLUDE "all.inc"

; Check how much it takes for read IF timer flag set.

; IN PROGRESS
EntryPoint:

Round1:
    ; Write something to TMA [debug]
    ld a, $42
    ldh [rTMA], a

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable interrupt
    ei

    ; Enable TIMER interrupt
    ld a, IEF_TIMER
    ldh [rIE], a

    ; Write FF to TIMA
    ld a, $ff
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    ; Wait for DIV[7] to be 1
    Nops 24

    ; Write to TAC
    xor a
    ldh [rTAC], a

    ; This should not be executed
    jp TestFail

SECTION "Timer handler", ROM0[$50]
    jp TestSuccess

