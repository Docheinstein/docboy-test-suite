INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how STOP behaves with:
; * Joypad    : not pressed
; * Interrupt : nothing pending

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIF], a
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    xor a
    db $10 ; STOP -> should work
    inc a  ; <- this should be ignored
    inc a

    ; Check that STOP consumed 2 bytes
    cp 1
    jp nz, TestFail

    ; Check that DIV has been reset
    ld a, [rDIV]
    cp 0
    jp nz, TestFail

    jp TestSuccess



