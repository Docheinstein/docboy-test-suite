INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating LY.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 42 * 114

    Nops 222

    ; Read LY
    ldh a, [rLY]
    cp $15

    jp nz, TestFail
    jp TestSuccess