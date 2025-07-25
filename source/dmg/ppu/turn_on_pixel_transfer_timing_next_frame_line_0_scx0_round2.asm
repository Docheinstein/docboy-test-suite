INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3) at line 0 of next frame, with:
; SCX=0
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160

    ; Reset PPU phase
    EnablePPU

    Wait 154 * 114
    Nops 60

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $84
    jp nz, TestFail

    jp TestSuccess