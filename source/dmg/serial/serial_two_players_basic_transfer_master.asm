INCLUDE "all.inc"

; Basic transfer of byte from a master (this GameBoy) to a slave (another GameBoy connected through the serial link).

EntryPoint:
    ; Enable SERIAL interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_SERIAL
    ldh [rIE], a

    ei

WaitForSlave:
    ; Set SB = 01 (master)
    ld a, $01
    ldh [rSB], a

    ; Start serial transfer as master
    ld a, $81
    ldh [rSC], a

    halt
    nop

    ; Wait for slave (02)
    ldh a, [rSB]
    cp $02

    jp nz, WaitForSlave

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    reti
