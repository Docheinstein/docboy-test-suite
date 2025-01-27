INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3) coming from a STAT interrupt, with:
; SCX=5
; 1 sprite X=0

EntryPoint:
    ; Enable sprites
    EnablePPU

    WaitVBlank

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    WaitScanline 1

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable interrupt
    ei

    halt
    nop

TestStart:
    ; Set SCX=5
    ld a, $05
    ldh [rSCX], a

    Nops 99

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $88
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, $00, $00, $00
    db $00, $00, $00, $00
OamDataEnd:

SECTION "STAT handler", ROM0[$48]
    jp TestStart