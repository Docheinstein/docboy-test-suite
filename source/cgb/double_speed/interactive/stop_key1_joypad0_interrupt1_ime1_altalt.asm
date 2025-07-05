INCLUDE "all.inc"

; Check how STOP behaves with:
; * KEY1      : 1
; * Joypad    : not pressed
; * Interrupt : pending
; * IME       : 1

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

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
    Wait 1024

    ; Manually set Serial interrupt flag.
    ld a, $08
    ldh [rIF], a
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a


    xor a

    ei
    db $10 ; STOP -> should work
    inc a
    inc a

    jp TestFail

TestContinue:
    cp $00
    jp nz, TestFail

    ldh a, [rKEY1]
    cp $fe

    jp nz, TestFail
    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    jp TestContinue
