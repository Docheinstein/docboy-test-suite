INCLUDE "all.inc"

; Check how speed switch affects PPU LY bug in double speed mode.

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Reset PPU
    DisablePPU
    EnablePPU

REPT 16
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop
ENDR

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to single speed
    stop

    LongWait 36 * 114

    Nops 2

    ; Read LY
    ldh a, [rLY]
    cp $83

    jp nz, TestFail
    jp TestSuccess
