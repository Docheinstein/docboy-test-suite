INCLUDE "all.inc"

; Check precise timing of LY for last scanline.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 152 * 114 + 109
    Wait 152 * 114 + 109

    Nops 4

    ; Read LY: it should read 152
    ldh a, [rLY]
    cp $98
    jp nz, TestFail
    jp TestSuccess
