INCLUDE "all.inc"

; Check precise timing of LY for LY=9.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 9 * 114 + 109
    Wait 9 * 114 + 109

    Nops 5

    ; Read LY: it should read 152
    ldh a, [rLY]
    cp $0a
    jp nz, TestFail
    jp TestSuccess
