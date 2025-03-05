INCLUDE "all.inc"

; Basic transfer of byte from a master (another GameBoy connected through the serial link) to a slave (this GameBoy).

EntryPoint:
    ; Enable SERIAL interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_SERIAL
    ldh [rIE], a

    ei

    ; Set SB = 02 (slave)
    ld a, $02
    ldh [rSB], a

    ; Serial transfer should start even with SC = 0
    xor a
    ldh [rSC], a

    halt
    nop

    ; Check SB sent by master (01)
    ldh a, [rSB]
    cp $01

    jp nz, TestFail

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    reti