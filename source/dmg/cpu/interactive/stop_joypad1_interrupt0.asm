INCLUDE "all.inc"

; Check how STOP behaves with:
; * Joypad    : pressed (manually on real hardware or artifically on emulators)
; * Interrupt : not pending

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
    Wait 1024

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable timer interrupt (so that we can exit halt state when TIMA overflows)
    ld a, $04
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    xor a
    db $10 ; STOP -> should behaves as HALT
    inc a  ; <- this should be ignored
    inc a

    ; Check that STOP consumed 2 bytes
    cp 1
    jp nz, TestFail

    ; Check that DIV has not been reset
    ld a, [rDIV]
    cp $20
    jp nz, TestFail

    jp TestSuccess



