INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating LY.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Enable PPU
    EnablePPU

    ; Skip glitched line
    Nops 228

    ; Switch to double speed
    stop

    LongWait 42 * 114

    LongWait 281

    ; Read LY
    ldh a, [rLY]
    cp $0e

    jp nz, TestFail
    jp TestSuccess