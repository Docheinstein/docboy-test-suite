INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating LY.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 42 * 114

    Nops 26

    ; Switch to double speed
    stop

    ; Read LY
    ldh a, [rLY]
    cp $1f

    jp nz, TestFail
    jp TestSuccess