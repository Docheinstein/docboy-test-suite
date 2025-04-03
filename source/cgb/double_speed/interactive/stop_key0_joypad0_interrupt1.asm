INCLUDE "all.inc"

; Check how STOP behaves with:
; * KEY1      : 0
; * Joypad    : not pressed
; * Interrupt : pending

EntryPoint:
    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Reset TIMA
    ld a, $00
    ldh [rTIMA], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Wait a bit so that TIMA can overflow and increase DIV
    LongWait 1024

    ; Manually set Serial interrupt flag.
    ld a, $08
    ldh [rIF], a
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    xor a
    db $10 ; STOP -> should work
    inc a
    inc a

    ; Check that STOP consumed 1 byte
    cp 2
    jp nz, TestFail

    ; Check that DIV has been reset
    ld a, [rDIV]
    cp 0
    jp nz, TestFail

    jp TestSuccess



