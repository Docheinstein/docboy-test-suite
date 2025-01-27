INCLUDE "docboy.inc"

; Check how much it takes to react to a stat interrupt of OAM mode while in busy loop with SCX=0.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Go to next line past OAM Scan
    Nops 150

    ; Enable interrupt
    ei

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Reset DIV
    ldh [rDIV], a

    ; Busy loop
    Nops 80

    ; If this is reached either STAT interrupt is not working or PPU is not working
    jp TestFail

TestFinish:
    ; 54 nops should read DIV=2
    Nops 54

    ; Read DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp TestFinish
