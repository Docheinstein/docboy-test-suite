INCLUDE "docboy.inc"

; Check how much it takes for EI to have effect.

EntryPoint:
    ; Manually set interrupt in IE and IF
    ld a, 1
    ldh [rIE], a
    ldh [rIF], a

    xor a

    ; Enable interrupt: but it should have effect after the following instruction
    ei

    ; Reset IF: interrupt should not take place
    ldh [rIF], a

    ; Just ensure that interrupt does not happen.
    nop

    ; If we get here, EI timing is right and interrupt didn't take place
    jp TestSuccess

SECTION "Zero Handler", ROM0[$00]
    ; We shouldn't reach this point.
    jp TestFail

SECTION "VBlank handler", ROM0[$40]
    ; We shouldn't reach this point.
    jp TestFail
