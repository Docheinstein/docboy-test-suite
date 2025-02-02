INCLUDE "all.inc"

; Check that PPU speed remains the same also in single speed mode after a switch back from double speed mode.

EntryPoint:
    ; Disable APU and PPU to avoid odd mode
    DisablePPU
    DisableAPU

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

    EnablePPU

    LongWait $80 * 114

    ; Read LY
    ldh a, [rLY]
    cp $80

    jp nz, TestFail
    jp TestSuccess