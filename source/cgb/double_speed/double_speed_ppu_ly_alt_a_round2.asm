INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating LY.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    DisablePPU

    ; Switch to double speed
    stop

    ; Reset PPU
    EnablePPU

    LongWait 42 * 114

    Nops 223

Read:
    ; Read LY
    ldh a, [rLY]
    cp $16

    jp nz, TestFail
    jp TestSuccess