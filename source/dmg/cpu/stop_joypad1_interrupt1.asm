INCLUDE "docboy.inc"

; Check how STOP behaves with:
; * Joypad    : pressed (manually on real hardware or artifically on emulators)
; * Interrupt : pending

EntryPoint:
    ; Manually set Serial interrupt flag.
    ld a, $08
    ldh [rIF], a
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    xor a
    db $10 ; STOP -> should behaves as NOP
    inc a
    inc a

    ; Check that STOP consumed 1 byte
    cp 2
    jp nz, TestFail

    ; Check that DIV has not been reset
    ld a, [rDIV]
    cp $ac
    jp nz, TestFail

    jp TestSuccess




