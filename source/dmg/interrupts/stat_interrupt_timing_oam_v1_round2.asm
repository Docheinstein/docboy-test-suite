INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much it takes to react to a stat interrupt of OAM mode while in busy loop with SCX=0.

EntryPoint:
    ; Set interrupt jump to TestStart
    ld hl, TestStart

    ResetPPU

    ; Go to next line
    Nops 114

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

    ; Busy loop
    Nops 80

    ; If this is reached either STAT interrupt is not working or PPU is not working
    jp TestFail

TestStart:
    ; Set interrupt jump to TestStart
    ld hl, TestFinish

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Enable interrupt
    ei

    ; Busy loop
    Nops 80

    ; If this is reached either STAT interrupt is not working or PPU is not working
    jp TestFail

TestFinish:
    ; 21 nops should read DIV=2
    Nops 21

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp hl
