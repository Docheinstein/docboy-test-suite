INCLUDE "all.inc"

; Check that PPU speed remains the same also in double speed mode by evaluating LY.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 2 * $40 * 114

    ; Read LY
    ldh a, [rLY]
    cp $40

    jp nz, TestFail
    jp TestSuccess