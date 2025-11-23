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

    Nops 8

    ; Read LY: it should read 0
    ldh a, [rLY]
    cp $00
    jp nz, TestFail
    jp TestSuccess
