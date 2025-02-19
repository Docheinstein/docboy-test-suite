INCLUDE "all.inc"

; Check the content of SB after a serial transfer is aborted during the last bit.
; Serial interrupt should not be raised.

EntryPoint:
    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 980

    ; Stop serial transfer
    ld a, $00
    ldh [rSC], a

    ldh a, [rSB]
    cp $ff

    jp nz, TestFail
    jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestFail
