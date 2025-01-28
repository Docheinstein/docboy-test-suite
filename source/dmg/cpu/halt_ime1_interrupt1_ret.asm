INCLUDE "all.inc"

; Check how HALT behaves with:
; * IME       : enabled
; * Interrupt : pending

EntryPoint:
    ld b, 0

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, 4
    ldh [rIE], a

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

    ei
    nop

    REPT 8
        inc b
    ENDR
    halt

    ld a, [rDIV]
    cp $40
    jp nz, TestFail

    ld a, b
    cp 8
    jp nz, TestFail

    jp TestSuccess


SECTION "Timer handler", ROM0[$50]
    ret

