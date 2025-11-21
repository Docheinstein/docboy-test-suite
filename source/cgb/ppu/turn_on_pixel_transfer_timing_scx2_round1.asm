INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3) at line 0, with:
; SCX=2
; 0 sprites

EntryPoint:
    DisablePPU

    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    ; Set OAM Data
    Memset $fe00, $00, 160

EnableIt:
    ; Reset PPU phase
    EnablePPU

    Nops 60

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]

    cp $87
    jp nz, TestFail

    jp TestSuccess