INCLUDE "all.inc"

; Check the duration of speed switch from double to single speed by evaluating LY.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 84 * 114

    Nops 117

    ; Switch to single speed
    stop

    ; Read LY
    ldh a, [rLY]
    cp $14 ; WTF? Odd Mode?

    jp nz, TestFail
    jp TestSuccess