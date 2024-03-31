INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how STOP behaves with:
; * Joypad    : pressed (manually on real hardware or artifically on emulators)
; * Interrupt : not pending

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable timer interrupt
    ld a, $04
    ldh [rIE], a

    ; Enable timer
    ldh [rTAC], a

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
    cp $ac
    jp nz, TestFail

    jp TestSuccess



