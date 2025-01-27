INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3) at line 0, with:
; SCX=4
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=4
    ld a, $04
    ldh [rSCX], a

    ; Set OAM Data
    Memset $fe00, $00, 160

    ; Reset PPU phase
    EnablePPU

    Nops 61

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $84
    jp nz, TestFail

    jp TestSuccess