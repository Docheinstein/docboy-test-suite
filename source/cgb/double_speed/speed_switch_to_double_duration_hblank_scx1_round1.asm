INCLUDE "all.inc"

; Check the duration of speed switch from single to double speed by evaluating STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
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

    LongWait 180

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess