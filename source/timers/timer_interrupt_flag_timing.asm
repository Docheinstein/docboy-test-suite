INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes for read IF timer flag set.

EntryPoint:

Round1:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; 8 nops should read IF=0
    Nops 8

    ; Load IF
    ldh a, [rIF]
    ld b, a

    ; Timer interrupt flag should be not set
    ld a, $e0
    cp b
    jp nz, TestFail

Round2:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Disable timer
    ldh [rTAC], a

    ; Reset IF
    ldh [rIF], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; 9 nops should read IF=1
    Nops 9

    ; Load IF
    ldh a, [rIF]
    ld b, a

    ; Timer interrupt flag should be set
    ld a, $e4
    cp b
    jp nz, TestFail

    jp TestSuccess

