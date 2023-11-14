INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a stat interrupt while halted with SCX=0.

EntryPoint:
    ; Write SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable interrupt
    ei

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Reset DIV
    ldh [rDIV], a

    ; Halt
    halt
    nop

    ; If this is reached either STAT interrupt is not working or PPU is not working
    jp TestFail

TestFinish:
    ; 61 nops should read DIV=1
    Nops 61

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp TestFinish
