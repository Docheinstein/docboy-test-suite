INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3) at line 0 of next frame, with:
; SCX=3
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    ; Set OAM Data
    Memset $fe00, $00, 160

    ; Reset PPU phase
    EnablePPU

    LongWait 154 * 114
    Nops 60

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $84
    jp nz, TestFail

    jp TestSuccess